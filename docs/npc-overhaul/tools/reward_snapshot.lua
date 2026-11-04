-- Offline authoring snapshot; does not load the gamemode or touch character/world saves.
local function encode(value)
	if value == nil then return "null" end
	if type(value) == "string" then
		return "\"" .. value:gsub("\\", "\\\\"):gsub("\"", "\\\""):gsub("\n", "\\n")
			:gsub("\r", "\\r"):gsub("\t", "\\t") .. "\""
	end
	if type(value) ~= "table" then return tostring(value) end
	local parts = {}
	if #value > 0 then
		for index = 1, #value do parts[#parts + 1] = encode(value[index]) end

		return "[" .. table.concat(parts, ",") .. "]"
	end
	local keys = {}
	for key in pairs(value) do keys[#keys + 1] = key end
	table.sort(keys)
	for _, key in ipairs(keys) do parts[#parts + 1] = encode(key) .. ":" .. encode(value[key]) end

	return "{" .. table.concat(parts, ",") .. "}"
end

Vector = function(...) return {...} end
Angle = Vector
PLUGIN = {contacts = {}, Register = function(self, id, contact)
	contact.id = id
	self.contacts[id] = contact
end}
local root = "gamemodes/ix_cotz/plugins/townnpcs/"
local file = assert(io.open(root .. "sh_plugin.lua"))
local source = file:read("*a")
file:close()
for path in source:gmatch([[ix%.util%.Include%("(definitions/[^"]+)"%)]]) do dofile(root .. path) end
local contacts = PLUGIN.contacts
ix = {item = {list = setmetatable({}, {__index = function() return {} end})}, progression = {
	npcRequirements = {},
	definitions = {}, Register = function(id, definition)
		definition.id = id
		ix.progression.definitions[id] = definition
	end,
}}
dofile(root .. "libs/sh_00_townnpcs.lua")
dofile("gamemodes/ix_cotz/plugins/progression/definitions/sh_requirementpools.lua")
PLUGIN.contacts = contacts
for _, contact in pairs(contacts) do PLUGIN.byName[contact.name] = contact end
dofile(root .. "libs/sh_catalogue.lua")
dofile(root .. "libs/sh_progressions.lua")
PLUGIN:BuildProgressions()
local compiled = {}
for id, definition in pairs(ix.progression.definitions) do
	compiled[id] = {
		prerequisites = definition.prerequisites, vendorUnlocks = definition.vendorUnlocks,
		variantUnlocks = definition.variantUnlocks, stockUnlocks = definition.stockUnlocks,
	}
end
print(encode({contacts = contacts, chains = PLUGIN.upgradeChains, compiled = compiled,
	ammoOrder = PLUGIN.ammoUnlockOrder, ammoVariants = PLUGIN.ammoVariants,
	canonical = PLUGIN.canonicalSellers, variants = PLUGIN.variantUnlocks, reserved = PLUGIN.reservedEquipment}))
