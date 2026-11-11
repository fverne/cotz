-- Run from the repository root: luatex --luaonly tests/item_requirement_tooltips_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local file = assert(io.open("gamemodes/ix_cotz/schema/derma/cl_inventory.lua"))
local source = file:read("*a")
file:close()
local function section(first, last)
	local start = assert(source:find(first, 1, true))
	local finish = assert(source:find(last, start, true))

	return source:sub(start, finish - 1)
end
local character = {}
function character:GetJobs()
	return {
		Issuer = {identifier = "courier"}, Alpha = {identifier = "ordinary"},
		Beta = {identifier = "ordinary"}, Hunter = {identifier = "hunt"},
		Epsilon = {identifier = "ordinaryOnly"},
		Retired = {identifier = "missing"},
	}
end
local player = {GetCharacter = function() return character end}
local properties = {}
local methods = {}
local inventory = {
	slots = {{ {id = 1}, {id = 2}, {id = 3}, {id = 4} }},
	GetSize = function() return 1, 4 end, GetID = function() return 1 end,
}
function character:GetInventory() return inventory end
local environment = {
	PANEL = methods, yellowCol = "yellow", purpleCol = "purple",
	LocalPlayer = function() return player end,
	IsValid = function(value) return type(value) == "table" end,
	ix = {
		gui = {}, jobs = {list = {
			courier = {requiredItem = "shared", alternateDelivery = true},
			ordinary = {requiredItem = "shared"}, ordinaryOnly = {requiredItem = "ordinary"}, hunt = {},
		}, regional = {EligibleReceivers = function(_, _, _, owner)
			check(owner == character, "Courier lookup uses the current character's discovery")
			return {"Gamma", "Beta", "Beta"}
		end}},
		progression = {GetNeededItemContacts = function()
			return {shared = {Delta = true, Alpha = true}, progression = {Delta = true}}
		end},
		item = {instances = {}}, hud = {PopulateItemTooltip = function() end},
		util = {PropertyDesc = function(_, text, color)
			properties[#properties + 1] = {text, color}
		end},
	},
}
setmetatable(environment, {__index = _G})
local init = "function PANEL:BuildHighlights()\n"
	.. section("\tself.highlghtItems = {}", "function PANEL:GetPadding(")
assert(load(init, "@inventory/highlights", "t", environment))()
local tooltipCode = section("local function addRequirementContacts(", "function PANEL:SetGridSize(")
-- These unchanged inventory guards are not reached by the populated test slots.
tooltipCode = tooltipCode:gsub("continue", 'error("Unexpected skipped inventory slot")')
assert(load(tooltipCode, "@inventory/tooltips", "t", environment))()
local panel = setmetatable({panels = {}, iconSize = 32}, {__index = methods})
function panel:SetSize() end
function panel:SetGridSize() end
local icons = {}
function panel:AddIcon()
	local icon = {SetHelixTooltip = function(self, callback) self.tooltip = callback end}
	icons[#icons + 1] = icon

	return icon
end
for id, uniqueID in ipairs({"shared", "progression", "ordinary", "unneeded"}) do
	environment.ix.item.instances[id] = {id = id, uniqueID = uniqueID, width = 1, height = 1,
		GetModel = function() return "model" end, GetSkin = function() return 0 end}
end
panel:BuildHighlights()
check(panel.highlghtItems.shared == "Both" and panel.highlghtItems.progression == "Progression",
	"Adding contact names preserves both requirement highlight types")
check(not panel.highlightContacts.Task.shared.Issuer and panel.highlightContacts.Task.shared.Gamma,
	"Courier tooltips identify eligible receivers rather than the issuing contact")
panel:SetInventory(inventory)
local tooltip = {SizeToContents = function() end}
icons[1].tooltip(tooltip)
check(#properties == 5, "Shared items list every contact once per requirement type")
check(properties[1][1] == "Task: Alpha" and properties[2][1] == "Task: Beta"
	and properties[3][1] == "Task: Gamma" and properties[4][1] == "Progression: Alpha"
	and properties[5][1] == "Progression: Delta", "Contact rows are sorted within each requirement type")
check(properties[1][2] == "yellow" and properties[4][2] == "purple",
	"Task and progression rows keep their established colors")
properties = {}
icons[2].tooltip(tooltip)
check(#properties == 1 and properties[1][1] == "Progression: Delta",
	"Progression-only items show their requesting contact")
properties = {}
icons[3].tooltip(tooltip)
check(#properties == 1 and properties[1][1] == "Task: Epsilon",
	"Task-only items show their issuing contact")
properties = {}
icons[4].tooltip(tooltip)
check(#properties == 0, "Unneeded items do not gain requirement rows")
print(string.format("PASS: %d item requirement tooltip checks", checks))
