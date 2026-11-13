local CHECK_INTERVAL = 0.5
local STALL_SECONDS = 6
local MOVEMENT_SQR = 32 ^ 2
local ARRIVAL_SQR = 48 ^ 2
local ESCAPE_INTERVAL = 3
local ESCAPE_ATTEMPTS = 4
local RELOCATION_RETRY = 10
local MAX_DROP = 128
local STEP_HEIGHT = 18
local GROUND_CLEARANCE = 2
local MIN_GROUND_NORMAL = 0.7
local SAFE_POSITION_INTERVAL = 5
local RELOCATION_RANGE_SQR = 512 ^ 2
local PLAYER_SAFE_RANGE_SQR = 512 ^ 2
local WITHDRAW_MIN_DISTANCE = 2000
local WITHDRAW_MAX_DISTANCE = 3000
local WITHDRAW_CANDIDATES = 4
local WITHDRAW_RETRY = 2
local WITHDRAW_TIMEOUT = 60
local WITHDRAW_ARRIVAL_SQR = 96 ^ 2
local JUMP_SEGMENTS = 16
local BUSY_FIELDS = {
	"isAttacking", "IsJumping", "IsLongJumping", "isBigJumping", "IsSuccing", "IsGrabbing",
	"IsSpitting", "SpecialAttack", "IsWarping", "IsThrow1", "IsThrow2", "IsBlast", "IsStamAttack",
}

local function takeBudget()
	return not ix or not ix.eventController or ix.eventController:TakeSearchBudget()
end

local function clearSchedules(actor)
	actor:ClearSchedule()
	actor:ScheduleFinished()
	actor:EngineScheduleFinish()
end

local function hullClear(actor, start, finish)
	local trace = util.TraceHull({
		start = start, endpos = finish, mins = actor:OBBMins(), maxs = actor:OBBMaxs(),
		filter = actor, mask = MASK_NPCSOLID,
	})

	return not trace.Hit and not trace.StartSolid and not trace.AllSolid
end

local function supported(actor, position)
	local mins, maxs = actor:OBBMins(), actor:OBBMaxs()
	for _, x in ipairs({mins.x, maxs.x}) do
		for _, y in ipairs({mins.y, maxs.y}) do
			local corner = position + Vector(x, y, mins.z)
			local trace = util.TraceLine({
				start = corner, endpos = corner - Vector(0, 0, STEP_HEIGHT), filter = actor, mask = MASK_NPCSOLID,
			})
			if not trace.HitWorld or trace.StartSolid or trace.HitNormal.z < MIN_GROUND_NORMAL then return false end
		end
	end

	return true
end

function ENT:STALKERNPCNavigationGround(position)
	local trace = util.TraceHull({
		start = position + Vector(0, 0, STEP_HEIGHT), endpos = position - Vector(0, 0, MAX_DROP),
		mins = self:OBBMins(), maxs = self:OBBMaxs(), filter = self, mask = MASK_NPCSOLID,
	})
	if not trace.HitWorld or trace.StartSolid or trace.AllSolid or trace.HitSky
		or trace.HitNormal.z < MIN_GROUND_NORMAL then return end

	local ground = trace.HitPos + Vector(0, 0, GROUND_CLEARANCE)
	if not util.IsInWorld(ground) or bit.band(util.PointContents(ground), MASK_WATER) ~= 0 then return end
	if not hullClear(self, ground, ground) or not supported(self, ground) then return end

	return ground
end

function ENT:STALKERNPCNavigationBusy()
	if self.PlayingAnimation then return true end
	for _, field in ipairs(BUSY_FIELDS) do
		if (self[field] or 0) ~= 0 then return true end
	end

	return false
end

function ENT:STALKERNPCNavigationJumpVelocity(enemy, shortJump)
	local height, speed = self.navigationLeapAimHeight, self.navigationLeapSpeed
	if shortJump and self.navigationShortLeapRange then
		height, speed = self.navigationShortLeapAimHeight, self.navigationShortLeapSpeed
	end
	local distance = self:GetPos():Distance(enemy:GetPos())
	local direction = (enemy:GetPos() + Vector(0, 0, height) + self:OBBCenter() - self:GetPos()):GetNormalized()

	return direction * (distance * speed)
end

