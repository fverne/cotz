local UPDATE_INTERVAL = 0.18
local IDLE_INTERVAL = 0.5
local WAVERING_INTERVAL = 4
local APPROACH_CLEARANCE = 32
local FLIGHT_RISE = Vector(0, 0, 28)
local FLIGHT_START = Vector(0, 0, 24)
local SLEEP_HOLD = 15
local GROUND_ACTIVITIES = {
	[ACT_WALK] = {"ACT_WALK", "ACT_WALK_AIM", "ACT_WALK_RIFLE", "ACT_WALK_AIM_RIFLE", "ACT_WALK_AIM_PISTOL"},
	[ACT_RUN] = {"ACT_RUN", "ACT_RUN_AIM", "ACT_RUN_RIFLE", "ACT_RUN_AIM_RIFLE", "ACT_RUN_AIM_PISTOL"},
}
local groundActivityCache = {}

local function getGroundActivities(npc)
	local model = npc:GetModel()
	if groundActivityCache[model] then return groundActivityCache[model] end
	local translations = {}
	for activity, candidates in pairs(GROUND_ACTIVITIES) do
		for _, candidate in ipairs(candidates) do
			local sequence = npc:LookupSequence(candidate)
			if sequence >= 0 then
				local replacement = npc:GetSequenceActivity(sequence)
				if replacement >= 0 and replacement ~= activity then translations[activity] = replacement end
				break
			end
		end
	end
	groundActivityCache[model] = translations

	return translations
end

function ENT:TranslateActivity(activity)
	if self.workshopGroundActivities then return self.workshopGroundActivities[activity] end
end

function ENT:ConfigureWorkshopMovement(profile)
	self.workshopMovement = profile.movement
	self.workshopUpdateInterval = UPDATE_INTERVAL
	if not self.workshopMovement then
		self.workshopGroundActivities = getGroundActivities(self)
		return
	end

	self:CapabilitiesRemove(CAP_MOVE_GROUND)
	self:SetAutomaticFrameAdvance(true)
	self:ResetSequence(self.IdleSequence)
	if self.workshopMovement == "hold" then
		self:SetMoveType(MOVETYPE_NONE)
		return
	end

	if self.workshopMovement == "fly" then
		local trace = util.TraceHull({
			start = self:GetPos(),
			endpos = self:GetPos() + FLIGHT_START,
			mins = self:OBBMins(),
			maxs = self:OBBMaxs(),
			filter = self,
			mask = MASK_NPCSOLID,
		})
		if not trace.Hit then self:SetPos(trace.HitPos) end
	end
	self.workshopHome = self:GetPos()
	self:SetGroundEntity(NULL)
	self:SetMoveType(MOVETYPE_FLY)
end

function ENT:RunAI(expression)
	if self.workshopMovement then return end

	return baseclass.Get("stalker_ai").RunAI(self, expression)
end

function ENT:STALKERNPCUpdateSleep()
	if not self.workshopMovement then
		return baseclass.Get("stalker_ai").STALKERNPCUpdateSleep(self)
	end
	if not ix or not ix.eventController or not ix.config.Get("mutantSleep", true) or self.cotzNoSleep then
		if self.cotzSleeping then self:STALKERNPCWake() end
		return
	end

	local wakeRange = ix.config.Get("mutantWakeRange", 5000)
	local sleepRange = math.max(wakeRange, ix.config.Get("mutantSleepRange", 6000))
	local range = self.cotzSleeping and wakeRange or sleepRange
	if ix.eventController:HasActivePlayerNear(self:GetPos(), range) then
		if self.cotzSleeping then self:STALKERNPCWake() end
		self.cotzAwakeUntil = CurTime() + SLEEP_HOLD
		return
	end

	if self.cotzSleeping or self:IsEFlagSet(EFL_NO_THINK_FUNCTION) then return end
	if (self.cotzAwakeUntil or 0) > CurTime() then return end
	self.cotzSleeping = true
	self.cotzPreviousState = self:GetNPCState()
	ix.eventController:ClearCombatEnemy(self)
	self:STALKERNPCStopAllTimers(true)
	if self.PlayingAnimation then self:STALKERNPCClearAnimation() end
	self.workshopAction = nil
	self:ClearSchedule()
	self:SetLocalVelocity(vector_origin)
	self:SetNPCState(NPC_STATE_IDLE)
	self:AddEFlags(EFL_NO_THINK_FUNCTION)
end

local function idleFlightGoal(npc, now)
	if now >= (npc.workshopNextWander or 0) then
		npc.workshopNextWander = now + WAVERING_INTERVAL
		npc.workshopWander = npc.workshopHome + Vector(math.Rand(-120, 120), math.Rand(-120, 120), math.Rand(8, 46))
	end

	return npc.workshopWander
end

function ENT:UpdateWorkshopMovement(target, visible)
	if not self.workshopMovement or self.workshopMovement == "hold" then return end
	if self.PlayingAnimation then return end

	local swimming = self.workshopMovement == "swim"
	local position = self:GetPos()
	local goal
	if visible then
		goal = target:WorldSpaceCenter()
		if not swimming and position:DistToSqr(goal) > 140 ^ 2 then goal = goal + FLIGHT_RISE end
	elseif not swimming then
		goal = idleFlightGoal(self, CurTime())
	end

	if not goal then
		self:SetLocalVelocity(vector_origin)
		self.workshopUpdateInterval = IDLE_INTERVAL
		return
	end
	self.workshopUpdateInterval = visible and UPDATE_INTERVAL or IDLE_INTERVAL

	local offset = goal - position
	local distance = offset:Length()
	if distance < APPROACH_CLEARANCE then
		self:SetLocalVelocity(vector_origin)
		return
	end
	local speed = math.min(self.workshopProfile.speed, distance / self.workshopUpdateInterval)
	local direction = offset / distance
	local finish = position + direction * speed * self.workshopUpdateInterval
	if swimming and bit.band(util.PointContents(finish), MASK_WATER) == 0 then
		self:SetLocalVelocity(vector_origin)
		return
	end

	local trace = util.TraceHull({
		start = position,
		endpos = finish,
		mins = self:OBBMins(),
		maxs = self:OBBMaxs(),
		filter = self,
		mask = MASK_NPCSOLID,
	})
	if trace.Hit then
		local normal = trace.HitNormal
		direction = direction - normal * direction:Dot(normal)
	end
	self:SetAngles(Angle(0, offset:Angle().y, 0))
	self:SetLocalVelocity(direction * speed)
end
