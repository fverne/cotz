AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Chimera.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 1

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Chimera.Hit"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 3

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Chimera.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 2

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Chimera.Idle"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 2
ENT.ChasingSound.chance = 20

ENT.CanSpecial = true

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.CanJump = 0
ENT.isAttacking = 0
ENT.jumping1 = 0
ENT.jumping2 = 0

ENT.hp = 1200

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 0
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_RUN_RANDOM
ENT.RangeSchedule = SCHED_CHASE_ENEMY

function ENT:Initialize()
	self.Model = "models/stalkertnb/chimera1.mdl"
	self:STALKERNPCInit(Vector(-48,-48,90),MOVETYPE_STEP)
	
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Snork.Miss1" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 85
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 80
	TEMP_MeleeTable.radius[1] = 90
	TEMP_MeleeTable.time[1] = 0.3
	TEMP_MeleeTable.bone[1] = "bip01_l_hand"
	self:STALKERNPCSetMeleeParams(1,"melee",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 35
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 120
	TEMP_MeleeTable.radius[1] = 400
	TEMP_MeleeTable.time[1] = 0.6
	TEMP_MeleeTable.bone[1] = "bone21"
	TEMP_MeleeTable.damage[2] = 35
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[2] = 120
	TEMP_MeleeTable.radius[2] = 400
	TEMP_MeleeTable.time[2] = 1
	TEMP_MeleeTable.bone[2] = "bone21"
	self:STALKERNPCSetMeleeParams(3,"leap",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp)	
	
	self:SetMaxHealth(self:Health())

	self.CanJump = CurTime()+1

	self.NextAbilityTime = CurTime()+1
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()
	if (self.jumping1 < CurTime()) and self.isAttacking == 1 then
		local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
		local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
		local dirnormal =((self:GetEnemy():GetPos() + Vector(0,0,32) + self:OBBCenter()) - (self:GetPos())):GetNormal()

		self:SetVelocity((dirnormal*(distance*2)))
		self:STALKERNPCPlayAnimation("leap",3)
		self:STALKERNPCMakeMeleeAttack(3)
		self:EmitSound("Stalker.Chimera.Hit4")
		self.isAttacking = 2
	end
	if (self.jumping2 < CurTime()) and self.isAttacking == 2 then
		self:STALKERNPCStopAllTimers()
		self:STALKERNPCClearAnimation()
		self.NextAbilityTime = CurTime()+0.5
		self.isAttacking = 0
	end
end


function ENT:STALKERNPCDistanceForMeleeTooBig() 
	if(self.PlayingAnimation==false) then
		if self:GetEnemy() then
			local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
			if distance > 300 && distance < 1200 then
				if(self.CanJump<CurTime()) then

					local TEMP_Rand = math.random(1,5)
				
					if(TEMP_Rand==1) then		
						self.CanJump = CurTime()+3
						self.isAttacking = 1
						self.jumping1 = CurTime()+0.2
						self.jumping2 = CurTime()+5
					end
				end
			end
		end
	end
end

function ENT:STALKERNPCDamageTake(dmginfo,mul) return mul*0.33 end