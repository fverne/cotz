-- Offline extraction only; never invokes FTS deployment or changes saved map data.
local function readFile(path)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()

	return source
end

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
	for _, key in ipairs(keys) do parts[#parts + 1] = encode(tostring(key)) .. ":" .. encode(value[key]) end

	return "{" .. table.concat(parts, ",") .. "}"
end

Vector = function(...) return {...} end
Angle = Vector
Color = Vector
local root = "gamemodes/ix_cotz/plugins/"
PLUGIN = {map_presets = {}}
local ftsLoader = readFile(root .. "firsttimesetup/sh_plugin.lua")
for path in ftsLoader:gmatch([[ix%.util%.Include%("(presets/[^"]+)"%)]]) do
	dofile(root .. "firsttimesetup/" .. path)
end
local presets = PLUGIN.map_presets
ix = {randomitems = {tables = {}}}
local randomLoader = readFile(root .. "randomitem/libs/sh_randomitems.lua")
for path in randomLoader:gmatch([[ix%.util%.Include%("(ix_cotz/plugins/randomitem/pools/[^"]+)"]]) do
	dofile("gamemodes/" .. path)
end
PLUGIN = {}
dofile(root .. "cycliccontainer/sh_definitions.lua")
dofile(root .. "cycliccontainer/sh_stashtypes.lua")
local cyclic = PLUGIN
PLUGIN = {contacts = {}, Register = function(self, slug, contact) self.contacts[slug] = contact end}
local files = assert(io.popen("rg --files " .. root .. "townnpcs/definitions"))
for path in files:lines() do
	if readFile(path):find("PLUGIN:Register(", 1, true) then dofile(path) end
end
files:close()
local contacts = PLUGIN.contacts
PLUGIN = {}
dofile(root .. "townnpcs/definitions/sh_config.lua")
local settings = PLUGIN.settings
local items = {}
files = assert(io.popen("rg --files gamemodes/ix_cotz/schema/items"))
for path in files:lines() do
	local id = path:match("/sh_([^/]+)%.lua$")
	if id then
		local source = readFile(path)
		items[id] = {
			name = source:match([[ITEM%.name%s*=%s*"([^"]+)"]]) or id,
			quantity = tonumber(source:match("ITEM%.quantity%s*=%s*(%d+)")) or tonumber(source:match("ITEM%.ammoAmount%s*=%s*(%d+)")) or 1,
		}
	end
end
files:close()
dofile(root .. "progression/definitions/sh_requirementpools.lua")
local result = {presets = presets, loot = ix.randomitems.tables, cyclic = cyclic,
	contacts = contacts, items = items, batches = settings.spawnBatches, pools = ix.progression.itemPools}
-- Only authoring data is exported, so functions in contact tables are excluded.
local function removeFunctions(value)
	if type(value) ~= "table" then return end
	for key, child in pairs(value) do
		if type(child) == "function" then value[key] = nil else removeFunctions(child) end
	end
end
removeFunctions(result)
print(encode(result))
