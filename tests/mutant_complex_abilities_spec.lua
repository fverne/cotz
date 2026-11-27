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