function ENT:STALKERNPCTryNavigationJump(enemy)
	if not self.navigationLeapRange or not self:IsOnGround() or self:STALKERNPCNavigationBusy() then return false end
	if self.navigationLeapHealthFraction and self:Health() <= self:GetMaxHealth() * self.navigationLeapHealthFraction then
		return false
	end
	local distance = self:GetPos():Distance(enemy:GetPos())
	local minimum, maximum = self:STALKERNPCNavigationAttackRange(distance)
	if not maximum or distance <= minimum or distance >= maximum then return false end
	local shortJump = self.navigationShortLeapRange and distance < self.navigationShortLeapRange
	local cooldown = shortJump and "CanJump" or (self.navigationLeapCooldown or "CanJump")
	if (self[cooldown] or 0) >= CurTime() or (self.NextAbilityTime or 0) >= CurTime() then return false end
	if not takeBudget() then return false end

	local start = self:GetPos()
	local offset = enemy:GetPos() - start
	local velocity = self:STALKERNPCNavigationJumpVelocity(enemy, shortJump)
	local speed = math.sqrt(velocity.x ^ 2 + velocity.y ^ 2)
	if speed <= 0 then return false end
	local flightTime = math.sqrt(offset.x ^ 2 + offset.y ^ 2) / speed
	if flightTime <= 0 then return false end
	local gravityScale = self:GetGravity()
	if gravityScale == 0 then gravityScale = 1 end
	local gravity = Vector(0, 0, -GetConVar("sv_gravity"):GetFloat() * gravityScale)
	local finish = start + velocity * flightTime + gravity * (flightTime ^ 2 / 2)
	if finish.z + self:OBBMaxs().z < enemy:GetPos().z + enemy:OBBMins().z
		or finish.z + self:OBBMins().z > enemy:GetPos().z + enemy:OBBMaxs().z then return false end

	local previous = start
	for segment = 1, JUMP_SEGMENTS do
		local time = flightTime * segment / JUMP_SEGMENTS
		local position = start + velocity * time + gravity * (time ^ 2 / 2)
		local trace = util.TraceHull({
			start = previous, endpos = position, mins = self:OBBMins(), maxs = self:OBBMaxs(),
			filter = self, mask = MASK_NPCSOLID,
		})
		if trace.StartSolid or trace.AllSolid then return false end
		if trace.Hit then
			local onTarget = trace.Entity == enemy
			local onPerch = segment >= JUMP_SEGMENTS - 1 and trace.HitWorld
				and trace.HitNormal.z >= MIN_GROUND_NORMAL and trace.HitPos.z >= enemy:GetPos().z - STEP_HEIGHT
			if not onTarget and not onPerch then return false end

			break
		end
		previous = position
	end

	self:STALKERNPCDistanceForMeleeTooBig(distance, true)

	return self:STALKERNPCNavigationBusy()
end

function ENT:STALKERNPCNavigationAttackRange(distance)
	if self.navigationLeapRange then
		if not self.navigationLeapHealthFraction
			or self:Health() > self:GetMaxHealth() * self.navigationLeapHealthFraction then
			local minimum = self.navigationLeapMinRange or 0
			if self.navigationShortLeapRange and distance and distance <= minimum then
				return 0, self.navigationShortLeapRange
			end

			return minimum, self.navigationLeapRange
		end
	end

	return self.navigationRangedMinRange or 0, self.navigationRangedRange
end

function ENT:STALKERNPCHoldNavigationPosition()
	self.cotzNavigationIntent, self.cotzNavigationMotion = nil, nil
	self.cotzNavigationIntentGrounded = nil
	if not self:IsCurrentSchedule(SCHED_COMBAT_FACE) then
		clearSchedules(self)
		self:SetSchedule(SCHED_COMBAT_FACE)
	end
end

function ENT:STALKERNPCMoveToPosition(position, grounded)
	self.cotzNavigationIntent = position
	self.cotzNavigationIntentGrounded = grounded == true
	self:SetLastPosition(position)
	self:SetSchedule(SCHED_FORCED_GO_RUN)
end

