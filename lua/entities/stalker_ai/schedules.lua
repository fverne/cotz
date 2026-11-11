local UNREACHABLE_GRACE = 1
local UNREACHABLE_RETRY_INTERVAL = 2
local UNREACHABLE_RETRIES = 2
local UNREACHABLE_TARGET_MOVEMENT_SQR = 64 ^ 2
local UNREACHABLE_PROGRESS = 64
local UNREACHABLE_APPROACHES = 4
local UNREACHABLE_RECHECK_INTERVAL = 10
local WALK_PROGRESS_SQR = 32 ^ 2

local function clearUnreachableRecovery(actor)
	if not actor.cotzUnreachableRecovery then return end

	actor.cotzUnreachableRecovery = nil
	actor.cotzNavigationIntent, actor.cotzNavigationMotion = nil, nil
	actor.cotzNavigationIntentGrounded = nil
	actor:ClearSchedule()
	actor:ScheduleFinished()
	actor:EngineScheduleFinish()
	actor.NextRun = 0
end

local function updateUnreachableRecovery(actor, enemy)
	local recovery = actor.cotzUnreachableRecovery
	local position = enemy:GetPos()
	local now = CurTime()
	if recovery and (recovery.enemy ~= enemy
		or position:DistToSqr(recovery.position) >= UNREACHABLE_TARGET_MOVEMENT_SQR) then
		clearUnreachableRecovery(actor)
		recovery = nil
	end

	if not recovery and not actor:IsUnreachable(enemy) then return false end

	local meleeRange = actor:STALKERNPCEnemyInMeleeRange(
		enemy, actor.MeleeAttackDistanceMin, actor.MeleeAttackDistance
	)
	if meleeRange ~= 0 then
		clearUnreachableRecovery(actor)

		return false
	end

	if not recovery then
		recovery = {
			enemy = enemy,
			position = position,
			distance = actor:GetPos():Distance(position),
			walkPosition = actor:GetPos(),
			nextRetry = now + UNREACHABLE_GRACE,
			retries = 0,
		}
		actor.cotzUnreachableRecovery = recovery
		actor:SetSchedule(SCHED_COMBAT_FACE)
	end

	local distance = actor:GetPos():Distance(position)
	local minimum, maximum = actor:STALKERNPCNavigationAttackRange(distance)
	if maximum and distance > minimum and distance < maximum then
		actor:STALKERNPCHoldNavigationPosition()

		return true
	end

	-- Expiry of the engine's unreachable memory alone does not prove that a retry found a path.
	if recovery.retries > 0 and not recovery.retreating and not actor:IsUnreachable(enemy)
		and actor:GetPos():Distance(position) <= recovery.distance - UNREACHABLE_PROGRESS then
		clearUnreachableRecovery(actor)

		return false
	end
	if actor.cotzNavigationIntent and actor:IsGoalActive()
		and actor:GetPos():DistToSqr(recovery.walkPosition) >= WALK_PROGRESS_SQR then
		recovery.walkPosition = actor:GetPos()
		recovery.nextRetry = math.max(recovery.nextRetry, now + UNREACHABLE_RETRY_INTERVAL)

		return true
	end
	if now < recovery.nextRetry then return true end

	if recovery.retries < UNREACHABLE_RETRIES then
		recovery.retries = recovery.retries + 1
		recovery.nextRetry = now + UNREACHABLE_RETRY_INTERVAL
		-- Position goals retry navigation without the chase task rejecting remembered unreachable enemies.
		actor:STALKERNPCMoveToPosition(position)
	elseif (recovery.approaches or 0) < UNREACHABLE_APPROACHES then
		recovery.nextRetry = now + UNREACHABLE_RETRY_INTERVAL
		actor:STALKERNPCApproachUnreachable(enemy, recovery)
	else
		if recovery.retreating then
			recovery.retries, recovery.approaches, recovery.retreating = 0, 0, nil
			recovery.nextRetry = now + UNREACHABLE_GRACE
		else
			recovery.retreating = true
			recovery.nextRetry = now + UNREACHABLE_RECHECK_INTERVAL
			actor:STALKERNPCWithdrawUnreachable(recovery)
		end
	end

	return true
end

function ENT:RunAI( strExp )
	if self.cotzSleeping then return end
	if self:STALKERNPCUpdateNavigation() then
		self:MaintainActivity()

		return
	end
	if(self.PlayingAnimation==false||(self.PlayingAnimation==true&&self.PlayingGesture==true&&self.AllowSchedulesOnGesture==true)) then
		if((self.PlayingAnimation==false||self.PlayingGesture==true)&&!self.CurrentSchedule) then
			self:SelectSchedule()
		end
		
		if ( self:IsRunningBehavior() ) then
			return true
		end
		
		if ( self:DoingEngineSchedule() ) then
			return true
		end
		
		if ( self.CurrentSchedule ) then
			self:DoSchedule( self.CurrentSchedule )
		end

		if ( !self.CurrentSchedule ) then
			self:SelectSchedule()
		end
	end
	
	self:MaintainActivity()
end

