-- Run from the repository root: luatex --luaonly tests/box_loot_placement_spec.lua
local root = "gamemodes/ix_cotz/plugins/boxspawner/"
local vectorMeta = {}
Vector = function(x, y, z)
	return setmetatable({x = x, y = y, z = z}, vectorMeta)
end
vectorMeta.__add = function(a, b)
	return Vector(a.x + b.x, a.y + b.y, a.z + b.z)
end

SERVER, CLIENT = true, false
AddCSLuaFile = function() end
IsValid = function(entity) return entity ~= nil and entity.valid ~= false end
AngleRand = function() return {randomRotation = true} end
bit = {bor = function(a, b) return a | b end}
ix = {
	config = {Add = function() end},
	spawnPolicy = {Register = function() end},
	command = {Add = function() end},
	type = {number = 1, string = 2, optional = 4},
	util = {},
	item = {},
}
timer = {Simple = function() end}
ents = {Create = function()
	return setmetatable({}, {__index = function() return function() end end})
end}

local plugin = {}
local definitions = {}
PLUGIN = plugin
for _, class in ipairs({"ix_entbox", "ix_paper_entbox", "ix_wood_entbox"}) do
	ENT = {}
	local file = assert(io.open(root .. "entities/entities/" .. class .. ".lua"))
	local source = file:read("*a")
	file:close()
	-- Normalize existing GLua syntax and the wooden entity's UTF-8 BOM for standalone Lua.
	source = source:gsub("^\239\187\191", ""):gsub("!", "not ")
	assert(load(source, class))()
	definitions[class] = ENT
end
dofile(root .. "sh_plugin.lua")
PLUGIN = nil

local queued = {}
ix.item.Spawn = function(id, position, callback, angles, data)
	queued[#queued + 1] = {id = id, position = position, callback = callback, angles = angles, data = data}
end
local selectedPools = {}
local dropData = {durability = 37, custom = {model = "large_custom_model.mdl"}}
ix.util.GetRandomItemFromPool = function(pool)
	selectedPools[#selectedPools + 1] = pool

	return {"test_item", dropData}
end
local originalRandom = math.random
math.random = function(_, maximum) return maximum end

local function makeBox(definition, customPool)
	return setmetatable({
		hp = 1,
		CustomSpawngroup = customPool,
		GetPos = function(self)
			assert(not self.removed, "Async placement must not access the removed box")

			return Vector(100, 200, 5)
		end,
		GetAngles = function() return {} end,
		WorldSpaceAABB = function(self)
			assert(not self.removed, "Read the box bounds before removal")

			return Vector(80, 180, 0), Vector(120, 220, 40)
		end,
		Remove = function(self) self.removed = true end,
	}, {__index = definition})
end

local function makeLoot(position, bottomOffset)
	return {
		position = position,
		GetPos = function(self) return self.position end,
		SetPos = function(self, value) self.position = value end,
		WorldSpaceAABB = function(self)
			return self.position + Vector(-20, -30, bottomOffset), self.position + Vector(20, 30, 80)
		end,
		PhysWake = function(self) self.awake = true end,
	}
end

local damage = {GetDamage = function() return 100 end}
for class, definition in pairs(definitions) do
	for _, custom in ipairs({false, true}) do
		queued, selectedPools = {}, {}
		local pool = custom and "custom_box_pool" or class .. "_drops"
		local box = makeBox(definition, custom and pool or nil)
		box:OnTakeDamage(damage)
		assert(box.removed and #queued == 4, "Retain four loot rolls for " .. class)
		-- Simulate delayed database callbacks after the box has gone, in reverse completion order.
		for index = #queued, 1, -1 do
			local spawn = queued[index]
			assert(selectedPools[index] == pool, "Preserve default and custom loot pools")
			assert(spawn.id == "test_item" and spawn.data == dropData, "Preserve selected item and data")
			assert(spawn.angles.randomRotation, "Preserve random item angles")
			-- Large rotated bounds, small item, fallback physics cube and offset model origin.
			local bottomOffsets = {-120, -2, -8, 15}
			local loot = makeLoot(spawn.position, bottomOffsets[index])
			local item = {SetData = function(self, key, value) self[key] = value end}
			spawn.callback(item, loot)
			local mins = loot:WorldSpaceAABB()
			assert(mins.z > 40, "The entire item must clear the box top, including large rotated models")
			assert(loot.position.x == 100 and loot.position.y == 200, "Keep loot at its box location")
			assert(item.bTemporary and loot.bTemporary and loot.awake, "Preserve temporary loot physics")
		end
		-- Repeated damage while the dying entity is still accessible must not roll more loot.
		box.removed = false
		box:OnTakeDamage(damage)
		assert(#queued == 4, "Repeated damage must not duplicate loot")
	end
end

-- A failed drop roll must still produce no reward.
math.random = function() return 1 end
queued = {}
makeBox(definitions.ix_entbox):OnTakeDamage(damage)
assert(#queued == 0, "Preserve missed loot rolls")
math.random = originalRandom

plugin:SpawnBoxLoot(makeBox(definitions.ix_entbox), {"test_item"}, 1)
assert(next(queued[1].data) == nil, "Keep empty instance data when the pool supplies none")
queued[1].callback({SetData = function() end}, nil)
queued[1].callback({SetData = function() end}, {valid = false})

print("PASS: all three box types place large and small loot above the box after delayed creation")
