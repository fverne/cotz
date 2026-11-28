-- Run from the addon root: luatex --luaonly tests/anomaly_selection_spec.lua
-- Anomaly spawn point selections: categories, names and legacy index masks.
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local root = "gamemodes/ix_cotz/plugins/anomalycontroller/"
PLUGIN = {anomalydefs = {}}
dofile(root .. "sh_anomalydefs.lua")
dofile(root .. "sh_anomalyselection.lua")
local plugin = PLUGIN

local function names(definitions)
	local list = {}

	for _, definition in ipairs(definitions) do
		list[#list + 1] = definition.name
	end

	return table.concat(list, ",")
end

local function parse(text)
	local radius, selectors, unknown = plugin:ParseAnomalySelection(text)

	return radius, table.concat(selectors, " "), table.concat(unknown, " ")
end

for index = 1, 10 do
	local definition = plugin.anomalydefs[index]
	check(definition.category and definition.triggerRadius, definition.name .. " is selectable and spaced")
end
for index = 11, #plugin.anomalydefs do
	check(not plugin.anomalydefs[index].category, plugin.anomalydefs[index].name .. " stays unselectable")
end

local radius, selectors, unknown = parse("fire")
check(radius == nil and selectors == "fire" and unknown == "", "a bare category parses without a radius")
check(names(plugin:ResolveAnomalySelection(selectors)) == "Burner1,Burner2", "fire resolves to both burners")

radius, selectors, unknown = parse("256 burner1 burner 2 Electro2")
check(radius == 256, "a leading number is the radius")
check(selectors == "burner1 burner2 electro2", "a quoted name split by Helix is joined back together")
check(unknown == "", "every word matched")
check(names(plugin:ResolveAnomalySelection(selectors)) == "Burner1,Burner2,Electro2", "names resolve in order")

radius, selectors = parse("acid fruitpunch1 fire burner1")
check(selectors == "acid fruitpunch1 fire burner1", "categories and names mix")
check(names(plugin:ResolveAnomalySelection(selectors)) == "Fruitpunch1,Fruitpunch2,Burner1,Burner2",
	"overlapping selectors resolve to unique definitions")

radius, selectors, unknown = parse("fire comet nonsense")
check(selectors == "fire" and unknown == "comet nonsense", "uncategorised and unknown names are rejected")

radius, selectors, unknown = parse("128 fire fire")
check(selectors == "fire", "repeated selectors are stored once")

check(#plugin:ResolveAnomalySelection("all") == 10, "all covers the ten original anomalies")
check(names(plugin:ResolveAnomalySelection("gravity")) == "Bubble1,Bubble2,Whirlgig,Karusel", "gravity category")
check(names(plugin:ResolveAnomalySelection("0000111")) == "Bubble1,Bubble2,Whirlgig", "legacy masks still resolve")
check(names(plugin:ResolveAnomalySelection("1100000000")) == "Burner1,Burner2", "ten-digit legacy mask")

local definitions, missing = plugin:ResolveAnomalySelection("fire bogus")
check(#definitions == 2 and missing[1] == "bogus", "stored unknown selectors are reported, known ones still spawn")

local categories, anomalies = plugin:GetAnomalySelectorNames()
check(table.concat(categories, ",") == "acid,all,electro,fire,gravity", "category list for feedback")
check(#anomalies == 10, "anomaly list for feedback")

print(string.format("PASS: %d anomaly selection checks", checks))
