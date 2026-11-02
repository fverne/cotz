util.AddNetworkString("ixSquadSync")
util.AddNetworkString("ixSquadKick")
util.AddNetworkString("ixSquadSettings")
util.AddNetworkString("ixSquadCreate")
util.AddNetworkString("ixSquadInvite")
util.AddNetworkString("cotz/squads/accept-invite")
util.AddNetworkString("ixSquadKickMember")
util.AddNetworkString("ixSquadDisband")
util.AddNetworkString("ixSquadRankChange")
util.AddNetworkString("ixSquadLeave")

local pendingRestores = {}
local pendingCreates = {}
local generations = {}

local function setMembership(characterID, squadID, rank, expectedID)
	local character = ix.char.loaded[characterID]

	if (character) then
		character:SetSquadID(squadID)
		character:SetSquadOfficer(rank)
		if (squadID == "NULL") then character:SetSquadName("") end
	end

	local query = mysql:Update("ix_characters")
		query:Update("squad_id", squadID)
		query:Update("squad_officer", rank)
		query:Where("schema", Schema.folder)
		query:Where("id", characterID)
		if (expectedID) then query:Where("squad_id", expectedID) end
	query:Execute()
end

local function getSquad(client)
	local character = IsValid(client) and client:GetCharacter()
	return character and ix.squad.list[character:GetSquadID()]
end