function ENT:SelectSchedule( iNPCState )
	if self.cotzSleeping then return end
	if self:STALKERNPCNavigationBusy() then return end
	if ix and ix.eventController then
		ix.eventController:ValidateCombatEnemy(self)
		if ix.eventController:UpdateCombatSchedule(self) then
			self.cotzUnreachableRecovery = nil

			return
		end
	end
	if(!isnumber(self.NextRun)) then
		self.NextRun = CurTime()+1
	end
	
	if(!isnumber(self.SeeEnemy)) then
		self.SeeEnemy = CurTime()+0
	end
	
	if(self.PlayingAnimation==false||self.PlayingGesture==true) then
		if(self.PlayingGesture==true&&self:IsCurrentSchedule()==SCHED_FORCED_GO_RUN) then
			return
		end
		
		if(IsValid(self:GetEnemy())&&self:GetEnemy()!=NULL&&self:GetEnemy()!=nil&&
		(self:GetEnemy():IsNPC()||(self:GetEnemy():IsPlayer()&&self:GetEnemy():Alive()))) then
			
			if(self:VisibleVec(self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter())&&
			self:GetEnemy():VisibleVec(self:GetPos()+self:OBBCenter())) then
				self.SeeEnemy = CurTime()+3

				if updateUnreachableRecovery(self, self:GetEnemy()) then return end
				
				local TEMP_EDist = (self:GetPos()+self:OBBCenter()):Distance(self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter())
				
				if(TEMP_EDist>self.MinRangeDist&&TEMP_EDist<self.MaxRangeDist) then
					if(self.RangeSchedule==SCHED_RUN_RANDOM) then
						if(self.NextRun<CurTime()) then
							self:SetSchedule(self.RangeSchedule)
							self.NextRun = CurTime()+1.5
						end
					else
						if(!self:IsCurrentSchedule(self.RangeSchedule)) then
							self:SetSchedule(self.RangeSchedule)
						end
					end
				else
					if(TEMP_EDist<self.MinRangeDist) then
						if(self.VisibleSchedule==32||self.VisibleSchedule==33||self.VisibleSchedule==83) then
							if(self.NextRun<CurTime()) then
								self:SetSchedule(self.VisibleSchedule)
								self.NextRun = CurTime()+0.6
							end
						else
							if(!self:IsCurrentSchedule(self.VisibleSchedule)) then
								self:SetSchedule(self.VisibleSchedule)
							end
						end
					elseif(TEMP_EDist>self.MaxRangeDist) then
						if(!self:IsCurrentSchedule(self.HiddenSchedule)) then
							self:SetSchedule(self.HiddenSchedule)
						end
					end
				end
						
			else
				clearUnreachableRecovery(self)
				if(self.SeeEnemy<CurTime()) then

					if(!self:IsCurrentSchedule(self.HiddenSchedule)) then
						self:SetSchedule(self.HiddenSchedule)
					end
				end
			end
		else
			clearUnreachableRecovery(self)
			if(!self:IsCurrentSchedule(SCHED_IDLE_WANDER)) then
				self:SetSchedule(SCHED_IDLE_WANDER)
			end
		end
	end
end

function ENT:StartSchedule( schedule )
	self.CurrentSchedule 	= schedule
	self.CurrentTaskID 		= 1
	self:SetTask( schedule:GetTask( 1 ) )
end

function ENT:DoSchedule( schedule )

	if ( self.CurrentTask ) then
		self:RunTask( self.CurrentTask )
	end

	if ( self:TaskFinished() ) then
		self:NextTask( schedule )
	end

end

function ENT:ScheduleFinished()
	self.CurrentSchedule 	= nil
	self.CurrentTask 		= nil
	self.CurrentTaskID 		= nil
end

function ENT:SetTask( task )
	self.CurrentTask 	= task
	self.bTaskComplete 	= false
	self.TaskStartTime 	= CurTime()

	self:StartTask( self.CurrentTask )
end

function ENT:NextTask( schedule )
	self.CurrentTaskID = self.CurrentTaskID + 1

	if ( self.CurrentTaskID > schedule:NumTasks() ) then
		self:ScheduleFinished( schedule )
		return
	end

	self:SetTask( schedule:GetTask( self.CurrentTaskID ) )
end

function ENT:StartTask( task )
	task:Start( self.Entity )
end

function ENT:RunTask( task )
	task:Run( self.Entity )
end

function ENT:TaskTime()
	return CurTime() - self.TaskStartTime
end

function ENT:OnTaskComplete()
	self.bTaskComplete = true
end

function ENT:TaskFinished()
	return self.bTaskComplete
end

function ENT:StartEngineTask( iTaskID, TaskData )
end

function ENT:RunEngineTask( iTaskID, TaskData )
end

function ENT:StartEngineSchedule( scheduleID ) self:ScheduleFinished() self.bDoingEngineSchedule = true end
function ENT:EngineScheduleFinish() self.bDoingEngineSchedule = nil end
function ENT:DoingEngineSchedule()	return self.bDoingEngineSchedule end

function ENT:OnCondition( iCondition )
end
