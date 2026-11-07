-- Run from the repository root: luatex --luaonly tests/progression_menu_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
SERVER, CLIENT = false, true
ix = {gui = {}, util = {Include = function() end}}
PLUGIN = {}
dofile("gamemodes/ix_cotz/plugins/progression/sh_plugin.lua")
local tabs = {tasks = function() end, squads = function() end, settings = function() end}
PLUGIN:CreateMenuButtons(tabs)
check(type(tabs.progression) == "function" and not PLUGIN.PopulateHelpMenu,
	"Progression registers in the main menu instead of the encyclopedia")
local panel
Vector = function() return {} end
DEFINE_BASECLASS = function() end
AccessorFunc = function() end
IsValid = function(value) return type(value) == "table" end
vgui = {Register = function(_, definition) panel = definition end}
local file = assert(io.open("gamemodes/ix_cotz/schema/derma/cl_menu.lua"))
local source = file:read("*a")
file:close()
source = source:gsub("/%*.-%*/", ""):gsub("//", "--")
source = source:gsub("!=", "~="):gsub("!", "not "):gsub("&&", "and"):gsub("||", "or")
assert(load(source, "@schema/cl_menu.lua"))()
SortedPairs = function(values)
	local names = {}
	for name in pairs(values) do names[#names + 1] = name end
	table.sort(names)
	local index = 0

	return function() index = index + 1 return names[index], values[names[index]] end
end
hook = {Run = function(_, result) for name, info in pairs(tabs) do result[name] = info end end}
local order = {}
local menu = {tabs = {buttons = {}}, buttons = {MoveToFront = function() end},
	guard = {MoveToBefore = function() end}, SetActiveSubpanel = function() end}
function menu:SetupTab(name)
	order[#order + 1] = name
	local button = {id = #order, SetSelected = function() end}
	self.tabs.buttons[#self.tabs.buttons + 1] = button

	return false, button
end
panel.PopulateTabs(menu)
check(table.concat(order, ",") == "settings,squads,tasks,progression",
	"Progression sits immediately after Tasks while other tabs retain their order")
print(string.format("PASS: %d progression menu checks", checks))