-- Existing squad primary keys remain opaque IDs. Only this compatibility resolver uses account IDs.
function ix.squad.ResolveLeader(id, rows)
	local characterID = tonumber(id:match("^char:(%d+)$")) or ix.squad.legacyLeaders[id]
	local candidates = {}

	for _, row in ipairs(rows) do
		local rowID = tonumber(row.id)
		if (characterID and rowID == characterID) then return rowID end
		if (not characterID and row.steamid == id) then candidates[#candidates + 1] = rowID end
	end

	if (not characterID and #candidates == 1) then return candidates[1] end
end

function ix.squad.Restore(id, characterID, callback)
	if (not id or id == "NULL") then callback(nil, "missing") return end

	local cached = ix.squad.list[id]
	if (cached) then
		callback(cached.members[characterID] ~= nil and cached or nil, "missing")
		return
	end

	local generation = generations[id] or 0
	local request = {characterID = characterID, callback = callback}
	if (pendingRestores[id]) then
		table.insert(pendingRestores[id], request)
		return
	end
	pendingRestores[id] = {request}

	local function finish(squad, reason)
		local requests = pendingRestores[id]
		pendingRestores[id] = nil

		for _, entry in ipairs(requests) do
			if (squad and squad.members[entry.characterID] == nil) then
				entry.callback(nil, "missing")
			else
				entry.callback(squad, reason)
			end
		end
	end

	local query = mysql:Select("ix_squads_squads")
		query:Where("owner", id)
		query:Callback(function(result)
			if (not istable(result) or not result[1]) then finish(nil, "missing") return end
			local record = result[1]
			local members = mysql:Select("ix_characters")
				members:Select("id")
				members:Select("steamid")
				members:Select("name")
				members:Select("pdaavatar")
				members:Select("squad_officer")
				members:Where("schema", Schema.folder)
				members:Where("squad_id", id)
				members:Callback(function(rows)
					rows = rows or {}
					local leaderID = ix.squad.ResolveLeader(id, rows)
					if (not leaderID) then
						ErrorNoHalt("[Squads] Cannot resolve leader for " .. id .. "; saved membership retained.\n")
						finish(nil, "leader")
						return
					end

					if ((generations[id] or 0) ~= generation) then finish(nil, "missing") return end
					local squad = ix.squad.Register(id, record.name, {leaderID = leaderID})
					if (record.color and record.color ~= "NULL") then squad.color = string.ToColor(record.color) end
					if (record.description and record.description ~= "NULL") then
						squad.description = record.description
					end

					for _, row in ipairs(rows) do
						local memberID = tonumber(row.id)
						local rank = tonumber(row.squad_officer) == 1 and 1 or 0
						squad.members[memberID] = memberID == leaderID and 2 or rank
						squad.memberInfo[memberID] = {name = row.name, pdaavatar = row.pdaavatar}
					end

					finish(squad)
				end)
			members:Execute()
		end)
	query:Execute()
end

function ix.squad.New(name, character, callback)
	local characterID = character:GetID()
	if (pendingCreates[characterID] or character:GetSquadID() ~= "NULL") then return end
	pendingCreates[characterID] = true
	local id = "char:" .. characterID

	local query = mysql:Select("ix_squads_squads")
		query:Where("owner", id)
		query:Callback(function(result)
			if (istable(result) and result[1]) then
				pendingCreates[characterID] = nil
				callback(nil)
				return
			end

			if (ix.char.loaded[characterID] ~= character or character:GetSquadID() ~= "NULL") then
				pendingCreates[characterID] = nil
				return
			end

			local insert = mysql:Insert("ix_squads_squads")
				insert:Insert("owner", id)
				insert:Insert("name", name)
				insert:Callback(function()
					pendingCreates[characterID] = nil
					if (ix.char.loaded[characterID] ~= character or character:GetSquadID() ~= "NULL") then
						local cleanup = mysql:Delete("ix_squads_squads")
							cleanup:Where("owner", id)
						cleanup:Execute()
						return
					end

					local squad = ix.squad.Register(id, name, {leaderID = characterID})
					squad.members[characterID] = 2
					setMembership(characterID, id, 0, "NULL")
					callback(squad)
				end)
			insert:Execute()
		end)
	query:Execute()
end

function ix.squad.AddMember(target, client, bNotNotify)
	local squad = getSquad(client)
	local rank = squad and squad:GetRank(client)
	local character = IsValid(target) and target:IsPlayer() and target:GetCharacter()
	if (not rank or rank == 0 or not character or character:GetSquadID() ~= "NULL") then return end

	local characterID = character:GetID()
	squad.members[characterID] = 0
	setMembership(characterID, squad.owner, 0, "NULL")
	squad:Sync()

	if (not bNotNotify) then
		client:NotifyLocalized("squad_invite_accepted", character:GetName())
		target:NotifyLocalized("squad_invite_accepted2", squad.name)
	end
end

function ix.squad.Disband(id)
	generations[id] = (generations[id] or 0) + 1
	local squad = ix.squad.list[id]
	local receivers = squad and squad:GetReceivers() or {}

	-- Clear every character, including unloaded members; account ownership is irrelevant.
	for _, character in pairs(ix.char.loaded) do
		if (character:GetSquadID() == id) then
			character:SetSquadID("NULL")
			character:SetSquadName("")
			character:SetSquadOfficer(0)
		end
	end

	local update = mysql:Update("ix_characters")
		update:Update("squad_id", "NULL")
		update:Update("squad_officer", 0)
		update:Where("schema", Schema.folder)
		update:Where("squad_id", id)
	update:Execute()

	local query = mysql:Delete("ix_squads_squads")
		query:Where("owner", id)
	query:Execute()
	ix.squad.list[id] = nil

	if (#receivers > 0) then
		net.Start("ixSquadKick")
			net.WriteString(id)
			net.WriteBool(true)
		net.Send(receivers)
	end
end

function ix.squad.KickMember(characterID, client)
	local squad = getSquad(client)
	local rank = squad and squad:GetRank(client)
	local targetRank = squad and squad.members[characterID]
	if (not rank or rank == 0 or targetRank == nil or targetRank >= rank) then return end
	if (characterID == squad.leaderID) then return end
	local character = ix.char.loaded[characterID]
	if (character and character:GetSquadID() ~= squad.owner) then return end

	local target = ix.squad.GetPlayer(characterID)
	squad.members[characterID] = nil
	squad.memberInfo[characterID] = nil
	setMembership(characterID, "NULL", 0, squad.owner)
	squad:Sync()

	if (target) then
		net.Start("ixSquadKick")
			net.WriteString(squad.owner)
			net.WriteBool(false)
			net.WriteUInt(characterID, 32)
		net.Send(target)
	end
end

function ix.squad.ChangeRank(characterID, client)
	local squad = getSquad(client)
	if (not squad or not squad:IsLeader(client) or squad.members[characterID] == nil) then return end
	if (characterID == squad.leaderID) then return end
	local character = ix.char.loaded[characterID]
	if (character and character:GetSquadID() ~= squad.owner) then return end

	local rank = squad.members[characterID] == 0 and 1 or 0
	squad.members[characterID] = rank
	setMembership(characterID, squad.owner, rank, squad.owner)
	squad:Sync()
end

function ix.squad.Leave(client)
	local squad = getSquad(client)
	if (not squad or squad:GetRank(client) == nil or squad:IsLeader(client)) then return end

	local characterID = client:GetCharacter():GetID()
	squad.members[characterID] = nil
	squad.memberInfo[characterID] = nil
	setMembership(characterID, "NULL", 0, squad.owner)
	squad:Sync()
	net.Start("ixSquadLeave")
		net.WriteString(squad.owner)
		net.WriteUInt(characterID, 32)
	net.Send(client)
end

ix.util.Include("sv_hooks.lua", "server")

ix.util.Include("sv_crossserver.lua")

if (ix.squad.cross) then
	for _, name in ipairs({"New", "ChangeRank", "KickMember", "Leave", "Disband"}) do
		local original = ix.squad[name]
		local shared = ix.squad.cross[name]
		ix.squad[name] = function(...)
			if (ix.squad.cross.Enabled()) then return shared(...) end
			return original(...)
		end
	end
end
