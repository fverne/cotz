-- Opt-in flight for mutants (ENT.MovementMode = "fly"). COTZ maps have no air nodegraph, so flyers steer
-- directly with one collision hull trace per update and never run engine schedules or ground navigation.
local COMBAT_INTERVAL = 0.15
local IDLE_INTERVAL = 0.5
local ARRIVAL_DISTANCE = 32
local TARGET_RADIUS = 16
local SPAWN_LIFT = Vector(0, 0, 24)
local CLIMB_STEP = Vector(0, 0, 48)
local BLOCKED_FRACTION = 0.25
local MIN_SLIDE_SQR = 0.25 ^ 2

ENT.MovementMode = "ground"
ENT.FlightSpeed = 250
ENT.FlightCruiseHeight = 96
ENT.FlightCruiseRange = 400
ENT.FlightWanderRadius = 256
ENT.FlightWanderHeight = {16, 96}
ENT.FlightWanderInterval = 4

-- Reused for every flight trace; the output table avoids allocating a result per update.
local flightTrace = {output = {}, mask = MASK_NPCSOLID}

local function traceHull(actor, start, finish)
	flightTrace.start, flightTrace.endpos = start, finish
	flightTrace.mins, flightTrace.maxs = actor:OBBMins(), actor:OBBMaxs()
	flightTrace.filter = actor
	util.TraceHull(flightTrace)
	flightTrace.filter = nil

	return flightTrace.output
end

local function setSequence(actor, sequence)
	if sequence < 0 or actor:GetSequence() == sequence then return end

	actor:ResetSequence(sequence)
end

local function faceTowards(actor, position)
	local yaw = (position - actor:GetPos()):Angle().y
	actor:SetAngles(Angle(0, yaw, 0))
end

function ENT:STALKERNPCInitFlight()
	self.cotzFlying = true
	self:CapabilitiesRemove(CAP_MOVE_GROUND)
	self:SetAutomaticFrameAdvance(true)

	local position = self:GetPos()
	local lift = traceHull(self, position, position + SPAWN_LIFT)
	if not lift.Hit then self:SetPos(lift.HitPos) end
	self.cotzFlightHome = self:GetPos()
	self:SetGroundEntity(NULL)
	self:SetMoveType(MOVETYPE_FLY)

	self.cotzFlightIdleSequence = self:LookupSequence(self.FlightIdleSequence or self.IdleSequence)
	self.cotzFlightMoveSequence = self.FlightMoveSequence and self:LookupSequence(self.FlightMoveSequence)
		or self.cotzFlightIdleSequence
end

function ENT:STALKERNPCStopFlight()
	if self.cotzFlightStopped then return end

	self.cotzFlightStopped = true
	self:SetLocalVelocity(vector_origin)
end

-- The center distance at which a flyer stops closing in. Ranged flyers set FlightHoldDistance.
function ENT:STALKERNPCFlightHoldDistance()
	return self.FlightHoldDistance or self.MeleeAttackDistance + self:OBBMaxs().x + TARGET_RADIUS
end

function ENT:STALKERNPCFlightWanderGoal(now)
	if not self.cotzFlightWander or now >= (self.cotzNextFlightWander or 0) then
		local radius = self.FlightWanderRadius
		local height = self.FlightWanderHeight
		self.cotzNextFlightWander = now + self.FlightWanderInterval
		self.cotzFlightWander = self.cotzFlightHome
			+ Vector(math.Rand(-radius, radius), math.Rand(-radius, radius), math.Rand(height[1], height[2]))
	end

	return self.cotzFlightWander
end

-- Where to steer while the enemy is in sight, and how close to get. Flyers with their own combat movement
-- override this.
function ENT:STALKERNPCFlightCombatGoal(enemy)
	local goal = enemy:WorldSpaceCenter()
	if self:GetPos():DistToSqr(goal) > self.FlightCruiseRange ^ 2 then
		goal = goal + Vector(0, 0, self.FlightCruiseHeight)
	end

	return goal, self:STALKERNPCFlightHoldDistance()
end

-- Returns the goal, whether the flyer is engaged in combat, and the distance at which it should stop.
function ENT:STALKERNPCFlightGoal(now)
	local enemy = self:GetEnemy()
	if IsValid(enemy) then
		if self.cotzPlayerVisible ~= false and self:Visible(enemy) then
			local goal, stopDistance = self:STALKERNPCFlightCombatGoal(enemy, now)

			return goal, true, stopDistance
		end

		-- Pursue the position COTZ last observed, never the hidden player's live position.
		local remembered = self.cotzPlayerVisible == false and self.cotzPlayerPosition
			or self:GetEnemyLastKnownPos(enemy)
		if remembered then return remembered + enemy:OBBCenter(), true, ARRIVAL_DISTANCE end
	end
	if self.cotzCombatApproach then return self.cotzCombatApproach, true, ARRIVAL_DISTANCE end
	local objective = self.cotzCombatObjective
	if IsValid(objective) then
		return objective:WorldSpaceCenter(), true, self.cotzCombatObjectiveRadius or ARRIVAL_DISTANCE
	end

	return self:STALKERNPCFlightWanderGoal(now), false, ARRIVAL_DISTANCE
end

-- Slides along whatever blocks the step, and climbs when the slide leaves almost no progress.
function ENT:STALKERNPCFlightDirection(position, direction, step)
	local trace = traceHull(self, position, position + direction * step)
	if not trace.Hit then return direction end

	local normal = trace.HitNormal
	local slide = direction - normal * direction:Dot(normal)
	if trace.Fraction >= BLOCKED_FRACTION or slide:LengthSqr() >= MIN_SLIDE_SQR then
		slide:Normalize()

		return slide
	end
	if not traceHull(self, position, position + CLIMB_STEP).Hit then return vector_up end
end

function ENT:STALKERNPCUpdateFlight()
	local ability = self.cotzAbility
	if ability and ability.definition.ownsMovement then return end
	if self.PlayingAnimation or ability then
		self:STALKERNPCStopFlight()
		return
	end

	local now = CurTime()
	if now < (self.cotzNextFlightUpdate or 0) then return end
	local goal, engaged, stopDistance = self:STALKERNPCFlightGoal(now)
	local interval = engaged and COMBAT_INTERVAL or IDLE_INTERVAL
	self.cotzNextFlightUpdate = now + interval

	local position = self:GetPos()
	local offset = goal - position
	local distance = offset:Length()
	if distance <= stopDistance then
		self:STALKERNPCStopFlight()
		if engaged then faceTowards(self, goal) end
		setSequence(self, self.cotzFlightIdleSequence)
		return
	end

	local speed = math.min(self.FlightSpeed, (distance - stopDistance) / interval)
	local direction = self:STALKERNPCFlightDirection(position, offset / distance, speed * interval)
	if not direction then
		self:STALKERNPCStopFlight()
		setSequence(self, self.cotzFlightIdleSequence)
		return
	end

	faceTowards(self, goal)
	self:SetLocalVelocity(direction * speed)
	self.cotzFlightStopped = nil
	setSequence(self, self.cotzFlightMoveSequence)
end
