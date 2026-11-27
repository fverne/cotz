-- Run from the addon root: luatex --luaonly tests/mutant_complex_abilities_spec.lua
-- Exercises the real ability definitions and methods of the mutants migrated to the ability runner.
local fixture = dofile("tests/helpers/mutant_base.lua")
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local base = fixture.LoadBase("sv_abilities")
local effects, particles, projectiles = 0, 0, {}
EffectData = function() return setmetatable({}, {__index = function() return function() end end}) end
util = {Effect = function() effects = effects + 1 end}
ParticleEffect = function() particles = particles + 1 end
sound = {Add = function() end, Play = function() end}
local nearby = {}
ents = {
	FindInSphere = function() return nearby end,
	Create = function(class)
		local projectile = {valid = true, class = class}
		for _, method in ipairs({"SetPos", "SetAngles", "Spawn", "SetOwner"}) do
			projectile[method] = function(self, value) self[method] = value or true end
		end
		projectile.GetPhysicsObject = function(self)
			return {valid = true, SetVelocity = function(_, velocity) self.velocity = velocity end}
		end
		projectiles[#projectiles + 1] = projectile

		return projectile
	end,
}

-- Chance rolls pass; integer rolls take their lowest value.
local originalRandom = math.random
math.random = function(low) return low or 0 end

local function actorFor(class, melee, extra)
	local actor = fixture.Actor(class, extra)
	actor.MeleeAttackSequence = melee or {}
	actor:STALKERNPCInitAbilities()

	return actor
end

local function advance(actor, seconds)
	fixture.now = fixture.now + seconds
	actor:STALKERNPCUpdateAbility()
end

local function target(distance, extra)
	local entity = fixture.Target(Vector(distance), extra)
	entity.NearestPoint = function(self) return self.position end
	entity.Visible = function(self) return not self.hidden end
	entity.Alive = function(self) return self.health > 0 end
	entity.SetVelocity = function(self, velocity) self.pushed = velocity end
	entity.EmitSound = function(self, name) self.sound = name end

	return entity
end

local function startNamed(actor, name, enemy)
	actor.cotzAbility, actor.PlayingAnimation = nil, false
	check(actor:STALKERNPCStartAbility(actor.cotzAbilityByName[name], enemy), name .. " starts")
end

do
	local snork = fixture.LoadMutant("snork", base, {})
	fixture.now = 100
	local actor = actorFor(snork, {[4] = "attack_run_0", [5] = "stand_attack_3"})
	local enemy = target(500)
	actor.enemy = enemy
	check(actor:STALKERNPCTryAbilities(enemy, 0) and actor.cotzAbility.definition.name == "longJump",
		"snorks long-jump at range")
	check(actor.cotzAbilityReady.shortJump == 103, "a long jump delays the short jump")
	actor.grounded = false
	advance(actor, 0.02)
	check(actor.velocities[1].x == 2 and actor.Animation == "stand_attack_3" and actor.meleeAttacks[1] == 5
		and actor.sounds[1] == "Stalker.Snork.Die2", "the long jump leaps and swings")
	advance(actor, 3)
	check(actor.cotzAbility, "the long jump waits for landing")
	actor.grounded = true
	advance(actor, 0.1)
	check(actor.cotzAbility == nil and actor.NextAbilityTime == fixture.now + 1.5, "landing ends the long jump")

	fixture.now = 200
	enemy.position = Vector(100)
	actor.cotzNextAbilityCheck, actor.NextAbilityTime = 0, 0
	check(actor:STALKERNPCTryAbilities(enemy, 0) and actor.cotzAbility.definition.name == "shortJump",
		"snorks short-jump up close")
	advance(actor, 0.2)
	check(actor.velocities[2].x == 1 and actor.meleeAttacks[2] == 4, "the short jump leaps and swings")
	actor.PlayingAnimation = false
	advance(actor, 0.1)
	check(actor.cotzAbility == nil and actor.NextAbilityTime == fixture.now + 0.5,
		"the short jump ends with its swing instead of holding the snork for five seconds")

	fixture.now = 300
	startNamed(actor, "longJump", enemy)
	actor.enemy = nil
	actor:STALKERNPCCancelAbilityWindup()
	check(actor.cotzAbility == nil and #actor.velocities == 2, "losing the target cancels the long-jump windup")
end

for _, name in ipairs({"chimera", "chimera_electro", "chimera_fire"}) do
	local chimera = fixture.LoadMutant(name, base, {})
	fixture.now = 100
	local actor = actorFor(chimera, {[1] = "jump_attack_0"})
	local enemy = target(600)
	actor.enemy = enemy
	check(not actor:STALKERNPCTryAbilities(enemy, 0), name .. " waits a second after spawning")
	fixture.now = 101
	check(actor:STALKERNPCTryAbilities(enemy, 0) and actor.cotzAbilityReady.jump == 104,
		name .. " leaps at range with its three second cooldown")
	advance(actor, 0.1)
	check(#actor.velocities == 0, name .. " winds up before leaving the ground")
	actor.grounded = false
	advance(actor, 0.11)
	check(actor.velocities[1].x == 2 and actor.Animation == "jump_attack_0" and actor.meleeAttacks[1] == 1
		and actor.sounds[1] == "Stalker.Chimera.Hit4", name .. " leaps and swings")
	actor.PlayingAnimation = false
	advance(actor, 1)
	check(actor.cotzAbility, name .. " stays committed while airborne")
	actor.grounded = true
	advance(actor, 0.1)
	check(actor.cotzAbility == nil and actor.NextAbilityTime == fixture.now + 0.5, name .. " recovers on landing")

	startNamed(actor, "jump", enemy)
	actor.grounded = false
	advance(actor, 0.2)
	advance(actor, 4.7)
	check(actor.cotzAbility, name .. " may stay airborne for the original leap duration")
	advance(actor, 0.2)
	check(actor.cotzAbility == nil, name .. " gives up on a landing after five seconds in total")
end

do
	local dog = fixture.LoadMutant("dog", base, {})
	fixture.now = 100
	local actor = actorFor(dog, {[5] = "jump_ataka_01"})
	local enemy = target(150)
	actor.enemy = enemy
	check(actor:STALKERNPCTryAbilities(enemy, 0) and actor.cotzAbilityReady.jump == 103, "dogs pounce up close")
	actor.grounded = false
	advance(actor, 0.2)
	check(actor.velocities[1].x == 2 and actor.meleeAttacks[1] == 5 and actor.sounds[1] == "Stalker.Dog.Melee1",
		"the dog pounce leaps and bites")
	advance(actor, 2)
	check(actor.cotzAbility, "the dog pounce waits for landing")
	actor.grounded = true
	advance(actor, 0.1)
	check(actor.cotzAbility == nil and actor.NextAbilityTime == fixture.now + 0.5, "landing ends the dog pounce")
	startNamed(actor, "jump", enemy)
	advance(actor, 0.2)
	advance(actor, 0.7)
	check(actor.cotzAbility, "a grounded dog pounce still lasts a second in total")
	advance(actor, 0.2)
	check(actor.cotzAbility == nil, "the grounded dog pounce then ends")
end

do
	local pseudodog = fixture.LoadMutant("pseudodog", base, {})
	fixture.now = 100
	local actor = actorFor(pseudodog, {[3] = "jump_attack_all"})
	local enemy = target(350)
	actor.enemy = enemy
	check(actor:STALKERNPCTryAbilities(enemy, 0), "pseudodogs pounce")
	check(actor.Animation == "jump_attack_all" and actor.meleeAttacks[1] == 3 and #actor.velocities == 0,
		"the pseudodog swing starts before it leaves the ground")
	advance(actor, 0.4)
	check(actor.velocities[1].x == 2 and actor.sounds[1] == "Stalker.Pseudodog.Melee1" and #actor.animations == 1,
		"the pseudodog leaps without restarting its swing")
	actor.PlayingAnimation = false
	advance(actor, 0.1)
	check(actor.cotzAbility == nil and actor.NextAbilityTime == fixture.now + 0.5,
		"the pseudodog pounce ends once landed with its swing done")

	startNamed(actor, "jump", enemy)
	actor.enemy = nil
	actor:STALKERNPCCancelAbilityWindup()
	check(actor.cotzAbility == nil and #actor.velocities == 1 and not actor.PlayingAnimation,
		"losing the target cancels the pseudodog windup and its swing")
end

do
	local hellhound = fixture.LoadMutant("hellhound", base, {"HellhoundStartFlames", "HellhoundStopFlames"})
	fixture.now = 100
	local actor = actorFor(hellhound, {[5] = "stand_attack_0"})
	local enemy = target(150)
	actor.enemy = enemy
	actor.cotzUnreachableRecovery = {}
	check(actor:STALKERNPCTryAbilities(enemy, 0) and actor.cotzAbility.definition.name == "spew",
		"hellhounds spew even during unreachable-target recovery")
	check(not actor.networked.Burn and not actor.PlayingAnimation, "the spew has a windup")
	advance(actor, 0.2)
	check(actor.networked.Burn and actor.meleeAttacks[1] == 5 and actor.Animation == "stand_attack_0"
		and actor.sounds[1] == "Stalker.Dog.Melee1" and #actor.velocities == 0, "the spew burns without leaping")
	advance(actor, 1.2)
	check(actor.cotzAbility and actor.networked.Burn, "the flames last the original duration")
	advance(actor, 0.2)
	check(actor.cotzAbility == nil and actor.networked.Burn == false and actor.NextAbilityTime == fixture.now + 0.5,
		"the flames stop with the spew")
	startNamed(actor, "spew", enemy)
	advance(actor, 0.2)
	actor:STALKERNPCAbandonAbility()
	check(actor.networked.Burn == false, "death and sleep put the flames out")
end

local LEAPERS = {
	bear = {melee = 1, animation = "attack", sound = "Stalker.Bear.Melee2", range = 150},
	cat = {melee = 4, animation = "stand_attack_1", sound = "Stalker.Cat.Melee2", range = 150},
	rodent = {melee = 4, table = "attack2", animation = "attack3", sound = "Stalker.Rodent.Melee2", range = 150},
	tark = {melee = 4, animation = "jump_attack_1", sound = "Stalker.Tark.Melee1", range = 300, total = 1},
	sprig = {melee = 4, animation = "stand_attack_2", sound = "Stalker.Sprig.Melee2", range = 150, total = 3},
}
for name, expected in pairs(LEAPERS) do
	local class = fixture.LoadMutant(name, base, {})
	fixture.now = 100
	local actor = actorFor(class, {[expected.melee] = expected.table or expected.animation})
	local enemy = target(expected.range)
	actor.enemy = enemy
	check(actor:STALKERNPCTryAbilities(enemy, 0) and actor.cotzAbilityReady.jump == 103,
		name .. " leaps with its three second cooldown")
	actor.grounded = false
	advance(actor, 0.2)
	check(actor.velocities[1].x == 2 and actor.Animation == expected.animation
		and actor.meleeAttacks[1] == expected.melee and actor.AttackIndex == expected.melee
		and actor.sounds[1] == expected.sound, name .. " leaps and attacks")
	actor.PlayingAnimation = false
	advance(actor, 2)
	check(actor.cotzAbility, name .. " stays committed while airborne")
	actor.grounded = true
	advance(actor, 0.1)
	check(actor.cotzAbility == nil and actor.NextAbilityTime == fixture.now + 0.5, name .. " recovers on landing")

	-- A leap that never lands, or never finishes its swing, ends at the original total duration.
	local total = expected.total or 5
	startNamed(actor, "jump", enemy)
	actor.grounded = false
	advance(actor, 0.2)
	advance(actor, (name == "tark" and 5 or total - 0.2) - 0.1)
	check(actor.cotzAbility, name .. " holds the leap until its limit")
	advance(actor, 0.2)
	check(actor.cotzAbility == nil, name .. " gives up at its limit")
end

do
	local tark = fixture.LoadMutant("tark", base, {})
	fixture.now = 100
	local actor = actorFor(tark, {[4] = "jump_attack_1"})
	startNamed(actor, "jump", target(300))
	advance(actor, 0.2)
	advance(actor, 0.7)
	check(actor.cotzAbility, "a grounded tark leap lasts a second in total")
	advance(actor, 0.2)
	check(actor.cotzAbility == nil, "the grounded tark leap then ends")
end

do
	local vareshka = fixture.LoadMutant("vareshka", base, {"VareshkaLand"})
	fixture.now = 100
	local actor = actorFor(vareshka, {[3] = "attack_1"})
	local enemy = target(600)
	actor.enemy = enemy
	nearby = {actor, target(256), target(700)}
	startNamed(actor, "longJump", enemy)
	advance(actor, 0.5)
	check(actor.meleeAttacks[1] == 3 and actor.sounds[1] == "Stalker.Vareshka.Hit1", "vareshkas leap and swing")
	check(nearby[2].damage[1].Damage == 12.5 and #nearby[3].damage == 0 and effects > 0,
		"the landing shockwave falls off with distance")
	check(actor.cotzAbility == nil, "the landing ends the long jump")
	startNamed(actor, "shortJump", enemy)
	advance(actor, 0.2)
	check(actor.sounds[2] == "Stalker.Vareshka.Chase4", "the short jump keeps its own sound")
end

do
	local giant = fixture.LoadMutant("pseudogiant_fast", base, {"PseudogiantLand"})
	fixture.now = 100
	local actor = actorFor(giant, {[5] = "jump_attack_0", [6] = "stand_attack_run_0"})
	local enemy = target(600)
	actor.enemy = enemy
	nearby = {target(0)}
	check(actor:STALKERNPCTryAbilities(enemy, 0) and actor.cotzAbility.definition.name == "bigJump",
		"fast pseudogiants big-jump at range")
	check(actor.meleeAttacks[1] == 5 and actor.sounds[1] == "Stalker.Pseudogiant.Idle1" and #actor.velocities == 0,
		"the big jump crouches before leaving the ground")
	advance(actor, 0.3)
	check(actor.velocities[1].x == 2, "the big jump launches after its windup")
	advance(actor, 0.5)
	check(actor.cotzAbility == nil and nearby[1].damage[1].Damage == 60,
		"the big jump lands with a full-strength slam")
	enemy.position = Vector(100)
	startNamed(actor, "shortJump", enemy)
	advance(actor, 0.3)
	check(actor.velocities[2].x == 1 and actor.meleeAttacks[2] == 6, "the short jump leaps and kicks")
	advance(actor, 0.5)
	check(actor.cotzAbility == nil and actor.NextAbilityTime == fixture.now + 0.5, "the short jump ends on time")
end

do
	local giant = fixture.LoadMutant("pseudogiant_slow", base, {"PseudogiantSlam"})
	fixture.now = 100
	local actor = actorFor(giant, {[5] = "stand_kick_0"}, {
		LookupBone = function() return 1 end,
		GetBonePosition = function() return Vector(0, 0, 0) end,
	})
	local victim = target(256)
	nearby = {actor, victim}
	actor.enemy = victim
	check(actor:STALKERNPCTryAbilities(victim, 0), "slow pseudogiants slam nearby targets")
	advance(actor, 0.3)
	check(actor.meleeAttacks[1] == 5 and actor.sounds[1] == "Stalker.Pseudogiant.Idle1", "the slam kicks")
	advance(actor, 1.5)
	check(victim.damage[1].Damage == 175 and victim.pushed, "the slam damages and throws nearby targets")
end

do
	local bloodsucker = fixture.LoadMutant("bloodsucker", base, {
		"BloodsuckerSeize", "BloodsuckerHasVictim", "BloodsuckerFeed", "BloodsuckerFinishFeed",
		"BloodsuckerReleaseVictim",
	})
	for _, isPlayer in ipairs({true, false}) do
		fixture.now = 100
		local actor = actorFor(bloodsucker, {[4] = "stand_attack_run_0", [6] = "vampire"})
		local victim = target(60, {player = isPlayer})
		victim.Freeze = function(self, frozen) self.frozen = frozen end
		actor.enemy = victim
		startNamed(actor, "feed", victim)
		check(victim.frozen == (isPlayer or nil) and actor.Animation == "vampire", "feeding freezes only players")
		actor.enemy = nil
		for _ = 1, 4 do advance(actor, 1) end
		check(actor.health == 600, "feeding heals four times, even after the enemy is lost")
		local released = isPlayer and victim.frozen == false or not isPlayer and victim.frozen == nil
		check(released and actor.PostSuccRunFinish == fixture.now + 10,
			"the feed releases players and makes the bloodsucker flee")
		check(actor.cotzAbility, "the bite animation may finish after the release")
		actor.PlayingAnimation = false
		advance(actor, 0.1)
		check(actor.cotzAbility == nil and actor.NextAbilityTime == fixture.now + 1, "the feed ends with recovery")
	end

	for stage = 1, 4 do
		fixture.now = 100
		local actor = actorFor(bloodsucker, {[6] = "vampire"})
		local victim = target(60, {player = true})
		victim.Freeze = function(self, frozen) self.frozen = frozen end
		actor.enemy = victim
		startNamed(actor, "feed", victim)
		for _ = 2, stage do advance(actor, 1) end
		victim.valid = false
		advance(actor, 0.01)
		check(actor.cotzAbility == nil and actor.cleared and actor.NextAbilityTime == fixture.now + 1,
			"the feed recovers when its victim disappears at stage " .. stage)
	end

	local actor = actorFor(bloodsucker, {[6] = "vampire"})
	local victim = target(60, {player = true})
	victim.Freeze = function(self, frozen) self.frozen = frozen end
	actor.enemy = victim
	startNamed(actor, "feed", victim)
	actor.IsAlive = false
	actor:STALKERNPCAbandonAbility()
	check(victim.frozen == false, "death and removal release a frozen player")

	fixture.now = 100
	actor = actorFor(bloodsucker, {[4] = "stand_attack_run_0"})
	victim = target(60)
	actor.enemy = victim
	check(actor:STALKERNPCTryAbilities(victim, 0) and actor.cotzAbility.definition.name == "jump",
		"bloodsuckers lunge before feeding")
	advance(actor, 0.2)
	check(actor.velocities[1].x == 2 and actor.meleeAttacks[1] == 4, "the lunge leaps and swings")
end

do
	local karlik = fixture.LoadMutant("karlik", base, {
		"STALKERNPCThink", "KarlikWarp", "KarlikKnock", "KarlikThrow", "STALKERNPCDamageTake",
	})
	local function makeKarlik()
		local actor = actorFor(karlik, nil, {
			MinRangeDist = 800,
			GetTeleportLocation = function() return Vector(5000) end,
		})
		actor.NextAbilityTime = 0

		return actor
	end

	fixture.now = 100
	local actor = makeKarlik()
	local before = #projectiles
	startNamed(actor, "throw", nil)
	advance(actor, 1.1)
	check(#projectiles == before + 1 and actor.cotzAbility == nil, "a throw fires once without a target")
	check(actor.cotzAbilityReady.volley == 104, "a throw delays the volley")
	startNamed(actor, "volley", nil)
	advance(actor, 0.7)
	advance(actor, 0.7)
	check(#projectiles == before + 3 and actor.cotzAbility == nil, "a volley fires twice without a target")
	check(TEMP_ShootPoint == nil, "karliks cannot share a stale global aim point")
	local enemy = target(1000)
	actor.cotzAbilityReady.throw = 0
	startNamed(actor, "throw", enemy)
	advance(actor, 1.1)
	check(projectiles[#projectiles].velocity.x > 0, "aimed throws fly towards the target")

	fixture.now = 200
	actor = makeKarlik()
	local close = target(300, {player = true})
	local prop = target(500, {GetPhysicsObject = function(self)
		return {valid = true, SetVelocity = function(_, velocity) self.thrown = velocity end}
	end})
	close.GetPhysicsObject = function() return nil end
	nearby = {actor, close, prop}
	actor.enemy = close
	actor:STALKERNPCThink()
	check(actor.cotzAbility == nil and actor.WantToKnock, "the knockback waits out its spawn cooldown")
	fixture.now = 201
	actor:STALKERNPCThink()
	check(actor.cotzAbility.definition.name == "knock" and not actor.WantToKnock, "close enemies trigger a knockback")
	advance(actor, 1.6)
	check(close.pushed and prop.thrown and actor.networked.Knocking, "the knockback throws players and props")
	actor.enemy = close
	actor:STALKERNPCThink()
	check(actor.WantToKnock and actor.cotzAbility == nil, "a knockback on cooldown stays queued")
	actor.enemy = nil
	fixture.now = 212
	actor:STALKERNPCThink()
	check(actor.cotzAbility and actor.cotzAbility.definition.name == "knock",
		"the queued knockback fires once its cooldown ends")

	fixture.now = 300
	actor = makeKarlik()
	fixture.now = 301
	startNamed(actor, "throw", enemy)
	actor:STALKERNPCDamageTake({}, 1)
	check(actor.cotzAbility.definition.name == "warp", "damage starts a warp that interrupts other attacks")
	actor.enemy = close
	actor:STALKERNPCThink()
	check(actor.cotzAbility.definition.name == "warp" and actor.WantToKnock, "a knockback cannot interrupt the warp")
	advance(actor, 1.2)
	check(actor.position.x == 5000 and actor.networked.Teleport and actor.networked.OldPos,
		"the warp teleports and marks the client effect")
end

COLLISION_GROUP_DEBRIS = 1
for _, name in ipairs({"classiczombie", "classiczombie_babka", "classiczombie_radio", "classiczombie_volatile"}) do
	local zombie = fixture.LoadMutant(name, base, {
		"STALKERNPCThink", "ZombieFakeDeathSequence", "ZombieCollapse", "ZombieLieStill", "ZombieStandUp",
		"ZombieEndFakeDeath", "STALKERNPCDamageTake",
	})
	local function makeZombie()
		return actorFor(zombie, nil, {
			CanFakeDeath = true, farttimer = math.huge, collisionGroup = 9,
			LookupSequence = function() return 1, 2.1 end,
			GetCollisionGroup = function(self) return self.collisionGroup end,
			SetCollisionGroup = function(self, group) self.collisionGroup = group end,
			GetHitBoxBone = function(_, hitbox) return hitbox end,
			GetBonePosition = function(_, bone) return Vector(0, 0, bone * 10) end,
		})
	end
	local function lethalHit()
		return {
			damage = 90, GetDamage = function(self) return self.damage end,
			SetDamage = function(self, damage) self.damage = damage end,
			GetDamagePosition = function() return Vector() end,
		}
	end

	fixture.now = 100
	local actor = makeZombie()
	local hit = lethalHit()
	actor:STALKERNPCDamageTake(hit, 1)
	check(hit.damage == 0 and actor.health == actor.maxHealth and not actor.CanFakeDeath,
		name .. " survives one lethal hit")
	actor.PlayingAnimation = true
	actor:STALKERNPCThink()
	check(actor.cotzAbility == nil and actor.FakeDeathPending, name .. " finishes its attack before collapsing")
	actor.PlayingAnimation = false
	actor:STALKERNPCThink()
	check(actor.cotzAbility and not actor.FakeDeathPending and actor.AttackIndex == 0,
		name .. " starts its queued fake death")
	advance(actor, 0)
	local set = "fake_death_" .. actor.FakeDeathAnimSet
	check(actor.Animation == set .. "_0" and actor.collisionGroup == COLLISION_GROUP_DEBRIS
		and actor.ShouldEmitSound == false and #actor.sounds == 1, name .. " collapses silently out of the way")
	actor:STALKERNPCCancelAbilityWindup()
	advance(actor, 2)
	check(actor.Animation == set .. "_1", name .. " lies still without a target")
	advance(actor, 12.9)
	check(actor.Animation == set .. "_1" and #actor.animations == 2,
		name .. " stays down until fifteen seconds after the hit")
	advance(actor, 0.2)
	check(actor.Animation == set .. "_2" and actor.collisionGroup == COLLISION_GROUP_DEBRIS, name .. " stands up")
	advance(actor, 2)
	check(actor.cotzAbility == nil and actor.collisionGroup == 9 and actor.ShouldEmitSound == true
		and actor.cleared == 1, name .. " is solid again once standing")

	actor = makeZombie()
	actor:STALKERNPCDamageTake(lethalHit(), 1)
	actor:STALKERNPCThink()
	actor:STALKERNPCAbandonAbility()
	check(actor.collisionGroup == 9 and actor.ShouldEmitSound == true,
		name .. " restores itself when sleep or death abandon the fake death")
end

do
	local skeleton = fixture.LoadMutant("skeleton", base, {
		"STALKERNPCThink", "SkeletonFakeDeathSequence", "SkeletonCollapse", "SkeletonLieStill",
		"SkeletonStandUp", "SkeletonEndFakeDeath", "SkeletonSeize", "SkeletonHasVictim", "SkeletonDrain",
		"SkeletonFinishGrab", "SkeletonReleaseVictim", "STALKERNPCDamageTake",
	})
	local function makeSkeleton()
		return actorFor(skeleton, {[6] = "stand_attack_sasi"}, {
			CanFakeDeath = true, collisionGroup = 9,
			LookupSequence = function() return 1, 2.1 end,
			GetCollisionGroup = function(self) return self.collisionGroup end,
			SetCollisionGroup = function(self, group) self.collisionGroup = group end,
		})
	end

	fixture.now = 100
	local actor = makeSkeleton()
	local victim = target(60, {player = true})
	victim.Freeze = function(self, frozen) self.frozen = frozen end
	actor.enemy = victim
	check(actor:STALKERNPCTryAbilities(victim, 0) and actor.cotzAbility.definition.name == "grab",
		"skeletons grab nearby targets")
	check(victim.frozen == true and actor.position.x == 25 and actor.meleeAttacks[1] == 6
		and actor.Animation == "stand_attack_sasi" and actor.cotzAbilityReady.grab == 115,
		"the grab lunges, freezes and swings")
	advance(actor, 1.2)
	check(#victim.damage == 1 and victim.damage[1].Damage == 7 and victim.damage[1].DamageType == DMG_SONIC,
		"the grab drains after 1.2 seconds")
	advance(actor, 1.3)
	check(#victim.damage == 2 and victim.frozen == false and actor.cotzAbility,
		"the grab drains again and releases after 2.5 seconds")
	actor.PlayingAnimation = false
	advance(actor, 0.1)
	check(actor.cotzAbility == nil and actor.NextAbilityTime == fixture.now + 10, "the grab ends with recovery")

	fixture.now = 200
	actor = makeSkeleton()
	local hit = {
		damage = 90, GetDamage = function(self) return self.damage end,
		SetDamage = function(self, damage) self.damage = damage end,
	}
	actor:STALKERNPCDamageTake(hit, 1)
	actor:STALKERNPCThink()
	advance(actor, 0)
	local set = "fake_death_" .. actor.FakeDeathAnimSet
	check(hit.damage == 0 and actor.Animation == set .. "_0" and actor.collisionGroup == COLLISION_GROUP_DEBRIS
		and #actor.sounds == 0, "skeletons collapse without a death cry")
	advance(actor, 2)
	check(actor.Animation == set .. "_1", "skeletons lie still")
	advance(actor, 13.1)
	check(actor.Animation == set .. "_2", "skeletons stand fifteen seconds after the hit")
	advance(actor, 2)
	check(actor.cotzAbility == nil and actor.collisionGroup == 9, "standing skeletons are solid again")
end

do
	local izlom = fixture.LoadMutant("izlom", base, {
		"IzlomPull", "IzlomSeize", "IzlomHasVictim", "IzlomThrow", "IzlomReleaseVictim",
	})
	fixture.now = 100
	local actor = actorFor(izlom, {[3] = "stand_run_attack_0", [4] = "stand_attack_1"})
	local enemy = target(400, {player = true})
	enemy.ConsumeStamina = function(self, amount) self.stamina = amount end
	actor.enemy = enemy
	check(actor:STALKERNPCTryAbilities(enemy, 0) and actor.cotzAbility.definition.name == "pull",
		"izloms pull distant targets")
	check(not enemy.pushed and actor.cotzAbilityReady.pull == 107, "the pull has a windup and cooldown")
	advance(actor, 0.2)
	check(enemy.pushed.x < 0 and enemy.pushed.z > 0 and enemy.stamina == 35 and actor.meleeAttacks[1] == 3
		and actor.sounds[1] == "Stalker.Izlom.Melee1", "the pull drags the target in, drains stamina and swings")
	advance(actor, 0.7)
	check(actor.cotzAbility == nil and actor.NextAbilityTime == fixture.now + 0.5, "the pull ends on time")

	fixture.now = 200
	local victim = target(100, {player = true})
	victim.Freeze = function(self, frozen) self.frozen = frozen end
	victim.SetLocalVelocity = function(self, velocity) self.thrown = velocity end
	actor.enemy, actor.cotzNextAbilityCheck, actor.NextAbilityTime = victim, 0, 0
	check(actor:STALKERNPCTryAbilities(victim, 0) and actor.cotzAbility.definition.name == "grab",
		"izloms grab nearby targets")
	check(victim.frozen == true and not actor.PlayingAnimation and actor.cotzAbilityReady.grab == 215,
		"the grab freezes before its swing")
	advance(actor, 0.1)
	check(actor.Animation == "stand_attack_1" and actor.meleeAttacks[2] == 4
		and actor.sounds[2] == "Stalker.Izlom.Chase10", "the grab swings after 0.1 seconds")
	advance(actor, 1.9)
	check(victim.frozen == true and not victim.thrown, "the grab holds for two seconds")
	advance(actor, 0.11)
	check(victim.frozen == false and victim.thrown.x == 120 and victim.thrown.z == 600
		and actor.cotzAbility == nil and actor.cleared == 2, "the grab throws and releases the victim")
end

do
	local spider = fixture.LoadMutant("spider", base, {
		"STALKERNPCThink", "SpiderCanLeap", "SpiderCanSpit", "SpiderSpitAim", "SpiderAimSpit", "SpiderSpit",
		"SpiderBurrow", "SpiderEmerge", "SpiderEndBurrow", "STALKERNPCDamageTake",
	})
	local function makeSpider(health)
		local actor = actorFor(spider, {[4] = "attack_2"}, {
			collisionGroup = 9,
			LookupSequence = function(_, sequence) return 1, sequence == "desummoned" and 1.2 or 2 end,
			GetCollisionGroup = function(self) return self.collisionGroup end,
			SetCollisionGroup = function(self, group) self.collisionGroup = group end,
			DoTeleport = function(self) self.position = Vector(5000) end,
		})
		actor.health = health

		return actor
	end

	fixture.now = 100
	local actor = makeSpider(1000)
	local enemy = target(600)
	actor.enemy = enemy
	check(actor:STALKERNPCTryAbilities(enemy, 0) and actor.cotzAbility.definition.name == "jump",
		"healthy spiders leap")
	advance(actor, 0.2)
	check(actor.velocities[1].x == 2 and actor.meleeAttacks[1] == 4, "the spider leap attacks")

	fixture.now = 200
	actor = makeSpider(500)
	actor.enemy = enemy
	actor.cotzUnreachableRecovery = {}
	check(not actor:STALKERNPCTryAbilities(enemy, 0), "wounded spiders do not spit during unreachable recovery")
	actor.cotzUnreachableRecovery, actor.cotzNextAbilityCheck = nil, 0
	check(actor:STALKERNPCTryAbilities(enemy, 0) and actor.cotzAbility.definition.name == "spit",
		"wounded spiders spit instead of leaping")
	check(actor.Animation == "attack_web" and actor.AttackIndex == 0 and actor.angles.y == 0
		and actor.cotzAbilityReady.spit == 204, "the spit faces its target and has a cooldown")
	local before = #projectiles
	advance(actor, 0.8)
	check(#projectiles == before + 1 and projectiles[#projectiles].class == "ent_spider_ball"
		and projectiles[#projectiles].velocity.x > 0, "the spit fires an arcing web")
	advance(actor, 0.5)
	check(actor.cotzAbility == nil, "the spit ends after 1.3 seconds")

	fixture.now = 300
	actor = makeSpider(1000)
	fixture.now = 301
	local passingRoll = math.random
	math.random = function() return 70 end
	actor:STALKERNPCDamageTake({}, 1)
	math.random = passingRoll
	check(not actor.TeleportPending, "most damage does not queue a teleport")
	actor:STALKERNPCDamageTake({}, 1)
	check(actor.TeleportPending and actor.CanTeleportTimer == 316, "lucky damage queues a teleport")
	actor.PlayingAnimation = true
	actor:STALKERNPCThink()
	check(actor.cotzAbility == nil, "the teleport waits for the current attack")
	actor.PlayingAnimation = false
	actor:STALKERNPCThink()
	check(actor.cotzAbility.definition.name == "teleport" and actor.Animation == "desummoned"
		and actor.collisionGroup == COLLISION_GROUP_DEBRIS and actor.sounds[1] == "Stalker.Spider.Spider",
		"the spider burrows")
	advance(actor, 1.9)
	check(actor.position.x == 0, "the burrow holds for its sequence plus 0.8 seconds")
	advance(actor, 0.11)
	check(actor.position.x == 5000 and actor.Animation == "summoned" and actor.collisionGroup == 9
		and actor.sounds[2] == "Stalker.Spider.Burrow", "the spider surfaces elsewhere")
	advance(actor, 2)
	check(actor.cotzAbility == nil, "the teleport ends with the surfacing sequence")
	actor.cotzAbilityReady.teleport = 0
	actor.TeleportPending = true
	actor:STALKERNPCThink()
	actor:STALKERNPCAbandonAbility()
	check(actor.collisionGroup == 9 and actor.ShouldEmitSound == true, "an abandoned burrow restores the spider")
end

local CONTROLLERS = {
	controller = {strike = 3, finish = 3.5},
	controller_electro = {strike = 2.7, finish = 3.5, face = true},
	controller_fast = {strike = 2.7, finish = 3.5, face = true, projectile = "ent_fastcontroller_ball"},
	controller_swamp = {strike = 2, finish = 2.1, face = true, projectile = "ent_swampcontroller_ball"},
}
for name, expected in pairs(CONTROLLERS) do
	local class = fixture.LoadMutant(name, base, {"ControllerPsyWindup", "ControllerPsyStrike"})
	for _, enemy in ipairs({false, target(800, {valid = false}), target(800, {hidden = true})}) do
		fixture.now = 100
		local actor = actorFor(class, nil, {ControllerPlaySoundToPlayer = function() end})
		local before = #projectiles
		startNamed(actor, "psyAttack", enemy or nil)
		actor.enemy = enemy or nil
		check(actor.AttackIndex == 0 and actor.Animation == "psy_attack_0", name .. " winds up without turning")
		advance(actor, expected.strike)
		check(actor.cotzAbility and actor.cotzAbility.phase == 2 and #projectiles == before,
			name .. " strikes nothing without a visible target")
		advance(actor, expected.finish - expected.strike)
		check(actor.cotzAbility == nil and actor.cleared, name .. " finishes recovery without a target")
	end

	fixture.now = 100
	local actor = actorFor(class, nil, {ControllerPlaySoundToPlayer = function() end})
	local victim = target(800, {player = true, ViewPunch = function(self) self.punched = true end})
	actor.enemy = victim
	check(actor:STALKERNPCTryAbilities(victim, 0) and actor.cotzAbilityReady.psyAttack > fixture.now,
		name .. " starts its psy attack out of melee reach")
	if expected.face then check(actor.angles and actor.angles.y == 0, name .. " faces its target") end
	local before = #projectiles
	advance(actor, expected.strike)
	if expected.projectile then
		check(#projectiles == before + 1 and projectiles[#projectiles].class == expected.projectile,
			name .. " fires its projectile")
	else
		check(victim.damage[1] ~= nil, name .. " damages a visible target")
	end
end

do
	local psydog = fixture.LoadMutant("psydog", base, {"STALKERNPCThink", "PsydogMissingClone", "PsydogSummon"})
	local summoned = 0
	fixture.now = 100
	local actor = actorFor(psydog, {[3] = "jump_attack_all"}, {
		STALKERNPCSpawnSummon = function()
			summoned = summoned + 1
			return {valid = true}
		end,
	})
	actor:STALKERNPCThink()
	check(actor.cotzAbility.definition.name == "summon" and actor.AttackIndex == 0,
		"psydogs summon whenever a phantom slot is empty, even without a target")
	advance(actor, 3)
	check(summoned == 4 and actor.cotzAbility == nil, "the summon fills every phantom slot")
	actor:STALKERNPCThink()
	check(actor.cotzAbility == nil, "full phantom slots start nothing")
	actor.Clone2.valid = false
	actor:STALKERNPCThink()
	check(actor.cotzAbility == nil, "the summon cooldown limits replacements")
	fixture.now = 111
	actor.PlayingAnimation = true
	actor:STALKERNPCThink()
	check(actor.cotzAbility == nil and actor.cotzAbilityReady.summon < fixture.now,
		"a busy psydog defers the summon without spending its cooldown")
	actor.PlayingAnimation = false
	actor:STALKERNPCThink()
	advance(actor, 3)
	check(summoned == 5, "only the missing phantom is replaced")

	local enemy = target(150)
	actor.enemy = enemy
	actor.cotzNextAbilityCheck = 0
	check(actor:STALKERNPCTryAbilities(enemy, 0) and actor.cotzAbility.definition.name == "jump",
		"psydogs pounce up close")
	advance(actor, 0.2)
	check(actor.velocities[1].x == 2 and actor.meleeAttacks[1] == 3, "the pounce leaps and bites")
end

do
	local phantom = fixture.LoadMutant("psydog_phantom", base, {})
	fixture.now = 100
	local actor = actorFor(phantom, {[3] = "jump_attack_all"})
	local enemy = target(150)
	actor.enemy = enemy
	check(actor:STALKERNPCTryAbilities(enemy, 0) and actor.cotzAbility.definition.name == "jump",
		"phantoms pounce like their summoner")
end

math.random = originalRandom
print("complex mutant ability checks passed: " .. checks)
