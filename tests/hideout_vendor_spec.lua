-- Run from the repository root: luatex --luaonly tests/hideout_vendor_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

AddCSLuaFile = function() end
IsValid = function(entity) return entity.valid == true end
MOVETYPE_NONE, MOVETYPE_VPHYSICS, SIMPLE_USE = 0, 6, 3
local registered, pending = {}, {}
scripted_ents = {GetStored = function(class) return registered[class] end}
-- Plugin entities are registered, but the separate engine baseclass cache is still empty.
baseclass = {Get = function() return {} end}
timer = {Simple = function(_, callback) pending[#pending + 1] = callback end}
local paths = {
	{"ix_hideout_vendor", "hideouts"},
	{"ix_sherpa_vendor", "sherpas"},
	{"ix_vendor_adv", "vendor_adv"},
}

local function makeEntity(class)
	local entity = setmetatable({valid = true, moves = {}, animations = 0}, {
		__index = function(_, key)
			local definition = registered[class].t
			while definition do
				if definition[key] ~= nil then return definition[key] end
				definition = registered[definition.Base] and registered[definition.Base].t
			end
		end,
	})
	for _, name in ipairs({"Model", "UseType", "DisplayName", "Description", "Sherpa", "SoundGroup"}) do
		entity["Set" .. name] = function(self, value) self[name] = value end
	end
	function entity:SetMoveType(value) self.moves[#self.moves + 1] = value end
	function entity:DrawShadow() end
	function entity:InitPhysObj() self.physicsInitialized = true end
	function entity:AddCallback() end
	function entity:SetNWBool() end
	function entity:SetAnim() self.animations = self.animations + 1 end

	return entity
end

for _, server in ipairs({true, false}) do
	SERVER, CLIENT = server, not server
	registered, pending = {}, {}
	-- Load children before their parents, as can happen during Helix plugin discovery.
	for _, entry in ipairs(paths) do
		ENT = {}
		dofile("gamemodes/ix_cotz/plugins/" .. entry[2] .. "/entities/entities/" .. entry[1] .. ".lua")
		registered[entry[1]] = {t = ENT}
	end
	ENT = nil
	for _, class in ipairs({"ix_hideout_vendor", "ix_sherpa_vendor"}) do
		local entity = makeEntity(class)
		entity:Initialize()
		check(#pending == 1, class .. " initializes the advanced vendor exactly once")
		if SERVER then
			check(entity.physicsInitialized and entity.UseType == SIMPLE_USE, "base physics and use are initialized")
			check(entity.items and entity.messages and entity.factions and entity.classes and entity.receivers,
				"base vendor state is initialized")
			check(entity.Sherpa and entity.DisplayName == "Quartermaster" and entity.SoundGroup == "nosound"
				and entity.dialogueid == "sherpa", "Sherpa identity is initialized")
			local expectedMove = class == "ix_hideout_vendor" and MOVETYPE_VPHYSICS or MOVETYPE_NONE
			check(entity.moves[1] == MOVETYPE_NONE and entity.moves[#entity.moves] == expectedMove,
				"only the hideout vendor overrides the base movement type")
		else
			check(entity.items == nil and #entity.moves == 0, "client initialization leaves server state alone")
		end
		pending[1]()
		check(entity.animations == 1, "delayed animation initialization reaches the derived entity")
		entity.valid = false
		pending[1]()
		check(entity.animations == 1, "animation callback tolerates removal before it runs")
		pending = {}
	end
end
print("PASS: " .. checks .. " hideout and Sherpa vendor initialization checks")
