AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
include("STALKERNPCBaseVars.lua")

ENT.PainSoundEnabled = true
ENT.PainSound.name = "Stalker.Spider.Pain"
ENT.PainSound.min = 1
ENT.PainSound.max = 3

ENT.DieSoundEnabled = true
ENT.DieSound.name = "Stalker.Spider.Die"
ENT.DieSound.min = 1
ENT.DieSound.max = 3

ENT.MeleeSoundEnabled = true
ENT.MeleeSound.name = "Stalker.Spider.Melee"
ENT.MeleeSound.min = 1
ENT.MeleeSound.max = 3

ENT.IdlingSoundEnabled = true
ENT.IdlingSound.name = "Stalker.Spider.Idle"
ENT.IdlingSound.min = 1
ENT.IdlingSound.max = 3

ENT.ChasingSoundEnabled = true
ENT.ChasingSound.name = "Stalker.Spider.Chase"
ENT.ChasingSound.min = 1
ENT.ChasingSound.max = 4
ENT.ChasingSound.chance = 20

--ENT.SNPCClass="C_MONSTER_LAB"
ENT.SNPCClass="C_MONSTER_PLAYERFOCUS"

ENT.hp = 370
ENT.hpvar = 50

ENT.FBR = 8
ENT.FBRAP = 8
ENT.BR = 20

ENT.NextAbilityTime = 0

ENT.TeleportPending = false
ENT.CanTeleportTimer = 0

ENT.MinRangeDist = 800
ENT.MaxRangeDist = 1200
ENT.VisibleSchedule = SCHED_IDLE_WANDER 
ENT.RangeSchedule = SCHED_CHASE_ENEMY

ENT.navigationLeapRange = 1200
ENT.navigationLeapMinRange = 300
ENT.navigationLeapHealthFraction = 0.5
ENT.navigationRangedRange = 800

ENT.navigationLeapAimHeight = 128
ENT.navigationLeapSpeed = 1.5

local SPIT_OFFSET_FORWARD = 15
local SPIT_OFFSET_UP = 50
local SPIT_ARC_DIVISOR = 8
local SPIT_SPEED = 1500
local BURROW_HOLD = 0.8

ENT.Abilities = {
	{
		name = "jump",
		navigationLeap = "long",
		canUse = "SpiderCanLeap",
		meleeRange = "outside",
		minRange = ENT.navigationLeapMinRange,
		maxRange = ENT.navigationLeapRange,
		chance = 0.5,
		cooldown = 3,
		recovery = 0.5,
		phases = {
			{duration = 0.2},
			{
				duration = 0, leap = "long", melee = 4, sound = "Stalker.Rodent.Melee2",
				untilGrounded = true, untilAnimationDone = true, maxDuration = 4.8,
			},
		},
	},
	{
		name = "spit",
		canUse = "SpiderCanSpit",
		meleeRange = "outside",
		maxRange = ENT.navigationRangedRange,
		cooldown = 4,
		cancelOnTargetLoss = false,
		phases = {
			{duration = 0.8, animation = "attack_web", attackIndex = 0, method = "SpiderAimSpit"},
			{duration = 0.5, method = "SpiderSpit"},
		},
	},
	{
		name = "teleport",
		triggerOnly = true,
		cancelOnTargetLoss = false,
		onFinish = "SpiderEndBurrow",
		phases = {
			{duration = 0, method = "SpiderBurrow"},
			{duration = 0, method = "SpiderEmerge"},
		},
	},
}

