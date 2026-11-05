local PLUGIN = PLUGIN
local presence = ix.crossserver
local cross = {ready = false, generation = 0, sessions = presence and presence.sessions or {}}
ix.squad.cross = cross
local POLL_INTERVAL = 5
local CHUNK_SIZE = 128
util.AddNetworkString("cotz/squads/presence-fresh")

ix.config.Add("squadCrossServer", true, "Share squad membership and presence through the schema database.", nil, {
	category = "Squads",
})

function cross.Enabled()
	return cross.lockedEnabled or ix.config.Get("squadCrossServer", true)
end

local function scope() return presence.Scope() end
local function token() return presence.Token() end

function cross.Query(query, callback)
	presence.Query(query, callback)
end

local function sequence(queries, callback)
	local index = 0
	local function nextQuery(_, failure)
		if (failure) then callback(false) return end
		index = index + 1
		if (not queries[index]) then callback(true) return end
		cross.Query(queries[index], nextQuery)
	end
	nextQuery()
end

local function scopedQuery(method, tableName, id)
	local query = mysql[method](mysql, tableName)
	query:Where("scope", scope())
	if (id) then query:Where("squad_id", id) end

	return query
end

local function actorCondition(characterID, squadID, rank)
	local member = scopedQuery("Select", "ix_squads_members")
	member:Where("character_id", characterID)
	member:Limit(1)
	local actor = mysql:Select(member):Alias("actor")
	actor:SelectValue(1)
	actor:WhereExpr(mysql.All(mysql.Compare("actor.squad_id", "=", squadID),
		mysql.Compare("actor.member_rank", ">=", rank)))

	return mysql.Exists(actor)
end

local function activeCondition(id)
	local query = scopedQuery("Select", "ix_squads_state", id)
	query:SelectValue(1)
	query:Where("active", 1)

	return mysql.Exists(query)
end

local function currentAssignment(characterID)
	local query = mysql:Select("ix_squads_members"):Alias("m")
	query:SelectValue(1)
	query:Join("ix_squads_state", "s", mysql.All(
		mysql.Compare("s.scope", "=", mysql.Column("m.scope")),
		mysql.Compare("s.squad_id", "=", mysql.Column("m.squad_id"))))
	query:WhereExpr(mysql.All(mysql.Compare("m.scope", "=", scope()),
		mysql.Compare("m.character_id", "=", characterID), mysql.Compare("s.active", "=", 1)))

	return query
end

local function existingAssignment()
	local query = scopedQuery("Select", "ix_squads_state")
	query:SelectValue(1)
	query:Where("active", 1)
	query:WhereExpr(mysql.Compare("squad_id", "=", mysql.Column("ix_squads_members.squad_id")))

	return query
end

local function setMirror(character, id, rank, name, color)
	if (character:GetSquadID() ~= id) then character:SetSquadID(id) end
	if (character:GetSquadOfficer() ~= rank) then character:SetSquadOfficer(rank) end
	if (character:GetSquadName() ~= name) then character:SetSquadName(name) end
	local current = character:GetSquadColor()
	if (current.r ~= color.r or current.g ~= color.g or current.b ~= color.b) then character:SetSquadColor(color) end
end

local function mutate(query, callback)
	if (not cross.ready) then return end
	cross.generation = cross.generation + 1
	cross.Query(query, function(rows, failure)
		cross.generation = cross.generation + 1
		if (callback) then callback(not failure, rows) end
		cross.Refresh()
	end)
end

