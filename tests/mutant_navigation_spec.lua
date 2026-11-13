-- Run from the addon root: luatex --luaonly tests/mutant_navigation_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local vectorMeta = {}
vectorMeta.__index = vectorMeta
function Vector(x, y, z)
	return setmetatable({x = x or 0, y = y or 0, z = z or 0}, vectorMeta)
end
function vectorMeta.__add(a, b) return Vector(a.x + b.x, a.y + b.y, a.z + b.z) end
function vectorMeta.__sub(a, b) return Vector(a.x - b.x, a.y - b.y, a.z - b.z) end
function vectorMeta.__mul(a, b) return Vector(a.x * b, a.y * b, a.z * b) end
function vectorMeta:GetNormalized()
	local length = math.sqrt(self.x ^ 2 + self.y ^ 2 + self.z ^ 2)
	return length == 0 and Vector() or self * (1 / length)
end
function vectorMeta:Angle() return {y = math.deg(math.atan(self.y, self.x))} end
function vectorMeta:DistToSqr(other)
	return (self.x - other.x) ^ 2 + (self.y - other.y) ^ 2 + (self.z - other.z) ^ 2
end
function vectorMeta:Distance(other) return math.sqrt(self:DistToSqr(other)) end

local now = 0
function CurTime() return now end
function IsValid(entity) return type(entity) == "table" and not entity.removed end
function isnumber(value) return type(value) == "number" end
SCHED_COMBAT_FACE, SCHED_FORCED_GO_RUN, SCHED_MOVE_AWAY_FROM_ENEMY = 1, 2, 3
SCHED_CHASE_ENEMY, SCHED_IDLE_WANDER, SCHED_RUN_RANDOM = 4, 5, 6
SCHED_TAKE_COVER_FROM_ENEMY, SCHED_RUN_FROM_ENEMY = 7, 8
MASK_NPCSOLID, MASK_WATER = 1, 2
vector_origin = Vector()
GetConVar = function()
	return {GetInt = function() return 0 end, GetFloat = function() return 600 end}
end
math.Rand = function(low, high) return (low + high) / 2 end
player = {Iterator = function() return ipairs({}) end}
local noGround, blocked, water, steep, noSupport = true, false, false, false, false
local traceCalls = 0
util = {
	TraceHull = function(data)
		traceCalls = traceCalls + 1
		if blocked then return {Hit = true, StartSolid = true} end
		if not noGround and data.start.z > 0 and data.endpos.z < 0 then
			return {Hit = true, HitWorld = true, HitPos = Vector(data.endpos.x, data.endpos.y, 0),
				HitNormal = Vector(0, 0, steep and 0.2 or 1)}
		end

		return {Hit = false}
	end,
	TraceLine = function() return {HitWorld = not noSupport, HitNormal = Vector(0, 0, 1)} end,
	IsInWorld = function() return true end,
	PointContents = function() return water and MASK_WATER or 0 end,
}
bit = {band = function(contents) return contents end}

local file = assert(io.open("lua/entities/stalker_ai/schedules.lua"))
local source = file:read("*a")
file:close()
source = source:gsub("!=", "~="):gsub("&&", " and "):gsub("||", " or "):gsub("!", "not ")
ENT = {}
dofile("lua/entities/stalker_ai/sv_navigation.lua")
assert(load(source, "@lua/entities/stalker_ai/schedules.lua"))()
local mutantMeta = ENT

local function target(isPlayer)
	return {
		position = Vector(400),
		GetPos = function(self) return self.position end,
		OBBCenter = function() return Vector(0, 0, 32) end,
		OBBMins = function() return Vector(0, 0, 0) end,
		OBBMaxs = function() return Vector(0, 0, 72) end,
		IsNPC = function() return not isPlayer end,
		IsPlayer = function() return isPlayer end,
		Alive = function(self) return not self.dead end,
		VisibleVec = function(self) return not self.hidden end,
	}
end

