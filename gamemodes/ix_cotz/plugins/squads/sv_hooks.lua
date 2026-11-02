function PLUGIN:PostLoadData()
	local query = mysql:Create("ix_squads_squads")
		query:Create("owner", "VARCHAR(20) NOT NULL") -- Stable squad key, not an authorization identity.
		query:Create("name", "VARCHAR(64) NOT NULL")
		query:Create("description", "TEXT")
		query:Create("logo", "VARCHAR(15) DEFAULT NULL")
		query:Create("color", "VARCHAR(20) DEFAULT NULL")
		query:PrimaryKey("owner")
	query:Execute()
end

function PLUGIN:PlayerLoadedCharacter(client, character)
	client.squad_invite = nil
	client:SetLocalVar("squadInvite", nil)
	local id = character:GetSquadID()
	if (id == "NULL") then return end

	ix.squad.Restore(id, character:GetID(), function(squad, reason)
		if (not IsValid(client) or client:GetCharacter() ~= character or character:GetSquadID() ~= id) then return end

		if (squad) then
			squad:Sync(client, true)
		elseif (reason == "missing") then
			character:SetSquadID("NULL")
			character:SetSquadName("")
			character:SetSquadOfficer(0)
		elseif (reason == "leader") then
			client:Notify("Your squad needs an administrator to resolve its legacy leader character.")
		end
	end)
end

function PLUGIN:PreCharacterDeleted(client, character)
	local id = character:GetSquadID()
	if (id == "NULL") then return end
	local characterID = character:GetID()
	local squad = ix.squad.list[id]

	if (squad) then
		if (squad.leaderID == characterID) then
			ix.squad.Disband(id)
		else
			squad.members[characterID] = nil
			squad.memberInfo[characterID] = nil
			squad:Sync()
		end
		return
	end

	-- Read before Helix queues deletion, so an unloaded founder can still be resolved.
	local query = mysql:Select("ix_characters")
		query:Select("id")
		query:Select("steamid")
		query:Where("schema", Schema.folder)
		query:Where("squad_id", id)
		query:Callback(function(rows)
			local leaderID = ix.squad.ResolveLeader(id, rows or {})
			if (leaderID == characterID) then ix.squad.Disband(id) end
			if (not leaderID) then
				ErrorNoHalt("[Squads] Unresolved legacy leader during character deletion: " .. id .. "\n")
			end
		end)
	query:Execute()
end

function PLUGIN:CharacterVarChanged(character, key)
	if (key ~= "name" and key ~= "pdaavatar") then return end
	local squad = ix.squad.list[character:GetSquadID()]
	if (squad and squad.members[character:GetID()] ~= nil) then squad:Sync() end
end

function PLUGIN:PostPlayerLoadout(client)
	local character = client:GetCharacter()
	local squad = character and ix.squad.list[character:GetSquadID()]

	if (squad and squad:GetRank(client) ~= nil and squad.color) then
		local color = squad.color
		client:SetPlayerColor(Vector(color.r / 255, color.g / 255, color.b / 255))
	end
end

net.Receive("ixSquadCreate", function(_, client)
	if ((client.ixSquadCreateTry or 0) > CurTime()) then return end
	client.ixSquadCreateTry = CurTime() + 30
	local character = client:GetCharacter()
	if (not character or character:GetSquadID() ~= "NULL") then return end

	local name = string.Trim(net.ReadString():gsub("[\r\n]", ""))
	if (name == "" or name:utf8len() > 48) then return end

	ix.squad.New(name, character, function(squad)
		if (not IsValid(client) or client:GetCharacter() ~= character or not squad) then return end

		squad:Sync(client)
		client:NotifyLocalized("squad_successfully_created", squad.name)
	end)
end)

