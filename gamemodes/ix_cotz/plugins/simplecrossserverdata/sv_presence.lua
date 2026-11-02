local PLUGIN = PLUGIN
local cross = ix.crossserver or {}
cross.ready = false
cross.sessions = {}
ix.crossserver = cross
local POLL_INTERVAL = 5
local HEARTBEAT_INTERVAL = 15
local LEASE_SECONDS = 45
local QUERY_TIMEOUT = 15
local boot = util.SHA256(game.GetIPAddress() .. SysTime() .. math.random())
local serial = 0
util.AddNetworkString("cotz/crossserver/roster")

ix.config.Add("crossServerPresence", true, "Share character presence across servers using the schema database.", nil, {
	category = "Cross Server",
})

function cross.Enabled()
	return ix.config.Get("crossServerPresence", true)
end

local function scope()
	return Schema.folder
end

function cross.Query(query, callback)
	assert(istable(query) and query.Execute, "expected a mysql query object")
	local finished = false
	local function finish(rows, failure)
		if (finished) then return end
		finished = true
		if (callback) then callback(rows or {}, failure) end
	end

	timer.Simple(QUERY_TIMEOUT, function()
		if (finished) then return end
		ErrorNoHalt("[Cross Server] Database operation timed out.\n")
		finish(nil, "query timed out")
	end)
	query:Callback(function(rows) finish(rows) end)
	query:OnError(function(failure) finish(nil, failure) end)
	query:Execute()
end

local function token()
	serial = serial + 1
	return util.SHA256(boot .. serial)
end

cross.Scope = scope
cross.Token = token

local function presenceQuery(method, characterID)
	local query = mysql[method](mysql, "ix_squads_presence")
	query:Where("scope", scope())
	query:Where("character_id", characterID)

	return query
end

function cross.Initialize()
	if (not cross.Enabled() or cross.ready or cross.starting or not mysql:IsConnected()) then return end
	cross.starting = true
	-- Retain the original table name and live leases when upgrading the squad-owned implementation.
	local query = mysql:Create("ix_squads_presence")
	for name, definition in pairs({scope = "VARCHAR(64) NOT NULL", character_id = "INTEGER NOT NULL",
		session = "VARCHAR(64) NOT NULL", map = "VARCHAR(128)", destination = "VARCHAR(128)",
		state = "VARCHAR(16)", hidden = "INTEGER NOT NULL DEFAULT 0", expires = "INTEGER NOT NULL DEFAULT 0",
		name = "VARCHAR(255)", pdaavatar = "VARCHAR(255)"}) do
		query:Create(name, definition)
	end
	query:PrimaryKey({"scope", "character_id"})
	cross.Query(query, function(_, failure)
		cross.starting = false
		cross.ready = not failure
	end)
end

local function updateIdentity(query, client, character)
	query:Update("name", character:GetName())
	query:Update("pdaavatar", character:GetPdaavatar())
	query:Update("hidden", hook.Run("ShouldShowPlayerOnScoreboard", client) == false and 1 or 0)
end

