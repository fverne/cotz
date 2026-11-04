-- Run from the addon root: luatex --luaonly tests/anomaly_performance_spec.lua
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end
local function loadMethod(path, signature, indent, environment)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()
	local first = assert(source:find(signature, 1, true))
	local last = assert(source:find("\n" .. indent .. "end", first, true)) + #indent + 3
	local method = source:sub(first, last):gsub("!=", "~="):gsub("!", "not ")
	method = method:gsub("&&", " and "):gsub("||", " or "):gsub("//([^\n]*)", "--%1")
	assert(load(method, "@" .. path, "t", setmetatable(environment, {__index = _G})))()
end
local now, damageCount, boxQueries, nearby = 10, 0, 0, true
local vectorMeta = {}
vectorMeta.__index = vectorMeta
vectorMeta.__add = function(a, b) return setmetatable({x = a.x + b.x, y = a.y + b.y, z = a.z + b.z}, vectorMeta) end
function vectorMeta:DistToSqr(other)
	return (self.x - other.x) ^ 2 + (self.y - other.y) ^ 2 + (self.z - other.z) ^ 2
end
function vectorMeta:Distance(other)
	return math.sqrt(self:DistToSqr(other))
end
local function vector(x, y, z) return setmetatable({x = x, y = y or 0, z = z or 0}, vectorMeta) end
local victim = {
	IsPlayer = function() return true end,
	IsValid = function() return true end,
	Alive = function() return true end,
	GetPos = function() return vector(500) end,
	TakeDamageInfo = function() damageCount = damageCount + 1 end,
	EmitSound = function() end,
}
local function damage()
	local result = {}
	for _, method in ipairs({"SetDamage", "SetAttacker", "SetInflictor", "SetDamageType"}) do
		result[method] = function() end
	end

	return result
end
local function hazard(meta, id)
	local entity = setmetatable({cotzNextDamage = now, index = id}, {__index = meta})
	entity.Entity = entity
	entity.EntIndex = function(self) return self.index end
	entity.GetPos = function() return vector(0) end
	entity.GetModelBounds = function() return vector(-200, -200, 0), vector(200, 200, 200) end
	entity.NextThink = function(self, deadline) self.deadline = deadline end
	entity.EmitSound = function() end
	entity.GetNetVar = function(self) return self.range or 600 end

	return entity
end
local red = {}
local environment = {
	ENT = red, CurTime = function() return now end, Vector = vector, DamageInfo = damage,
	ix = {eventController = {HasPlayerNear = function() return nearby end}},
	ents = {FindInBox = function() boxQueries = boxQueries + 1 return {victim} end},
	DMG_ACID = 1,
}
loadMethod("lua/entities/anom_redrazor/init.lua", "function ENT:Think()", "", environment)
local first, second = hazard(red, 1), hazard(red, 2)
first:Think()
second:Think()
check(damageCount == 2, "two red razors both damage in the same interval")
check(first.deadline == now + 0.3 and second.deadline == now + 0.3, "red razor schedules at its damage deadline")
first:Think()
check(damageCount == 2, "same anomaly cannot damage again before its cooldown")
now = now + 0.3
first:Think()
second:Think()
check(damageCount == 4, "exact damage deadline does not skip every other pulse")
nearby = false
local previous = boxQueries
first:Think()
check(boxQueries == previous and first.deadline == now + 1, "distant red razor avoids collision query")
nearby = true
local passive = {}
environment.ENT = passive
environment.damage = 5
environment.player = {Iterator = function() return ipairs({victim}) end}
loadMethod("gamemodes/ix_cotz/plugins/anomalycontroller/entities/entities/anom_passive/init.lua",
	"function ENT:Think()", "", environment)
local small, large = hazard(passive, 3), hazard(passive, 4)
small.range, large.range = 100, 1000
damageCount = 0
small:Think()
large:Think()
check(damageCount == 1, "passive anomalies use their own independent radius")
check(small.deadline == now + 0.2 and large.deadline == now + 0.2, "passive pulse schedules at 0.2 seconds")
local fuzz = {}
environment.ENT = fuzz
loadMethod("lua/entities/sanom_burntfuzz/init.lua", "function ENT:Think()", "", environment)
local burning = hazard(fuzz, 5)
burning.SleepTimer = now + 100
burning.damageCooldown = now
burning.shouldResetSequence = false
burning:Think()
check(damageCount == 2 and burning.deadline == now + 0.3, "burnt fuzz damages on the exact scheduled deadline")
burning.IsSleeping = true
previous = boxQueries
burning:Think()
check(boxQueries == previous and burning.deadline == now + 1, "sleeping burnt fuzz skips damage queries")

