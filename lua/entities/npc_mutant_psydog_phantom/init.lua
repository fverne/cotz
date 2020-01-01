AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Pseudodog.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 2

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Pseudodog.Melee"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 4

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Pseudodog.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 3

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Pseudodog.Chase"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 4
ENT.ChasingSound.chance = 20

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.hp = 80000

ENT.CanJump = 0
ENT.isAttacking = 0
ENT.jumping1 = 0
ENT.jumping2 = 0

ENT.NextAbilityTime = 0
ENT.PackTimer = 0

ENT.MinRangeDist = 800
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_IDLE_WANDER 
ENT.RangeSchedule = SCHED_CHASE_ENEMY

function ENT:Initialize()
	self.Model = "models/jerry/mutants/stalker_anomaly_pseudodog.mdl"
	self:STALKERNPCInit(Vector(-16,-16,60),MOVETYPE_STEP)
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()

	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Dog.Miss1" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	

	TEMP_MeleeTable.damage[1] = 5
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SONIC)
	TEMP_MeleeTable.distance[1] = 90
	TEMP_MeleeTable.radius[1] = 50
	TEMP_MeleeTable.time[1] = 0.4
	TEMP_MeleeTable.bone[1] = "bip01_head"
	self:STALKERNPCSetMeleeParams(1,"attack1",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 5
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SONIC)
	TEMP_MeleeTable.distance[1] = 128
	TEMP_MeleeTable.radius[1] = 75
	TEMP_MeleeTable.time[1] = 0.4
	TEMP_MeleeTable.bone[1] = "bip01_head"
	self:STALKERNPCSetMeleeParams(3,"attack1",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp)	
	self:SetMaxHealth(self:Health())
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()

end

//little aggressive jump
function ENT:STALKERNPCDistanceForMeleeTooBig() 
	if(self.PlayingAnimation==false) then
		local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
		if distance < 200 then
			if(self.CanJump<CurTime()) then
				local TEMP_Rand = math.random(1,5)
			
				if(TEMP_Rand==1) then		
					self.CanJump = CurTime()+3
					self.isAttacking = 1
					self.jumping1 = CurTime()+0.2
					self.jumping2 = CurTime()+5
				end

				if (self.jumping1 < CurTime()) and self.isAttacking == 1 then
					self:SetLocalVelocity(((self:GetEnemy():GetPos() + self:OBBCenter()) -(self:GetPos() + self:OBBCenter())):GetNormal()*400 +self:GetForward()*(12*distance) +self:GetUp()*math.Clamp((0.5 * distance),150,400))
					self:STALKERNPCPlayAnimation("attack1",2)
					self:STALKERNPCMakeMeleeAttack(3)
					self:EmitSound("Stalker.Pseudodog.Melee1")
					self.isAttacking = 2
				end

				if (self.jumping2 < CurTime()) and self.isAttacking == 2 then
					self:STALKERNPCStopAllTimers()
					self:STALKERNPCClearAnimation()
					self.NextAbilityTime = CurTime()+0.5
					self.isAttacking = 0
				end
			end
		end
	end
end


function ENT:STALKERNPCHitSomething()
	if self.isClone then
		self:TakeDamage( 5, self, self )
	end
end

function ENT:STALKERNPCDamageTake(dmginfo,mul) 
	local TEMP_CEffectData = EffectData()
	TEMP_CEffectData:SetOrigin(self:GetPos() + Vector(0,0,32))
	TEMP_CEffectData:SetColor(0)
	TEMP_CEffectData:SetScale(120)
	TEMP_CEffectData:SetNormal(self:GetAngles():Forward())
	TEMP_CEffectData:SetEntity(self)
	TEMP_CEffectData:SetAngles(self:GetAngles())
	util.Effect( "ThumperDust", TEMP_CEffectData, false )

	self:Remove()

	return mul
end

function ENT:STALKERNPCOnDeath()							

end