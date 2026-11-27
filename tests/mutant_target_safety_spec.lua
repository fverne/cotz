-- Run from the addon root: luatex --luaonly tests/mutant_target_safety_spec.lua
-- Grabs and the spider spit must survive targets that are NPCs, disappear or die mid-attack.
local fixture = dofile("tests/helpers/mutant_base.lua")
local base = fixture.LoadBase("sv_abilities")
local projectiles = 0
ents = {Create = function()
	projectiles = projectiles + 1

	return {
		valid = true,
		SetPos = function() end, SetAngles = function() end, Spawn = function() end, SetOwner = function() end,
		GetPhysicsObject = function() return {valid = true, SetVelocity = function() end} end,
	}
end}

local function makeTarget(isPlayer)
	local target = fixture.Target(Vector(60), {player = isPlayer})
	target.NearestPoint = function(self) return self.position end
	target.SetLocalVelocity = function(self) assert(self.valid, "removed targets cannot be thrown") end
	target.TakeDamageInfo = function(self)
		assert(self.valid, "removed targets cannot take damage")
		self.hits = (self.hits or 0) + 1
	end
	if isPlayer then
		target.Freeze = function(self, frozen)
			assert(self.valid, "removed players cannot be frozen or released")
			self.frozen = frozen
		end
	end

	return target
end

local function advance(actor, seconds)
	fixture.now = fixture.now + seconds
	if actor.cotzAbility then actor:STALKERNPCUpdateAbility() end
end

local GRABBERS = {
	skeleton = {
		methods = {"SkeletonSeize", "SkeletonHasVictim", "SkeletonDrain", "SkeletonFinishGrab",
			"SkeletonReleaseVictim"},
		hits = 2, steps = {1.2, 1.3},
	},
	izlom = {
		methods = {"IzlomSeize", "IzlomHasVictim", "IzlomThrow", "IzlomReleaseVictim"},
		steps = {0.1, 2},
	},
}
for name, expected in pairs(GRABBERS) do
	local class = fixture.LoadMutant(name, base, expected.methods)
	local function startGrab(target)
		fixture.now = 10
		local actor = fixture.Actor(class)
		actor.MeleeAttackSequence = {}
		actor:STALKERNPCInitAbilities()
		actor.enemy = target
		assert(actor:STALKERNPCStartAbility(actor.cotzAbilityByName.grab, target), name .. " starts a grab")

		return actor
	end

	for _, isPlayer in ipairs({false, true}) do
		local target = makeTarget(isPlayer)
		local actor = startGrab(target)
		assert(target.frozen == (isPlayer and true or nil), name .. " freezes only players")
		actor.enemy = nil
		actor:STALKERNPCCancelAbilityWindup()
		assert(actor.cotzAbility, name .. " keeps its grab when the enemy is lost")
		for _, step in ipairs(expected.steps) do advance(actor, step + 0.01) end
		actor.PlayingAnimation = false
		advance(actor, 0.1)
		assert(actor.cotzAbility == nil, name .. " completes the grab")
		assert((isPlayer and target.frozen == false or not isPlayer and target.frozen == nil),
			name .. " releases players")
		assert(target.hits == expected.hits, name .. " deals the same grab damage to NPCs and players")

		-- Death, removal and sleep all abandon the ability.
		target = makeTarget(isPlayer)
		actor = startGrab(target)
		actor:STALKERNPCAbandonAbility()
		assert((isPlayer and target.frozen == false or not isPlayer and target.frozen == nil),
			name .. " cleanup releases players only")
		actor = startGrab(target)
		target.valid = false
		actor:STALKERNPCAbandonAbility()
	end

	for stage = 1, #expected.steps do
		local target = makeTarget(true)
		local actor = startGrab(target)
		for step = 1, stage - 1 do advance(actor, expected.steps[step] + 0.01) end
		target.valid = false
		advance(actor, 0.01)
		assert(actor.cotzAbility == nil, name .. " recovers when a captured target disappears at any stage")
	end
end

do
	local class = fixture.LoadMutant("skeleton", base, GRABBERS.skeleton.methods)
	fixture.now = 10
	local actor, target = fixture.Actor(class), makeTarget(false)
	actor.MeleeAttackSequence = {}
	actor:STALKERNPCInitAbilities()
	target.TakeDamageInfo = function(self) self.valid = false end
	actor:STALKERNPCStartAbility(actor.cotzAbilityByName.grab, target)
	-- A late Think runs the first drain and the finishing drain in one update.
	advance(actor, 5)
end

local spider = fixture.LoadMutant("spider", base, {"SpiderSpitAim", "SpiderAimSpit", "SpiderSpit"})
local removed = makeTarget(false)
removed.valid = false
for _, enemy in ipairs({removed, false, makeTarget(false)}) do
	fixture.now = 10
	local actor = fixture.Actor(spider)
	actor.MeleeAttackSequence = {}
	actor:STALKERNPCInitAbilities()
	if enemy then enemy.Visible = function() return true end end
	actor.enemy = enemy or nil
	assert(actor:STALKERNPCStartAbility(actor.cotzAbilityByName.spit, IsValid(actor.enemy) and enemy or nil))
	local before = projectiles
	advance(actor, 0.81)
	assert(projectiles == before + (IsValid(actor.enemy) and 1 or 0), "spider spits only at valid targets")
	advance(actor, 0.5)
	assert(actor.cotzAbility == nil, "spider recovers after a missed spit")
end

-- Bloodsucker, controller and karlik specials are covered by tests/mutant_complex_abilities_spec.lua.
print("Mutant target safety regression checks passed")
