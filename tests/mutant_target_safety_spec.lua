-- Run from the addon root: luatex --luaonly tests/mutant_target_safety_spec.lua
local function readSource(name)
	local file = assert(io.open("lua/entities/npc_mutant_" .. name .. "/init.lua"))
	local source = file:read("*a")
	file:close()

	return source
end

local function compile(source)
	source = source:gsub("!=", "~="):gsub("&&", " and "):gsub("||", " or "):gsub("!", "not ")
	source = source:gsub("//([^\n]*)", "--%1")
	ENT = {}
	assert(load(source))()

	return ENT
end

local function loadMethod(name, method)
	local source = readSource(name)
	local start = assert(source:find("function ENT:" .. method .. "(", 1, true))
	local finish = source:find("\nfunction ENT:", start + 1, true)

	return compile(source:sub(start, finish and finish - 1 or #source))[method]
end

local now = 10
function CurTime() return now end
function IsValid(entity) return entity ~= nil and entity.valid == true end
local vectorMeta = {}
vectorMeta.__index = vectorMeta
function Vector(x, y, z) return setmetatable({x = x, y = y, z = z}, vectorMeta) end
function vectorMeta.__add(a, b) return Vector(a.x + b.x, a.y + b.y, a.z + b.z) end
function vectorMeta.__sub(a, b) return Vector(a.x - b.x, a.y - b.y, a.z - b.z) end
function vectorMeta.__mul(a, b) return Vector(a.x * b, a.y * b, a.z * b) end
function vectorMeta:Distance(other) return math.abs(self.x - other.x) end
function vectorMeta:GetNormalized() return self end
function vectorMeta:Angle() return self end
local damageMeta = {}
for _, method in ipairs({"SetDamage", "SetAttacker", "SetInflictor", "SetDamageType", "SetDamagePosition"}) do
	damageMeta[method] = function() end
end
function DamageInfo() return damageMeta end
math.Clamp = function(value, low, high) return math.max(low, math.min(value, high)) end

local function makeActor()
	return {
		valid = true,
		GetPos = function() return Vector(0, 0, 0) end,
		GetForward = function() return Vector(1, 0, 0) end,
		OBBCenter = function() return Vector(0, 0, 0) end,
		GetEnemy = function(self) return self.enemy end,
		Health = function(self) return self.health or 100 end,
		GetMaxHealth = function() return 1000 end,
		SetHealth = function(self, health) self.health = health end,
		SetPos = function() end,
		SetMovementActivity = function() end,
		EmitSound = function() end,
		STALKERNPCPlayAnimation = function(self) self.PlayingAnimation = true end,
		STALKERNPCMakeMeleeAttack = function() end,
		STALKERNPCStopAllTimers = function(self) self.stopped = true end,
		STALKERNPCClearAnimation = function(self) self.PlayingAnimation = false end,
		STALKERNPCPlaySoundRandom = function() end,
		ControllerPlaySoundToPlayer = function() end,
	}
end

local function makeTarget(isPlayer)
	local target = makeActor()
	target.IsPlayer = function() return isPlayer end
	target.NearestPoint = target.GetPos
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

local originalRandom = math.random
math.random = function() return 1 end
-- Bloodsucker feeding moved to the ability runner; tests/mutant_complex_abilities_spec.lua covers it.
for _, name in ipairs({"skeleton"}) do
	local think = loadMethod(name, "STALKERNPCThink")
	local attack = loadMethod(name, "STALKERNPCDistanceForMeleeTooBig")
	local victimField = "GrabTarget"
	local stateField = "IsGrabbing"
	local function makeGrabber()
		local actor = makeActor()
		actor.navigationLeapRange = 100
		actor.NextAbilityTime, actor.CanJump, actor.CanGrab = 0, 100, 0
		actor.PlayingAnimation, actor.FakeDeath = false, 0
		actor.jumping1, actor.jumping2, actor.IsJumping = 0, 0, 0
		actor.grabbing1, actor.grabbing2 = 0, 0
		actor[stateField] = 0

		return actor
	end
	for _, isPlayer in ipairs({false, true}) do
		now = 10
		local actor, target = makeGrabber(), makeTarget(isPlayer)
		actor.enemy = target
		attack(actor)
		assert(actor[victimField] == target and actor[stateField] == 1, name .. " starts grabs on both types")
		assert(target.frozen == (isPlayer and true or nil), name .. " freezes only players")
		actor.enemy = nil
		now = 20
		think(actor)
		assert(actor[stateField] == 0 and actor[victimField] == nil, name .. " completes the grab")
		assert((isPlayer and target.frozen == false or not isPlayer and target.frozen == nil), name .. " releases players")
		assert(target.hits == 2, "NPC and player grab damage stays intact")
		for _, method in ipairs({"STALKERNPCOnKilled", "STALKERNPCRemove"}) do
			actor[victimField] = target
			target.frozen = isPlayer and true or nil
			loadMethod(name, method)(actor)
			local released = isPlayer and target.frozen == false or not isPlayer and target.frozen == nil
			assert(released, name .. " cleanup releases players only")
			target.valid = false
			loadMethod(name, method)(actor)
			target.valid = true
		end
	end
	for _, stage in ipairs({1, 2}) do
		local actor = makeGrabber()
		actor[stateField], actor[victimField] = stage, {valid = false}
		think(actor)
		assert(actor[stateField] == 0 and actor[victimField] == nil and actor.stopped,
			name .. " recovers when a captured target disappears at any stage")
	end
	local actor, target = makeGrabber(), makeTarget(false)
	actor.IsGrabbing, actor.GrabTarget = 1, target
	target.TakeDamageInfo = function(self) self.valid = false end
	think(actor)
	assert(actor.IsGrabbing == 0, "a first hit that removes the target cannot break the second hit")
end
math.random = originalRandom

local projectiles = 0
ents = {Create = function()
	projectiles = projectiles + 1
	return {
		SetPos = function() end, SetAngles = function() end, Spawn = function() end, SetOwner = function() end,
		GetPhysicsObject = function() return {SetVelocity = function() end} end,
	}
end}
local spiderThink = loadMethod("spider", "STALKERNPCThink")
for _, enemy in ipairs({{valid = false}, false, makeTarget(false)}) do
	local actor = makeActor()
	actor.enemy = enemy or nil
	if enemy then enemy.Visible = function() return true end end
	actor.isAttacking, actor.jumping1, actor.jumping2 = 0, 0, 0
	actor.IsTeleporting, actor.IsSpitting, actor.spitting = 0, 1, 0
	local before = projectiles
	spiderThink(actor)
	assert(projectiles == before + (IsValid(actor.enemy) and 1 or 0), "spider spits only at valid targets")
	now = now + 1
	spiderThink(actor)
	assert(actor.IsSpitting == 0, "spider recovers after a missed spit")
end

-- Controller and karlik specials are covered by tests/mutant_complex_abilities_spec.lua.
print("Mutant target safety regression checks passed")
