-- Run from the addon root: luatex --luaonly tests/fts_entities_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local function typed(kind, value)
	return setmetatable(value, {kind = kind})
end

Vector = function(x, y, z) return typed("vector", {x = x, y = y, z = z}) end
Angle = function(p, y, r) return typed("angle", {p = p, y = y, r = r}) end
Color = function(r, g, b, a) return typed("color", {r = r, g = g, b = b, a = a}) end
isvector = function(value) return (getmetatable(value) or {}).kind == "vector" end
isangle = function(value) return (getmetatable(value) or {}).kind == "angle" end
IsColor = function(value) return (getmetatable(value) or {}).kind == "color" end
isstring = function(value) return type(value) == "string" end
isnumber = function(value) return type(value) == "number" end
isbool = function(value) return type(value) == "boolean" end
IsValid = function(value) return type(value) == "table" and value.valid == true end

local now = 0
local files = {}
local failWrite = false
local errors = {}
local created = {}
local commands = {}
local includes = {}
local spawnCount = 0
local netWrites = 0
CurTime = function() return now end
game = {GetMap = function() return "rp_test" end}
file = {
	CreateDir = function(path) check(path == "ftsdump", "Uses a Linux-compatible lowercase directory") end,
	Write = function(path, contents) if not failWrite then files[path] = contents end end,
	Read = function(path, realm)
		check(realm == "DATA", "Reads from server DATA")
		return files[path]
	end,
}
ErrorNoHalt = function(message) errors[#errors + 1] = message end

local function makeEntity(index, persistent)
	local entity = {
		valid = true,
		index = index,
		class = "prop_physics",
		position = Vector(1.123456789012345, -2, 3),
		angles = Angle(4, 5, 6),
		model = "models/props_c17/oildrum001.mdl",
		skin = 0,
		color = Color(17, 83, 201, 94),
		material = "test/quoted\"material\\name",
		renderMode = 1,
		renderFX = 0,
		modelScale = 0.75,
		collisionGroup = 20,
		bodygroups = {[0] = 2, [1] = 0},
		submaterials = {[0] = "test/first", [1] = "", [2] = "test/third"},
		persistent = persistent,
	}
	local physics = {valid = true, movable = false}
	function physics:IsMoveable() return self.movable end
	function physics:EnableMotion(value) self.movable = value end
	function physics:Sleep() self.sleeping = true end
	entity.physics = physics
	function entity:GetClass() return self.class end
	function entity:EntIndex() return self.index end
	function entity:GetBodyGroups() return {{id = 0}, {id = 1}} end
	function entity:GetBodygroup(id) return self.bodygroups[id] end
	function entity:SetBodygroup(id, value) self.bodygroups[id] = value end
	function entity:GetMaterials() return {"a", "b", "c"} end
	function entity:GetSubMaterial(id) return self.submaterials[id] end
	function entity:SetSubMaterial(id, value) self.submaterials[id] = value end
	function entity:GetPhysicsObject() return self.physics end
	function entity:GetNetVar(key, default)
		check(key == "Persistent", "Reads the installed persistence flag")
		return self.persistent or default
	end
	function entity:SetNetVar(key, value)
		check(key == "Persistent", "Registers the installed persistence flag")
		netWrites = netWrites + 1
		self.persistent = value
	end
	function entity:Spawn()
		check(self.position and self.angles, "Placement is set before spawning")
		if self.class == "prop_physics" then
			check(self.model ~= nil, "Physics props receive their model before spawning")
		end
		spawnCount = spawnCount + 1
	end
	function entity:Activate() self.activated = true end
	for method, field in pairs({
		Pos = "position", Angles = "angles", Model = "model", Skin = "skin", Color = "color",
		Material = "material", RenderMode = "renderMode", RenderFX = "renderFX",
		ModelScale = "modelScale", CollisionGroup = "collisionGroup",
	}) do
		entity["Get" .. method] = function(self) return self[field] end
		entity["Set" .. method] = function(self, value) self[field] = value end
	end

	return entity
end

ents = {Create = function(class)
	if class == "invalid_class" then return {valid = false} end
	local entity = makeEntity(#created + 100, false)
	entity.class = class
	entity.model = nil
	entity.position = nil
	entity.angles = nil
	if class == "prop_effect" then entity.AttachedEntity = makeEntity(999, false) end
	created[#created + 1] = entity

	return entity
end}

SERVER = true
CLIENT = false
PLUGIN = {}
ix = {
	plugin = {list = {persistence = {stored = {}}}},
	command = {Add = function(name, data) commands[name] = data end},
	type = {bool = 1, optional = 2},
	util = {Include = function(path)
		includes[path] = true
		if path == "sv_entities.lua" and SERVER then
			dofile("gamemodes/ix_cotz/plugins/firsttimesetup/" .. path)
		end
	end},
}
bit = {bor = function() return 3 end}
local sourceFile = assert(io.open("gamemodes/ix_cotz/plugins/firsttimesetup/sh_plugin.lua"))
local source = sourceFile:read("*a"):gsub("!=", "~=")
sourceFile:close()
assert(load(source, "@firsttimesetup/sh_plugin.lua"))()
local plugin = PLUGIN
PLUGIN = {DumpPersistentEntities = function() error("Wrong loader table captured") end}
check(includes["sv_entities.lua"], "Shared entry point explicitly includes the server implementation")
check(commands.FTSDumpPersistentEntities.adminOnly, "Export uses Helix admin permissions")

local first = makeEntity(5, true)
local second = makeEntity(2, true)
second.physics.movable = true
second.ClassOverride = "prop_physics_override"
local removed = makeEntity(1, true)
removed.valid = false
local stopped = makeEntity(3, false)
local persistence = ix.plugin.list.persistence
persistence.stored = {first, removed, stopped, second, first}

local filename, count = plugin:DumpPersistentEntities()
check(filename == "ftsdump/rp_test_persistent_entities.txt" and count == 2, "Exports each live persistent entity once")
check(spawnCount == 0 and netWrites == 0 and #persistence.stored == 5,
	"Dump does not mutate the live world or registry")
local contents = files[filename]
local records = assert(load("return {\n" .. contents .. "\n}"))().entities
check(#records == 2 and records[1].class == second.ClassOverride,
	"Output is ready to paste into FTS and sorted by entity ID")
local data = records[2]
check(data.position.x == first.position.x and data.angles.r == first.angles.r,
	"Coordinates round trip without truncation")
check(data.color.r == 17 and data.color.a == 94 and data.renderMode == 1,
	"Color tool tint and alpha render mode round trip")
check(data.renderFX == 0 and data.skin == 0, "Meaningful zero values survive")
check(data.material == first.material, "Lua output escapes quotes and backslashes")
check(data.bodygroups[0] == 2 and data.bodygroups[1] == 0, "Bodygroup IDs and zero values survive")
check(data.submaterials[0] == "test/first" and data.submaterials[2] == "test/third",
	"Sparse zero-based submaterials survive")
check(data.movable == false and records[1].movable == true, "Both movement states survive")
check(data.persistent == true and data.modelScale == 0.75, "Persistence and scale survive")
check(not plugin:DumpPersistentEntities(), "Repeated exports are rate limited")

local spawned = plugin:SpawnEntity(data)
check(spawned.model == first.model and spawned.activated, "FTS supplies a physics model and activates the entity")
check(spawned.color.a == 94 and spawned.renderMode == 1 and spawned.renderFX == 0, "FTS restores Color tool appearance")
check(spawned.material == first.material and spawned.skin == 0 and spawned.modelScale == 0.75,
	"FTS restores model appearance")
check(spawned.bodygroups[0] == 2 and spawned.submaterials[2] == "test/third",
	"FTS restores bodygroups and submaterials")
check(spawned.collisionGroup == 20 and not spawned.physics.movable, "FTS restores collision and frozen physics")
check(spawned.persistent and persistence.stored[#persistence.stored] == spawned,
	"FTS registers exported entities for persistence")
data.movable = true
check(plugin:SpawnEntity(data).physics.movable, "Explicit movable=true overrides the legacy frozen default")
local legacy = plugin:SpawnEntity({class = "ix_spawnsaver", position = Vector(0, 0, 0), angles = Angle(0, 0, 0)})
check(legacy and not legacy.physics.movable and legacy.physics.sleeping, "Legacy FTS records still spawn frozen")
check(not legacy.persistent, "Legacy plugin-owned records do not acquire Helix persistence")

local effect = makeEntity(10, true)
effect.class = "prop_effect"
effect.AttachedEntity = first
local effectData = plugin:GetPersistentEntityData(effect)
local restoredEffect = plugin:SpawnEntity(effectData)
check(effectData.model == first.model and restoredEffect.AttachedEntity.color.a == 94,
	"Effect props use their visual entity")

local beforeInvalid = #created
check(not plugin:SpawnEntity({class = "invalid_class"}), "Invalid entity classes fail cleanly")
check(#created == beforeInvalid and #errors == 1, "Failed creation reports an error without registering an entity")
ix.plugin.list.persistence = nil
check(not plugin:SpawnEntity(data) and #created == beforeInvalid, "Persistent records require their persistence owner")
local missingPath, missingError = plugin:DumpPersistentEntities()
check(not missingPath and missingError:find("not loaded", 1, true), "Missing persistence produces actionable feedback")
ix.plugin.list.persistence = persistence

now = now + 5
files[filename] = nil
failWrite = true
local failedPath, failedError = plugin:DumpPersistentEntities()
check(not failedPath and failedError:find("Could not write", 1, true), "Failed disk writes do not report success")
failWrite = false
now = now + 5
persistence.stored = {}
local emptyPath, emptyCount = plugin:DumpPersistentEntities()
check(emptyPath == filename and emptyCount == 0, "An empty map produces an empty replacement section")
check(#assert(load("return {" .. files[filename] .. "}"))().entities == 0, "Empty output is valid Lua")
now = now + 5
local commandMessage = commands.FTSDumpPersistentEntities:OnRun({})
check(commandMessage:find("Exported 0", 1, true), "Command retains the original plugin table after loading")

SERVER = false
CLIENT = true
PLUGIN = {}
netstream = {Hook = function() end}
assert(load(source, "@firsttimesetup/sh_plugin.lua (client)"))()
check(PLUGIN.SpawnEntity == nil and PLUGIN.DumpPersistentEntities == nil,
	"Server entity code stays out of the client realm")
check(commands.FTSDumpPersistentEntities.adminOnly, "Clients receive command permission metadata")
check(commands.FTSDumpPersistentEntities:OnRun({}) == nil, "Client command registration performs no export")

print(string.format("fts_entities_spec: %d checks passed", checks))
