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
ENT.injuredact = ACT_DOD_WALK_AIM_RIFLE

ENT.FBR = 5
ENT.FBRAP = 12
ENT.BR = 15

ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.farttimer = 0

ENT.MinRangeDist = 900
ENT.MaxRangeDist = 1500
ENT.VisibleSchedule = SCHED_RUN_FROM_ENEMY_FALLBACK
ENT.RangeSchedule = SCHED_RUN_RANDOM

ENT.navigationRangedRange = 1500

local SHOT_HEIGHT = Vector(0, 0, 50)
local SHOT_FORWARD = 15
local AIM_FALLBACK_DISTANCE = 1000
local PROJECTILE_OFFSET = Vector(SHOT_FORWARD, 0, 50)
local PROJECTILE_SPEED = 2500

ENT.Abilities = {
	{
		name = "psyAttack",
		meleeRange = "outside",
		cooldown = 9,
		cancelOnTargetLoss = false,
		phases = {
			{duration = 2.7, animation = "psy_attack_0", attackIndex = 0, method = "ControllerPsyWindup"},
			{duration = 0.8, method = "ControllerPsyStrike"},
		},
	},
}

function ENT:Initialize()
	self.Model = "models/monsters/controler_fast.mdl"
	self:STALKERNPCInit(Vector(-16,-16,70),MOVETYPE_STEP)
	
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Claw.Miss" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 19
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_CLUB)
	TEMP_MeleeTable.distance[1] = 21
	TEMP_MeleeTable.radius[1] = 60
	TEMP_MeleeTable.time[1] = 0.8
	TEMP_MeleeTable.bone[1] = "bip01_r_hand"
	TEMP_MeleeTable.damage[2] = 19
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_CLUB)
	TEMP_MeleeTable.distance[2] = 21
	TEMP_MeleeTable.radius[2] = 60
	TEMP_MeleeTable.time[2] = 1.2
	TEMP_MeleeTable.bone[2] = "bip01_l_hand"
	self:STALKERNPCSetMeleeParams(1,"S_Melee2",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	
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
	-- npc wounded animation
	if self:Health() < (self:GetMaxHealth() * 0.33) then
		self:SetMovementActivity(self.injuredact)
	end

	if (self.farttimer < CurTime()) then
		for _, v in player.Iterator() do
			if self:GetPos():DistToSqr(v:GetPos()) <= 256 ^ 2 then
				local distance = self:GetPos():Distance(v:GetPos())

				local TEMP_TargetDamage = DamageInfo()

				TEMP_TargetDamage:SetDamage(20 * ((256-distance)/256))
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
end

function ENT:ControllerPsyWindup(enemy)
	local origin = self:GetPos() + SHOT_HEIGHT + self:GetForward() * SHOT_FORWARD
	local target = enemy and enemy:WorldSpaceCenter() or self:GetPos() + self:GetForward() * AIM_FALLBACK_DISTANCE
	local angles = self:GetAngles()
	self:SetAngles(Angle(angles.p, (target - origin):Angle().y, angles.r))
	self:STALKERNPCPlaySoundRandom(100, "Stalker.Controller.SpecialAttack", 1, 1)
end

function ENT:ControllerPsyStrike(enemy)
	self:ControllerPlaySoundToPlayer(enemy, "Stalker.Controller.Control.3")
	if not enemy or not enemy:Visible(self) then return end

	self:STALKERNPCAbilityLaunchProjectile("ent_fastcontroller_ball", enemy, PROJECTILE_SPEED, PROJECTILE_OFFSET)
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

function ENT:STALKERNPCRemove()
end