AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.PainSoundEnabled = true
ENT.PainSound.name = "Stalker.Chimera.Pain"
ENT.PainSound.min = 1
ENT.PainSound.max = 5

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

ENT.hp = 850
ENT.hpvar = 20
ENT.injuredact = ACT_WALK_PISTOL

ENT.FBR = 7
ENT.FBRAP = 15
ENT.BR = 55

ENT.CanBlast = 0

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 0
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_RUN_RANDOM
ENT.RangeSchedule = SCHED_CHASE_ENEMY

ENT.flatbulletresistance = 9
ENT.percentbulletresistance = 25

sound.Add( {
	name = "electra_blast",
	channel = CHAN_STATIC,
	volume = 1,
	level = 100,
	pitch = 100,
	sound = "anomaly/electra_blast1.mp3"
} )


ENT.navigationLeapRange = 1200
ENT.navigationLeapMinRange = 300

ENT.navigationLeapAimHeight = 128
ENT.navigationLeapSpeed = 1.5

ENT.Abilities = {
	{
		name = "jump",
		navigationLeap = "long",
		meleeRange = "outside",
		minRange = ENT.navigationLeapMinRange,
		maxRange = ENT.navigationLeapRange,
		chance = 0.5,
		cooldown = 3,
		initialCooldown = 1,
		recovery = 0.5,
		phases = {
			{duration = 0.2},
			{
				duration = 0, leap = "long", melee = 1, sound = "Stalker.Chimera.Hit4",
				untilGrounded = true, untilAnimationDone = true, maxDuration = 4.8,
			},
		},
	},
}

function ENT:Initialize()
	self.Model = "models/monsters/chimera2.mdl"
	self.ragdollModel = "models/monsters/chimera.mdl" -- skins dont overlap, will anyone notice? x

	self:STALKERNPCInit(Vector(-48,-48,70),MOVETYPE_STEP)
	
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Snork.Miss1" }

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 10
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 120
	TEMP_MeleeTable.radius[1] = 400
	TEMP_MeleeTable.time[1] = 0.6
	TEMP_MeleeTable.bone[1] = "bone21"
	TEMP_MeleeTable.damage[2] = 10
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[2] = 120
	TEMP_MeleeTable.radius[2] = 400
	TEMP_MeleeTable.time[2] = 1
	TEMP_MeleeTable.bone[2] = "bone21"
	self:STALKERNPCSetMeleeParams(1,"jump_attack_0",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	
	self:SetMaxHealth(self:Health())

	self.NextAbilityTime = CurTime()+1
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()
	-- npc wounded animation
	if self:Health() < (self:GetMaxHealth() * 0.33) then
		self:SetMovementActivity(self.injuredact)
	end
end

function ENT:STALKERNPCHitSomething()
	self:Blast()
end

function ENT:STALKERNPCDamageTake(dmginfo,mul)
	if(dmginfo:GetDamageType() == DMG_BULLET) then
		dmginfo:SetDamage(dmginfo:GetDamage()*(1 - (self.percentbulletresistance/100)))
		dmginfo:SubtractDamage(self.flatbulletresistance)
		dmginfo:SetDamage(math.max(0,dmginfo:GetDamage())) --So he can't heal from our attacks

		self:Blast()
	end
end

function ENT:Blast()
	if (self.CanBlast < CurTime()) then
		self:EmitSound("electra_blast")
		ParticleEffect( "electra_activated", self:GetPos() + Vector(0,0,16), Angle( 0, 0, 0 ) )
		for _,v in pairs(ents.FindInSphere(self:GetPos() + Vector(0,0,16), 512)) do
			if v == self then continue end
			local dmg = DamageInfo()
			dmg:SetDamage(75)
			dmg:SetAttacker(self)
			dmg:SetDamageType(DMG_SHOCK)
			dmg:SetInflictor(self)
			dmg:SetDamagePosition(v:NearestPoint(self:GetPos()))

			v:TakeDamageInfo(dmg)
		end

		self.CanBlast = CurTime() + 4
	end
end