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

ENT.hp = 275
ENT.hpvar = 75

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

ENT.flatbulletresistance = 2
ENT.percentbulletresistance = 0

function ENT:Initialize()
	self.Model = "models/monsters/psydog.mdl"
	self:STALKERNPCInit(Vector(-24,-24,90),MOVETYPE_STEP)
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Dog.Miss1" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 45
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 90
	TEMP_MeleeTable.radius[1] = 50
	TEMP_MeleeTable.time[1] = 0.4
	TEMP_MeleeTable.bone[1] = "bip01_head"
	self:STALKERNPCSetMeleeParams(1,"stand_attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 45
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_BULLET)
	TEMP_MeleeTable.distance[1] = 128
	TEMP_MeleeTable.radius[1] = 256
	TEMP_MeleeTable.time[1] = 1.1
	TEMP_MeleeTable.bone[1] = "bip01_head"
	self:STALKERNPCSetMeleeParams(3,"jump_attack_all",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	
	self:SetMaxHealth(self:Health())
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)

	for j, i in pairs (ents.FindInSphere(self:GetPos(), 256 )) do
		if i:GetClass() == "npc_mutant_dog" then
			i.HasLeader = true
		end
	end
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()
	if self.PackTimer < CurTime() then
		for j, i in pairs (ents.FindInSphere(self:GetPos(), 256 )) do
			if i:GetClass() == "npc_mutant_dog" then
				i.HasLeader = true
			end
		end
		self.PackTimer = CurTime()+10
	end

	if (self.jumping1 < CurTime()) and self.isAttacking == 1 && self:GetEnemy() then
		local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
		local dirnormal =((self:GetEnemy():GetPos() + Vector(0,0,96) + self:OBBCenter()) - (self:GetPos())):GetNormal()
		
		self:SetVelocity((dirnormal*(distance*2)))

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

function ENT:STALKERNPCOnDeath()
	for j, i in pairs (ents.FindInSphere(self:GetPos(), 256 )) do
		if i:GetClass() == "npc_mutant_dog" then
			i.HasLeader = false
			i:RunAway()
		end
	end
	
	return mul
end

//little aggressive jump
function ENT:STALKERNPCDistanceForMeleeTooBig() 
	if(self.PlayingAnimation==false) then
		local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
		if distance < 400 then
			if(self.CanJump<CurTime()) then
				local TEMP_Rand = math.random(1,5)
			
				if(TEMP_Rand==1) then		
					self.CanJump = CurTime()+3
					self.isAttacking = 1
					self.jumping1 = CurTime()+0.4
					self.jumping2 = CurTime()+5

					self:STALKERNPCPlayAnimation("jump_attack_all",3)
					self:STALKERNPCMakeMeleeAttack(3)
				end

			end
		end
	end
end

function ENT:STALKERNPCDamageTake(dmginfo,mul)
	if(dmginfo:GetDamageType() == DMG_BULLET) then
		dmginfo:SetDamage(dmginfo:GetDamage()*(1 - (self.percentbulletresistance/100)))
		dmginfo:SubtractDamage(self.flatbulletresistance)
		dmginfo:SetDamage(math.max(0,dmginfo:GetDamage())) --So he can't heal from our attacks
	end
end