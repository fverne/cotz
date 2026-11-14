-- Read-only recipe extraction; no map setup, persistence or server hooks run.
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

PLUGIN = {}
ix = {
	inventory = {Register = function() end}, config = {Add = function() end}, command = {Add = function() end},
	type = {string = 1, text = 2},
}
isnumber = function(value) return type(value) == "number" end
table.Copy = function(value)
	if type(value) ~= "table" then return value end
	local result = {}
	for key, entry in pairs(value) do result[key] = table.Copy(entry) end

	return result
end
local root = "gamemodes/ix_cotz/plugins/hideouts/"
dofile(root .. "sh_definitions.lua")
dofile(root .. "sh_personal.lua")
dofile(root .. "sh_crates.lua")
local recipes = {}
for family in pairs(PLUGIN.crateMaterials) do
	recipes[family] = {}
	for level = 1, 12 do recipes[family][level] = PLUGIN:GetCrateRecipe(family, level, false) end
end
print(encode({recipes = recipes, batchSizes = PLUGIN.crateBatchSizes}))
