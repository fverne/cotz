-- Run from the addon root: luatex --luaonly tests/mutant_summoning_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local vectorMeta = {}
Vector = function(x, y, z) return setmetatable({x = x, y = y, z = z}, vectorMeta) end
vectorMeta.__add = function(a, b) return Vector(a.x + b.x, a.y + b.y, a.z + b.z) end
vectorMeta.__mul = function(a, b) return Vector(a.x * b, a.y * b, a.z * b) end
local now = 100
CurTime = function() return now end
IsValid = function(entity) return type(entity) == "table" and entity.valid == true end
DamageInfo = function()
	return setmetatable({}, {__index = function() return function() end end})
end
ENT = {}
dofile("lua/entities/stalker_ai/sv_summoning.lua")
local base = ENT
local function read(path)
	local input = assert(io.open(path))
	local source = input:read("*a")
	input:close()

	return source
end
local function loadNPC(name, offsets, cleanup)
	local source = read("lua/entities/npc_mutant_" .. name .. "/init.lua")
	local definitions = assert(source:match("(local " .. offsets .. " = %b{})"))
	local radius = assert(source:match("ENT.summonSpawnRadius = (%d+)"))
	local start = assert(source:find("function ENT:STALKERNPCThink()", 1, true))
	local finish = assert(source:find("\nfunction ENT:", start + 1, true))
	local cleanupStart = assert(source:find("function ENT:" .. cleanup .. "()", 1, true))
	local cleanupFinish = source:find("\nfunction ENT:", cleanupStart + 1, true)
	local methods = source:sub(start, finish - 1) .. "\n" .. source:sub(cleanupStart, cleanupFinish and cleanupFinish - 1)
	methods = methods:gsub("!=", "~="):gsub("&&", " and "):gsub("||", " or "):gsub("!", "not ")
	methods = methods:gsub("//([^\n]*)", "--%1")
	ENT = setmetatable({summonSpawnRadius = tonumber(radius)}, {__index = base})
	assert(load(definitions .. "\n" .. methods))()

	return ENT
