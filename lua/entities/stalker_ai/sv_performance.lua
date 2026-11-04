local COMBAT_HOLD = 15

local function getConfig(key, default)
	if ix and ix.config then return ix.config.Get(key, default) end

	return default
end

local function clearSchedules(entity)
	entity:ClearSchedule()
	if entity.ScheduleFinished then entity:ScheduleFinished() end
	if entity.EngineScheduleFinish then entity:EngineScheduleFinish() end
end

function ENT:STALKERNPCWake()
	self.cotzAwakeUntil = CurTime() + COMBAT_HOLD
	if not self.cotzSleeping then return end

	self.cotzSleeping = nil
	self:RemoveEFlags(EFL_NO_THINK_FUNCTION)
	self:SetNPCState(self.cotzPreviousState or NPC_STATE_IDLE)
	self.cotzPreviousState = nil
	clearSchedules(self)
	self:NextThink(CurTime())
end

function ENT:STALKERNPCIsInCombat()
	local enemy = self:GetEnemy()
	return (IsValid(enemy) and enemy:Health() > 0) or self.PlayingAnimation == true
		or (self.isAttacking or 0) ~= 0 or (self.cotzAwakeUntil or 0) > CurTime()
end

function ENT:STALKERNPCUpdateSleep()
	local manager = ix and ix.eventController
	if not manager then
		if self.cotzSleeping then self:STALKERNPCWake() end
		return
	end
	if not getConfig("mutantSleep", true) or self.cotzNoSleep or self:STALKERNPCIsInCombat() then
		if self.cotzSleeping then self:STALKERNPCWake() end
		return
	end

	local wakeRange = getConfig("mutantWakeRange", 5000)
	local range = self.cotzSleeping and wakeRange or math.max(wakeRange, getConfig("mutantSleepRange", 6000))
	if manager:HasPlayerNear(self:GetPos(), range) then
		if self.cotzSleeping then self:STALKERNPCWake() end
		return
	end
	if self.cotzSleeping or self:IsEFlagSet(EFL_NO_THINK_FUNCTION) or not self:IsOnGround() then return end

	self.cotzPreviousState = self:GetNPCState()
	self.cotzSleeping = true
	self:StopMoving()
	clearSchedules(self)
	self:SetNPCState(NPC_STATE_IDLE)
	-- The central manager wakes these entities; their own Think is intentionally suspended.
	self:AddEFlags(EFL_NO_THINK_FUNCTION)
end

function ENT:STALKERNPCGetThinkInterval()
	if self:STALKERNPCIsInCombat() then return 0 end

	return getConfig("mutantIdleInterval", 0.1)
end

function ENT:STALKERNPCTryEnemySearch()
	local now = CurTime()
	if not self.cotzNextEnemySearch then
		self.cotzNextEnemySearch = now + (self:EntIndex() % 20) * 0.1
	end
	if now < self.cotzNextEnemySearch then return false end

	local manager = ix and ix.eventController
	if manager and not manager:TakeSearchBudget() then return false end

	self.cotzNextEnemySearch = now + 2 + math.Rand(0, 0.3)

	return true
end

