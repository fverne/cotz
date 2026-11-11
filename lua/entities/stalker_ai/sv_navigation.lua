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

	return not self:IsOnGround()
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

function ENT:STALKERNPCWithdrawUnreachable(recovery)
	local origin = self.cotzCombatPack and self.cotzCombatPack.origin
	if origin and self:GetPos():DistToSqr(origin) > ARRIVAL_SQR and takeBudget() then
		local ground = self:STALKERNPCNavigationGround(origin)
		if ground then
			self:STALKERNPCMoveToPosition(ground, true)

			return
		end
	end

	-- Let the engine choose an actual cover route when the encounter origin is unavailable.
	self.cotzNavigationIntent = recovery.position
	self.cotzNavigationIntentGrounded = nil
	self:SetSchedule(SCHED_TAKE_COVER_FROM_ENEMY)
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
	if self:STALKERNPCNavigationBusy() then
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