function ENT:Initialize()
	self.Model = "models/darkmessiah/spider_regular.mdl"
	self:STALKERNPCInit(Vector(-16,-16,70),MOVETYPE_STEP)
	
	self.MinRangeDist = 0
	self.MaxRangeDist = 1200
	self:SetBloodColor(BLOOD_COLOR_RED)
	
	self:DropToFloor()
	
	local TEMP_MeleeHitTable = { "Stalker.Claw.Hit" }
	
	local TEMP_MeleeMissTable = { "Stalker.Dog.Miss1" }
						
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	
	TEMP_MeleeTable.damage[1] = 35
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 40
	TEMP_MeleeTable.radius[1] = 80
	TEMP_MeleeTable.time[1] = 0.8
	TEMP_MeleeTable.bone[1] = "SK_Head_End"
	self:STALKERNPCSetMeleeParams(1,"attack_4",1, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()

	//Jumping attack
	local TEMP_MeleeTable = self:STALKERNPCCreateMeleeTable()
	TEMP_MeleeTable.damage[1] = 15
	TEMP_MeleeTable.damagetype[1] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[1] = 64
	TEMP_MeleeTable.radius[1] = 40
	TEMP_MeleeTable.time[1] = 1.3
	TEMP_MeleeTable.bone[1] = "SK_R_Leg_a3"
	TEMP_MeleeTable.damage[2] = 15
	TEMP_MeleeTable.damagetype[2] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[2] = 64
	TEMP_MeleeTable.radius[2] = 40
	TEMP_MeleeTable.time[2] = 1.3
	TEMP_MeleeTable.bone[2] = "SK_L_Leg_a3"
	TEMP_MeleeTable.damage[3] = 15
	TEMP_MeleeTable.damagetype[3] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[3] = 64
	TEMP_MeleeTable.radius[3] = 40
	TEMP_MeleeTable.time[3] = 1.3
	TEMP_MeleeTable.bone[3] = "SK_R_Leg_b3"
	TEMP_MeleeTable.damage[4] = 15
	TEMP_MeleeTable.damagetype[4] = bit.bor(DMG_SLASH)
	TEMP_MeleeTable.distance[4] = 64
	TEMP_MeleeTable.radius[4] = 40
	TEMP_MeleeTable.time[4] = 1.3
	TEMP_MeleeTable.bone[4] = "SK_L_Leg_b3"
	self:STALKERNPCSetMeleeParams(4,"attack_2",4, TEMP_MeleeTable,TEMP_MeleeHitTable,TEMP_MeleeMissTable)

	self:SetHealth(self.hp + math.random(-self.hpvar, self.hpvar))
	
	self:SetMaxHealth(self:Health())
	
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
end

function ENT:STALKERNPCThinkEnemyValid()
	
end

function ENT:STALKERNPCThink()
	-- A queued teleport waits for the current attack to finish.
	if self.TeleportPending and self:STALKERNPCTriggerAbility("teleport") then
		self.TeleportPending = false
	end
end

-- Healthy spiders leap; wounded ones spit instead.
function ENT:SpiderCanLeap()
	return self:Health() > self.navigationLeapHealthFraction * self:GetMaxHealth()
end

function ENT:SpiderCanSpit()
	return not self.cotzUnreachableRecovery and not self:SpiderCanLeap()
end

function ENT:SpiderSpitAim(enemy)
	local origin = self:GetPos() + Vector(0, 0, SPIT_OFFSET_UP) + self:GetForward() * SPIT_OFFSET_FORWARD
	-- Lead the shot first, then loft it for the distance to where the target will be.
	local aim = self:STALKERNPCPredictAim(enemy, origin, SPIT_SPEED)
	local arc = Vector(0, 0, self:GetPos():Distance(aim - enemy:OBBCenter()) / SPIT_ARC_DIVISOR)

	return origin, aim + arc
end

function ENT:SpiderAimSpit(enemy)
	if not enemy then return end

	local origin, target = self:SpiderSpitAim(enemy)
	local angles = self:GetAngles()
	local yaw = (target - origin):GetNormalized():Angle().y
	self:SetAngles(Angle(angles.p, yaw, angles.r))
end

function ENT:SpiderSpit(enemy)
	if not enemy or not enemy:Visible(self) then return end

	local origin, target = self:SpiderSpitAim(enemy)
	local projectile = ents.Create("ent_spider_ball")
	if not IsValid(projectile) then return end
	projectile:SetPos(origin)
	projectile:SetAngles((target - origin):Angle())
	projectile:Spawn()
	projectile:SetOwner(self)
	local physics = projectile:GetPhysicsObject()
	if IsValid(physics) then physics:SetVelocity((target - origin):GetNormalized() * SPIT_SPEED) end
end

function ENT:SpiderBurrow(_, state)
	local _, duration = self:LookupSequence("desummoned")
	self:STALKERNPCAbilityPlaySequence(state, "desummoned", duration + BURROW_HOLD)
	self:EmitSound("Stalker.Spider.Spider")
	self.ShouldEmitSound = false
	state.collisionGroup = self:GetCollisionGroup()
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
end

function ENT:SpiderEmerge(_, state)
	self:DoTeleport()
	local _, duration = self:LookupSequence("summoned")
	self:STALKERNPCAbilityPlaySequence(state, "summoned", duration)
	self:SpiderEndBurrow(state)
	self:EmitSound("Stalker.Spider.Burrow")
end

function ENT:SpiderEndBurrow(state)
	self.ShouldEmitSound = true
	self:SetCollisionGroup(state.collisionGroup)
end

function ENT:STALKERNPCOnDeath()

end

function ENT:STALKERNPCDamageTake(dmginfo,mul)

	if( math.random(100) > 70) and self.CanTeleportTimer < CurTime() then
		self.TeleportPending = true
		self.CanTeleportTimer = CurTime() + 15
	end

	return mul
end

function ENT:DoTeleport()
	self:SetPos(self:GetTeleportLocation())
end

function ENT:GetTeleportLocation( )
	local tracegood = false
	local teleres
	local tracecnt = 0

	local firstTrace = util.TraceLine( {
			start = self:GetPos() + Vector(0,0,64),
			endpos = self:GetPos() + Vector(0,0,400),
			filter = "npc_mutant_spider",
			mask = MASK_ALL,
			ignoreworld = false
		} )

	repeat
		local trace = util.TraceHull( {
			start = firstTrace.HitPos - Vector(0,0,-64),
			endpos = self:GetPos() + Vector(math.random(-1200,1200),math.random(-1200,1200),-400),
			mins = Vector( -32, -32, 0 ),
			maxs = Vector( 32, 32, 64 ),
			filter = "npc_mutant_spider",
			mask = MASK_ALL,
			ignoreworld = false
		} )

		if IsValid(self:GetEnemy()) then
			if (!trace.HitSky && trace.HitPos:Distance(self:GetEnemy():GetPos()) > 600) then
				tracegood = true
				teleres = trace.HitPos
			end
		end
		

		tracecnt = tracecnt + 1

		if tracecnt > 50 then
			tracegood = true
			teleres = self:GetPos() -- Teleport to original position if we cant find a position
		end

	until tracegood


	return teleres
end
