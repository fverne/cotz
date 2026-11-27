AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Bloodsucker.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 4

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Bloodsucker.Hit"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 5

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Bloodsucker.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 3

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Bloodsucker.Chase"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 3
ENT.ChasingSound.chance = 20

ENT.CanSpecial = true

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.hp = 300
ENT.hpvar = 25
ENT.injuredact = ACT_RUN_AIM_PISTOL

ENT.FBR = 5
ENT.FBRAP = 5
ENT.BR = 20

ENT.NextAbilityTime = 0

ENT.MinRangeDist = 0
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_RUN_RANDOM
ENT.RangeSchedule = SCHED_CHASE_ENEMY

ENT.PostSuccRunFinish = 0

ENT.navigationLeapRange = 100

ENT.navigationLeapAimHeight = 96
ENT.navigationLeapSpeed = 2

local FEED_HEAL = 125
local FEED_FLEE_SECONDS = 10

ENT.Abilities = {
	{
		name = "jump",
		navigationLeap = "long",
		meleeRange = "outside",
		maxRange = ENT.navigationLeapRange,
		chance = 0.5,
		cooldown = 9,
		recovery = 1,
		phases = {
			{duration = 0.2},
			{
				duration = 0.8, leap = "long", melee = 4, sound = "Stalker.Bloodsucker.Hit1",
				untilGrounded = true, maxDuration = 5,
			},
		},
	},
	{
		name = "feed",
		meleeRange = "outside",
		maxRange = 75,
		chance = 0.5,
		cooldown = 15,
		recovery = 1,
		cancelOnTargetLoss = false,
		validate = "BloodsuckerHasVictim",
		onFinish = "BloodsuckerReleaseVictim",
		phases = {
			{duration = 0.2, melee = 6, method = "BloodsuckerSeize"},
			{duration = 1, sound = "Stalker.Bloodsucker.Feed", method = "BloodsuckerFeed"},
			{duration = 1, method = "BloodsuckerFeed"},
			{duration = 1, method = "BloodsuckerFeed"},
			{duration = 0, method = "BloodsuckerFinishFeed", untilAnimationDone = true, maxDuration = 3},
		},
	},
}

function ENT:Initialize()
	self.Model = "models/monsters/krovosos.mdl"
	self:STALKERNPCInit(Vector(-28,-28,70),MOVETYPE_STEP)
	
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Snork.Hit1" }
	
	local TEMP_MeleeMissTable = { "Stalker.Snork.Miss1" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 30
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 81
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 1
	TEMP_MeleeTable.bone[1] = "bip01_l_hand"
	self:STALKERNPCSetMeleeParams(1,"stand_attack_0",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 30
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 81
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 1
	TEMP_MeleeTable.bone[1] = "bip01_r_hand"
	self:STALKERNPCSetMeleeParams(2,"stand_attack_1",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 30
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 81
	TEMP_MeleeTable.radius[1] = 120
	TEMP_MeleeTable.time[1] = 0.5
	TEMP_MeleeTable.bone[1] = "bip01_l_hand"
	TEMP_MeleeTable.damage[2] = 30
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[2] = 81
	TEMP_MeleeTable.radius[2] = 120
	TEMP_MeleeTable.time[2] = 0.8
	TEMP_MeleeTable.bone[2] = "bip01_r_hand"
	self:STALKERNPCSetMeleeParams(4,"stand_attack_run_0",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 15
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SONIC)
	TEMP_MeleeTable.distance[1] = 81
	TEMP_MeleeTable.radius[1] = 512
	TEMP_MeleeTable.time[1] = 1
	TEMP_MeleeTable.bone[1] = "bip01_r_hand"
	TEMP_MeleeTable.damage[2] = 30
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[2] = 81
	TEMP_MeleeTable.radius[2] = 120
	TEMP_MeleeTable.time[2] = 3.3
	TEMP_MeleeTable.bone[2] = "bip01_r_hand"
	self:STALKERNPCSetMeleeParams(6,"vampire",2, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

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

	if(self.PostSuccRunFinish<CurTime()) then
		self.RangeSchedule = SCHED_CHASE_ENEMY
	else
		self.RangeSchedule = SCHED_RUN_FROM_ENEMY_FALLBACK
	end
end

function ENT:BloodsuckerSeize(enemy, state)
	state.victim = enemy
	if enemy and enemy:IsPlayer() then enemy:Freeze(true) end
end

-- A victim that disappears mid-feed ends it; after the release, the bite animation may finish.
function ENT:BloodsuckerHasVictim(state)
	return state.released or IsValid(state.victim)
end

function ENT:BloodsuckerFeed()
	self:SetHealth(math.Clamp(self:Health() + FEED_HEAL, 0, self:GetMaxHealth()))
end

function ENT:BloodsuckerFinishFeed(_, state)
	self:BloodsuckerFeed()
	self:BloodsuckerReleaseVictim(state)
	self.PostSuccRunFinish = CurTime() + FEED_FLEE_SECONDS
end

function ENT:BloodsuckerReleaseVictim(state)
	local victim = state.victim
	state.victim, state.released = nil, true
	if IsValid(victim) and victim:IsPlayer() then victim:Freeze(false) end
end
