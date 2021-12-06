AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Sprig.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 1

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Sprig.Melee"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 3

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Sprig.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 3

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Sprig.Chase"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 4
ENT.ChasingSound.chance = 20

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.hp = 350
ENT.hpvar = 75

ENT.CanJump = 0
ENT.isAttacking = 0
ENT.jumping1 = 0
ENT.jumping2 = 0

ENT.passive = 2

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 800
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_CHASE_ENEMY 
ENT.RangeSchedule = SCHED_CHASE_ENEMY

ENT.flatbulletresistance = 14

function ENT:Initialize()
	self.Model = "models/monsters/zanoza.mdl"
	self:STALKERNPCInit(Vector(-24,-24,70),MOVETYPE_STEP)
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Sprig.Melee" }
	
	local TEMP_MeleeMissTable = { "Stalker.Dog.Miss1" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 25
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 80
	TEMP_MeleeTable.radius[1] = 60
	TEMP_MeleeTable.time[1] = 0.6
	TEMP_MeleeTable.bone[1] = "bip01_l_hand"
	self:STALKERNPCSetMeleeParams(1,"stand_attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 25
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 80
	TEMP_MeleeTable.radius[1] = 60
	TEMP_MeleeTable.time[1] = 0.8
	TEMP_MeleeTable.bone[1] = "bip01_l_hand"
	TEMP_MeleeTable.damage[2] = 25
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[2] = 80
	TEMP_MeleeTable.radius[2] = 60
	TEMP_MeleeTable.time[2] = 0.9
	TEMP_MeleeTable.bone[2] = "bip01_r_hand"
	self:STALKERNPCSetMeleeParams(2,"stand_attack_1",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	TEMP_MeleeTable.damage[1] = 25
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 80
	TEMP_MeleeTable.radius[1] = 60
	TEMP_MeleeTable.time[1] = 0.8
	TEMP_MeleeTable.bone[1] = "bip01_l_hand"
	TEMP_MeleeTable.damage[2] = 25
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[2] = 80
	TEMP_MeleeTable.radius[2] = 60
	TEMP_MeleeTable.time[2] = 0.9
	TEMP_MeleeTable.bone[2] = "bip01_r_hand"
	self:STALKERNPCSetMeleeParams(4,"stand_attack_2",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	
	self:SetMaxHealth(self:Health())

	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()
	if (self.jumping1 < CurTime()) and self.isAttacking == 1 and self:GetEnemy() then
		local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
		local dirnormal =((self:GetEnemy():GetPos() + Vector(0,0,32) + self:OBBCenter()) - (self:GetPos())):GetNormal()

		self:SetVelocity((dirnormal*(distance*3)))
		self:STALKERNPCPlayAnimation("stand_attack_2",4)
		self:STALKERNPCMakeMeleeAttack(4)
		self:EmitSound("Stalker.Sprig.Melee2")
		self.isAttacking = 2
	end

	if (self.jumping2 < CurTime()) and self.isAttacking == 2 then
		self:STALKERNPCStopAllTimers()
		self:STALKERNPCClearAnimation()
		self.NextAbilityTime = CurTime()+0.5
		self.isAttacking = 0
	end


	if ( self.passive == 2 ) then
		self:STALKERNPCPlayAnimation("lie_idle_0")

		for k,v in pairs(ents.FindInSphere(self:GetPos(), 256)) do
			if(v:IsPlayer())then
				self.passive = 1 
				self:EmitSound("Stalker.Sprig.Chase2")
				self:SetEnemy(v)
			end

		end
	end

	if self.passive == 1 then 
		self:STALKERNPCClearAnimation()
		self.passive = 0
	end

end

function ENT:STALKERNPCOnDeath()

end

function ENT:STALKERNPCDamageTake(dmginfo,mul) 
	if(dmginfo:GetDamageType() == DMG_BULLET) then
		dmginfo:SubtractDamage(self.flatbulletresistance)
		dmginfo:SetDamage(math.max(0,dmginfo:GetDamage())) --So he can't heal from our attacks
	end

	if (self.passive != 0) then self.passive = 1 end
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
					self.jumping2 = CurTime()+3
				end
			end
		end
	end
end