function ENT:STALKERNPCApproachUnreachable(enemy, recovery)
	if not takeBudget() then return end

	recovery.approaches = (recovery.approaches or 0) + 1
	local minimum, maximum = self:STALKERNPCNavigationAttackRange(self:GetPos():Distance(enemy:GetPos()))
	local radius = maximum and (minimum + maximum) / 2 or self.MeleeAttackDistance * 0.75
	radius = math.max(radius, self:OBBMaxs().x - self:OBBMins().x + STEP_HEIGHT)
	local direction = (self:GetPos() - enemy:GetPos()):Angle().y
	local angle = math.rad(direction + (recovery.approaches - 1) * 90)
	local point = enemy:GetPos() + Vector(math.cos(angle) * radius, math.sin(angle) * radius, 0)
	-- Look for footing below the target's perch, rather than using its elevated origin as a walk goal.
	point.z = self:GetPos().z
	local ground = self:STALKERNPCNavigationGround(point)
	if not ground then return false end
	if self:GetPos():DistToSqr(ground) <= ARRIVAL_SQR then return false end

	self:STALKERNPCMoveToPosition(ground, true)

	return true
end

local function retreatsAway(position, retreat)
	local away = retreat.start - retreat.enemyPosition
	local offset = position - retreat.start
	if away.x ^ 2 + away.y ^ 2 <= 1 then return true end

	return offset.x * away.x + offset.y * away.y > 0
end

local function retreatCandidates(retreat)
	local nodes = ix and ix.eventController and ix.eventController.GetSpawnNodes
		and ix.eventController:GetSpawnNodes()
	local candidates = {}
	local enemyDistance = retreat.start:DistToSqr(retreat.enemyPosition)
	for _, node in ipairs(nodes or {}) do
		local distanceSquared = retreat.start:DistToSqr(node)
		if distanceSquared >= WITHDRAW_MIN_DISTANCE ^ 2 and distanceSquared <= WITHDRAW_MAX_DISTANCE ^ 2
			and node:DistToSqr(retreat.enemyPosition) > enemyDistance and retreatsAway(node, retreat) then
			local score = math.abs(math.sqrt(distanceSquared) - retreat.distance)
			for index = 1, WITHDRAW_CANDIDATES do
				if not candidates[index] or score < candidates[index].score then
					table.insert(candidates, index, {position = node, score = score})
					break
				end
			end
			if #candidates > WITHDRAW_CANDIDATES then table.remove(candidates) end
		end
	end

	return candidates
end

local function fleeWithoutDestination(actor)
	actor.cotzNavigationIntent, actor.cotzNavigationMotion, actor.cotzNavigationIntentGrounded = nil, nil, nil
	local schedule = IsValid(actor:GetEnemy()) and SCHED_RUN_FROM_ENEMY or SCHED_RUN_RANDOM
	if not actor:IsCurrentSchedule(schedule) then
		clearSchedules(actor)
		actor:SetSchedule(schedule)
	end
end

function ENT:STALKERNPCWithdrawUnreachable(recovery)
	if not self.cotzNavigationRetreat then
		self.cotzNavigationRetreat = {
			start = self:GetPos(), enemyPosition = recovery.position,
			distance = math.Rand(WITHDRAW_MIN_DISTANCE, WITHDRAW_MAX_DISTANCE),
			expires = CurTime() + WITHDRAW_TIMEOUT, nextTry = 0, attempts = 0,
			progressPosition = self:GetPos(), progressTime = CurTime(),
		}
	end

	return self:STALKERNPCUpdateRetreat()
end

