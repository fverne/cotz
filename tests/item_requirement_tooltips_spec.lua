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
local upgradeRequests = 0
local hideouts = {}
local upgradeItems = {shared = {["Marsh room"] = true}, unneeded = {["Squad base"] = true, ["Marsh room"] = true}}
function hideouts:RequestUpgradeItems() upgradeRequests = upgradeRequests + 1 end
function hideouts:GetUpgradeItemHideouts(uniqueID)
	return upgradeItems[uniqueID]
end
local drawColors = {}
local gradientMaterial
local gradientX
local environment = {
	PANEL = methods, yellowCol = "yellow", purpleCol = "purple",
	Color = function(r, g, b, a) return {r = r, g = g, b = b, a = a} end,
	ColorAlpha = function(color, a) return {r = color.r, g = color.g, b = color.b, a = a} end,
	Material = function(path) return path end,
	surface = {
		SetDrawColor = function(color) drawColors[#drawColors + 1] = color end,
		DrawRect = function() end,
		SetMaterial = function(material) gradientMaterial = material end,
		DrawTexturedRect = function(x) gradientX = x end,
	},
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
		plugin = {Get = function(id) return id == "hideouts" and hideouts or nil end},
		item = {instances = {}}, hud = {PopulateItemTooltip = function() end},
		util = {PropertyDesc = function(_, text, color)
			properties[#properties + 1] = {text, color}
		end},
	},
}
setmetatable(environment, {__index = _G})
local paintCode = section("local blackCol = ", 'vgui.Register("ixItemIcon"')
	.. "return getUpgradeItemHideouts, HIDEOUT_COLOR, HIDEOUT_BACKGROUND, blackCol"
local getUpgradeItemHideouts, hideoutColor, hideoutBackground, blackColor =
	assert(load(paintCode, "@inventory/paint", "t", environment))()
environment.getUpgradeItemHideouts = getUpgradeItemHideouts
environment.HIDEOUT_COLOR = hideoutColor
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
check(upgradeRequests == 1, "Opening an inventory requests current hideout upgrade materials")
check(panel.highlghtItems.shared == "Both" and panel.highlghtItems.progression == "Progression",
	"Adding contact names preserves both requirement highlight types")
check(not panel.highlightContacts.Task.shared.Issuer and panel.highlightContacts.Task.shared.Gamma,
	"Courier tooltips identify eligible receivers rather than the issuing contact")
panel:SetInventory(inventory)
local tooltip = {SizeToContents = function() end}
icons[1].tooltip(tooltip)
check(#properties == 6, "Shared items list every contact once per requirement type")
check(properties[1][1] == "Task: Alpha" and properties[2][1] == "Task: Beta"
	and properties[3][1] == "Task: Gamma" and properties[4][1] == "Progression: Alpha"
	and properties[5][1] == "Progression: Delta", "Contact rows are sorted within each requirement type")
check(properties[1][2] == "yellow" and properties[4][2] == "purple",
	"Task and progression rows keep their established colors")
check(properties[6][1] == "Hideout: Marsh room" and properties[6][2] == hideoutColor
	and hideoutColor.r > hideoutColor.g and hideoutColor.r > hideoutColor.b,
	"Hideout upgrade materials follow requirement rows in red")
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
check(#properties == 2 and properties[1][1] == "Hideout: Marsh room" and properties[2][1] == "Hideout: Squad base",
	"Hideout-only materials list every hideout that needs them")
local icon = {
	itemTable = environment.ix.item.instances[1],
	GetParent = function() return panel end,
	GetWide = function() return 32 end,
	ExtraPaint = function() end,
}
methods.Paint(icon, 32, 32)
check(drawColors[1] == blackColor and drawColors[2] == hideoutBackground and #drawColors == 4,
	"Shared items draw a red gradient under both requirement highlights")
icon.itemTable = environment.ix.item.instances[4]
drawColors = {}
methods.Paint(icon, 32, 32)
check(drawColors[1] == blackColor and drawColors[2] == hideoutBackground and #drawColors == 2
	and gradientMaterial == "vgui/gradient-r" and gradientX == 18,
	"Hideout-only materials draw a red gradient on the right half")
upgradeItems.unneeded = nil
drawColors = {}
methods.Paint(icon, 32, 32)
check(drawColors[1] == blackColor and #drawColors == 1, "Open icons reflect updated hideout material needs")
print(string.format("PASS: %d item requirement tooltip checks", checks))
