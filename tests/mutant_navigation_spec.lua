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
SCHED_TAKE_COVER_FROM_ENEMY = 7
MASK_NPCSOLID, MASK_WATER = 1, 2
vector_origin = Vector()
GetConVar = function() return {GetInt = function() return 0 end} end
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
	selectAt(actor, 0)
	selectAt(actor, 1)
	selectAt(actor, 3)
	selectAt(actor, 5)
	selectAt(actor, 7)
	selectAt(actor, 9)
	selectAt(actor, 11)
	selectAt(actor, 13)
end

for _, isPlayer in ipairs({true, false}) do
	local enemy = target(isPlayer)
	local actor = mutant(enemy)
	selectAt(actor, 0)
	check(actor.schedule == SCHED_COMBAT_FACE, "a first path failure starts a grace period instead of retreat")
	for i = 1, 9 do selectAt(actor, i / 10) end
	check(#actor.schedules == 1, "repeated schedule selections cannot restart the grace period")
	selectAt(actor, 1)
	check(actor.schedule == SCHED_FORCED_GO_RUN and actor.destination == enemy.position,
		"the first retry paths toward the visible target position despite stale unreachable memory")
	selectAt(actor, 2.9)
	check(#actor.schedules == 2, "retries are spaced out instead of restarting navigation every frame")
	selectAt(actor, 3)
	check(actor.schedule == SCHED_FORCED_GO_RUN and #actor.schedules == 3, "the second retry runs once")
	actor.unreachable = false
	selectAt(actor, 4)
	check(actor.cotzUnreachableRecovery.retries == 2, "engine memory expiry cannot renew the retry budget")
	for time = 5, 13, 2 do selectAt(actor, time) end
	check(actor.schedule == SCHED_COMBAT_FACE, "without usable graph nodes failed approaches hold instead of fleeing")
	selectAt(actor, 22)
	check(#actor.schedules == 4 and actor.enemy == enemy, "withdrawal does not restart navigation every frame")

	enemy.position = Vector(430)
	selectAt(actor, 22.1)
	check(actor.cotzUnreachableRecovery.retreating, "small target movement does not reset recovery")
	enemy.position = Vector(464)
	selectAt(actor, 22.2)
	check(not actor.cotzUnreachableRecovery and actor.schedule == SCHED_CHASE_ENEMY,
		"64 units of cumulative movement releases retreat and resumes ordinary combat")

	actor = mutant(target(isPlayer))
	exhaustRetries(actor)
	actor.enemy.position = Vector(400, 0, -64)
	selectAt(actor, 6)
	check(actor.schedule == SCHED_COMBAT_FACE and actor.cotzUnreachableRecovery.retries == 0,
		"vertical target movement starts fresh recovery even while engine memory remains stale")
	selectAt(actor, 7)
	check(actor.schedule == SCHED_FORCED_GO_RUN, "a moved target receives a fresh position retry")

	for _, range in ipairs({1, 2}) do
		actor = mutant(target(isPlayer))
		exhaustRetries(actor)
		actor.meleeRange = range
		selectAt(actor, 6)
		check(not actor.cotzUnreachableRecovery and actor.schedule == SCHED_CHASE_ENEMY,
			"returning within melee range or too close to attack cancels retreat despite stale engine memory")
	end
end

local actor = mutant(target(true))
actor.unreachable = false
selectAt(actor, 0)
check(actor.schedule == SCHED_CHASE_ENEMY and not actor.cotzUnreachableRecovery,
	"reachable targets retain ordinary combat schedules")

actor = mutant(target(true))
selectAt(actor, 0)
selectAt(actor, 1)
actor.position, actor.unreachable = Vector(64), false
selectAt(actor, 2)
check(not actor.cotzUnreachableRecovery and actor.schedule == SCHED_CHASE_ENEMY,
	"successful navigation progress with expired failure memory restores ordinary combat")

actor = mutant(target(true))
exhaustRetries(actor)
actor.enemy = target(false)
selectAt(actor, 6)
check(actor.schedule == SCHED_COMBAT_FACE and actor.cotzUnreachableRecovery.retries == 0,
	"switching targets discards the previous target's retry budget")
actor.enemy.removed = true
selectAt(actor, 7)
check(not actor.cotzUnreachableRecovery and actor.schedule == SCHED_IDLE_WANDER,
	"target removal clears recovery without accessing an invalid entity")

actor = mutant(target(true))
exhaustRetries(actor)
actor.enemy.dead = true
selectAt(actor, 6)
check(not actor.cotzUnreachableRecovery and actor.schedule == SCHED_IDLE_WANDER,
	"player death clears recovery")

actor = mutant(target(true))
selectAt(actor, 0)
actor.PlayingAnimation = true
selectAt(actor, 10)
check(#actor.schedules == 1, "attack animations finish without navigation retries interrupting them")
actor.PlayingAnimation, actor.cotzSleeping = false, true
selectAt(actor, 11)
check(#actor.schedules == 1, "sleeping mutants cannot issue navigation retries")

actor = mutant(target(true))
exhaustRetries(actor)
actor.enemy.hidden = true
selectAt(actor, 17)
check(not actor.cotzUnreachableRecovery and actor.schedule == SCHED_CHASE_ENEMY,
	"without the combat manager, loss of visibility clears recovery and uses ordinary hidden schedules")

actor = mutant(target(true))
exhaustRetries(actor)
ix = {eventController = {
	ValidateCombatEnemy = function() end,
	UpdateCombatSchedule = function(self, entity)
		entity:SetLastPosition(Vector(200))
		entity:SetSchedule(SCHED_FORCED_GO_RUN)

		return true
	end,
}}
selectAt(actor, 6)
check(not actor.cotzUnreachableRecovery and actor.destination.x == 200
	and actor.schedule == SCHED_FORCED_GO_RUN,
	"combat-manager pursuit owns occluded movement without recovery clearing its schedule or tracking hidden positions")

ix = nil
actor = mutant(target(true))
exhaustRetries(actor)
local other = mutant(actor.enemy)
selectAt(other, 6)
check(actor.cotzUnreachableRecovery.retreating and other.cotzUnreachableRecovery.retries == 0,
	"mutants fighting the same target keep independent retry budgets")

local function applySpecies(entity, name)
	local definition = assert(io.open("lua/entities/npc_mutant_" .. name .. "/init.lua"))
	local contents = definition:read("*a")
	definition:close()
	local declarations = {}
	for line in contents:gmatch("[^\n]+") do
		if line:match("^ENT%.navigation") then declarations[#declarations + 1] = line end
	end
	assert(load(table.concat(declarations, "\n"), "@" .. name, "t", {ENT = entity}))()

	return contents
end

for _, name in ipairs({"dog", "rodent", "cat", "psydog", "psydog_phantom", "bear", "sprig", "pseudodog",
	"bloodsucker", "chimera", "chimera_fire", "chimera_electro", "snork", "vareshka", "tark",
	"pseudogiant_fast", "spider"}) do
	actor = mutant(target(true))
	applySpecies(actor, name)
	actor.enemy.position = Vector(actor.navigationLeapRange + 200)
	selectAt(actor, 0)
	selectAt(actor, 1)
	check(actor.schedule == SCHED_FORCED_GO_RUN, name .. " approaches targets outside its existing leap range")
	actor.enemy.position = Vector((actor.navigationLeapRange + (actor.navigationLeapMinRange or 0)) / 2)
	selectAt(actor, 2)
	check(actor.schedule == SCHED_COMBAT_FACE and not actor.cotzNavigationIntent,
		name .. " stops walking inside leap range so the normal jump callback can run")
end

for _, name in ipairs({"controller", "controller_fast", "controller_electro", "controller_swamp", "burer",
	"karlik", "hellhound", "izlom"}) do
	actor = mutant(target(false))
	applySpecies(actor, name)
	actor.enemy.position = Vector(((actor.navigationRangedMinRange or 0) + actor.navigationRangedRange) / 2)
	selectAt(actor, 0)
	selectAt(actor, 20)
	check(actor.schedule == SCHED_COMBAT_FACE and not actor.cotzNavigationIntent,
		name .. " preserves ranged attacks against an unreachable NPC instead of retreating")
end

actor = mutant(target(true))
applySpecies(actor, "spider")
actor.health = 50
local minimum, maximum = actor:STALKERNPCNavigationAttackRange(400)
check(minimum == 0 and maximum == 800, "wounded spiders use their existing spit range rather than a disabled leap")
actor.enemy.position = Vector(400)
selectAt(actor, 0)
check(actor.schedule == SCHED_COMBAT_FACE, "a wounded spider keeps attacking from a valid spit position")

actor = mutant(target(true))
applySpecies(actor, "pseudogiant_fast")
minimum, maximum = actor:STALKERNPCNavigationAttackRange(250)
check(minimum == 0 and maximum == 200, "pseudogiants approach into short-jump range from the gap between leaps")

-- Exercise the real dog attack after navigation has brought it into range; preserve rolls and cooldowns.
actor = mutant(target(true))
local definition = applySpecies(actor, "dog")
actor.enemy.position = Vector(150)
selectAt(actor, 1)
local attackStart = assert(definition:find("function ENT:STALKERNPCDistanceForMeleeTooBig()", 1, true))
local attackSource = definition:sub(attackStart):gsub("!=", "~="):gsub("&&", " and ")
attackSource = attackSource:gsub("//([^\n]*)", "--%1")
local dog = {}
assert(load(attackSource, "@dog-attack", "t", setmetatable({ENT = dog}, {__index = _G})))()
local formerRandom = math.random
actor.CanJump = 0
math.random = function() return 2 end
dog.STALKERNPCDistanceForMeleeTooBig(actor)
check(not actor.isAttacking, "navigation does not bypass the species' existing jump roll")
math.random = function() return 1 end
dog.STALKERNPCDistanceForMeleeTooBig(actor)
check(actor.isAttacking == 1 and actor.CanJump == 4, "normal jumps start with their unchanged three-second cooldown")
local schedules = #actor.schedules
selectAt(actor, 1.1)
check(#actor.schedules == schedules, "queued jumps cannot be interrupted before their animation begins")
math.random = formerRandom

noGround = false
actor = mutant(target(true))
local recovery = {position = actor.enemy.position}
check(actor:STALKERNPCApproachUnreachable(actor.enemy, recovery) == true
	and actor.destination.z == 2 and actor.destination.x < actor.enemy.position.x,
	"alternate approaches use supported footing below a perch on the mutant's side")
actor.cotzCombatPack = {origin = Vector(-400)}
ix = {eventController = {
	GetSpawnNodes = function() return {Vector(-4500), Vector(-3100), Vector(-3000), Vector(-2500)} end,
	TakeSearchBudget = function() return true end,
}}
actor:STALKERNPCWithdrawUnreachable(recovery)
check(actor.destination.x == -3000 and actor.schedule == SCHED_FORCED_GO_RUN,
	"withdrawal runs to the closest grounded graph point at least 3000 units away")
local groundChecks = 0
local originalGround = actor.STALKERNPCNavigationGround
actor.STALKERNPCNavigationGround = function(self, position)
	groundChecks = groundChecks + 1
	if position.x == -3000 then return end

	return originalGround(self, position)
end
actor:STALKERNPCWithdrawUnreachable(recovery)
check(actor.destination.x == -3100 and groundChecks == 2,
	"a blocked retreat node falls back to the next closest graph point")
ix.eventController.GetSpawnNodes = function() return {Vector(-2500)} end
actor:STALKERNPCWithdrawUnreachable(recovery)
check(actor.schedule == SCHED_COMBAT_FACE and not actor.cotzNavigationIntent,
	"missing distant graph nodes hold safely without scheduling cover or flee")
ix.eventController.TakeSearchBudget = function() return false end
groundChecks = 0
actor:STALKERNPCWithdrawUnreachable(recovery)
check(groundChecks == 0, "retreat node validation respects the shared search budget")
actor.STALKERNPCNavigationGround = nil
ix = nil

actor = mutant(target(true))
selectAt(actor, 0)
selectAt(actor, 1)
actor.goalActive = true
actor.position = Vector(0, 64)
selectAt(actor, 3)
check(#actor.schedules == 2, "a working route can make sideways progress without being restarted")

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
actor.navigationRangedRange = 1500
selectAt(actor, 31)
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
actor:RunAI()
check(actor.maintained, "RunAI keeps navigation recovery active without selecting a competing combat schedule")

for _, state in ipairs({"sleep", "dead", "disabled"}) do
	actor = stranded()
	if state == "sleep" then actor.cotzSleeping = true end
	if state == "dead" then actor.health = 0 end
	GetConVar = function() return {GetInt = function() return state == "disabled" and 1 or 0 end} end
	navigationAt(actor, 30)
	check(not actor.cotzNavigationRecovery and not actor.relocated, state .. " actors cannot trigger recovery")
end

print("PASS: " .. checks .. " mutant navigation checks")
