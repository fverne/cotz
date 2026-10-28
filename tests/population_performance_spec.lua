-- Run from the addon root: luatex --luaonly tests/population_performance_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local now, tick, created = 100, 1, 0
local currentMap = "rp_waystation"
game = {GetMap = function() return currentMap end}
local deferred, configValues, configMetadata, commands = {}, {}, {}, {}
local mutantMeta = {}
local includeRoot = "gamemodes/ix_cotz/plugins/eventcontroller/"
PLUGIN = {}
local clients, entities = {}, {}
local function vector(x)
	return {x = x, DistToSqr = function(self, other) return (self.x - other.x) ^ 2 end}
end
CurTime = function() return now end
EFL_NO_THINK_FUNCTION, NPC_STATE_IDLE = 4194304, 1
ix = {
	config = {
		Add = function(name, default, description, callback, data)
			configValues[name] = default
			configMetadata[name] = data
		end,
		Get = function(name, default)
			if configValues[name] == nil then return default end

			return configValues[name]
		end,
	},
	command = {Add = function(name, command) commands[name] = command end},
	util = {Include = function(path)
		dofile(includeRoot .. path)
	end},
}
ENT = mutantMeta
dofile("lua/entities/stalker_ai/sv_performance.lua")
engine = {TickCount = function() return tick end}
math.Rand = function(a) return a end
player = {Iterator = function() return ipairs(clients) end}
ents = {Iterator = function() return ipairs(entities) end}
IsValid = function(entity) return type(entity) == "table" and not entity.invalid end
timer = {Simple = function(_, callback) deferred[#deferred + 1] = callback end}
SafeRemoveEntity = function(entity)
	entity.invalid = true
	if PLUGIN.EntityRemoved then PLUGIN:EntityRemoved(entity) end
end
local function mutant(index, position)
	local entity = {
		index = index, position = vector(position), health = 100, state = 2, flags = 0,
		IsSTALKERNPC = true, IsAlive = true, grounded = true, class = "npc_mutant_dog",
	}
	entity.GetClass = function(self) return self.class end
	entity.IsNPC = function() return true end
	entity.Health = function(self) return self.health end
	entity.GetPos = function(self) return self.position end
	entity.EntIndex = function(self) return self.index end
	entity.GetEnemy = function(self) return self.enemy end
	entity.IsOnGround = function(self) return self.grounded end
	entity.IsEFlagSet = function(self) return self.flags ~= 0 end
	entity.AddEFlags = function(self, flag) self.flags = flag end
	entity.RemoveEFlags = function(self) self.flags = 0 end
	entity.GetNPCState = function(self) return self.state end
	entity.SetNPCState = function(self, state) self.state = state end
	entity.ClearSchedule = function(self) self.cleared = true end
	entity.ScheduleFinished = function(self) self.CurrentSchedule = nil end
	entity.EngineScheduleFinish = function(self) self.bDoingEngineSchedule = nil end
	entity.StopMoving = function(self) self.stopped = true end
	entity.NextThink = function(self, time) self.nextThink = time end
	entity.GetNetVar = function(self, key) return self[key] end
	entity.SetPos = function(self, position) self.position = position end
	entity.Spawn = function() end
	entity.DropToFloor = function() end

	return setmetatable(entity, {__index = mutantMeta})
end
ents.Create = function(class)
	created = created + 1
	local entity = mutant(created + 100, 0)
	entity.class = class

	return entity
end

dofile(includeRoot .. "sh_population.lua")
local performance = PLUGIN
local eventPlugin = PLUGIN
-- Exercise the real controller hook so maintenance cannot be lost to its spawn-point early return.
local sourceFile = assert(io.open(includeRoot .. "sh_plugin.lua"))
local source = sourceFile:read("*a")
sourceFile:close()
local firstThink = assert(source:find("function PLUGIN:Think()", 1, true))
local lastThink = assert(source:find("\n\tend", firstThink, true)) + 5
local thinkSource = source:sub(firstThink, lastThink):gsub("!=", "~="):gsub("!", "not ")
thinkSource = thinkSource:gsub("//([^\n]*)", "--%1")
assert(load("local populate, spawntime = false, 0\n" .. thinkSource, "@eventcontroller/Think", "t", _G))()
table.IsEmpty = function(value) return next(value) == nil end
PLUGIN.eventpoints = {}
check(ix.eventController == PLUGIN, "eventcontroller owns the AI services and population policy")
local function reset()
	performance.mutants = {}
	performance.corpses = {}
	clients = {}
	now, tick = now + 20, tick + 1
end
local function step()
	now, tick = now + 1, tick + 1
	PLUGIN:Think()
end
reset()
configValues.mutantLimit = 2
configValues.mutantRegionLimit = 1
local first = mutant(20, 0)
performance:RegisterMutant(first, true)
check(performance.mutants[first], "accepted mutants enter the registry")
local nearby = mutant(21, 10)
performance:RegisterMutant(nearby, true)
check(nearby.invalid and not performance.mutants[nearby], "regional limit rejects excess spawns")
local distant = mutant(22, 10000)
performance:RegisterMutant(distant, true)
check(performance.mutants[distant], "regional cap permits a different region")
local excess = mutant(23, 20000)
performance:RegisterMutant(excess, true)
check(excess.invalid, "global cap rejects excess spawns")
local existing = mutant(24, 30000)
performance:RegisterMutant(existing, false)
check(performance.mutants[existing], "initial scan does not delete existing population")
configValues.mutantLimit = 0
configValues.mutantRegionLimit = 0
check(eventPlugin:CanSpawnMutant(vector(0)), "zero population limits disable enforcement")

reset()
local entity = mutant(20, 10000)
performance:RegisterMutant(entity, false)
entity.CurrentSchedule, entity.bDoingEngineSchedule = {}, true
entity:STALKERNPCUpdateSleep()
check(entity.cotzSleeping and entity.flags ~= 0 and entity.stopped, "distant idle mutant stops engine Think")
check(entity.CurrentSchedule == nil and entity.bDoingEngineSchedule == nil,
	"sleep clears Lua and engine schedule bookkeeping")
local damage = {GetAttacker = function() return {} end}
PLUGIN:EntityTakeDamage(entity, damage)
check(not entity.cotzSleeping and entity.flags == 0 and entity.state == 2,
	"damage wakes immediately and restores state/engine thinking")
check(entity.nextThink == now, "damage schedules an immediate think")
entity:STALKERNPCUpdateSleep()
check(not entity.cotzSleeping, "combat grace prevents immediate resleep")
now = now + 16
entity:STALKERNPCUpdateSleep()
check(entity.cotzSleeping, "inactive mutant sleeps after combat grace")
clients = {{GetPos = function() return vector(5500) end}}
now = now + 1
entity:STALKERNPCUpdateSleep()
check(not entity.cotzSleeping, "player inside wake distance wakes mutant")
entity.cotzAwakeUntil = 0
clients = {{GetPos = function() return vector(4500) end}}
now = now + 1
entity:STALKERNPCUpdateSleep()
check(not entity.cotzSleeping, "hysteresis keeps an awake mutant awake between the two distances")
clients = {}
now = now + 1
entity.enemy = mutant(2, 10000)
entity:STALKERNPCUpdateSleep()
check(not entity.cotzSleeping, "off-screen combat remains active")
entity.enemy = nil
entity.PlayingAnimation = true
entity:STALKERNPCUpdateSleep()
check(not entity.cotzSleeping, "animation/attack timing prevents sleep")
check(entity:STALKERNPCGetThinkInterval() == 0, "active combat retains tick-rate Think")
entity.PlayingAnimation = false
check(entity:STALKERNPCGetThinkInterval() == 0.1, "idle Think is throttled")
entity.grounded = false
entity:STALKERNPCUpdateSleep()
check(not entity.cotzSleeping, "airborne mutants cannot be frozen mid-jump")
entity.grounded = true
entity.flags = EFL_NO_THINK_FUNCTION
entity:STALKERNPCUpdateSleep()
check(not entity.cotzSleeping, "existing external no-think flags are not owned/cleared")
entity.flags = 0
entity:STALKERNPCUpdateSleep()
configValues.mutantSleep = false
entity:STALKERNPCUpdateSleep()
check(not entity.cotzSleeping and entity.flags == 0, "disabling sleep restores sleeping entities")
configValues.mutantSleep = true

reset()
configValues.mutantSearchBudget = 1
local searchA, searchB = mutant(20, 0), mutant(40, 0)
check(searchA:STALKERNPCTryEnemySearch(), "first search gets the tick budget")
check(not searchB:STALKERNPCTryEnemySearch(), "second search waits when budget is exhausted")
tick = tick + 1
check(searchB:STALKERNPCTryEnemySearch(), "deferred searches can run next tick")
check(not searchA:STALKERNPCTryEnemySearch(), "search cooldown is retained")

reset()
configValues.mutantCorpseLimit = 1
local bodyA, bodyB = mutant(1, 10000), mutant(2, 20000)
performance:TrackCorpse(bodyA)
performance:TrackCorpse(bodyB)
step()
check(bodyA.invalid and not bodyB.invalid, "soft cap removes the oldest distant corpse")
bodyB.beingSkinned = true
now = now + 200
step()
check(not bodyB.invalid, "active skinning protects even an expired corpse")
bodyB.beingSkinned = false
step()
check(bodyB.invalid, "expired corpse is removed after skinning finishes")
reset()
clients = {{GetPos = function() return vector(0) end}}
local nearA, nearB = mutant(1, 0), mutant(2, 100)
performance:TrackCorpse(nearA)
performance:TrackCorpse(nearB)
step()
check(not nearA.invalid and not nearB.invalid, "soft cap preserves nearby lootable corpses")

reset()
local before = created
for i = 1, 3 do check(performance:QueueMutant("npc_mutant_dog", vector(i * 10000)), "spawn queued") end
step()
check(created == before + 2, "spawn queue obeys the per-tick budget")
step()
check(created == before + 3, "remaining spawns run on later ticks")
clients = {{GetPos = function() return vector(0) end}}
performance:QueueMutant("npc_mutant_dog", vector(0), 1500)
step()
check(created == before + 3, "queued spawns recheck player safety")
performance:QueueMutant("npc_mutant_dog", vector(50000))
now = now + 31
step()
check(created == before + 3, "expired queued spawns do not execute")
configValues.mutantLimit = 3
performance:QueueMutant("npc_mutant_dog", vector(70000))
step()
check(created == before + 3, "queued spawn rechecks population cap before creating an entity")
configValues.mutantLimit = 0
reset()
configValues.eventControllerThreshold = 3
local accepted = 0
for i = 1, 5 do
	if performance:QueueMutant("npc_mutant_dog", vector(i * 10000), nil, true) then accepted = accepted + 1 end
end
check(accepted == 3, "routine group is clamped to the remaining event-controller target")
check(eventPlugin:GetNumMutants() == 0 and eventPlugin:GetNumMutants(true) == 3,
	"event controller includes pending mutants in its target count")
check(not eventPlugin:CanPopulateMutant(nil, true), "queued reservations stop another group at equality")
configValues.eventControllerThreshold = 1
local beforeLowering = created
step()
step()
check(created == beforeLowering + 1, "queue execution rechecks a lowered event-controller target")
reset()
configValues.eventControllerThreshold = 70
configValues.eventControllerThreshold_rp_waystation = 12
configValues.mutantLimit_rp_waystation = 8
check(eventPlugin:GetMutantTarget() == 8, "map target is clamped by the hard map limit")
configValues.mutantLimit_rp_waystation = 0
check(eventPlugin:GetMutantTarget() == 12, "map target remains active when the hard cap is disabled")
currentMap = "rp_marsh_cs"
check(eventPlugin:GetMutantTarget() == 70, "another map inherits the shared controller target")
currentMap = "rp_waystation"
configValues.eventControllerThreshold_rp_waystation = 0
check(not eventPlugin:CanPopulateMutant(nil, true), "zero map target stops routine mutants")
configValues.eventControllerThreshold_rp_waystation = -1
configValues.mutantLimit_rp_waystation = -1

local dead = mutant(870, 0)
dead.IsAlive = false
performance:RegisterMutant(dead, false)
local human = mutant(871, 0)
human.class = "npc_human_bandit"
performance:RegisterMutant(human, false)
check(eventPlugin:GetNumMutants() == 0, "dead mutants and human NPCs do not consume the mutant target")
check(performance:QueueMutant("npc_mutant_dog", vector(50000), nil, true), "routine request queues with active policy")
eventPlugin:OnUnload()
local createdBeforePolicyUnload = created
step()
check(created == createdBeforePolicyUnload, "pending routine request cancels when eventcontroller unloads")
ix.eventController = eventPlugin
check(eventPlugin:GetPopulationStatus():find("queued: 0", 1, true), "unload discards the pending queue")

for _ = 1, 512 do assert(performance:QueueMutant("npc_mutant_dog", vector(0))) end
check(not performance:QueueMutant("npc_mutant_dog", vector(0)), "outstanding queue is bounded")
local pending = #deferred
local prop = mutant(1, 0)
prop.class = "prop_physics"
PLUGIN:OnEntityCreated(prop)
check(#deferred == pending, "non-mutant entity creation does not allocate registration timers")

check(commands.PopulationStatus.adminOnly == true, "population status is a Helix admin-only command")
check(commands.PopulationStatus:OnRun({}):find("Mutants:", 1, true), "admin command returns manager status")
local count = 0
for _, metadata in pairs(configMetadata) do
	count = count + 1
	check(metadata.category:find("^Performance") or metadata.category:find("^Spawning"),
		"config appears under its owning plugin category")
end
check(count == 21, "AI settings and event-controller map caps/targets are registered on every server")
check(configMetadata.mutantIdleInterval.data.decimals == 2, "fractional idle intervals remain editable")
-- Shared config must resolve only the current map's overrides, including zero values.
local savedGlobal, savedRegion = configValues.mutantLimit, configValues.mutantRegionLimit
configValues.mutantLimit, configValues.mutantRegionLimit = 128, 32
local globalLimit, regionLimit = eventPlugin:GetMutantLimits()
check(globalLimit == 128 and regionLimit == 32, "unset map caps inherit shared defaults")
configValues.mutantLimit_rp_waystation = 2
configValues.mutantRegionLimit_rp_waystation = 1
configValues.mutantLimit_rp_marsh_cs = 100
configValues.mutantRegionLimit_rp_marsh_cs = 20
globalLimit, regionLimit = eventPlugin:GetMutantLimits()
check(globalLimit == 2 and regionLimit == 1, "waystation resolves its own smaller limits")
check(commands.PopulationStatus:OnRun({}):find("limits: 2 global / 1 regional", 1, true),
	"status reports the effective map-specific caps")
performance.mutants = {}
local mapResident = mutant(850, 0)
performance:RegisterMutant(mapResident, false)
check(not eventPlugin:CanSpawnMutant(vector(0)), "map regional cap is enforced")
check(eventPlugin:CanSpawnMutant(vector(10000)), "different region can fill the map global cap")
performance:RegisterMutant(mutant(851, 10000), false)
check(not eventPlugin:CanSpawnMutant(vector(20000)), "map global cap is enforced across regions")
currentMap = "rp_marsh_cs"
globalLimit, regionLimit = eventPlugin:GetMutantLimits()
check(globalLimit == 100 and regionLimit == 20, "same shared config gives marsh its independent limits")
currentMap = "rp_waystation"
configValues.mutantLimit_rp_waystation = 0
configValues.mutantRegionLimit_rp_waystation = 0
check(eventPlugin:CanSpawnMutant(vector(0)), "explicit zero disables map caps instead of inheriting")
configValues.mutantRegionLimit_rp_waystation = -1
globalLimit, regionLimit = eventPlugin:GetMutantLimits()
check(globalLimit == 0 and regionLimit == 32, "each map cap can independently inherit")
currentMap = "custom_map"
globalLimit, regionLimit = eventPlugin:GetMutantLimits()
check(globalLimit == 128 and regionLimit == 32, "unknown maps safely use the shared defaults")
currentMap = "rp_waystation"
configValues.mutantLimit_rp_waystation, configValues.mutantRegionLimit_rp_waystation = -1, -1
configValues.mutantLimit_rp_marsh_cs, configValues.mutantRegionLimit_rp_marsh_cs = -1, -1
configValues.mutantLimit, configValues.mutantRegionLimit = savedGlobal, savedRegion
performance.mutants = {}

local sleeper = mutant(800, 10000)
performance:RegisterMutant(sleeper, false)
sleeper:STALKERNPCUpdateSleep()
check(sleeper.cotzSleeping, "unload test starts with a sleeping mutant")
local corpse = mutant(801, 10000)
corpse.Fire = function(self, input, _, delay) self.cleanup = {input, delay} end
performance:TrackCorpse(corpse)
local late = mutant(802, 10000)
PLUGIN:OnEntityCreated(late)
local lateRegistration = deferred[#deferred]
PLUGIN:OnUnload()
check(ix.eventController == nil and not sleeper.cotzSleeping and sleeper.flags == 0,
	"plugin unload clears the service and wakes its sleeping mutants")
check(corpse.cleanup[1] == "kill" and corpse.cleanup[2] >= 30,
	"unloading retains a bounded corpse cleanup fallback")
lateRegistration()
check(performance.mutants[late] == nil, "pending registration cannot run after unload")
local createdBeforeUnload = created
PLUGIN:Think()
check(created == createdBeforeUnload, "cached plugin Think cannot spawn from an unloaded queue")
check(commands.PopulationStatus:OnRun({}):find("unavailable", 1, true), "status handles an unloaded controller")
local savedIx = ix
ix = nil
local standalone = mutant(820, 0)
check(standalone:STALKERNPCGetThinkInterval() == 0.1, "base AI has defaults outside Helix")
check(standalone:STALKERNPCTryEnemySearch(), "standalone AI can search without the plugin")
standalone:STALKERNPCUpdateSleep()
check(not standalone.cotzSleeping, "standalone AI cannot sleep without a wake manager")
ix = savedIx

print(string.format("PASS: %d population performance checks", checks))
