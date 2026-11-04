local root = "gamemodes/ix_cotz/plugins/"
local function read(path)
	local file = assert(io.open(root .. path))
	local source = file:read("*a")
	file:close()
	return source
end

local source = read("eventcontroller/sh_plugin.lua")
local lookup = assert(source:match("(local LEGACY_LOCATION_TAGS = .-)PLUGIN.eventdefs"))
local loadBody = assert(source:match("function PLUGIN:LoadData%(%)%s*(.-)\n\tend"))
local migrate = assert(load(lookup .. "\nreturn function(self)\n" .. loadBody .. "\nend"))()
game = {GetMap = function() return "rp_marsh_cs" end}
local points = {rp_marsh_cs = {}, rp_waystation = {}, rp_pripyat_remaster = {}}
local prefixes = {"swamps", "waystation", "pripyat"}
local suffixes = {"outside_easy", "outside_hard", "building", "sniperspot", "underground"}
for mapIndex, mapName in ipairs({"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"}) do
	for index, suffix in ipairs(suffixes) do
		points[mapName][index] = {{}, "Area", mapIndex * 10 + index}
	end
end
points.custom = {{{}, "Custom", 99}, {{}, "Existing", "swamps_building"}}
local plugin = {GetData = function() return points end}
migrate(plugin)
migrate(plugin)
for mapIndex, mapName in ipairs({"rp_marsh_cs", "rp_waystation", "rp_pripyat_remaster"}) do
	for index, suffix in ipairs(suffixes) do
		assert(points[mapName][index][3] == prefixes[mapIndex] .. "_" .. suffix)
		assert(points[mapName][index][2] == "Area")
	end
end
assert(points.custom[1][3] == 99 and points.custom[2][3] == "swamps_building")

PLUGIN = {eventdefs = {}, map_presets = {}}
local definitions = read("eventcontroller/sh_eventdefs.lua"):gsub("/%*.-%*/", "")
assert(load(definitions))()
local valid = {}
prefixes[#prefixes + 1] = "garbage"
for _, prefix in ipairs(prefixes) do
	for _, suffix in ipairs(suffixes) do
		valid[prefix .. "_" .. suffix] = true
	end
end
for _, definition in pairs(PLUGIN.eventdefs) do
	for _, tag in ipairs(definition.difficulty) do
		assert(valid[tag], tostring(tag))
	end
end
local formatter = read("firsttimesetup/sh_plugin.lua")
formatter = assert(formatter:match('%["eventcontroller"%] = function%(id, data%)(.-)\n\t\tend,'))
local export = assert(load("return function(id, data)\n" .. formatter .. "\nend"))()
Vector = function(x, y, z) return {x = x, y = y, z = z} end
local text = export(1, {Vector(1, 2, 3), 'Area "quoted"', "swamps_building"})
local restored = assert(load("return {" .. text .. "}"))()
restored = restored[1]
assert(restored[2] == 'Area "quoted"' and restored[3] == "swamps_building")
local function hasTag(key, tag)
	for _, candidate in ipairs(PLUGIN.eventdefs[key].difficulty) do
		if candidate == tag then return true end
	end

	return false
end

for _, key in ipairs({"Dog1", "Dog2", "Dog4", "rodent2", "cat1", "cat2", "izlom1", "zombies1", "tark1", "tark2", "spider1", "sprig1"}) do
	assert(hasTag(key, "garbage_outside_easy"))
	assert(not hasTag(key, "waystation_outside_easy"))
	assert(not hasTag(key, "waystation_outside_hard"))
end
assert(hasTag("cat3", "waystation_outside_hard"))
assert(hasTag("Dog2", "swamps_outside_hard"))
assert(PLUGIN.eventdefs.garbage_dogs == nil)
assert(PLUGIN.eventdefs.garbage_cat == nil)
assert(PLUGIN.eventdefs.garbage_rodents == nil)
assert(hasTag("garbage_bloodsucker", "garbage_outside_hard"))
assert(not hasTag("bloodsucker1", "swamps_outside_hard"))
assert(not hasTag("bloodsucker1", "swamps_building"))
assert(not hasTag("Dog3", "swamps_outside_hard"))
assert(not hasTag("boar3", "swamps_outside_hard"))
assert(not hasTag("boar1", "waystation_outside_easy"))
assert(hasTag("bloodsucker1", "waystation_building"))
assert(PLUGIN.eventdefs.garbage_bloodsucker.entities[1][2] == 1)
local garbageCount = 0
for key, definition in pairs(PLUGIN.eventdefs) do
	if key:match("^garbage_") then
		garbageCount = garbageCount + 1
		for _, tag in ipairs(definition.difficulty) do
			assert(tag:match("^garbage_"))
		end
		for _, entity in ipairs(definition.entities) do
			assert(not entity[1]:match("controller"))
			assert(not entity[1]:match("chimera"))
			assert(not entity[1]:match("pseudogiant"))
			assert(not entity[1]:match("burer"))
		end
	end
end
assert(garbageCount == 11)
local tags = assert(load(lookup .. "\nreturn LOCATION_TAGS"))()
for _, suffix in ipairs(suffixes) do
	assert(tags["garbage_" .. suffix])
end
print("Location tags, migration, FTS export and Garbage encounter tier checks passed")