function cross.Claim(client, character)
	if (not cross.ready) then return end
	local id = character:GetID()
	local existing = cross.sessions[id]
	if (existing and (existing.claimed or (existing.nextClaim or 0) > CurTime())) then return end
	local session = existing or {token = token(), character = character, client = client}
	session.nextClaim = CurTime() + POLL_INTERVAL
	cross.sessions[id] = session
	local insert = mysql:InsertIgnore("ix_squads_presence")
	insert:Insert("scope", scope())
	insert:Insert("character_id", id)
	insert:Insert("session", "")
	insert:Insert("expires", 0)
	cross.Query(insert, function(_, failure)
		if (failure or cross.sessions[id] ~= session) then return end
		if (not IsValid(client) or client:GetCharacter() ~= character) then cross.Release(id, session) return end
		local claim = presenceQuery("Update", id)
		claim:Update("session", session.token)
		claim:Update("map", game.GetMap())
		claim:Update("state", "online")
		claim:Update("destination", "")
		claim:UpdateValue("expires", mysql.Add(mysql.Now(), LEASE_SECONDS))
		updateIdentity(claim, client, character)
		claim:WhereExpr(mysql.Any(mysql.Compare("expires", "<=", mysql.Now()),
			mysql.Compare("session", "=", session.token), mysql.All(mysql.Compare("state", "=", "travelling"),
				mysql.Compare("destination", "=", game.GetMap()))))
		cross.Query(claim, function(_, claimFailure)
			if (claimFailure) then return end
			local read = presenceQuery("Select", id)
			read:Select("session")
			cross.Query(read, function(rows, readFailure)
				if (readFailure) then return end
				if (cross.sessions[id] ~= session) then cross.Release(id, session) return end
				if (not IsValid(client) or client:GetCharacter() ~= character) then cross.Release(id, session) return end
				if (not rows[1] or rows[1].session ~= session.token) then
					cross.sessions[id] = nil
					client:Notify("This character already has a live session on another server. Please try again shortly.")
					character:Kick()
					return
				end
				session.claimed = true
				cross.Heartbeat(id, session)
			end)
		end)
	end)
end

function cross.Release(id, session)
	if (cross.sessions[id] == session) then cross.sessions[id] = nil end
	if (session.travelling) then return end
	local query = presenceQuery("Update", id)
	query:Update("state", "offline")
	query:UpdateValue("expires", mysql.Now())
	query:Where("session", session.token)
	cross.Query(query)
end

function cross.Heartbeat(id, session)
	if (not session.claimed or session.travelling or session.writing) then return end
	local client, character = session.client, session.character
	if (not IsValid(client) or client:GetCharacter() ~= character) then cross.Release(id, session) return end
	session.writing = true
	local query = presenceQuery("Update", id)
	query:UpdateValue("expires", mysql.Add(mysql.Now(), LEASE_SECONDS))
	query:Where("session", session.token)
	updateIdentity(query, client, character)
	cross.Query(query, function(_, failure)
		if (failure) then session.writing = false return end
		local read = presenceQuery("Select", id)
		read:Select("session")
		cross.Query(read, function(rows, readFailure)
			session.writing = false
			if (readFailure or cross.sessions[id] ~= session) then return end
			if (not rows[1] or rows[1].session ~= session.token) then
				cross.sessions[id] = nil
				if (IsValid(client) and client:GetCharacter() == character) then
					client:Notify("This character's session moved to another server.")
					character:Kick()
				end
			end
		end)
	end)
end

function cross.BeginTransfer(character, destination, callback)
	local session = cross.sessions[character:GetID()]
	if (not session or not session.claimed) then callback(false) return end
	session.travelling = true
	local query = presenceQuery("Update", character:GetID())
	query:Update("state", "travelling")
	query:Update("destination", destination)
	query:UpdateValue("expires", mysql.Add(mysql.Now(), LEASE_SECONDS))
	query:Where("session", session.token)
	cross.Query(query, function(_, failure)
		if (failure) then session.travelling = false end
		callback(not failure)
	end)
end

local SNAPSHOT_CHUNK = 32
local ROSTER_STRINGS = {"name", "pdaavatar", "state", "map", "destination", "squadID", "squadName"}

local function writeRecord(record)
	net.WriteUInt(record.characterID, 32)
	for _, key in ipairs(ROSTER_STRINGS) do net.WriteString(record[key]) end
	net.WriteUInt(record.squadColor.r, 8)
	net.WriteUInt(record.squadColor.g, 8)
	net.WriteUInt(record.squadColor.b, 8)
end

