AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Bloodsucker.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 4

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Bloodsucker.Hit"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 5

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Bloodsucker.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 3

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Bloodsucker.Chase"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 3
ENT.ChasingSound.chance = 20

ENT.CanSpecial = true

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.CanJump = 0
ENT.CanSuck = 0

ENT.hp = 350

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 0
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_RUN_RANDOM
ENT.RangeSchedule = SCHED_CHASE_ENEMY

function ENT:Initialize()
	self.Model = "models/stalkertnb/bloodsucker1.mdl"
	self:STALKERNPCInit(Vector(-16,-16,60),MOVETYPE_STEP)
	
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Snork.Hit1" }
	
	local TEMP_MeleeMissTable = { "Stalker.Snork.Miss1" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 60
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 81
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 1
	TEMP_MeleeTable.bone[1] = "ValveBiped.Bip01_R_Hand"
	self:STALKERNPCSetMeleeParams(1,"attackA",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 60
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 81
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 1
	TEMP_MeleeTable.bone[1] = "ValveBiped.Bip01_R_Hand"
	self:STALKERNPCSetMeleeParams(2,"attackB",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 60
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 81
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 1
	TEMP_MeleeTable.bone[1] = "ValveBiped.Bip01_L_Hand"
	self:STALKERNPCSetMeleeParams(3,"attackC",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 60
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 81
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 1
	TEMP_MeleeTable.bone[1] = "ValveBiped.Bip01_L_Hand"
	self:STALKERNPCSetMeleeParams(4,"attackD",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 45
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 81
	TEMP_MeleeTable.radius[1] = 120
	TEMP_MeleeTable.time[1] = 1
	TEMP_MeleeTable.bone[1] = "ValveBiped.Bip01_L_Hand"
	TEMP_MeleeTable.damage[2] = 45
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[2] = 81
	TEMP_MeleeTable.radius[2] = 120
	TEMP_MeleeTable.time[2] = 1.2
	TEMP_MeleeTable.bone[2] = "ValveBiped.Bip01_R_Hand"
	self:STALKERNPCSetMeleeParams(5,"attackE",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 45
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 81
	TEMP_MeleeTable.radius[1] = 120
	TEMP_MeleeTable.time[1] = 1
	TEMP_MeleeTable.bone[1] = "ValveBiped.Bip01_L_Hand"
	TEMP_MeleeTable.damage[2] = 45
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[2] = 81
	TEMP_MeleeTable.radius[2] = 120
	TEMP_MeleeTable.time[2] = 1.2
	TEMP_MeleeTable.bone[2] = "ValveBiped.Bip01_R_Hand"
	self:STALKERNPCSetMeleeParams(6,"attackF",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp)	
	
	self:SetMaxHealth(self:Health())

	self.CanJump = CurTime()+1

	self.NextAbilityTime = CurTime()+1
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()

end

//little aggressive jump
function ENT:STALKERNPCDistanceForMeleeTooBig() 
	if self.NextAbilityTime < CurTime() then
		if(self.PlayingAnimation==false) then
			local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
			if distance < 200 then
				if(self.CanJump<CurTime()) then
					local TEMP_Rand = math.random(1,5)
				
					if(TEMP_Rand==1) then		
						self.CanJump = CurTime()+3
						self.NextAbilityTime = CurTime()+2
						timer.Create("Attack"..tostring(self).."1",0.2,1,function()
							if(IsValid(self)&&self!=nil&&self!=NULL) then
								self:SetLocalVelocity(((self:GetEnemy():GetPos() + self:OBBCenter()) -(self:GetPos() + self:OBBCenter())):GetNormal()*400 +self:GetForward()*(10*distance) +self:GetUp()*math.Clamp((0.5 * distance),200,400))
								self:STALKERNPCPlayAnimation("attackF",6)
								self:STALKERNPCMakeMeleeAttack(6)
								self:EmitSound("Stalker.Bloodsucker.Hit1")
							end
						end)
						timer.Create("Attack"..tostring(self).."2",2,1,function()
							if(IsValid(self)&&self!=nil&&self!=NULL) then
								self:STALKERNPCStopAllTimers()
								self:STALKERNPCClearAnimation()
								self.NextAbilityTime = CurTime()+1
							end
						end)	
					end
				end
			end
		end

		if(self.PlayingAnimation==false) then
			local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
			if distance < 125 then
				if(self.CanSuck<CurTime()) then
					local TEMP_Rand = math.random(1,5)
				
					if(TEMP_Rand==1) then		
						self.CanSuck = CurTime()+15

						local target = self:GetEnemy()
						self.EatTarget = target
						target:Freeze(true)

						self.NextAbilityTime = CurTime()+4

						local TEMP_TargetDamage = DamageInfo()
									
						TEMP_TargetDamage:SetDamage(10)
						TEMP_TargetDamage:SetInflictor(self)
						TEMP_TargetDamage:SetDamageType(DMG_SONIC)
						TEMP_TargetDamage:SetAttacker(self)
						TEMP_TargetDamage:SetDamagePosition(self:GetEnemy():NearestPoint(self:GetPos()+self:OBBCenter()))
						TEMP_TargetDamage:SetDamageForce(Vector(0,0,0))

						timer.Create("Attack"..tostring(self).."3",0.2,1,function()
							if(IsValid(self)&&self!=nil&&self!=NULL) then
								self:STALKERNPCPlayAnimation("Tantrum")
								self:EmitSound("Stalker.Bloodsucker.Feed")
								self:SetHealth(math.Clamp(self:Health()+125,0,self:GetMaxHealth()))
								target:TakeDamageInfo(TEMP_TargetDamage)
							end
						end)

						timer.Create("Attack"..tostring(self).."4",1.2,1,function()
							if(IsValid(self)&&self!=nil&&self!=NULL) then
								self:STALKERNPCPlayAnimation("Tantrum")
								self:SetHealth(math.Clamp(self:Health()+125,0,self:GetMaxHealth()))
								target:TakeDamageInfo(TEMP_TargetDamage)
							end
						end)

						timer.Create("Attack"..tostring(self).."5",2.2,1,function()
							if(IsValid(self)&&self!=nil&&self!=NULL) then
								self:STALKERNPCPlayAnimation("Tantrum")
								self:SetHealth(math.Clamp(self:Health()+125,0,self:GetMaxHealth()))
								target:TakeDamageInfo(TEMP_TargetDamage)
							end
						end)
						timer.Create("Suck"..tostring(self).."1",3,1,function()
							if(IsValid(self)&&self!=nil&&self!=NULL) then
								self:STALKERNPCStopAllTimers()
								self:STALKERNPCClearAnimation()
								self.NextAbilityTime = CurTime()+1

								target:TakeDamageInfo(TEMP_TargetDamage)
								self:SetHealth(math.Clamp(self:Health()+125,0,self:GetMaxHealth()))
								target:Freeze(false)
								self.EatTarget = nil
							end
						end)	
					end
				end
			end
		end
	end
end

function ENT:STALKERNPCOnKilled()
	if self.EatTarget then
		self.EatTarget:Freeze(false)
	end
end

function ENT:STALKERNPCRemove() 
	if self.EatTarget then
		self.EatTarget:Freeze(false)
	end
end