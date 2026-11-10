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

local file = assert(io.open("lua/entities/stalker_ai/schedules.lua"))
local source = file:read("*a")
file:close()
source = source:gsub("!=", "~="):gsub("&&", " and "):gsub("||", " or "):gsub("!", "not ")
ENT = {}
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
	selectAt(actor, 5)
	check(actor.schedule == SCHED_MOVE_AWAY_FROM_ENEMY, "failed retries retain the existing retreat fallback")
	selectAt(actor, 50)
	check(#actor.schedules == 4 and actor.enemy == enemy, "stationary targets cannot cause unbounded chase retries")

	enemy.position = Vector(430)
	selectAt(actor, 51)
	check(actor.cotzUnreachableRecovery.retreating, "small target movement does not reset recovery")
	enemy.position = Vector(464)
	selectAt(actor, 52)
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
selectAt(actor, 9)
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

print("PASS: " .. checks .. " mutant navigation checks")