function ENT:STALKERNPCUpdateRetreat()
	local retreat = self.cotzNavigationRetreat
	if not retreat then return false end
	if self.cotzSleeping or self.IsAlive == false or self:Health() <= 0
		or GetConVar("ai_disabled"):GetInt() ~= 0 then return false end
	local now = CurTime()
	local travelled = self:GetPos():DistToSqr(retreat.start)
	local arrived = retreat.goal and self:GetPos():DistToSqr(retreat.goal) <= WITHDRAW_ARRIVAL_SQR
	local escaped = travelled >= WITHDRAW_MIN_DISTANCE ^ 2 and retreatsAway(self:GetPos(), retreat)
		and self:GetPos():DistToSqr(retreat.enemyPosition) > retreat.start:DistToSqr(retreat.enemyPosition)
	if now >= retreat.expires or (escaped
		and (arrived or travelled >= retreat.distance ^ 2)) then
		self.cotzNavigationRetreat, self.cotzUnreachableRecovery = nil, nil
		self.cotzNavigationIntent, self.cotzNavigationMotion = nil, nil
		self.cotzNavigationIntentGrounded = nil
		clearSchedules(self)
		self.cotzCombatScheduleDirty = true
		self.NextRun = 0

		return false
	end
	if self:STALKERNPCNavigationBusy() or self.cotzNavigationRecovery then return true end
	if self:GetPos():DistToSqr(retreat.progressPosition) >= MOVEMENT_SQR then
		retreat.progressPosition, retreat.progressTime = self:GetPos(), now
	end
	if self:IsGoalActive() and now - retreat.progressTime < ESCAPE_INTERVAL then return true end
	if now < retreat.nextTry then return true end
	retreat.nextTry = now + WITHDRAW_RETRY
	if not takeBudget() then
		fleeWithoutDestination(self)

		return true
	end
	if not retreat.candidates then retreat.candidates = retreatCandidates(retreat) end

	retreat.attempts = retreat.attempts + 1
	local candidate = retreat.candidates[(retreat.attempts - 1) % math.max(1, #retreat.candidates) + 1]
	local direction = (retreat.start - retreat.enemyPosition):Angle().y
	local angle = math.rad(direction + ((retreat.attempts - 1) % 5 - 2) * 30)
	local sampled = retreat.start + Vector(math.cos(angle) * retreat.distance, math.sin(angle) * retreat.distance, 0)
	local ground = candidate and self:STALKERNPCNavigationGround(candidate.position)
	if not ground then ground = self:STALKERNPCNavigationGround(sampled) end
	local distance = ground and retreat.start:Distance(ground)
	if ground and distance >= WITHDRAW_MIN_DISTANCE and distance <= WITHDRAW_MAX_DISTANCE
		and retreatsAway(ground, retreat)
		and ground:DistToSqr(retreat.enemyPosition) > retreat.start:DistToSqr(retreat.enemyPosition) then
		retreat.goal = ground
		self:STALKERNPCMoveToPosition(ground, true)
	else
		-- Missing/blocked graph data must not turn the escape response into another stationary hold.
		fleeWithoutDestination(self)
	end

	return true
end

local function hullInPVS(view, position, mins, maxs)
	local center = position + Vector((mins.x + maxs.x) / 2, (mins.y + maxs.y) / 2, (mins.z + maxs.z) / 2)
	if view:TestPVS(center) then return true end

	for _, x in ipairs({mins.x, maxs.x}) do
		for _, y in ipairs({mins.y, maxs.y}) do
			for _, z in ipairs({mins.z, maxs.z}) do
				if view:TestPVS(position + Vector(x, y, z)) then return true end
			end
		end
	end

	return false
end

local function visibleToPlayers(actor, position)
	local mins, maxs = actor:OBBMins(), actor:OBBMaxs()
	for _, client in player.Iterator() do
		local view = client:GetViewEntity()
		if not IsValid(view) then view = client end
		if client:GetPos():DistToSqr(actor:GetPos()) <= PLAYER_SAFE_RANGE_SQR
			or client:GetPos():DistToSqr(position) <= PLAYER_SAFE_RANGE_SQR
			or client:TestPVS(actor) or view:TestPVS(actor) then return true end
		if hullInPVS(client, position, mins, maxs) or hullInPVS(view, position, mins, maxs) then return true end
	end

	return false
end

local function escapePoint(actor, index)
	local width = math.max(actor:OBBMaxs().x - actor:OBBMins().x, actor:OBBMaxs().y - actor:OBBMins().y)
	local radius = width + 64
	local angle = math.rad((index - 1) * 90)

	return actor:GetPos() + Vector(math.cos(angle) * radius, math.sin(angle) * radius, 0)
end

local function finishRecovery(actor, relocated)
	actor.cotzNavigationRecovery, actor.cotzNavigationMotion, actor.cotzNavigationIntent = nil, nil, nil
	actor.cotzNavigationIntentGrounded = nil
	if relocated then actor.cotzUnreachableRecovery = nil end
	clearSchedules(actor)
	actor.NextRun = 0
end

local function updateStrandedRecovery(actor, now)
	local recovery = actor.cotzNavigationRecovery
	if actor:GetPos():DistToSqr(recovery.position) >= MOVEMENT_SQR then
		finishRecovery(actor)

		return false
	end
	if now < recovery.nextAttempt or not takeBudget() then return true end

	if recovery.attempts < ESCAPE_ATTEMPTS then
		recovery.attempts = recovery.attempts + 1
		recovery.nextAttempt = now + ESCAPE_INTERVAL
		local ground = actor:STALKERNPCNavigationGround(escapePoint(actor, recovery.attempts))
		local start = actor:GetPos() + Vector(0, 0, STEP_HEIGHT)
		if ground then
			local edge = Vector(ground.x, ground.y, start.z)
			if hullClear(actor, start, edge) and hullClear(actor, edge, ground) then
				actor:STALKERNPCMoveToPosition(ground, true)
			end
		end

		return true
	end

	recovery.nextAttempt = now + RELOCATION_RETRY
	local knownSafe = actor.cotzNavigationSafePosition ~= nil
	local candidate = actor.cotzNavigationSafePosition or escapePoint(actor, recovery.relocationIndex or 1)
	actor.cotzNavigationSafePosition = nil
	recovery.relocationIndex = (recovery.relocationIndex or 1) % ESCAPE_ATTEMPTS + 1
	if actor:GetPos():DistToSqr(candidate) > RELOCATION_RANGE_SQR then
		return true
	end
	local ground = actor:STALKERNPCNavigationGround(candidate)
	if not ground or actor:GetPos():DistToSqr(ground) <= ARRIVAL_SQR
		or actor:GetPos():DistToSqr(ground) > RELOCATION_RANGE_SQR
		or math.abs(ground.z - actor:GetPos().z) > MAX_DROP then return true end
	if not knownSafe and ground.z >= actor:GetPos().z - STEP_HEIGHT then return true end
	if visibleToPlayers(actor, ground) then return true end

	-- Recheck occupancy immediately before moving; neither recovery path mutates health or rewards.
	if not hullClear(actor, ground, ground) then return true end
	actor:StopMoving()
	actor:SetLocalVelocity(vector_origin)
	actor:SetPos(ground)
	finishRecovery(actor, true)

	return true
end

function ENT:STALKERNPCUpdateNavigation()
	if self.cotzSleeping or self.IsAlive == false or self:Health() <= 0
		or GetConVar("ai_disabled"):GetInt() ~= 0 then return end
	local now = CurTime()
	if now < (self.cotzNextNavigationCheck or 0) then return self.cotzNavigationRecovery ~= nil end
	self.cotzNextNavigationCheck = now + CHECK_INTERVAL
	if self:STALKERNPCNavigationBusy() or not self:IsOnGround() then
		self.cotzNavigationMotion = nil
		if self.cotzNavigationRecovery then
			self.cotzNavigationRecovery.position = self:GetPos()
			self.cotzNavigationRecovery.nextAttempt = now + ESCAPE_INTERVAL
		end

		return
	end
	if self.cotzNavigationRecovery then return updateStrandedRecovery(self, now) end

	local goal = self.cotzNavigationIntent
	if self:IsGoalActive() then
		goal = self:GetGoalPos()
		self.cotzNavigationIntent = goal
		self.cotzNavigationIntentGrounded = true
	end
	if not goal or self:GetPos():DistToSqr(goal) <= ARRIVAL_SQR then
		self.cotzNavigationMotion, self.cotzNavigationIntent = nil, nil
		self.cotzNavigationIntentGrounded = nil

		return
	end

	local motion = self.cotzNavigationMotion
	if not motion then
		-- A failed chase to a perch does not establish that the mutant itself is stranded.
		if not self.cotzNavigationIntentGrounded then return end

		self.cotzNavigationMotion = {position = self:GetPos(), since = now}

		return
	end
	if self:GetPos():DistToSqr(motion.position) >= MOVEMENT_SQR then
		motion.position, motion.since = self:GetPos(), now
		if now >= (self.cotzNextSafePosition or 0) and takeBudget() then
			self.cotzNextSafePosition = now + SAFE_POSITION_INTERVAL
			local ground = self:STALKERNPCNavigationGround(self:GetPos())
			if ground then self.cotzNavigationSafePosition = ground end
		end

		return
	end
	if now - motion.since < STALL_SECONDS then return end
	-- A distant target alone is not a stall: this requires a requested walk goal with no physical progress.
	self.cotzNavigationRecovery = {position = self:GetPos(), attempts = 0, nextAttempt = now}

	return updateStrandedRecovery(self, now)
end
