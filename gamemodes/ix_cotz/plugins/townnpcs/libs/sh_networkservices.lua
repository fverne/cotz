local PLUGIN = PLUGIN
local NETWORK_SERVICES = {
	search = "networkSearch", squads = "networkSquads", ranking = "networkRanking",
	activity = "networkActivity", location = "networkLocation", remote = "networkRemote", dossier = "networkDossier",
}
local BASIC_COUNTERS = {"tasksCompleted", "mutantsKilled", "humansKilled"}

function PLUGIN:GetNetworkAccess(character)
	local access = {}
	for key, service in pairs(NETWORK_SERVICES) do access[key] = self:HasService(character, service) end

	return access
end

function PLUGIN:FilterNetworkRecord(character, record, access)
	access = access or self:GetNetworkAccess(character)
	if record.map ~= game.GetMap() and not access.remote then return end
	local result = table.Copy(record)
	local profile = result.profile or {}
	if type(profile) == "string" then profile = util.JSONToTable(profile) or {} end
	local stats = {}
	if access.dossier then
		stats = profile.leaderboardStats or {}
	elseif access.activity then
		for _, key in ipairs(BASIC_COUNTERS) do stats[key] = (profile.leaderboardStats or {})[key] end
	end
	result.profile = {reputation = access.ranking and profile.reputation or 0, leaderboardStats = stats}
	result.networkRanking = access.ranking
	if not access.location then result.state = "unknown" result.destination = "" end

	return result
end