function cross.Initialize()
	if (not cross.Enabled() or cross.starting or cross.ready) then return end
	if (not presence) then return end
	presence.Initialize()
	if (not presence.ready) then return end
	cross.sessions = presence.sessions
	cross.starting = true
	cross.lockedEnabled = true
	-- These fields become explicit mirrors. Normal Helix saves must never restore stale remote ranks.
	ix.char.vars.squadID.bSaveLoadInitialOnly = true
	ix.char.vars.squadOfficer.bSaveLoadInitialOnly = true
	local queries = {}
	local function create(tableName, definitions, primaryKey)
		local query = mysql:Create(tableName)
		for name, definition in pairs(definitions) do query:Create(name, definition) end
		query:PrimaryKey(primaryKey)
		queries[#queries + 1] = query
		return query
	end
	create("ix_squads_state", {scope = "VARCHAR(64) NOT NULL", squad_id = "VARCHAR(20) NOT NULL",
		leader_id = "INTEGER NOT NULL", name = "VARCHAR(64) NOT NULL", description = "TEXT", color = "VARCHAR(32)",
		active = "INTEGER NOT NULL DEFAULT 1", revision = "INTEGER NOT NULL DEFAULT 1"}, {"scope", "squad_id"})
	local members = create("ix_squads_members", {scope = "VARCHAR(64) NOT NULL", character_id = "INTEGER NOT NULL",
		squad_id = "VARCHAR(20) NOT NULL", member_rank = "INTEGER NOT NULL DEFAULT 0"}, {"scope", "character_id"})
	members:Index("ix_squads_members_group", {"scope", "squad_id"})
	create("ix_squads_invites", {scope = "VARCHAR(64) NOT NULL", character_id = "INTEGER NOT NULL",
		inviter_id = "INTEGER NOT NULL", squad_id = "VARCHAR(20) NOT NULL", token = "VARCHAR(64) NOT NULL",
		expires = "INTEGER NOT NULL"}, {"scope", "character_id"})
	local source = mysql:Select("ix_characters")
	source:SelectValue(scope())
	source:SelectColumn("id")
	source:SelectValue(mysql.Coalesce(mysql.Column("squad_id"), "NULL"))
	source:SelectValue(mysql.Case(mysql.Compare("squad_officer", "=", 1), 1, 0))
	source:Where("schema", scope())
	local import = mysql:InsertIgnore("ix_squads_members")
	import:InsertFrom(source, {"scope", "character_id", "squad_id", "member_rank"})
	queries[#queries + 1] = import
	sequence(queries, function(success)
		if (not success) then cross.starting = false return end
		cross.Query(mysql:Select("ix_squads_squads"), function(records, failure)
			if (failure) then cross.starting = false return end
			local index = 0
			local function importNext()
				index = index + 1
				local record = records and records[index]
				if (not record) then
					cross.starting = false
					cross.ready = true
					cross.Refresh()
					return
				end
				local members = mysql:Select("ix_characters")
				members:Select("id")
				members:Select("steamid")
				members:Where("schema", scope())
				members:Where("squad_id", record.owner)
				cross.Query(members, function(rows, failure)
					if (failure) then cross.starting = false return end
					local leader = ix.squad.ResolveLeader(record.owner, rows)
					if (leader) then
						local insert = mysql:InsertIgnore("ix_squads_state")
						for field, value in pairs({scope = scope(), squad_id = record.owner, leader_id = leader,
							name = record.name, description = record.description or "", color = record.color or "NULL"}) do
							insert:Insert(field, value)
						end
						cross.Query(insert, function(_, errorText)
							if (errorText) then cross.starting = false return end
							local update = scopedQuery("Update", "ix_squads_members", record.owner)
							update:Update("member_rank", 2)
							update:Where("character_id", leader)
							update:WhereExpr(activeCondition(record.owner))
							cross.Query(update, function(_, rankError)
								if (rankError) then cross.starting = false else importNext() end
							end)
						end)
					else
						ErrorNoHalt("[Squads] Legacy squad retained pending leader mapping: " .. record.owner .. "\n")
						importNext()
					end
				end)
			end
			importNext()
		end)
	end)
end

function cross.Claim(client, character)
	presence.Claim(client, character)
end

function cross.Release(id, session)
	presence.Release(id, session)
end

function cross.Heartbeat(id, session)
	presence.Heartbeat(id, session)
end

function cross.BeginTransfer(character, destination, callback)
	presence.BeginTransfer(character, destination, callback)
end

local function chunkedIDs(ids, callback, finished)
	local index = 1
	local function nextChunk()
		if (index > #ids) then finished() return end
		local chunk = {}
		for _ = 1, CHUNK_SIZE do
			if (not ids[index]) then break end
			chunk[#chunk + 1] = ids[index]
			index = index + 1
		end
		callback(chunk, nextChunk)
	end
	nextChunk()
end

function cross.Refresh()
	if (not cross.ready) then return end
	if (cross.reading) then cross.refreshAgain = true return end
	cross.refreshAgain = false
	cross.reading = true
	local generation = cross.generation
	local ids, seen = {}, {}
	local function addID(id)
		if (ix.char.loaded[id] and not seen[id]) then
			seen[id] = true
			ids[#ids + 1] = id
		end
	end
	for _, client in ipairs(player.GetHumans()) do
		local cached = ix.char.cache and ix.char.cache[client:SteamID64()] or client.ixCharList or {}
		for _, id in ipairs(cached) do addID(id) end
		local character = client:GetCharacter()
		if (character) then addID(character:GetID()) end
	end
	chunkedIDs(ids, function(chunk, nextChunk)
		local query = mysql:Select("ix_characters"):Alias("c")
		query:SelectColumn("c.id", "id")
		for _, field in ipairs({"squad_id", "member_rank"}) do query:SelectColumn("m." .. field, field) end
		for _, field in ipairs({"leader_id", "active"}) do query:SelectColumn("s." .. field, field) end
		query:Join("ix_squads_members", "m", mysql.All(
			mysql.Compare("m.character_id", "=", mysql.Column("c.id")),
			mysql.Compare("m.scope", "=", scope())), "LEFT")
		query:Join("ix_squads_state", "s", mysql.All(
			mysql.Compare("s.squad_id", "=", mysql.Column("m.squad_id")),
			mysql.Compare("s.scope", "=", mysql.Column("m.scope"))), "LEFT")
		query:WhereExpr(mysql.Compare("c.schema", "=", scope()))
		query:WhereIn("id", chunk)
		cross.Query(query, function(rows, failure)
			if (not failure and generation == cross.generation) then
				for _, row in ipairs(rows) do
					local character = ix.char.loaded[tonumber(row.id)]
					if (character) then
						local active = tonumber(row.active) == 1
						local id = active and row.squad_id or "NULL"
						-- Unresolved legacy squads remain assigned until an administrator supplies the leader mapping.
						if (not row.leader_id and row.squad_id and row.squad_id ~= "NULL") then id = row.squad_id end
						local rank = active and tonumber(row.member_rank) or 0
						if (character:GetSquadID() ~= id) then character:SetSquadID(id) end
						if (character:GetSquadOfficer() ~= rank) then character:SetSquadOfficer(rank) end
						if (id == "NULL") then setMirror(character, id, 0, "", {}) end
					end
				end
			end
			nextChunk()
		end)
	end, function()
		cross.reading = false
		if (generation ~= cross.generation or cross.refreshAgain) then cross.Refresh() return end
		cross.RefreshSquads()
		cross.RefreshInvites()
	end)
end

function cross.RefreshSquads()
	if (cross.squadReading) then return end
	local ids = {}
	for _, client in ipairs(player.GetHumans()) do
		local character = client:GetCharacter()
		if (character and character:GetSquadID() ~= "NULL") then ids[character:GetSquadID()] = true end
	end
	-- Keep offline shop owners authoritative while their local hideouts are provisioned.
	local hideouts = ix.plugin and ix.plugin.Get("hideouts")
	for _, record in pairs(hideouts and hideouts.state and hideouts.state.hideouts or {}) do
		if record.ownerType == "squad" then ids[record.squadID] = true end
	end
	local ordered = {}
	for id in pairs(ids) do ordered[#ordered + 1] = id end
	cross.squadReading = true
	local index = 0
	local function nextSquad()
		index = index + 1
		local id = ordered[index]
		if (not id) then
			cross.squadReading = false
			for cachedID in pairs(ix.squad.list) do
				if (not ids[cachedID]) then
					ix.squad.list[cachedID] = nil
					if (cross.signatures) then cross.signatures[cachedID] = nil end
				end
			end
			return
		end
		local generation = cross.generation
		local state = scopedQuery("Select", "ix_squads_state", id)
		state:Where("active", 1)
		cross.Query(state, function(records, failure)
			if (failure or not records[1]) then
				if (not failure) then ix.squad.list[id] = nil end
				nextSquad()
				return
			end
			local record = records[1]
			local query = mysql:Select("ix_squads_members"):Alias("m")
			for _, field in ipairs({"character_id", "member_rank"}) do query:SelectColumn("m." .. field, field) end
			for _, field in ipairs({"name", "pdaavatar"}) do query:SelectColumn("c." .. field, field) end
			query:SelectColumn("p.name", "live_name")
			query:SelectColumn("p.pdaavatar", "live_avatar")
			for _, field in ipairs({"state", "map", "destination", "hidden", "expires"}) do
				query:SelectColumn("p." .. field, field)
			end
			query:SelectValue(mysql.Now(), "db_now")
			query:Join("ix_characters", "c", mysql.All(
				mysql.Compare("c.id", "=", mysql.Column("m.character_id")),
				mysql.Compare("c.schema", "=", mysql.Column("m.scope"))))
			query:Join("ix_squads_state", "currentState", mysql.All(
				mysql.Compare("currentState.scope", "=", mysql.Column("m.scope")),
				mysql.Compare("currentState.squad_id", "=", mysql.Column("m.squad_id")),
				mysql.Compare("currentState.active", "=", 1),
				mysql.Compare("currentState.revision", "=", tonumber(record.revision))))
			query:Join("ix_squads_presence", "p", mysql.All(
				mysql.Compare("p.scope", "=", mysql.Column("m.scope")),
				mysql.Compare("p.character_id", "=", mysql.Column("m.character_id"))), "LEFT")
			query:WhereExpr(mysql.All(mysql.Compare("m.scope", "=", scope()), mysql.Compare("m.squad_id", "=", id)))
			cross.Query(query, function(rows, errorText)
				if (not errorText and generation == cross.generation) then
					local hasLeader = false
					for _, row in ipairs(rows) do
						if (tonumber(row.character_id) == tonumber(record.leader_id)) then hasLeader = true end
					end
					if (not hasLeader) then nextSquad() return end
					local color = record.color ~= "NULL" and string.ToColor(record.color or "") or Color(105, 139, 87)
					local squad = ix.squad.Register(id, record.name, {
						leaderID = tonumber(record.leader_id), description = record.description, color = color,
					})
					squad.hideoutFresh = CurTime()
					for _, row in ipairs(rows) do
						local memberID = tonumber(row.character_id)
						squad.members[memberID] = memberID == squad.leaderID and 2 or tonumber(row.member_rank)
						local live = tonumber(row.expires or 0) > tonumber(row.db_now)
						local visible = tonumber(row.hidden or 0) == 0
						squad.memberInfo[memberID] = {
							name = live and visible and row.live_name or row.name,
							pdaavatar = live and visible and row.live_avatar or row.pdaavatar,
							state = not visible and "unknown" or (live and row.state or "offline"),
							map = visible and live and row.map or "", destination = visible and live and row.destination or "",
						}
					end
					local signature = util.TableToJSON(squad:CollectData())
					cross.signatures = cross.signatures or {}
					if (cross.signatures[id] ~= signature) then
						cross.signatures[id] = signature
						squad:Sync(nil, true)
					end
					for _, client in ipairs(squad:GetReceivers()) do
						net.Start("cotz/squads/presence-fresh")
							net.WriteString(id)
						net.Send(client)
						if (client.ixSquadSnapshot ~= signature) then
							client.ixSquadSnapshot = signature
							squad:Sync(client, true)
						end
					end
				end
				nextSquad()
			end)
		end)
	end
	nextSquad()
end

function cross.RefreshInvites()
	cross.inviteReads = cross.inviteReads or {}
	for _, client in ipairs(player.GetHumans()) do
		local character = client:GetCharacter()
		if (character and character:GetSquadID() == "NULL" and not cross.inviteReads[character:GetID()]) then
			cross.inviteReads[character:GetID()] = true
			local query = mysql:Select("ix_squads_invites"):Alias("i")
			query:SelectAll("i")
			query:SelectColumn("s.name", "name")
			query:SelectColumn("c.name", "inviter")
			query:SelectValue(mysql.Now(), "db_now")
			query:Join("ix_squads_state", "s", mysql.All(
				mysql.Compare("s.scope", "=", mysql.Column("i.scope")),
				mysql.Compare("s.squad_id", "=", mysql.Column("i.squad_id"))))
			query:Join("ix_characters", "c", mysql.Compare("c.id", "=", mysql.Column("i.inviter_id")))
			query:WhereExpr(mysql.All(mysql.Compare("i.scope", "=", scope()),
				mysql.Compare("i.character_id", "=", character:GetID()), mysql.Compare("s.active", "=", 1),
				mysql.Compare("i.expires", ">", mysql.Now())))
			cross.Query(query, function(rows, failure)
				cross.inviteReads[character:GetID()] = nil
				if (failure or not IsValid(client) or client:GetCharacter() ~= character) then return end
				local row = rows[1]
				local inviteToken = row and row.token or ""
				if (client.ixSquadInviteToken == inviteToken) then return end
				client.ixSquadInviteToken = inviteToken
				client.squad_invite = row
				if row then client:NotifyLocalized("squad_invite", row.inviter, row.name) end
				client:SetLocalVar("squadInvite", row and {
					targetID = character:GetID(), name = row.name, inviter = row.inviter,
					expires = CurTime() + tonumber(row.expires) - tonumber(row.db_now),
				} or nil)
			end)
		end
	end
end

function cross.New(name, character, callback)
	if (not cross.ready) then return end
	local id = "c:" .. character:GetID() .. ":" .. token():sub(1, 7)
	local source = mysql:Select()
	for _, value in ipairs({scope(), id, character:GetID(), name, "", "NULL"}) do source:SelectValue(value) end
	source:WhereExpr(mysql.NotExists(currentAssignment(character:GetID())))
	local insert = mysql:Insert("ix_squads_state")
	insert:InsertFrom(source, {"scope", "squad_id", "leader_id", "name", "description", "color"})
	mutate(insert, function(success)
		if (not success) then return end
		cross.EnsureMember(character:GetID(), function()
			if (ix.char.loaded[character:GetID()] ~= character) then
				cross.Query(scopedQuery("Delete", "ix_squads_state", id))
				return
			end
			local update = scopedQuery("Update", "ix_squads_members")
			update:Update("squad_id", id)
			update:Update("member_rank", 2)
			update:Where("character_id", character:GetID())
			update:WhereExpr(mysql.NotExists(existingAssignment()))
			update:WhereExpr(activeCondition(id))
			mutate(update, function()
				local read = scopedQuery("Select", "ix_squads_members")
				read:Select("squad_id")
				read:Where("character_id", character:GetID())
				cross.Query(read, function(rows, failure)
						if (failure) then return end
						if (rows[1] and rows[1].squad_id == id) then
							if (ix.char.loaded[character:GetID()] ~= character) then return end
							setMirror(character, id, 2, name, Color(105, 139, 87))
							local squad = ix.squad.Register(id, name, {leaderID = character:GetID()})
							squad.members[character:GetID()] = 2
							if (callback) then callback(squad) end
							cross.Refresh()
						else
							cross.Query(scopedQuery("Delete", "ix_squads_state", id))
						end
					end)
			end)
		end)
	end)
end

function cross.EnsureMember(characterID, callback)
	local query = mysql:InsertIgnore("ix_squads_members")
	for field, value in pairs({scope = scope(), character_id = characterID, squad_id = "NULL", member_rank = 0}) do
		query:Insert(field, value)
	end
	cross.Query(query, function(_, failure) if (not failure) then callback() end end)
end

function cross.ChangeRank(characterID, client, desiredRank)
	local actor = client:GetCharacter()
	local squad = actor and ix.squad.list[actor:GetSquadID()]
	local rank = squad and squad.members[characterID]
	if (not squad or rank == nil or characterID == squad.leaderID) then return end
	desiredRank = desiredRank == nil and (rank == 0 and 1 or 0) or desiredRank
	if (desiredRank ~= 0 and desiredRank ~= 1) then return end
	local query = scopedQuery("Update", "ix_squads_members", squad.owner)
	query:Update("member_rank", desiredRank)
	query:Where("character_id", characterID)
	query:Where("member_rank", rank)
	query:WhereExpr(actorCondition(actor:GetID(), squad.owner, 2))
	query:WhereExpr(activeCondition(squad.owner))
	mutate(query)
end

function cross.KickMember(characterID, client)
	local actor = client:GetCharacter()
	local squad = actor and ix.squad.list[actor:GetSquadID()]
	local rank = squad and squad:GetRank(client)
	if (not rank or rank == 0 or characterID == squad.leaderID) then return end
	local query = scopedQuery("Update", "ix_squads_members", squad.owner)
	query:Update("squad_id", "NULL")
	query:Update("member_rank", 0)
	query:Where("character_id", characterID)
	query:WhereLT("member_rank", rank)
	query:WhereExpr(actorCondition(actor:GetID(), squad.owner, rank))
	query:WhereExpr(activeCondition(squad.owner))
	mutate(query)
end

function cross.Leave(client)
	local actor = client:GetCharacter()
	local squad = actor and ix.squad.list[actor:GetSquadID()]
	if (not squad or squad.leaderID == actor:GetID()) then return end
	local query = scopedQuery("Update", "ix_squads_members", squad.owner)
	query:Update("squad_id", "NULL")
	query:Update("member_rank", 0)
	query:Where("character_id", actor:GetID())
	query:WhereLT("member_rank", 2)
	mutate(query)
end

function cross.Disband(id, leaderID)
	if (not leaderID) then return end
	local query = scopedQuery("Update", "ix_squads_state", id)
	query:Update("active", 0)
	query:UpdateValue("revision", mysql.Add(mysql.Column("revision"), 1))
	query:Where("active", 1)
	query:Where("leader_id", leaderID)
	mutate(query)
end

function cross.SaveSettings(client, data)
	local actor = client:GetCharacter()
	if (not actor) then return end
	local id = actor:GetSquadID()
	local values = {}
	if (isstring(data.name)) then
		local name = string.Trim(data.name:gsub("[\r\n]", "")):utf8sub(1, 48)
		if (name ~= "") then values.name = name end
	end
	if (isstring(data.description)) then
		values.description = data.description:utf8sub(1, 2048)
	end
	if (ix.util.IsColor(data.color)) then
		local color = data.color
		color = Color(math.Clamp(color.r, 0, 255), math.Clamp(color.g, 0, 255), math.Clamp(color.b, 0, 255))
		values.color = string.FromColor(color)
	end
	if (not next(values)) then return end
	local query = scopedQuery("Update", "ix_squads_state", id)
	for field, value in pairs(values) do query:Update(field, value) end
	query:UpdateValue("revision", mysql.Add(mysql.Column("revision"), 1))
	query:Where("active", 1)
	query:Where("leader_id", actor:GetID())
	query:WhereExpr(actorCondition(actor:GetID(), id, 2))
	mutate(query)
end

function cross.Invite(target, client)
	local actor, character = client:GetCharacter(), target:GetCharacter()
	local id = actor:GetSquadID()
	local inviteToken = token()
	local source = mysql:Select()
	for _, value in ipairs({scope(), character:GetID(), actor:GetID(), id, inviteToken}) do source:SelectValue(value) end
	source:SelectValue(mysql.Add(mysql.Now(), 30))
	source:WhereExpr(actorCondition(actor:GetID(), id, 1))
	source:WhereExpr(activeCondition(id))
	local query = mysql:Replace("ix_squads_invites")
	query:InsertFrom(source, {"scope", "character_id", "inviter_id", "squad_id", "token", "expires"})
	mutate(query, function(success)
		if not success then return end
		local stored = mysql:Select("ix_squads_invites")
		stored:Where("scope", scope())
		stored:Where("character_id", character:GetID())
		stored:Where("token", inviteToken)
		cross.Query(stored, function(rows, failure)
			if failure or not rows[1] then return end
			if IsValid(client) and client:GetCharacter() == actor then
				client:Notify("Squad invitation sent to " .. character:GetName() .. ".")
			end
		end)
	end)
end

function cross.AcceptInvite(client)
	local character = client:GetCharacter()
	local invite = client.squad_invite
	if (not character or not invite or tonumber(invite.character_id) ~= character:GetID()) then return end
	client.squad_invite = nil
	client.ixSquadInviteToken = nil
	client:SetLocalVar("squadInvite", nil)
	cross.EnsureMember(character:GetID(), function()
		if (not IsValid(client) or client:GetCharacter() ~= character) then return end
		local stored = scopedQuery("Select", "ix_squads_invites")
		stored:SelectValue(1)
		stored:Where("character_id", character:GetID())
		stored:Where("token", invite.token)
		stored:WhereExpr(mysql.Compare("expires", ">", mysql.Now()))
		local query = scopedQuery("Update", "ix_squads_members")
		query:Update("squad_id", invite.squad_id)
		query:Update("member_rank", 0)
		query:Where("character_id", character:GetID())
		query:WhereExpr(mysql.NotExists(existingAssignment()))
		query:WhereExpr(mysql.Exists(stored))
		query:WhereExpr(actorCondition(tonumber(invite.inviter_id), invite.squad_id, 1))
		query:WhereExpr(activeCondition(invite.squad_id))
		mutate(query, function()
			local delete = scopedQuery("Delete", "ix_squads_invites")
			delete:Where("character_id", character:GetID())
			delete:Where("token", invite.token)
			cross.Query(delete)
		end)
	end)
end

function cross.DeleteCharacter(character)
	local characterID = character:GetID()
	local state = scopedQuery("Update", "ix_squads_state")
	state:Update("active", 0)
	state:UpdateValue("revision", mysql.Add(mysql.Column("revision"), 1))
	state:Where("leader_id", characterID)
	mutate(state)
	local member = scopedQuery("Update", "ix_squads_members")
	member:Update("squad_id", "NULL")
	member:Update("member_rank", 0)
	member:Where("character_id", characterID)
	mutate(member)
	local session = cross.sessions[characterID]
	if (session) then cross.Release(characterID, session) end
end

function PLUGIN:Think()
	if (not cross.Enabled()) then return end
	if (not cross.ready) then
		if ((cross.nextInitialize or 0) < CurTime()) then
			cross.nextInitialize = CurTime() + 30
			cross.Initialize()
		end
		return
	end
	if ((cross.nextPoll or 0) > CurTime()) then return end
	cross.nextPoll = CurTime() + POLL_INTERVAL
	cross.Refresh()
end

-- Extend the public roster with display metadata, never the private squad roster.
PLUGIN["cotz/crossserver/roster-query"] = function(_, query)
	if (not cross.ready) then return end
	query:SelectColumn("s.squad_id", "squad_id")
	query:SelectColumn("s.name", "squad_name")
	query:SelectColumn("s.color", "squad_color")
	query:Join("ix_squads_members", "m", mysql.All(
		mysql.Compare("m.scope", "=", mysql.Column("p.scope")),
		mysql.Compare("m.character_id", "=", mysql.Column("p.character_id"))), "LEFT")
	query:Join("ix_squads_state", "s", mysql.All(
		mysql.Compare("s.scope", "=", mysql.Column("m.scope")),
		mysql.Compare("s.squad_id", "=", mysql.Column("m.squad_id")), mysql.Compare("s.active", "=", 1)), "LEFT")
end