local function mutant(enemy)
	now = 0
	return setmetatable({
		enemy = enemy,
		position = Vector(),
		PlayingAnimation = false,
		MinRangeDist = 0,
		MaxRangeDist = 1200,
		MeleeAttackDistanceMin = 0,
		MeleeAttackDistance = 80,
		RangeSchedule = SCHED_CHASE_ENEMY,
		HiddenSchedule = SCHED_CHASE_ENEMY,
		VisibleSchedule = SCHED_CHASE_ENEMY,
		schedules = {},
		unreachable = true,
		GetEnemy = function(self) return self.enemy end,
		GetGravity = function() return 1 end,
		IsRunningBehavior = function() return false end,
		EmitSound = function() end,
		STALKERNPCPlayAnimation = function(self) self.PlayingAnimation = true end,
		STALKERNPCMakeMeleeAttack = function() end,
		IsOnGround = function(self) return not self.airborne end,
		IsGoalActive = function(self) return self.goalActive or false end,
		GetGoalPos = function(self) return self.destination end,
		OBBMins = function() return Vector(-16, -16, 0) end,
		OBBMaxs = function() return Vector(16, 16, 64) end,
		Health = function(self) return self.health or 100 end,
		GetMaxHealth = function() return 100 end,
		StopMoving = function(self) self.stopped = true end,
		SetPos = function(self, position) self.position, self.relocated = position, true end,
		SetLocalVelocity = function(self, velocity) self.velocity = velocity end,
		MaintainActivity = function(self) self.maintained = true end,
		GetPos = function(self) return self.position end,
		OBBCenter = function() return Vector(0, 0, 32) end,
		VisibleVec = function(self) return not self.enemy.hidden end,
		IsUnreachable = function(self) return self.unreachable end,
		STALKERNPCEnemyInMeleeRange = function(self, _, minimum, maximum)
			check(minimum == 0 and maximum == 80, "recovery uses the mutant's configured melee range")

			return self.meleeRange or 0
		end,
		SetSchedule = function(self, schedule)
			self:StartEngineSchedule(schedule)
			self.schedule = schedule
			self.schedules[#self.schedules + 1] = schedule
		end,
		IsCurrentSchedule = function(self, schedule) return self.schedule == schedule end,
		SetLastPosition = function(self, position) self.destination = position end,
		ClearSchedule = function(self) self.schedule = nil end,
	}, {__index = mutantMeta})
end

local function selectAt(actor, time)
	now = time
	actor:SelectSchedule()
end

local function exhaustRetries(actor)
	for _, time in ipairs({0, 1, 3, 5}) do selectAt(actor, time) end
end

local function applySpecies(entity, name)
	local definition = assert(io.open("lua/entities/npc_mutant_" .. name .. "/init.lua"))
	local contents = definition:read("*a")
	definition:close()
	local declarations = {}
	for line in contents:gmatch("[^\n]+") do
		if line:match("^ENT%.navigation") then declarations[#declarations + 1] = line end
	end
	assert(load(table.concat(declarations, "\n"), "@" .. name, "t", {ENT = entity}))()
	local start = assert(contents:find("function ENT:STALKERNPCDistanceForMeleeTooBig(", 1, true))
	local finish = contents:find("\nfunction ENT:", start + 1, true)
	local callback = contents:sub(start, finish and finish - 1 or #contents)
	callback = callback:gsub("!=", "~="):gsub("&&", " and "):gsub("||", " or "):gsub("!", "not ")
	callback = callback:gsub("//([^\n]*)", "--%1")
	local methods = {}
	assert(load(callback, "@" .. name .. ":attack", "t", setmetatable({ENT = methods}, {__index = _G})))()
	entity.STALKERNPCDistanceForMeleeTooBig = methods.STALKERNPCDistanceForMeleeTooBig
	entity.CanJump, entity.CanLongJump, entity.CanBigJump, entity.NextAbilityTime = 0, 0, 0, 0
	entity.CanSuck = 1000
end

for _, isPlayer in ipairs({true, false}) do
	local actor = mutant(target(isPlayer))
	selectAt(actor, 0)
	check(actor.schedule == SCHED_COMBAT_FACE, "a path failure starts only a short grace period")
	for i = 1, 9 do selectAt(actor, i / 10) end
	check(#actor.schedules == 1, "the grace period cannot restart every frame")
	selectAt(actor, 1)
	check(actor.schedule == SCHED_FORCED_GO_RUN, "the first retry requests a real path")
	selectAt(actor, 3)
	actor.unreachable = false
	selectAt(actor, 4)
	check(actor.cotzUnreachableRecovery.retries == 2, "memory expiry does not replenish path retries")
	selectAt(actor, 5)
	check(actor.cotzNavigationRetreat and actor.schedule == SCHED_RUN_FROM_ENEMY,
		"failed player and NPC chases flee instead of holding when graph/floor sampling fails")
	actor.enemy.hidden, actor.enemy.position = true, Vector(9000)
	selectAt(actor, 6)
	check(actor.cotzNavigationRetreat and actor.cotzNavigationRetreat.enemyPosition.x == 400,
		"retreat survives occlusion without tracking hidden target movement")
end

local actor = mutant(target(true))
actor.unreachable = false
selectAt(actor, 0)
check(actor.schedule == SCHED_CHASE_ENEMY, "ordinary reachable combat remains unchanged")
check(actor:RunAI() == true, "normal combat continues to run native engine schedules")
actor = mutant(target(true))
actor.airborne = true
selectAt(actor, 0)
check(actor.schedule ~= nil, "an airborne flag alone cannot permanently block ordinary schedule selection")

actor = mutant(target(true))
selectAt(actor, 0)
selectAt(actor, 1)
actor.position, actor.unreachable = Vector(64), false
selectAt(actor, 2)
check(not actor.cotzUnreachableRecovery and actor.schedule == SCHED_CHASE_ENEMY,
	"successful path progress returns to ordinary combat")

actor = mutant(target(true))
actor.navigationRangedRange = 1500
exhaustRetries(actor)
check(actor.cotzNavigationRetreat, "a ranged attack range alone no longer creates an indefinite stationary hold")

local formerRandom = math.random
math.random = function() return 2 end
for _, name in ipairs({"dog", "rodent", "cat", "psydog", "psydog_phantom", "bear", "sprig", "pseudodog",
	"bloodsucker", "chimera", "chimera_fire", "chimera_electro", "snork", "vareshka", "tark",
	"pseudogiant_fast", "spider"}) do
	actor = mutant(target(true))
	applySpecies(actor, name)
	actor.enemy.position = Vector((actor.navigationLeapRange + (actor.navigationLeapMinRange or 0)) / 2)
	if name == "bloodsucker" then actor.enemy.position = Vector(60, 0, -40) end
	selectAt(actor, 1)
	check(actor:STALKERNPCNavigationBusy(), name .. " starts a feasible jump even when the normal random roll fails")
	check(not actor.cotzNavigationRetreat, name .. " uses a feasible jump before retreating")
	local schedules = #actor.schedules
	selectAt(actor, 1.1)
	check(#actor.schedules == schedules, name .. " protects the queued jump windup")
end

actor = mutant(target(true))
applySpecies(actor, "dog")
actor.enemy.position = Vector(150)
actor:STALKERNPCDistanceForMeleeTooBig()
check(not actor.isAttacking, "ordinary jump attacks still use their normal probability")
selectAt(actor, 1)
check(actor.isAttacking == 1 and actor.CanJump == 4, "an escape jump preserves the native cooldown")

actor = mutant(target(true))
applySpecies(actor, "dog")
actor.enemy.position = Vector(150)
actor.CanJump = 100
exhaustRetries(actor)
check(actor.cotzNavigationRetreat and not actor.isAttacking,
	"jump cooldowns cause retreat rather than an infinite hold")

actor = mutant(target(true))
applySpecies(actor, "spider")
actor.health, actor.enemy.position = 50, Vector(400)
exhaustRetries(actor)
check(actor.cotzNavigationRetreat and not actor.isAttacking, "wounded spiders cannot force a disabled leap")

for _, name in ipairs({"snork", "vareshka", "pseudogiant_fast"}) do
	actor = mutant(target(true))
	applySpecies(actor, name)
	actor.enemy.position = Vector(actor.navigationShortLeapRange / 2)
	selectAt(actor, 1)
	check(actor.isAttacking == 1, name .. " chooses its native short jump below the long-jump minimum")
end

actor = mutant(target(true))
applySpecies(actor, "dog")
actor.enemy.position = Vector(150)
local formerTrace = util.TraceHull
util.TraceHull = function() return {Hit = true, StartSolid = true} end
exhaustRetries(actor)
check(actor.cotzNavigationRetreat and not actor.isAttacking,
	"blocked jump arcs retreat instead of jumping through props")
util.TraceHull = formerTrace

actor = mutant(target(true))
applySpecies(actor, "dog")
actor.enemy.position = Vector(150)
util.TraceHull = function()
	return {Hit = true, HitWorld = true, HitPos = Vector(60, 0, 80), HitNormal = Vector(0, 0, -1)}
end
selectAt(actor, 1)
check(not actor.isAttacking, "a ceiling blocks a forced jump even when its endpoint is in range")
util.TraceHull = formerTrace

actor = mutant(target(true))
applySpecies(actor, "bloodsucker")
actor.enemy.position = Vector(50)
selectAt(actor, 1)
check(not actor.isAttacking, "a jump that falls below the target before arrival is rejected despite being in range")
math.random = formerRandom

noGround = false
actor = mutant(target(true))
local recovery = {position = actor.enemy.position}
ix = {eventController = {
	GetSpawnNodes = function() return {Vector(-4500), Vector(-3100), Vector(-2900), Vector(-2500)} end,
	TakeSearchBudget = function() return true end,
	ValidateCombatEnemy = function() end,
	UpdateCombatSchedule = function() end,
}}
actor:STALKERNPCWithdrawUnreachable(recovery)
check(actor.destination.x == -2500 and actor.schedule == SCHED_FORCED_GO_RUN,
	"retreat chooses a grounded node within 2000-3000 units, away from its target")
local schedules = #actor.schedules
actor.enemy.hidden, actor.enemy.position = true, Vector(8000)
actor.enemy = nil
selectAt(actor, 0.5)
check(actor.cotzNavigationRetreat and #actor.schedules == schedules,
	"losing the enemy does not cancel the retreat or restart its path every frame")
actor.position = Vector(-2500, 0, 2)
selectAt(actor, 1)
check(not actor.cotzNavigationRetreat, "retreat finishes after reaching its distant destination")

actor = mutant(target(true))
ix.eventController.GetSpawnNodes = function() return {Vector(2500), Vector(-2900)} end
actor:STALKERNPCWithdrawUnreachable({position = actor.enemy.position})
check(actor.destination.x == -2900, "retreat does not choose a destination reached by running toward the enemy")

actor = mutant(target(true))
ix.eventController.GetSpawnNodes = function() return {Vector(-2500), Vector(-2900)} end
actor:STALKERNPCWithdrawUnreachable({position = actor.enemy.position})
local retreat = actor.cotzNavigationRetreat
actor.goalActive, actor.position = true, Vector(-64)
now = 1
check(actor:STALKERNPCUpdateRetreat() and actor.cotzNavigationRetreat == retreat,
	"an active retreat keeps its original distance and deadline while making progress")
actor.goalActive = false
now = 3
actor:STALKERNPCUpdateRetreat()
check(actor.destination.x == -2900, "a failed retreat route tries the next distant candidate")

actor = mutant(target(true))
ix.eventController.GetSpawnNodes = function() return {Vector(-2500)} end
actor:STALKERNPCWithdrawUnreachable({position = actor.enemy.position})
actor.enemy = nil
actor.goalActive = true
for tick = 1, 5 do
	now = tick
	local runEngine = actor:RunAI()
	check(runEngine == true, "retreat frames keep native movement enabled after enemy loss")
	actor.position = actor.position + Vector(-500)
end
now = 6
actor:RunAI()
check(not actor.cotzNavigationRetreat, "native movement can complete a persistent 2500-unit retreat")

actor = mutant(target(true))
ix.eventController.GetSpawnNodes = function() return {} end
actor:STALKERNPCWithdrawUnreachable({position = actor.enemy.position})
check(actor.destination and actor.destination:Distance(actor.position) >= 2000
	and actor.destination:Distance(actor.position) <= 3000,
	"missing distant graph nodes use grounded directional sampling instead of standing still")

actor = mutant(target(true))
ix.eventController.TakeSearchBudget = function() return false end
local traceCount = traceCalls
actor:STALKERNPCWithdrawUnreachable({position = actor.enemy.position})
check(traceCalls == traceCount, "retreat geometry searches respect the shared budget")
check(actor.schedule == SCHED_RUN_FROM_ENEMY, "budget exhaustion still starts native fleeing instead of standing still")
ix = nil

local function navigationAt(entity, time)
	now = time
	return entity:STALKERNPCUpdateNavigation()
end

local function stranded()
	local entity = mutant(target(true))
	entity.position = Vector(0, 0, 80)
	entity:STALKERNPCMoveToPosition(Vector(500, 0, 80), true)
	navigationAt(entity, 0)

	return entity
end

local function failWalks(entity)
	for time = 6, 15, 3 do navigationAt(entity, time) end
end

actor = stranded()
navigationAt(actor, 5.5)
check(not actor.cotzNavigationRecovery, "brief movement stalls do not trigger physical recovery")
navigationAt(actor, 6)
check(actor.cotzNavigationRecovery.attempts == 1 and not actor.relocated,
	"a six-second stall starts walking to another destination before relocation")
schedules = #actor.schedules
navigationAt(actor, 6.1)
check(#actor.schedules == schedules, "navigation recovery is throttled between checks")
actor.cotzUnreachableRecovery = {retries = 2, approaches = 3}
actor.position = Vector(40, 0, 80)
navigationAt(actor, 6.5)
check(not actor.cotzNavigationRecovery and not actor.relocated,
	"actual movement ends recovery without relocation")
check(actor.cotzUnreachableRecovery.approaches == 3,
	"successful escape walking preserves the bounded target-approach budget")

actor = mutant(target(true))
actor:STALKERNPCMoveToPosition(Vector(400, 0, 80))
navigationAt(actor, 0)
navigationAt(actor, 20)
check(not actor.cotzNavigationRecovery, "unreachable elevated target goals alone do not diagnose a stranded mutant")

actor = mutant(target(true))
for time = 0, 30 do navigationAt(actor, time) end
check(not actor.cotzNavigationRecovery, "stationary idle mutants have no requested goal and are never unstuck")
actor:STALKERNPCHoldNavigationPosition()
for time = 32, 60 do navigationAt(actor, time) end
check(not actor.cotzNavigationRecovery, "intentional ranged holds are never treated as movement failures")

for _, field in ipairs({"PlayingAnimation", "isAttacking", "IsJumping", "IsLongJumping", "isBigJumping",
	"IsSuccing", "IsGrabbing", "IsSpitting", "SpecialAttack", "IsWarping"}) do
	actor = stranded()
	actor[field] = field == "PlayingAnimation" and true or 1
	navigationAt(actor, 20)
	check(not actor.cotzNavigationRecovery and not actor.relocated, field .. " protects attack and movement recovery")
end
actor = stranded()
actor.airborne = true
navigationAt(actor, 20)
check(not actor.cotzNavigationRecovery and not actor.relocated, "airborne mutants finish their landing naturally")

actor = stranded()
actor.health = 30
local enemy, pack, objective = actor.enemy, {}, {}
actor.cotzCombatPack, actor.cotzCombatObjective = pack, objective
failWalks(actor)
navigationAt(actor, 18)
check(actor.relocated and actor.position.z == 2 and not actor.cotzNavigationRecovery
	and actor.velocity == vector_origin, "confirmed stranded mutants can relocate unseen onto a supported lower surface")
check(actor.health == 30 and actor.enemy == enemy and actor.cotzCombatPack == pack
	and actor.cotzCombatObjective == objective, "relocation preserves damage, combat targets, packs and task ownership")

for _, reason in ipairs({"occupied", "water", "slope", "unsupported", "no ground"}) do
	actor = stranded()
	failWalks(actor)
	blocked, water, steep, noSupport, noGround = reason == "occupied", reason == "water", reason == "slope",
		reason == "unsupported", reason == "no ground"
	navigationAt(actor, 18)
	check(not actor.relocated, "relocation rejects " .. reason)
	blocked, water, steep, noSupport, noGround = false, false, false, false, false
end

for _, visibility in ipairs({"old position", "destination", "observer", "nearby"}) do
	local viewer = {
		GetPos = function() return visibility == "nearby" and Vector(100) or Vector(2000) end,
		TestPVS = function(_, point)
			return visibility == "old position" and type(point.GetPos) == "function"
				or visibility == "destination" and type(point.GetPos) ~= "function"
		end,
	}
	viewer.GetViewEntity = function()
		return visibility == "observer" and {TestPVS = function() return true end} or viewer
	end
	player.Iterator = function() return ipairs({viewer}) end
	actor = stranded()
	failWalks(actor)
	navigationAt(actor, 18)
	check(not actor.relocated, visibility .. " visibility prevents relocation")
end
player.Iterator = function() return ipairs({}) end

actor = stranded()
failWalks(actor)
actor.cotzNavigationSafePosition = Vector(10000)
navigationAt(actor, 18)
check(not actor.relocated, "recovery rejects saved positions outside its local relocation limit")
navigationAt(actor, 28)
check(actor.relocated, "an invalid saved position does not prevent later local recovery attempts")

actor = mutant(target(true))
actor.position = Vector(0, 0, 300)
actor:STALKERNPCMoveToPosition(Vector(500, 0, 300), true)
navigationAt(actor, 0)
failWalks(actor)
actor.cotzNavigationSafePosition = Vector(100, 0, 0)
navigationAt(actor, 18)
check(not actor.relocated, "recovery rejects excessive vertical relocation even to a previously saved position")

actor = mutant(target(true))
actor:STALKERNPCMoveToPosition(Vector(400))
actor.goalActive = true
navigationAt(actor, 0)
actor.position = Vector(40)
navigationAt(actor, 1)
check(actor.cotzNavigationSafePosition and actor.cotzNavigationSafePosition.x == 40,
	"safe positions are recorded only after walking progress and grounding checks")
actor.destination = Vector(40)
navigationAt(actor, 2)
check(not actor.cotzNavigationMotion and not actor.cotzNavigationIntent,
	"arrival at the actual path endpoint cancels stall tracking")

actor = stranded()
ix = {eventController = {TakeSearchBudget = function() return false end}}
local traces = traceCalls
navigationAt(actor, 6)
check(traceCalls == traces and actor.cotzNavigationRecovery.attempts == 0,
	"exhausting the shared search budget defers recovery without geometry scans or lost attempts")
ix = nil
local runsEngine = actor:RunAI()
check(runsEngine == true and actor.maintained,
	"RunAI keeps navigation recovery active without selecting a competing combat schedule")

for _, state in ipairs({"sleep", "dead", "disabled"}) do
	actor = stranded()
	if state == "sleep" then actor.cotzSleeping = true end
	if state == "dead" then actor.health = 0 end
	GetConVar = function() return {GetInt = function() return state == "disabled" and 1 or 0 end} end
	navigationAt(actor, 30)
	check(not actor.cotzNavigationRecovery and not actor.relocated, state .. " actors cannot trigger recovery")
end

print("PASS: " .. checks .. " mutant navigation checks")
