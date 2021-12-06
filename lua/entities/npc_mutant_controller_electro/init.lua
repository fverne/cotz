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
ENT.hp = 1800
ENT.hpvar = 200

ENT.CanSpecial = true

ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.CanSpecialTimer = 0
ENT.SpecialAttack = 0
ENT.special1 = 0
ENT.special2 = 0

ENT.farttimer = 0

ENT.MinRangeDist = 900
ENT.MaxRangeDist = 1500
ENT.VisibleSchedule = SCHED_RUN_FROM_ENEMY_FALLBACK
ENT.RangeSchedule = SCHED_RUN_RANDOM

sound.Add( {
	name = "electra_blast",
	channel = CHAN_STATIC,
	volume = 1,
	level = 100,
	pitch = 100,
	sound = "anomaly/electra_blast1.mp3"
} )

function ENT:Initialize()
	self.Model = "models/monsters/controler_big.mdl"
	self:STALKERNPCInit(Vector(-16,-16,70),MOVETYPE_STEP)
	
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Claw.Miss" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 19
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH, DMG_CLUB)
	TEMP_MeleeTable.distance[1] = 21
	TEMP_MeleeTable.radius[1] = 60
	TEMP_MeleeTable.time[1] = 0.8
	TEMP_MeleeTable.bone[1] = "bip01_r_hand"
	TEMP_MeleeTable.damage[2] = 19
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_SLASH, DMG_CLUB)
	TEMP_MeleeTable.distance[2] = 21
	TEMP_MeleeTable.radius[2] = 60
	TEMP_MeleeTable.time[2] = 1.2
	TEMP_MeleeTable.bone[2] = "bip01_l_hand"
	self:STALKERNPCSetMeleeParams(1,"S_Melee2",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	
	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	self.MaxVictims = 0

	self:SetSkin(3)

	self.GoingToSpawnThem = false
	self.NextSpawn = 0


	self:SetMaxHealth(self:Health())
	
	
	self.Victims = {}
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()

	if (self.farttimer < CurTime()) then
		for _,v in pairs(ents.FindInSphere(self:GetPos(),256)) do
			if (v == self or (!v:IsNPC() and !v:IsPlayer()) or !v:Alive()) then continue end

			local distance = self:GetPos():Distance(v:GetPos())

			local TEMP_TargetDamage = DamageInfo()

			TEMP_TargetDamage:SetDamage(15)
			TEMP_TargetDamage:SetInflictor(self)
			TEMP_TargetDamage:SetDamageType(DMG_SHOCK)
			TEMP_TargetDamage:SetAttacker(self)
			TEMP_TargetDamage:SetDamagePosition(v:NearestPoint(self:GetPos()+self:OBBCenter()))
			TEMP_TargetDamage:SetDamageForce(self:GetForward()*1000)

			v:TakeDamageInfo(TEMP_TargetDamage)

			if (distance < 256) then
				local TEMP_Effect = EffectData()
				TEMP_Effect:SetOrigin(self:GetPos()+Vector(0,0,50))
				TEMP_Effect:SetStart(v:GetPos()+v:OBBCenter())
				TEMP_Effect:SetNormal((v:GetPos()-self:GetPos()):GetNormalized())
				TEMP_Effect:SetScale(10)
				TEMP_Effect:SetRadius(10)
	
				util.Effect("lightningzap", TEMP_Effect, true, true)
			end
		end

		self.farttimer = CurTime() + 0.5
	end

	if(self.CanSpecialTimer < CurTime()) then
		self.CanSpecial = true
	end


	if (self.special1 < CurTime() and self.SpecialAttack == 1) then
		self:ControllerPlaySoundToPlayer(self:GetEnemy(),"Stalker.Controller.Control.3")	
		
		if (IsValid(self:GetEnemy())&&self:GetEnemy()!=nil&&self:GetEnemy()!=nil) then
			local TEMP_POORGUY = self:GetEnemy()
			if(TEMP_POORGUY:Visible(self)) then	
				local TEMP_ShootPoint = TEMP_POORGUY:GetPos()+TEMP_POORGUY:OBBCenter()

				local TEMP_ShootPos = self:GetPos()+Vector(0,0,50)+(self:GetForward()*15)
					
				local TEMP_Effect = EffectData()
				TEMP_Effect:SetOrigin(TEMP_ShootPos)
				TEMP_Effect:SetStart(TEMP_ShootPoint)
				TEMP_Effect:SetNormal((TEMP_ShootPoint-TEMP_ShootPos):GetNormalized())
				TEMP_Effect:SetScale(10)
				TEMP_Effect:SetRadius(10)

				util.Effect("lightningzap", TEMP_Effect, true, true)

				ParticleEffect( "electra_activated", TEMP_ShootPoint, Angle( 0, 0, 0 ) )

				local dmg = DamageInfo()
				dmg:SetDamage(75)
				dmg:SetAttacker(self)
				dmg:SetDamageType(DMG_SHOCK)
				dmg:SetInflictor(self)
				dmg:SetDamagePosition(TEMP_POORGUY:NearestPoint(self:GetPos()))

				TEMP_POORGUY:TakeDamageInfo(dmg)
				TEMP_POORGUY:EmitSound("electra_blast")

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
		local TEMP_ShootPoint = self:GetPos()+(self:GetForward()*1000)
		if(self:GetEnemy()) then
			TEMP_ShootPoint = self:GetEnemy():GetPos()+self:GetEnemy():OBBCenter()
		end
		local TEMP_ShootPos = self:GetPos()+Vector(0,0,50)+(self:GetForward()*15)

		local _, yaw, _ = (TEMP_ShootPoint-TEMP_ShootPos):GetNormalized():Angle():Unpack()
		local pitch, _, roll = self:GetAngles():Unpack()

		self:SetAngles(Angle(pitch,yaw,roll))

		self:STALKERNPCPlayAnimation("psy_attack_0")
		
		self:STALKERNPCPlaySoundRandom(100,"Stalker.Controller.SpecialAttack",1,1)

		self.special1 = CurTime() + 2.7
		self.special2 = CurTime() + 3.5
		self.SpecialAttack = 1

		self.CanSpecial = false
		self.CanSpecialTimer = CurTime()+9
	end
end

function ENT:STALKERNPCRemove()
end