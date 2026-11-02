-- Run from the addon root: luatex --luaonly tests/jobsystem_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local base = "gamemodes/ix_cotz/plugins/jobsystem/"
local callbacks, commands = {}, {}
local now = 1000
CurTime = function() return now end
IsValid = function(value) return type(value) == "table" and not value.invalid end
istable = function(value) return type(value) == "table" end
math.Clamp = function(value, minimum, maximum) return math.max(minimum, math.min(maximum, value)) end
local playerMeta = {}
FindMetaTable = function() return playerMeta end
ix = {
	util = {Include = function(path) dofile("gamemodes/" .. path) end},
	command = {Add = function(name, definition) commands[name] = definition end},
	type = {character = "character"},
	progression = {CanUseNPC = function() return true end},
}
netstream = {Hook = function(name, callback) callbacks[name] = callback end}
dofile(base .. "libs/sh_00_definitions.lua")
dofile(base .. "libs/sh_jobs.lua")
dofile(base .. "libs/sh_tooljobs.lua")
dofile(base .. "sv_npcjobs.lua")
local jobs = ix.jobs
jobs.field.IsAvailable = function() return true end

check(jobs.getJobFromTier(100) == nil, "missing tiers return without retrying indefinitely")
jobs.register({name = "First", numberRec = 1, tier = 1, categories = {"first"}}, "example")
jobs.register({name = "Second", numberRec = 2, tier = 2, categories = {"second"}}, "example")
check(#jobs.jobsbycategory.first == 0 and #jobs.jobsbycategory.second == 1,
	"re-registration removes stale category memberships")
check(jobs.getJobFromTier(2) == "example", "tier selection only returns matching jobs")
check(jobs.getJobFromCategory("missing") == nil, "empty categories have no offer")
check(not jobs.isStructValid({name = "Broken", numberRec = {5, 2}}), "invalid count ranges rejected")
check(not jobs.isStructValid({name = "Broken", numberRec = "2"}), "invalid count types rejected")
check(not playerMeta.ixHasJobFromNPC({GetCharacter = function() end}, "Contact"),
	"job queries tolerate missing characters")

