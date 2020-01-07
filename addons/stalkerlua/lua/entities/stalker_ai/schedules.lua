function ENT:RunAI( strExp )
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
				if(self.SeeEnemy<CurTime()) then

					if(!self:IsCurrentSchedule(self.HiddenSchedule)) then
						self:SetSchedule(self.HiddenSchedule)
					end
				end
			end
		else
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