local bead = {}
environment.ENT = bead
environment.IsValid = function(entity) return entity ~= nil end
environment.SIM_NOTHING = 0
loadMethod("lua/entities/anom_bead/init.lua", "function ENT:Think()", "", environment)
loadMethod("lua/entities/anom_bead/init.lua", "function ENT:PhysicsSimulate(", "", environment)
local floating = hazard(bead, 6)
local physics = {EnableMotion = function(self, active) self.active = active end, Wake = function() end}
floating.GetPhysicsObject = function() return physics end
floating.ShouldWake = function() return nearby end
floating.SoundTime = now + 100
nearby = false
floating:Think()
check(physics.active == false, "distant floating anomaly freezes its physics")
check(floating:PhysicsSimulate(physics, 0.01) == 0, "sleeping floating anomaly skips tracing/forces")
nearby = true
floating:Think()
check(physics.active == true and not floating.IsSleeping, "floating anomaly resumes physics near players")

local plugin = {}
local threshold, starts = 1, 0
table.Count = function(value) local count = 0 for _ in pairs(value) do count = count + 1 end return count end
local pluginEnvironment = {
	PLUGIN = plugin,
	isClear = function() return true end,
	ix = {config = {Get = function(key)
		check(key == "eventControllerAdvThreshold", "event limit uses the registered setting")
		return threshold
	end}},
}
loadMethod("gamemodes/ix_cotz/plugins/eventcontrolleradv/sh_plugin.lua", "function PLUGIN:spawnEvent(", "\t",
	pluginEnvironment)
plugin.currentEvents = {named_event = {}}
plugin.eventdefs = {new_event = {
	funcPrestart = function(data) starts = starts + 1 return data end,
	funcStart = function(data) return data end,
}}
plugin:spawnEvent({vector(0)}, {key = "new_event"})
check(starts == 0, "string-keyed active event counts enforce the cap")
threshold = 2
plugin:spawnEvent({vector(0)}, {key = "new_event"})
check(starts == 1 and table.Count(plugin.currentEvents) == 2, "event spawns below the configured cap")
plugin:spawnEvent({vector(0)}, {key = "new_event"})
check(starts == 1, "repeat event cannot exceed the cap")

local populateCalls = 0
plugin.populate, plugin.populateAmount = true, 2
plugin.currentEvents = {}
plugin.updatetime, plugin.spawntime = now + 100, now + 100
plugin.MapToDifficultyMap = {test = 1}
plugin.eventpoints = {{vector(0)}}
plugin.eventdefs = {test = {difficulty = 1, allowedPoints = {1}}}
plugin.spawnEvent = function() populateCalls = populateCalls + 1 end
pluginEnvironment.CurTime = function() return now end
pluginEnvironment.game = {GetMap = function() return "test" end}
table.Random = function(values) return values[1] end
loadMethod("gamemodes/ix_cotz/plugins/eventcontrolleradv/sh_plugin.lua", "function PLUGIN:Think()", "\t",
	pluginEnvironment)
plugin:Think()
check(populateCalls == 1 and plugin.populate, "initial population attempts one event per tick")
plugin:Think()
check(populateCalls == 2 and not plugin.populate, "population stops after its configured number of attempts")

vectorMeta.__sub = function(a, b) return vector(a.x - b.x, a.y - b.y, a.z - b.z) end
function vectorMeta:Angle() return {Yaw = self.x >= 0 and 0 or 180} end
local searchMeta, positionReads, angleReads = {}, 0, 0
local function candidate(position)
	return {
		GetPos = function() return vector(position) end,
		GetClass = function() return "player" end,
		IsNPC = function() return false end,
		IsPlayer = function() return true end,
	}
end
local far, close, behind = candidate(500), candidate(50), candidate(-10)
local searchEnvironment = {
	ENT = searchMeta, IsValid = function(value) return type(value) == "table" end,
	ents = {FindInSphere = function(_, range)
		check(range == 1500, "target query retains its original radius")
		return {far, close, behind}
	end},
}
loadMethod("lua/entities/stalker_ai/init.lua", "function ENT:STALKERNPCTryToFindEnemy()", "", searchEnvironment)
local hunter = setmetatable({
	PlayingAnimation = false, NearestEnemyFindDistance = 0,
	GetPos = function() positionReads = positionReads + 1 return vector(0) end,
	GetAngles = function() angleReads = angleReads + 1 return {Yaw = 0} end,
	STALKERNPCIsEnemyPlayer = function() return true end,
	GetEnemy = function(self) return self.enemy end,
	SetEnemy = function(self, enemy) self.enemy = enemy end,
	AddEntityRelationship = function() end,
	UpdateEnemyMemory = function() end,
	SelectSchedule = function() end,
}, {__index = searchMeta})
hunter:STALKERNPCTryToFindEnemy()
check(hunter.enemy == close, "nearest eligible forward target is selected")
check(positionReads == 1 and angleReads == 1, "search caches its own transform once for all candidates")

print(string.format("PASS: %d anomaly/event performance checks", checks))
