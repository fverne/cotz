local PLUGIN = PLUGIN
local MUTANT_REPORT_SERVICES = {
	rp_marsh_cs = "mutantReportsSwamps",
	rp_garbage_cotz = "mutantReportsGarbage",
	rp_waystation = "mutantReportsWaystation",
	rp_pripyat_remaster = "mutantReportsPripyat",
}

function PLUGIN:GetNetworkAccess(character)
	return {search = true, squads = true, ranking = true, activity = true,
		location = true, dossier = true, remote = true}
end

function PLUGIN:CanReceiveMutantReports(character, map)
	local service = MUTANT_REPORT_SERVICES[map]

	return service ~= nil and self:HasService(character, service)
end

function PLUGIN:FilterNetworkRecord(character, record, access)
	local result = table.Copy(record)
	local profile = result.profile or {}
	if type(profile) == "string" then profile = util.JSONToTable(profile) or {} end
	result.profile = {reputation = profile.reputation or 0, leaderboardStats = profile.leaderboardStats or {}}
	result.networkRanking = true

	return result
end
