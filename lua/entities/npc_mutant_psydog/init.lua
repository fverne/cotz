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

ENT.NextSpawn = 0
ENT.CanSpawn = false

ENT.PsiAttackCancel = 0

ENT.MinRangeDist = 800
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_IDLE_WANDER 
ENT.RangeSchedule = SCHED_CHASE_ENEMY

function ENT:Initialize()
	self.Model = "models/monsters/psydog.mdl"
	self:STALKERNPCInit(Vector(-24,-24,70),MOVETYPE_STEP)
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()

	self.GoingToSpawnThem = false
	self.NextSpawn = 0

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
	TEMP_MeleeTable.radius[1] = 75
	TEMP_MeleeTable.time[1] = 1.1
	TEMP_MeleeTable.bone[1] = "bip01_head"
	self:STALKERNPCSetMeleeParams(3,"jump_attack_all",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self.PsiAttackCancel = CurTime() + 10

	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	self:SetMaxHealth(self:Health())
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()

	if (self.PsiAttackCancel < CurTime() and self.CanSpawn) then
		self:STALKERNPCClearAnimation()

		if (!IsValid(self.Clone1)) then
			self.Clone1 = ents.Create("npc_mutant_psydog_phantom")
			self.Clone1:SetPos(self:GetPos() +self:GetForward()*100 +self:GetRight()*40)
			self.Clone1:SetAngles(self:GetAngles())
			self.Clone1:Spawn()
		end
		if (!IsValid(self.Clone2)) then
			self.Clone2 = ents.Create("npc_mutant_psydog_phantom")
			self.Clone2:SetPos(self:GetPos() +self:GetForward()*100 +self:GetRight()*-40)
			self.Clone2:SetAngles(self:GetAngles())
			self.Clone2:Spawn()
		end
		if (!IsValid(self.Clone3)) then
			self.Clone3 = ents.Create("npc_mutant_psydog_phantom")
			self.Clone3:SetPos(self:GetPos() +self:GetForward()*-100 +self:GetRight()*-40)
			self.Clone3:SetAngles(self:GetAngles())
			self.Clone3:Spawn()
		end
		if (!IsValid(self.Clone4)) then
			self.Clone4 = ents.Create("npc_mutant_psydog_phantom")
			self.Clone4:SetPos(self:GetPos() +self:GetForward()*-100 +self:GetRight()*40)
			self.Clone4:SetAngles(self:GetAngles())
			self.Clone4:Spawn()
		end
		self.CanSpawn = false
	end

	if self.NextSpawn < CurTime() then
		if (!IsValid(self.Clone1)) or (!IsValid(self.Clone2)) or (!IsValid(self.Clone3)) or (!IsValid(self.Clone4)) then
			self:STALKERNPCPlayAnimation("stand_psi_attack_1")
			self.PsiAttackCancel = CurTime() + 3
			self.NextSpawn = CurTime() + 10
			self.CanSpawn = true
		end
	end


	if (self.jumping1 < CurTime()) and self.isAttacking == 1 then
		local distance = (self:GetPos():Distance(self:GetEnemy():GetPos()))
		local dirnormal =((self:GetEnemy():GetPos() + Vector(0,0,32) + self:OBBCenter()) - (self:GetPos())):GetNormal()

		self:SetVelocity((dirnormal*(distance*3)))
		
		self:STALKERNPCPlayAnimation("jump_attack_all",3)
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
			end
		end
	end
end

function ENT:STALKERNPCRemove()

	local TEMP_TargetDamage = DamageInfo()						

	if IsValid(self.Clone1) then self.Clone1:TakeDamage( 5, self, self ) end
	if IsValid(self.Clone2) then self.Clone2:TakeDamage( 5, self, self ) end
	if IsValid(self.Clone3) then self.Clone3:TakeDamage( 5, self, self ) end
	if IsValid(self.Clone4) then self.Clone4:TakeDamage( 5, self, self ) end

	
end


function ENT:STALKERNPCDamageTake(dmginfo,mul) 

	return mul
end

function ENT:STALKERNPCOnDeath()							
	if IsValid(self.Clone1) then self.Clone1:TakeDamage( 5, self, self ) end
	if IsValid(self.Clone2) then self.Clone2:TakeDamage( 5, self, self ) end
	if IsValid(self.Clone3) then self.Clone3:TakeDamage( 5, self, self ) end
	if IsValid(self.Clone4) then self.Clone4:TakeDamage( 5, self, self ) end
end