local function sendSnapshot(client, records)
	for offset = 1, math.max(#records, 1), SNAPSHOT_CHUNK do
		local last = math.min(offset + SNAPSHOT_CHUNK - 1, #records)
		net.Start("cotz/crossserver/roster")
		net.WriteBool(true)
		net.WriteBool(offset == 1)
		net.WriteBool(last == #records)
		net.WriteUInt(math.max(last - offset + 1, 0), 6)
		for index = offset, last do writeRecord(records[index]) end
		net.Send(client)
	end
end

function cross.PublishRoster(rows)
	local records = {}
	for _, row in ipairs(rows) do
		records[#records + 1] = {
			characterID = tonumber(row.character_id), name = row.name or "",
			pdaavatar = row.pdaavatar or "vgui/icons/face_31.png", state = row.state,
			map = row.map or "", destination = row.destination or "",
			squadID = row.squad_id or "", squadName = row.squad_name or "",
			squadColor = row.squad_color and row.squad_color ~= "NULL"
				and string.ToColor(row.squad_color) or Color(105, 139, 87),
		}
	end
	local signature = util.TableToJSON(records)
	for _, client in ipairs(player.GetHumans()) do
		if (client:GetCharacter()) then
			if (client.ixPresenceSnapshot ~= signature) then
				sendSnapshot(client, records)
				client.ixPresenceSnapshot = signature
			else
				net.Start("cotz/crossserver/roster")
				net.WriteBool(false)
				net.Send(client)
			end
		end
	end
end

function cross.RefreshRoster()
	if (not cross.ready or cross.reading) then return end
	cross.reading = true
	local query = mysql:Select("ix_squads_presence"):Alias("p")
	query:SelectAll("p")
	query:WhereExpr(mysql.All(mysql.Compare("p.scope", "=", scope()), mysql.Compare("p.hidden", "=", 0),
		mysql.Compare("p.expires", ">", mysql.Now()), mysql.Any(mysql.Compare("p.state", "=", "online"),
			mysql.Compare("p.state", "=", "travelling"))))
	query:OrderByAsc("character_id")
	hook.Run("cotz/crossserver/roster-query", query)
	cross.Query(query, function(rows, failure)
		cross.reading = false
		if (not failure) then cross.PublishRoster(rows) end
	end)
end

function PLUGIN:Think()
	if (not cross.Enabled()) then return end
	if (not cross.ready) then
		if ((cross.nextInitialize or 0) <= CurTime()) then
			cross.nextInitialize = CurTime() + 30
			cross.Initialize()
		end
		return
	end
	if ((cross.nextPoll or 0) > CurTime()) then return end
	cross.nextPoll = CurTime() + POLL_INTERVAL
	for id, session in pairs(cross.sessions) do
		if (not IsValid(session.client) or session.client:GetCharacter() ~= session.character) then
			cross.Release(id, session)
		elseif ((session.nextHeartbeat or 0) <= CurTime()) then
			session.nextHeartbeat = CurTime() + HEARTBEAT_INTERVAL
			cross.Heartbeat(id, session)
		end
	end
	for _, client in ipairs(player.GetHumans()) do
		local character = client:GetCharacter()
		if (character) then cross.Claim(client, character) end
	end
	cross.RefreshRoster()
end

function PLUGIN:PlayerLoadedCharacter(client, character)
	client.ixPresenceSnapshot = nil
	if (cross.Enabled()) then cross.Claim(client, character) end
end

function PLUGIN:PrePlayerLoadedCharacter(client, character, lastCharacter)
	if (not lastCharacter) then return end
	local id = lastCharacter:GetID()
	local session = cross.sessions[id]
	if (session and session.client == client) then cross.Release(id, session) end
end

function PLUGIN:OnCharacterDisconnect(client, character)
	local id = character:GetID()
	local session = cross.sessions[id]
	if (session and session.client == client) then cross.Release(id, session) end
end

function PLUGIN:CharacterVarChanged(character, key)
	if (key ~= "name" and key ~= "pdaavatar") then return end
	local session = cross.sessions[character:GetID()]
	if (session) then cross.Heartbeat(character:GetID(), session) end
end

function PLUGIN:ShutDown()
	for id, session in pairs(cross.sessions) do cross.Release(id, session) end
end
