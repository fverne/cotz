-- Run from the addon root: luatex --luaonly tests/config_defaults_spec.lua
local checks = 0
local function check(value, message) checks = checks + 1 assert(value, message) end
local function read(path)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()

	return source
end
SERVER, CLIENT, IX_RELOADED = true, false, false
function Color(r, g, b, a) return {r = r, g = g, b = b, a = a} end
istable = function(value) return type(value) == "table" end
CAMI = {RegisterPrivilege = function() end}
util = {AddNetworkString = function() end}
net = {Receive = function() end}
hook = {Run = function() end}
local saved = {}
local writes, callbacks = 0, 0
ix = {yaml = {Read = function() return {} end}, util = {
	GetTypeFromValue = type,
	Include = function()
		ix.config.Add("inventoryWidth", 5, "Width", function() callbacks = callbacks + 1 end,
			{category = "Inventory", data = {min = 1, max = 20}}, true, true)
		ix.config.Add("webUrl", "", "Webhook", nil, nil, true)
		ix.config.Add("communityURL", "", "Community")
	end,
}, data = {
	Get = function(_, _, global) return global and saved or {} end,
	Set = function() writes = writes + 1 end,
}}
local source = read("gamemodes/helix/gamemode/core/sh_config.lua"):gsub("!=", "~="):gsub("!", "not ")
assert(load(source))()
PLUGIN = {}
dofile("gamemodes/ix_cotz/plugins/corechanges/sh_defaults.lua")
ix.config.Add("worldSpawnerThreshold", 75, "World items", nil,
	{category = "Spawning", data = {min = 0, max = 200}})
PLUGIN:ApplyConfiguredDefaults()
ix.config.Load()
check(ix.config.Get("inventoryWidth") == 7 and ix.config.Get("worldSpawnerThreshold") == 50,
	"fresh installs receive configured defaults before and after option registration")
check(ix.config.stored.inventoryWidth.bNoNetworking and not ix.config.stored.inventoryWidth.global,
	"default seeding preserves registered networking and persistence metadata")
check(ix.config.stored.inventoryWidth.callback ~= nil and callbacks == 0 and writes == 0,
	"startup defaults neither replace callbacks nor write saved config")
check(ix.config.Get("webUrl") == "" and ix.config.Get("communityURL") == "",
	"deployment endpoints are excluded from repository defaults")
check(ix.config.stored.communityText.default == "Discord", "community link caption is retained")
saved = {inventoryWidth = 9, worldSpawnerThreshold = 32, webUrl = "private-hook", communityURL = "private-community"}
PLUGIN:ApplyConfiguredDefaults()
ix.config.Load()
check(ix.config.Get("inventoryWidth") == 9 and ix.config.Get("worldSpawnerThreshold") == 32,
	"saved administrator settings override repository defaults")
check(ix.config.Get("webUrl") == "private-hook" and ix.config.Get("communityURL") == "private-community",
	"existing private deployment endpoints survive startup")
IX_RELOADED = true
ix.config.stored.inventoryWidth.value = 11
PLUGIN:ApplyConfiguredDefaults()
check(ix.config.Get("inventoryWidth") == 11 and ix.config.stored.inventoryWidth.default == 7,
	"hot reload updates the default without replacing the current value")
table.Copy = function(value)
	local result = {}
	for key, item in pairs(value) do result[key] = item end
	return result
end
dofile("gamemodes/ix_cotz/schema/libs/sh_spawnpolicy.lua")
game = {GetMap = function() return "rp_garbage_cotz" end}
for _, key in ipairs({"worldSpawnerThreshold", "boxSpawnerThreshold", "artifactSpawnerThreshold",
	"eventControllerAdvThreshold", "eventControllerThreshold", "mutantLimit", "mutantRegionLimit"}) do
	ix.config.Add(key, 75, "Spawner", nil, {category = "Spawning", data = {min = 0, max = 200}})
	ix.spawnPolicy.Register(key)
	for _, map in ipairs(ix.spawnPolicy.maps) do
		local entry = ix.config.stored[key .. "_" .. map]
		check(entry and entry.default == -1 and entry.data.data.min == -1 and entry.data.data.max == 200,
			"each supported map has an independently editable override with inherited bounds")
	end
end
check(ix.spawnPolicy.Get("worldSpawnerThreshold", 75) == 32, "Garbage inherits the saved shared threshold")
ix.config.stored.worldSpawnerThreshold_rp_garbage_cotz.value = 0
ix.config.stored.worldSpawnerThreshold_rp_marsh_cs.value = 20
check(ix.spawnPolicy.Get("worldSpawnerThreshold", 75) == 0, "zero map thresholds stop spawning")
check(ix.spawnPolicy.Get("worldSpawnerThreshold", 75, "rp_marsh_cs") == 20,
	"another map's threshold remains independent")
check(ix.spawnPolicy.Get("worldSpawnerThreshold", 75, "custom") == 32, "custom maps retain shared fallbacks")
print("PASS: " .. checks .. " config defaults and map override checks")