end
local psydog = loadNPC("psydog", "CLONE_OFFSETS", "STALKERNPCOnDeath")
local controller = loadNPC("controller", "ZOMBIE_OFFSETS", "STALKERNPCRemove")
local created, placements, registered = {}, 0, 0
local capacity, safePosition, creationFails, reject = true, true, false, false
local populationLimit
ix = {eventController = {
	GetSpawnLocation = function(_, origin, radius, owner)
		placements = placements + 1
		check(origin == owner:GetPos() and radius == 256, "summons search near their owner within their configured radius")
		if safePosition then return Vector(placements * 100, 0, 2) end
	end,
	CanSpawnMutant = function(_, _, includeQueued)
		check(includeQueued, "summons respect existing queued population reservations")

		return capacity and (not populationLimit or registered < populationLimit)
	end,
	RegisterMutant = function(_, entity, enforceLimit, pack)
		check(enforceLimit and entity.spawned and entity.cotzCombatPack == pack,
			"spawned summons register immediately with their inherited pack and hard-cap enforcement")
		registered = registered + 1
		entity.cotzPopulationRejected = reject
	end,
}}
ents = {Create = function(class)
	if creationFails then return end
	local entity = {
		valid = true, class = class,
		SetPos = function(self, position) self.position = position end,
		SetAngles = function(self, angles) self.angles = angles end,
		Spawn = function(self)
			check(self.position.z == 2 or ix == nil, "COTZ summons use validated floor height before spawning")
			self.spawned = true
		end,
		DropToFloor = function(self) self.grounded = true end,
		TakeDamage = function(self) self.damaged = true end,
		STALKERNPCKill = function(self) self.killed = true end,
	}
	created[#created + 1] = entity

	return entity
end}
local function makeOwner(definition)
	local position, angles = Vector(0, 0, 0), {}
	return setmetatable({
		valid = true, cotzCombatPack = {isolated = true},
		GetPos = function() return position end, GetAngles = function() return angles end,
		GetForward = function() return Vector(1, 0, 0) end,
		GetRight = function() return Vector(0, 1, 0) end, GetUp = function() return Vector(0, 0, 1) end,
		Health = function() return 100 end, GetMaxHealth = function() return 100 end,
		STALKERNPCClearAnimation = function() end, STALKERNPCPlayAnimation = function() end,
		PsiAttackCancel = 0, CanSpawn = true, NextSpawn = now + 100,
		jumping1 = 0, jumping2 = 0, isAttacking = 0,
		farttimer = now + 100, GoingToSpawnThem = false, CanSpecialTimer = now + 100,
		special1 = 0, special2 = 0, SpecialAttack = 0,
	}, {__index = definition})
end
local dog = makeOwner(psydog)
dog:STALKERNPCThink()
check(#created == 4 and registered == 4 and not dog.CanSpawn, "psydog fills its four original clone slots once")
for index = 1, 4 do
	local child = dog["Clone" .. index]
	check(child == created[index] and child.class == "npc_mutant_psydog_phantom"
		and child.cotzCombatPack == dog.cotzCombatPack and child.angles == dog:GetAngles() and child.grounded,
		"phantoms keep their owner's pack, angles, grounded position and cleanup references")
end
dog.Clone2.valid, dog.CanSpawn = false, true
dog:STALKERNPCThink()
check(#created == 5 and dog.Clone2 == created[5] and dog.Clone1 == created[1],
	"psydog replaces only missing clone slots")
dog:STALKERNPCOnDeath()
check(dog.Clone1.damaged and dog.Clone2.damaged and dog.Clone3.damaged and dog.Clone4.damaged,
	"psydog death still cleans up every current phantom")

local mutant = makeOwner(controller)
mutant.NextSpawn = 0
local before = #created
mutant:STALKERNPCThink()
check(#created == before + 6 and mutant.NextSpawn == now + 60 and not mutant.GoingToSpawnThem,
	"controller creates six zombies and retains its 60-second cooldown")
for index = 1, 6 do
	check(mutant["Zombie" .. index] == created[before + index]
		and mutant["Zombie" .. index].cotzCombatPack == mutant.cotzCombatPack,
		"controller keeps zombie references and isolated pack ownership")
end
now = now + 61
mutant:STALKERNPCThink()
check(#created == before + 6, "controller does not spawn a replacement group while any zombie survives")
mutant:STALKERNPCRemove()
for index = 1, 6 do check(mutant["Zombie" .. index].killed, "controller removal still cleans up its zombies") end

local offset = Vector(100, 40, 100)
before = #created
safePosition = false
check(not dog:STALKERNPCSpawnSummon("npc_mutant_psydog_phantom", offset) and #created == before,
	"unsafe placement does not create an entity at an unchecked offset")
safePosition, capacity = true, false
check(not dog:STALKERNPCSpawnSummon("npc_mutant_psydog_phantom", offset) and #created == before,
	"population cap prevents summon creation")
capacity, creationFails = true, true
check(not dog:STALKERNPCSpawnSummon("npc_mutant_psydog_phantom", offset), "failed entity creation is handled")
creationFails, reject = false, true
check(not dog:STALKERNPCSpawnSummon("npc_mutant_psydog_phantom", offset),
	"population-rejected entities are not retained in owner slots")
reject = false
populationLimit = registered + 2
local limitedDog = makeOwner(psydog)
before = #created
limitedDog:STALKERNPCThink()
check(#created == before + 2 and limitedDog.Clone1 and limitedDog.Clone2
	and not limitedDog.Clone3 and not limitedDog.Clone4,
	"immediate registration limits a summon group to remaining population capacity")
populationLimit = nil
ix = nil
local standalone = dog:STALKERNPCSpawnSummon("npc_mutant_psydog_phantom", offset)
check(standalone.position.x == 100 and standalone.position.y == 40 and standalone.position.z == 100,
	"NPCs outside COTZ retain their original local summon offsets")
print("PASS: " .. checks .. " mutant summoning checks")