net.Receive("ixSquadSettings", function(_, client)
	if ((client.ixSquadSettingsTry or 0) > CurTime()) then return end
	client.ixSquadSettingsTry = CurTime() + 1

	local data = net.ReadTable()
	data.logoID = nil
	if (table.IsEmpty(data) or !client:GetCharacter()) then return end

	local squad = ix.squad.list[client:GetCharacter():GetSquadID()]

	if (squad and squad:IsLeader(client)) then
		if (data.name) then
			local name = tostring(data.name):gsub("\r\n", ""):gsub("\n", "")
			name = string.Trim(name)

			if (name:utf8len() < 1 or !name:find("%S")) then
				data.name = nil
			else
				if (name:gsub("%s", ""):utf8len() > 48) then
					name = name:utf8sub(0, 48)
				end

				squad.name = name
			end
		end

		if (data.description) then
			local desc = string.Trim(tostring(data.description))

			if (!desc:find("%S")) then
				squad.description = ""
			else
				if (desc:utf8len() < 1) then
					desc = ""
				elseif (desc:gsub("%s", ""):utf8len() > 2048) then
					desc = desc:utf8sub(0, 2048)
				end

				squad.description = desc
			end
		end

		local isColor = ix.util.IsColor(data.color)
		if (isColor) then
			data.color.a = 255
			squad.color = data.color
		end

		if (!table.IsEmpty(data)) then
			local query = mysql:Update("ix_squads_squads")
				if (data.name) then query:Update("name", squad.name) end
				if (data.description) then query:Update("description", squad.description) end
				if (isColor) then query:Update("color", string.FromColor(data.color)) end 
				query:Where("owner", squad.owner)
			query:Execute()

			squad:Sync(nil, isColor)
		end

		isColor = nil
	end

	data = nil
end)

net.Receive("ixSquadInvite", function(_, client)
	if ((client.ixSquadInviteTry or 0) > CurTime()) then return end
	client.ixSquadInviteTry = CurTime() + 2
	local character = client:GetCharacter()
	local squad = character and ix.squad.list[character:GetSquadID()]
	local rank = squad and squad:GetRank(client)
	if (not rank or rank == 0) then return end

	local target = net.ReadEntity()
	if (not IsValid(target) or not target:IsPlayer() or target == client) then return end
	local targetCharacter = target:GetCharacter()
	if (not targetCharacter or targetCharacter:GetSquadID() ~= "NULL") then return end
	if (client:GetPos():DistToSqr(target:GetPos()) > 160 * 160) then return end

	target.squad_invite = {
		expires = CurTime() + 30,
		inviterID = character:GetID(),
		targetID = targetCharacter:GetID(),
		squadID = squad.owner,
	}
	target:SetLocalVar("squadInvite", {
		targetID = targetCharacter:GetID(), name = squad.name, inviter = character:GetName(),
		expires = target.squad_invite.expires,
	})
	target:NotifyLocalized("squad_invite", character:GetName(), squad.name)
end)

net.Receive("ixSquadKickMember", function(_, client)
	if ((client.ixSquadKickTry or 0) > CurTime()) then return end
	client.ixSquadKickTry = CurTime() + 2
	ix.squad.KickMember(net.ReadUInt(32), client)
end)

net.Receive("ixSquadRankChange", function(_, client)
	if ((client.ixSquadRankTry or 0) > CurTime()) then return end
	client.ixSquadRankTry = CurTime() + 2
	ix.squad.ChangeRank(net.ReadUInt(32), client)
end)

net.Receive("ixSquadDisband", function(_, client)
	if ((client.ixSquadKickTry or 0) > CurTime()) then return end
	client.ixSquadKickTry = CurTime() + 2
	local character = client:GetCharacter()
	local squad = character and ix.squad.list[character:GetSquadID()]
	if (squad and squad:IsLeader(client)) then ix.squad.Disband(squad.owner) end
end)

net.Receive("ixSquadLeave", function(_, client)
	if ((client.ixSquadLeaveTry or 0) > CurTime()) then return end
	client.ixSquadLeaveTry = CurTime() + 2
	ix.squad.Leave(client)
end)

net.Receive("cotz/squads/accept-invite", function(_, client)
	if ((client.ixSquadAcceptTry or 0) > CurTime()) then return end
	client.ixSquadAcceptTry = CurTime() + 1
	ix.squad.AcceptInvite(client)
end)
