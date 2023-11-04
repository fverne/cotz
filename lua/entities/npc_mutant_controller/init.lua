AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")


ENT.PainSoundEnabled = true
ENT.PainSound.name = "Stalker.Controller.Pain"
ENT.PainSound.min = 1
ENT.PainSound.max = 6

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Controller.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 2

ENT.hp = 750
ENT.hpvar = 100

ENT.FBR = 3
ENT.FBRAP = 40
ENT.BR = 5

ENT.CanSpecial = true

ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.Victims = {}
ENT.MaxVictims = 10

ENT.CanSpecialTimer = 0
ENT.SpecialAttack = 0
ENT.special1 = 0
ENT.special2 = 0

ENT.farttimer = 0

function ENT:Initialize()
	self.Model = "models/monsters/controler.mdl"
	self:STALKERNPCInit(Vector(-16,-16,70),MOVETYPE_STEP)
	
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Claw.Miss" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 19
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH, DMG_CLUB)
	TEMP_MeleeTable.distance[1] = 21
	TEMP_MeleeTable.radius[1] = 40
	TEMP_MeleeTable.time[1] = 0.8
	TEMP_MeleeTable.bone[1] = "bip01_r_hand"
	self:STALKERNPCSetMeleeParams(1,"S_Melee1",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	
	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	self.MaxVictims = 0


	self.GoingToSpawnThem = false
	self.NextSpawn = 0


	self:SetMaxHealth(self:Health())
	
	
	self.Victims = {}
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()

	if (self.farttimer < CurTime()) then
		for _,v in pairs(ents.FindInSphere(self:GetPos(),512)) do
			if v:IsPlayer() then
				local distance = self:GetPos():Distance(v:GetPos())

				local TEMP_TargetDamage = DamageInfo()

				TEMP_TargetDamage:SetDamage(4 * ((512-distance)/512))
				TEMP_TargetDamage:SetInflictor(self)
				TEMP_TargetDamage:SetDamageType(DMG_SONIC)
				TEMP_TargetDamage:SetAttacker(self)
				TEMP_TargetDamage:SetDamagePosition(v:NearestPoint(self:GetPos()+self:OBBCenter()))
				TEMP_TargetDamage:SetDamageForce(self:GetForward()*1000)
			
				v:TakeDamageInfo(TEMP_TargetDamage)
				if v.hasGeiger and v:hasGeiger() then v:EmitSound(table.Random(self.sndGeigerHeavy)) end
			end
		end

		for _,v in pairs(ents.FindInSphere(self:GetPos(),1024)) do
			if v:IsPlayer() then
				local distance = self:GetPos():Distance(v:GetPos())

				local TEMP_TargetDamage = DamageInfo()

				TEMP_TargetDamage:SetDamage(3 * ((1024-distance)/1024))
				TEMP_TargetDamage:SetInflictor(self)
				TEMP_TargetDamage:SetDamageType(DMG_SONIC)
				TEMP_TargetDamage:SetAttacker(self)
				TEMP_TargetDamage:SetDamagePosition(v:NearestPoint(self:GetPos()+self:OBBCenter()))
				TEMP_TargetDamage:SetDamageForce(self:GetForward()*1000)
			
				v:TakeDamageInfo(TEMP_TargetDamage)
			end
		end

		self.farttimer = CurTime() + 1
	end


	if CurTime() > self.NextSpawn then
		if (!IsValid(self.Zombie1) && !IsValid(self.Zombie2) && !IsValid(self.Zombie3) && !IsValid(self.Zombie4) && !IsValid(self.Zombie5) && !IsValid(self.Zombie6) && self.GoingToSpawnThem == false) then
			self.GoingToSpawnThem = true
			
			self.Zombie1 = ents.Create("npc_mutant_classiczombie")
			self.Zombie1:SetPos(self:GetPos() +self:GetRight()*90)
			self.Zombie1:SetAngles(self:GetAngles())
			self.Zombie1:Spawn()
			
			self.Zombie2 = ents.Create("npc_mutant_classiczombie")
			self.Zombie2:SetPos(self:GetPos() +self:GetRight()*-90)
			self.Zombie2:SetAngles(self:GetAngles())
			self.Zombie2:Spawn()
			
			self.Zombie3 = ents.Create("npc_mutant_classiczombie")
			self.Zombie3:SetPos(self:GetPos() +self:GetForward()*100 +self:GetRight()*40)
			self.Zombie3:SetAngles(self:GetAngles())
			self.Zombie3:Spawn()
			
			self.Zombie4 = ents.Create("npc_mutant_classiczombie")
			self.Zombie4:SetPos(self:GetPos() +self:GetForward()*100 +self:GetRight()*-40)
			self.Zombie4:SetAngles(self:GetAngles())
			self.Zombie4:Spawn()
			
			self.Zombie5 = ents.Create("npc_mutant_classiczombie")
			self.Zombie5:SetPos(self:GetPos() +self:GetForward()*-100 +self:GetRight()*-40)
			self.Zombie5:SetAngles(self:GetAngles())
			self.Zombie5:Spawn()
			
			self.Zombie6 = ents.Create("npc_mutant_classiczombie")
			self.Zombie6:SetPos(self:GetPos() +self:GetForward()*-100 +self:GetRight()*40)
			self.Zombie6:SetAngles(self:GetAngles())
			self.Zombie6:Spawn()
		
			self.GoingToSpawnThem = false
			self.NextSpawn = CurTime() + 60
		end
	end

	if(self.CanSpecialTimer < CurTime()) then
		self.CanSpecial = true
	end


	if (self.special1 < CurTime() and self.SpecialAttack == 1) then
		self:ControllerPlaySoundToPlayer(self:GetEnemy(),"Stalker.Controller.Control.4")	
		
		if (IsValid(self:GetEnemy())&&self:GetEnemy()!=nil&&self:GetEnemy()!=nil) then
			local TEMP_POORGUY = self:GetEnemy()
			if(TEMP_POORGUY:Visible(self)) then		
				if(TEMP_POORGUY:IsPlayer()&&TEMP_POORGUY:Alive()) then
					TEMP_POORGUY:ViewPunch(Angle(math.random(-40,-30),math.random(-23,23),0))
				end
			
				local TEMP_TargetDamage = DamageInfo()
								
				TEMP_TargetDamage:SetDamage(15)
				TEMP_TargetDamage:SetInflictor(self)
				TEMP_TargetDamage:SetDamageType(DMG_SONIC)
				TEMP_TargetDamage:SetAttacker(self)
				TEMP_TargetDamage:SetDamagePosition(TEMP_POORGUY:NearestPoint(self:GetPos()+self:OBBCenter()))
				TEMP_TargetDamage:SetDamageForce(self:GetForward()*1000)
			
				TEMP_POORGUY:TakeDamageInfo(TEMP_TargetDamage)
			end

			self.SpecialAttack = 2
		end
	end

	if (self.special2 < CurTime() and self.SpecialAttack == 2) then
		self:STALKERNPCClearAnimation()
		self.SpecialAttack = 0
	end
end

function ENT:ControllerPlaySoundToPlayer(ent,SND)
	local TEMP_SOUND = nil
	
	if(IsValid(ent)&&ent!=nil&&ent!=NULL&&ent:IsPlayer()&&ent:Alive()&&self:Visible(ent)) then
		local TEMP_FILTER = RecipientFilter()
		
		TEMP_FILTER:AddPlayer(ent)
		
		TEMP_SOUND = CreateSound( game.GetWorld(), SND, TEMP_FILTER )
		
		if(TEMP_SOUND) then
			TEMP_SOUND:SetSoundLevel( 0 )
			TEMP_SOUND:Play()
		end
	end
	
	return TEMP_SOUND
end

function ENT:STALKERNPCDistanceForMeleeTooBig() 
	if(self.CanSpecial==true) then
		self:STALKERNPCPlayAnimation("psy_attack_0")
		
		self:STALKERNPCPlaySoundRandom(100,"Stalker.Controller.SpecialAttack",1,1)
		self:ControllerPlaySoundToPlayer(self:GetEnemy(),"Stalker.Controller.Control.1")

		self.special1 = CurTime() + 3.0
		self.special2 = CurTime() + 3.5
		self.SpecialAttack = 1

		self.CanSpecial = false
		self.CanSpecialTimer = CurTime()+5
	end
end

function ENT:STALKERNPCRemove()

	local TEMP_TargetDamage = DamageInfo()
								
	TEMP_TargetDamage:SetDamage(5)
	TEMP_TargetDamage:SetInflictor(self)
	TEMP_TargetDamage:SetDamageType(DMG_SONIC)
	TEMP_TargetDamage:SetAttacker(self)
	TEMP_TargetDamage:SetDamagePosition(self:GetPos())
	TEMP_TargetDamage:SetDamageForce(self:GetForward()*1000)

	if IsValid(self.Zombie1) then self.Zombie1:STALKERNPCKill(TEMP_TargetDamage) end
	if IsValid(self.Zombie2) then self.Zombie2:STALKERNPCKill(TEMP_TargetDamage) end
	if IsValid(self.Zombie3) then self.Zombie3:STALKERNPCKill(TEMP_TargetDamage) end
	if IsValid(self.Zombie4) then self.Zombie4:STALKERNPCKill(TEMP_TargetDamage) end
	if IsValid(self.Zombie5) then self.Zombie5:STALKERNPCKill(TEMP_TargetDamage) end
	if IsValid(self.Zombie6) then self.Zombie6:STALKERNPCKill(TEMP_TargetDamage) end
end