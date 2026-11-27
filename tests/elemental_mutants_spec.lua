-- Run from the repository root: luatex --luaonly tests/elemental_mutants_spec.lua
-- Mimic aerial attack, mutant orbs, poltergeist flames and telekinetic grips.
local fixture = dofile("tests/helpers/mutant_base.lua")
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end

DMG_CLUB, DMG_SLASH, DMG_BURN, DMG_SHOCK = 64, 4, 8, 256
MOVETYPE_NONE, MOVETYPE_STEP, MASK_SHOT_HULL, MASK_SOLID_BRUSHONLY, COLLISION_GROUP_WEAPON = 0, 3, 5, 6, 11
angle_zero = {}
ParticleEffect = function() end
sound = {Add = function() end, Play = function() end}
math.random = function(low, high)
	if not low then return 0 end

	return high and low or 1
end

local base = fixture.LoadBase("sv_abilities", "sv_flight")

local function advance(actor, seconds)
	for _ = 1, math.floor(seconds / 0.05 + 0.5) do
		fixture.now = fixture.now + 0.05
		if actor.cotzAbility then actor:STALKERNPCUpdateAbility() end
	end
end

-- Every new ability list passes the base validator and names methods its class defines.
local function checkAbilities(class)
	local source = assert(io.open("lua/entities/npc_mutant_" .. class .. "/init.lua")):read("*a")
	local extra = io.open("lua/entities/npc_mutant_" .. class .. "/sv_telekinesis.lua")
	if extra then source = source .. extra:read("*a") end
	local loaded = fixture.LoadMutant(class, base, {})
	local actor = fixture.Actor(base, {Abilities = loaded.Abilities})
	fixture.errors = {}
	actor:STALKERNPCInitAbilities()
	check(actor.Abilities and #fixture.errors == 0, class .. " abilities are valid")
	for _, ability in ipairs(loaded.Abilities) do
		local names = {ability.canUse, ability.onFinish, ability.validate}
		for _, phase in ipairs(ability.phases) do names[#names + 1] = phase.method end
		for _, name in pairs(names) do
			check(source:find("function ENT:" .. name .. "(", 1, true), class .. " lacks " .. tostring(name))
		end
	end
end

for _, class in ipairs({"bloodsucker_swamp", "mimic", "poltergeist_fire", "poltergeist_electro", "poltergeist_tele"}) do
	checkAbilities(class)
end

local swamp = fixture.LoadMutant("bloodsucker_swamp", base, {})
for _, ability in ipairs(swamp.Abilities) do
	check(ability.name ~= "feed", "the swamp bloodsucker has no feeding stun")
end

local mimic = fixture.LoadMutant("mimic", base, {
	"MimicCanFly", "MimicFace", "MimicTeleport", "MimicSetAirborne", "MimicVanish", "MimicTakePerch",
	"MimicShoot", "MimicLand",
})

local function newMimic()
	local perches = 0
	local actor = fixture.Actor(mimic, {
		Abilities = mimic.Abilities, capabilities = true, shots = {}, positions = {},
		CapabilitiesRemove = function(self) self.capabilities = false end,
		CapabilitiesAdd = function(self) self.capabilities = true end,
		SetMoveType = function(self, moveType) self.moveType = moveType end,
		SetGroundEntity = function() end, SetLocalVelocity = function() end, StopMoving = function() end,
		DropToFloor = function() end, Visible = function() return true end,
		IsMarkedForDeletion = function() return false end,
		SetPos = function(self, position)
			self.position = position
			self.positions[#self.positions + 1] = position
		end,
		MimicFindPerch = function()
			perches = perches + 1

			return Vector(perches * 300, 0, 200)
		end,
		MimicFindLanding = function() return Vector(250, 250, 0) end,
		STALKERNPCAbilityLaunchProjectile = function(self, class)
			self.shots[#self.shots + 1] = {class = class, from = self.position}
		end,
	})
	actor:STALKERNPCInitAbilities()
	actor.cotzNextFlight = 0
	actor.enemy = fixture.Target(Vector(400, 0, 0), {player = true})

	return actor
end

local function startAerial(actor)
	local aerial = actor.cotzAbilityByName.aerial
	check(actor:MimicCanFly(actor.enemy), "a perch with a clear view permits takeoff")

	return actor:STALKERNPCStartAbility(aerial, actor.enemy)
end

local actor = newMimic()
startAerial(actor)
advance(actor, 4)
check(not actor.cotzAbility and #actor.shots == 2, "one flight fires exactly two orbs")
check(actor.shots[1].class == "ent_mimic_ball", "the flight fires mimic orbs")
check(actor.shots[1].from.x ~= actor.shots[2].from.x, "the mimic moves between shots")
check(actor.position.x == 250 and actor.position.y == 250, "it lands near its enemy")
check(actor.moveType == MOVETYPE_STEP and actor.capabilities and not actor.cotzAirborne, "ground movement returns")
local waiting = actor.cotzNextFlight > fixture.now and not actor:MimicCanFly(actor.enemy)
check(waiting, "it fights on the ground before flying")

actor = newMimic()
startAerial(actor)
advance(actor, 0.6)
check(actor.cotzAirborne, "the mimic is airborne after vanishing")
actor.enemy = nil
advance(actor, 4)
check(not actor.cotzAirborne and actor.position.x == 0, "losing the target returns it to its takeoff point")

actor = newMimic()
startAerial(actor)
advance(actor, 0.6)
local teleports = #actor.positions
actor.IsAlive = false
actor:STALKERNPCAbandonAbility()
check(#actor.positions == teleports, "a mimic killed in the air is left to fall")

-- Shots lead a moving target so that projectile and target reach the aim point together.
local wall
util = util or {}
util.TraceLine = function(trace)
	if wall then return {Hit = true, HitPos = wall} end

	return {Hit = false, HitPos = trace.endpos}
end

local shooter = fixture.Actor(base)
local muzzle = Vector(0, 0, 36)
local function runner(velocity, grounded)
	return fixture.Target(Vector(600, 0, 0), {
		player = true, velocity = velocity,
		GetMoveType = function() return MOVETYPE_WALK end,
		IsOnGround = function() return grounded ~= false end,
	})
end

local function meets(aim, target, speed)
	local flight = aim:Distance(muzzle) / speed
	local arrival = target:WorldSpaceCenter() + target:GetVelocity() * flight

	return aim:Distance(arrival) < 0.01
end

local still = runner(Vector())
check(shooter:STALKERNPCPredictAim(still, muzzle, 420):Distance(still:WorldSpaceCenter()) == 0,
	"a standing target is aimed at directly")
for _, case in ipairs({
	{velocity = Vector(0, 250, 0), speed = 420},
	{velocity = Vector(200, 100, 0), speed = 1100},
	{velocity = Vector(-300, 0, 0), speed = 2000},
}) do
	local target = runner(case.velocity)
	check(meets(shooter:STALKERNPCPredictAim(target, muzzle, case.speed), target, case.speed),
		"the projectile and a moving target arrive together")
end
local jumper = runner(Vector(0, 200, 300), false)
check(shooter:STALKERNPCPredictAim(jumper, muzzle, 1100).z == jumper:WorldSpaceCenter().z,
	"a jump is not extrapolated upwards")
local sprinter = shooter:STALKERNPCPredictAim(runner(Vector(900, 0, 0)), muzzle, 420)
check(sprinter.x > 600 and sprinter.x <= 600 + 900 * 3, "an uncatchable target still gets a bounded lead")
wall = Vector(600, 90, 36)
check(shooter:STALKERNPCPredictAim(runner(Vector(0, 250, 0)), muzzle, 420) == wall, "walls stop the prediction")
wall = nil

-- Physics projectiles are capped by the engine, so their lead must use the capped speed.
local ledWith
local launcher = fixture.Actor(base, {
	STALKERNPCPredictAim = function(_, _, _, speed)
		ledWith = speed

		return Vector(100, 0, 0)
	end,
})
local pushed
local ballPhysics = {valid = true, SetVelocity = function(_, velocity) pushed = velocity end}
local function projectile(physicsObject)
	return {
		valid = true, SetPos = function() end, SetAngles = function() end, Spawn = function() end,
		SetOwner = function() end, GetPhysicsObject = function() return physicsObject end,
	}
end
fixture.maxVelocity = 2000
ents = {Create = function() return projectile(ballPhysics) end}
launcher:STALKERNPCAbilityLaunchProjectile("ent_fastcontroller_ball", still, 2500, Vector())
check(ledWith == 2000 and pushed:Length() > 0, "physics balls lead with the capped speed")
ents = {Create = function() return projectile({valid = false}) end}
launcher:STALKERNPCAbilityLaunchProjectile("ent_poltergeist_spark", still, 2500, Vector())
check(ledWith == 2500, "Lua orbs lead with their own speed")
fixture.maxVelocity = nil

-- Orbs apply impact and psy damage as separate events, since PsyHealth zeroes the sonic one.
AddCSLuaFile, include = function() end, function() end
local function loadEntity(path)
	ENT = {}
	dofile(path)

	return ENT
end

local orbBase = loadEntity("lua/entities/ent_cotz_orb/init.lua")
local ball = loadEntity("lua/entities/ent_mimic_ball/init.lua")
setmetatable(ball, {__index = orbBase})
local victim = fixture.Target(Vector(10, 0, 0), {player = true})
local owner = {valid = true, STALKERNPCCanAttackThis = function() return true end}
ball.GetOwner = function() return owner end
ball.cotzVelocity = Vector(1, 0, 0)
ball:Impact({Entity = victim, HitPos = Vector()})
check(#victim.damage == 2 and victim.damage[1] ~= victim.damage[2], "an orb deals two damage events")
check(victim.damage[1].DamageType == DMG_CLUB and victim.damage[2].DamageType == DMG_SONIC, "impact then psy")
check(victim.damage[2].Attacker == owner, "combat rules see the mimic as the attacker")
ball:Impact({Entity = {valid = false}, HitPos = Vector()})
check(#victim.damage == 2, "hitting the world damages nobody")

local flame = loadEntity("lua/entities/ent_poltergeist_flame/init.lua")
local inside = fixture.Target(Vector(40, 0, 0), {player = true})
local above = fixture.Target(Vector(0, 0, 200), {player = true})
local beside = fixture.Target(Vector(120, 0, 0), {player = true})
ents = {FindInSphere = function() return {inside, above, beside} end}
flame.GetPos = function() return Vector() end
flame.GetOwner = function() return owner end
flame:BurnPulse()
check(#inside.damage == 1 and inside.damage[1].DamageType == DMG_BURN, "flames burn players standing in them")
check(#above.damage == 0 and #beside.damage == 0, "flames spare other floors and players outside the ring")

-- A borrowed prop gets its physics and collision back when its poltergeist dies mid-lift.
VectorRand = function() return Vector(1, 0, 0) end
local grip = loadEntity("lua/entities/ent_poltergeist_grip/init.lua")
local physics = {
	valid = true, gravity = true,
	IsGravityEnabled = function(self) return self.gravity end,
	EnableGravity = function(self, enabled) self.gravity = enabled end,
	Wake = function() end, SetVelocity = function() end, AddAngleVelocity = function() end,
}
local overlapping = true
local prop = {
	valid = true, group = 0,
	GetPhysicsObject = function() return physics end,
	GetCollisionGroup = function(self) return self.group end,
	SetCollisionGroup = function(self, group) self.group = group end,
	GetPos = function() return Vector() end,
	WorldSpaceCenter = function() return Vector() end,
	WorldSpaceAABB = function() return Vector(), Vector(1, 1, 1) end,
}
ents.FindInBox = function()
	if not overlapping then return {} end

	return {{IsPlayer = function() return true end, Alive = function() return true end}}
end
local holder = {valid = true, IsAlive = true}
local removed = false
grip.GetOwner = function() return holder end
grip.NextThink = function() end
grip.Remove = function() removed = true end
check(grip:Grab(prop, false, 80), "the grip takes a physics prop")
check(not physics.gravity and prop.group == COLLISION_GROUP_WEAPON and grip:IsHolding(), "held props float")
holder.IsAlive = false
grip:Think()
check(physics.gravity and not grip:IsHolding(), "death drops the prop")
fixture.now = fixture.now + 1
grip:Think()
check(prop.group == COLLISION_GROUP_WEAPON and not removed, "collision waits while a player overlaps the prop")
overlapping = false
grip:Think()
check(prop.group == 0 and removed and not prop.cotzPoltergeistHeld, "the borrowed prop is fully restored")

print(string.format("PASS: %d elemental mutant checks", checks))