local offers = jobs.getNPCJobs("Contact", {"second"}, 2)
check(#offers == 2 and jobs.NPCHasJob("Contact", "example"), "NPC offers register on the server")
jobs.setNPCJobTaken("Contact", "example")
check(#jobs.getNPCJobs("Contact", {"second"}, 2) == 2, "sparse taken offers refill correctly")
check(not jobs.NPCHasJob("Unknown", "example"), "unknown NPC has no offer")
jobs.activejobs.Contact = {{identifier = "example", expiration = 0}}
check(not jobs.NPCHasJob("Contact", "example"), "expired offers cannot be claimed")
check(#jobs.getNPCJobs("Empty", {"missing"}, 2) == 0, "empty pools create no placeholder offers")
check(#jobs.getNPCJobs("Bounded", {"second"}, 9999) == jobs.settings.maxNPCOffers,
	"NPC offer counts are bounded")

local statsData = {}
local character = {
	GetData = function(_, key, default) return statsData[key] or default end,
	SetData = function(_, key, value) statsData[key] = value end,
}
local removed
local client = {
	GetCharacter = function() return character end,
	GetPos = function() return {DistToSqr = function() return 0 end} end,
	ixJobRemove = function(_, npc) removed = npc end,
}
local published
local target = {
	GetClass = function() return "ix_vendor_adv" end,
	GetDisplayName = function() return "'Computer'" end,
	CanAccess = function() return true end,
	GetPos = function() return {} end,
	SetNetVar = function(_, key, value) published = value end,
}
jobs.register({name = "Computer", numberRec = 1, categories = {"artifactcollect_computer"}}, "computer")
callbacks.job_updatenpcjobs(client, target, "'Computer'", {"second"}, 9999)
check(#published == 2 and published[1] == "computer", "client cannot choose categories or offer count")
published = nil
callbacks.job_updatenpcjobs(client, target, "'Computer'", {"second"}, 9999)
check(published == nil, "offer requests are rate limited")
now = now + 1
target.CanAccess = function() return false end
callbacks.job_updatenpcjobs(client, target, "'Computer'")
check(published == nil, "NPC access is checked")
now = now + 1
target.CanAccess = function() return true end
target.GetPos = function() return {} end
client.GetPos = function() return {DistToSqr = function() return 1000000 end} end
callbacks.job_updatenpcjobs(client, target, "'Computer'")
check(published == nil, "remote NPC requests rejected")
now = now + 1
callbacks.job_removeplayerjob(client, {})
check(removed == nil, "malformed abandonment ignored")
now = now + 1
callbacks.job_removeplayerjob(client, "Contact")
check(removed == "Contact", "valid abandonment reaches character lifecycle")

jobs.list, jobs.jobsbycategory = {}, {}
for _, name in ipairs({"itemjobs_artifacts_pc", "itemjobs_artifacts", "itemjobs_meals", "itemjobs_parts",
	"itemjobs_world", "killjobs_humans", "killjobs_mutants", "specialjobs", "fieldjobs"}) do
	dofile(base .. "definitions/sh_" .. name .. ".lua")
end
local count = 0
for identifier, definition in pairs(jobs.list) do
	count = count + 1
	check(jobs.isStructValid(definition), "valid registered definition: " .. identifier)
end
check(count == 337, "all 304 ordinary, 18 tool and 15 field definitions load")
check(jobs.list.scanAreaEasy1.toolData.npoints == 1, "legacy tool count is editable data")
check(jobs.list.stashPackageNpc_hard.toolItem == "stashpackage_heavy", "legacy tool ID preserved")

local tool = jobs.list.scanAreaEasy1
local issued, removedTool
local data = {finished = true, npoints = 1, finishedtrigger = "scanAreaEasyComplete"}
local item = {
	uniqueID = "gasanalyzer",
	GetData = function(_, key) return data[key] end,
	Remove = function() removedTool = true end,
}
local inventory = {
	Add = function(_, id, quantity, initial) issued = {id = id, quantity = quantity, data = initial} return 1 end,
	GetItems = function() return {item} end,
}
table.Copy = function(value)
	local result = {}
	for key, entry in pairs(value) do result[key] = entry end

	return result
end
ix.item = {list = {gasanalyzer = {name = "Analyzer"}}}
ix.dialogue = {notifyItemGet = function() end, notifyItemLost = function() end}
character.GetInventory = function() return inventory end
client.Notify = function() end
check(tool.CanAcceptTask(client) and issued.id == "gasanalyzer" and issued.data.npoints == 1,
	"tool callbacks use editable tool item and initial data")
check(issued.data ~= tool.toolData, "issued tool state does not mutate definition defaults")
data.finishedtrigger = "anotherJob"
tool.OnTaskComplete(client)
check(not removedTool, "completion ignores tools for a different trigger")
data.finishedtrigger = "scanAreaEasyComplete"
tool.OnTaskComplete(client)
check(removedTool, "completion removes the matching finished tool")
inventory.Add = function() return false end
check(tool.CanAcceptTask(client) == false, "full inventory rejects legacy tool acceptance")

-- Kill credit must keep species/group overlap and credit nearby characters only once per trigger.
local events = {}
hook = {Run = function(_, recipient, trigger)
	events[recipient] = events[recipient] or {}
	events[recipient][trigger] = (events[recipient][trigger] or 0) + 1
end}
PLUGIN = {}
jobs.field.DefenceKilled = function() end
local neighbour = {IsPlayer = function() return true end, GetCharacter = function() return {} end}
client.IsPlayer = function() return true end
client.GetPos = function() return {} end
ents = {FindInSphere = function() return {client, neighbour} end}
dofile(base .. "sv_listeners.lua")
local npc = {GetClass = function() return "npc_human_z_bandit" end, GetPos = function() return {} end}
PLUGIN:OnNPCKilled(npc, client)
check(events[client].zombieKilled == 1 and events[client].groupHumanoidKilled == 2,
	"legacy overlapping zombie/human group credits preserved")
check(events[neighbour].zombieKilled == 1, "overlapping nearby scans do not duplicate recipients")
events = {}
npc.GetClass = function() return "npc_mutant_bloodsucker" end
PLUGIN:OnNPCKilled(npc, client)
check(events[client].mutantKilled == 1 and events[client].bloodsuckerKilled == 1
	and events[client].groupPredatorKilled == 1 and events[client].groupHumanoidKilled == 1,
	"species, family and general kill triggers preserved")

print("PASS: " .. checks .. " jobsystem checks")

check(statsData.leaderboardStats.mutantsKilled == 1, "personal mutant kill counted once")
