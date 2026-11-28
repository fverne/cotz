AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.PainSoundEnabled = true
ENT.PainSound.name = "Stalker.Karlik.Pain"
ENT.PainSound.min = 1
ENT.PainSound.max = 4

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Karlik.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 1

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Karlik.Melee"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 1

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Karlik.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 3

ENT.CanSpecial = true

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.hp = 1200
ENT.hpvar = 50

ENT.FBR = 10
ENT.FBRAP = 15
ENT.BR = 10

ENT.WantToKnock = false

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 800
ENT.MaxRangeDist = 1500
ENT.VisibleSchedule = SCHED_ALERT_FACE
ENT.RangeSchedule = SCHED_IDLE_STAND

ENT.navigationRangedRange = 1500

local PROJECTILE_OFFSET = Vector(15, 0, 50)
local PROJECTILE_SPEED = 2000
local KNOCK_SPEED = 700
local KNOCK_ORIGIN_DROP = Vector(0, 0, 96)
local TELEPORT_EFFECT_OFFSET = Vector(0, 0, 45)
local WARP_ODDS = 3

ENT.Abilities = {
	{
		name = "warp",
		triggerOnly = true,
		interrupts = true,
		uninterruptible = true,
		cancelOnTargetLoss = false,
		-- Ten seconds after the teleport, as in the original.
		cooldown = 11.2,
		initialCooldown = 1,
		phases = {
			{duration = 1.2, animation = "stand_blinded_2"},
			{duration = 0, method = "KarlikWarp"},
		},
	},
	{
		name = "knock",
		triggerOnly = true,
		interrupts = true,
		cancelOnTargetLoss = false,
		cooldown = 10,
		initialCooldown = 1,
		phases = {
			{duration = 1.6, animation = "stand_attack_3"},
			{duration = 0, method = "KarlikKnock"},
		},
	},
	{
		name = "throw",
		meleeRange = "outside",
		chance = 0.4,
		cooldown = 4,
		linkedCooldowns = {volley = 4},
		cancelOnTargetLoss = false,
		phases = {
			{duration = 1.1, animation = "stand_attack_0"},
			{duration = 0, method = "KarlikThrow"},
		},
	},
	{
		name = "volley",
		meleeRange = "outside",
		chance = 0.34,
		cooldown = 6,
		linkedCooldowns = {throw = 6},
		cancelOnTargetLoss = false,
		phases = {
			{duration = 0.7, animation = "stand_attack_1"},
			{duration = 0.7, method = "KarlikThrow"},
			{duration = 0, method = "KarlikThrow"},
		},
	},
}

function ENT:Initialize()
	self.Model = "models/maver1k_XVII/Stalker/mutants/karlik.mdl"
	self.ragdollModel = "models/monsters/karlik.mdl"

	self:STALKERNPCInit(Vector(-32,-32,40),MOVETYPE_STEP)
	
	self.MinRangeDist = 800
	self.MaxRangeDist = 1500
	self:SetBloodColor(BLOOD_COLOR_ZOMBIE)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Claw.Miss" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 0
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_MISSILEDEFENSE)
	TEMP_MeleeTable.distance[1] = 21
	TEMP_MeleeTable.radius[1] = 60
	TEMP_MeleeTable.time[1] = 0.6
	TEMP_MeleeTable.bone[1] = "right_hand"
	self:STALKERNPCSetMeleeParams(1,"stand_idle_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	
	self:SetMaxHealth(self:Health())

	self.NextAbilityTime = CurTime()+1
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

-- Enemies that come close queue a knockback, which fires as soon as its cooldown allows.
function ENT:STALKERNPCThink()
	local enemy = self:GetEnemy()
	if IsValid(enemy) and self:GetPos():Distance(enemy:GetPos()) < self.MinRangeDist / 2 then
		self.WantToKnock = true
	end
	if self.WantToKnock and self:STALKERNPCTriggerAbility("knock") then self.WantToKnock = false end
end

function ENT:KarlikWarp()
	sound.Play("Stalker.Controller.Control.3", self:GetPos())
	self:SetNWBool("Teleport", true)
	self:SetNWVector("OldPos", self:GetPos() + TELEPORT_EFFECT_OFFSET)
	self:SetPos(self:GetTeleportLocation())
end

function ENT:KarlikKnock()
	local origin = self:GetPos() - KNOCK_ORIGIN_DROP
	for _, target in ipairs(ents.FindInSphere(self:GetPos(), self.MinRangeDist)) do
		if target ~= self then
			local direction = (target:GetPos() + self:OBBCenter() - origin):GetNormalized()
			local physics = target:GetPhysicsObject()
			if IsValid(physics) then physics:SetVelocity(direction * KNOCK_SPEED) end
			if target:IsPlayer() then target:SetVelocity(direction * KNOCK_SPEED) end
		end
	end
	self:SetNWBool("Knocking", true)
end

function ENT:KarlikThrow(enemy)
	self:STALKERNPCPlaySoundRandom(100, "Stalker.Karlik.Push", 1, 1)
	self:STALKERNPCAbilityLaunchProjectile("ent_karlik_ball", enemy, PROJECTILE_SPEED, PROJECTILE_OFFSET)
end

function ENT:STALKERNPCDistanceForMeleeTooSmall()

end

function ENT:STALKERNPCDamageTake(dmginfo, mul)
	if math.random(1, WARP_ODDS) == 1 then self:STALKERNPCTriggerAbility("warp") end

	return mul
end

function ENT:GetTeleportLocation( )
	local enemy = self:GetEnemy()
	-- The enemy can disappear during the teleport windup.
	if not IsValid(enemy) then return self:GetPos() end

	local enemyPos = enemy:GetPos()
	local tracegood = false
	local teleres
	local tracecnt = 0

	local firstTrace = util.TraceLine( {
			start = self:GetPos() + Vector(0,0,64),
			endpos = self:GetPos() + Vector(0,0,800),
			filter = "npc_mutant_karlik",
			mask = MASK_ALL,
			ignoreworld = false
		} )

	repeat
		local trace = util.TraceHull( {
			start = firstTrace.HitPos - Vector(0,0,-64),
			endpos = enemyPos + Vector(math.random(-1200,1200),math.random(-1200,1200),-400),
			mins = Vector( -32, -32, 0 ),
			maxs = Vector( 32, 32, 64 ),
			filter = "npc_mutant_karlik",
			mask = MASK_ALL,
			ignoreworld = false
		} )

		if not trace.HitSky and trace.HitPos:Distance(enemyPos) > 600 then
			tracegood = true
			teleres = trace.HitPos
		end

		tracecnt = tracecnt + 1

		if tracecnt > 50 then
			tracegood = true
			teleres = self:GetPos() -- Teleport to original position if we cant find a position
		end

	until tracegood


	return teleres
end
