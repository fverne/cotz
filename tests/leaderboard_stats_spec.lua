local function copy(value)
	if type(value) ~= "table" then return value end
	local result = {}
	for key, item in pairs(value) do result[key] = copy(item) end
	return result
end
table.Copy = copy
ix = {jobs = {}}
dofile("gamemodes/ix_cotz/plugins/jobsystem/definitions/sh_killcredit.lua")
dofile("gamemodes/ix_cotz/plugins/jobsystem/libs/sh_leaderboard.lua")
local data = {}
local character = {
	GetData = function(_, key, default) return data[key] or default end,
	SetData = function(_, key, value) data[key] = value end,
}
ix.jobs.RecordLeaderboardKill(character, "npc_mutant_controller")
ix.jobs.RecordLeaderboardKill(character, "npc_mutant_controller_swamp")
ix.jobs.RecordLeaderboardKill(character, "npc_mutant_chimera_electro")
ix.jobs.RecordLeaderboardKill(character, "npc_human_bandit")
ix.jobs.RecordLeaderboardKill(character, "prop_physics")
local stats = ix.jobs.GetLeaderboardStats(data)
assert(stats.mutantsKilled == 3 and stats.humansKilled == 1)
assert(stats.rareMutantsKilled == 3, "overlapping groups must not multiply rare kills")
assert(stats.speciesKilled == 2, "variants share species and human factions are excluded")
assert(stats.species == nil, "public statistics omit the private species set")
ix.jobs.RecordLeaderboardTask(character, {tier = 3, fieldType = "sensor"}, {})
ix.jobs.RecordLeaderboardTask(character, {tier = 2, fieldType = "defence"}, {})
ix.jobs.RecordLeaderboardTask(character, {tier = 1, fieldType = "recovery"}, {})
stats = ix.jobs.GetLeaderboardStats(data)
assert(stats.tasksCompleted == 3 and stats.hardTasks == 1)
assert(stats.researchOperations == 2 and stats.recoveryOperations == 1)
ix.townNPCs = {
	contacts = {test = {progression = {{id = "one"}, {id = "two"}}}},
	StepID = function(_, slug, step) return slug .. "/" .. step end,
}
local progression = {lines = {["test/one"] = {completed = true}}}
assert(ix.jobs.GetLeaderboardStats(data, progression).favoriteContact == "test",
	"partial progression establishes a favorite")
progression.lines["test/two"] = {completed = true}
ix.townNPCs.contacts.other = {name = "Other", progression = {{id = "one"}, {id = "two"}}}
progression.lines["other/one"] = {completed = true}
assert(ix.jobs.GetLeaderboardStats(data, progression).favoriteContact == "test", "most completed steps wins")
progression.lines["other/two"] = {completed = true}
assert(ix.jobs.GetLeaderboardStats(data, progression).favoriteContact == "Other, test",
	"ties list every name in stable order")
assert(ix.jobs.GetLeaderboardStats({}, progression).favoriteContact == "Other, test",
	"favorite contacts read the separate progression var without generic data")
assert(ix.jobs.GetLeaderboardStats({}).favoriteContact == "None", "zero progress has no favorite")
assert(ix.jobs.GetLeaderboardStats({}).taskEarnings == 0, "old saves receive safe defaults")
assert(ix.jobs.GetLeaderboardStats({}).mutantsPoached == 0, "old saves default to zero poaches")
assert(ix.jobs.GetLeaderboardStats({leaderboardStats = {mutantsPoached = 7}}).mutantsPoached == 7)
print("leaderboard statistics: 14 checks passed")
