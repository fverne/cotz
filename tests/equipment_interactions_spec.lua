-- Run from the addon root: luatex --luaonly tests/equipment_interactions_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local function read(path)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()

	return source
end
local source = read("gamemodes/ix_cotz/plugins/itemhotkeys/sh_plugin.lua")
local first = assert(source:find('netstream.Hook("ixHotkeyChange"', 1, true))
local last = assert(source:find("\nif (CLIENT)", first, true))
local callback
local now = 0
local assignments = {}
local ownsItem = true
local character = {}
function character:GetInventory()
	return {HasItem = function() return ownsItem end}
end
function character:SetHotkey(index, value) assignments[index] = value end
local client = {GetCharacter = function() return character end}
local environment = {
	PLUGIN = {hotkeyitems = {bandage = "use"}},
	CurTime = function() return now end,
	isnumber = function(value) return type(value) == "number" end,
	isstring = function(value) return type(value) == "string" end,
	netstream = {Hook = function(_, handler) callback = handler end},
}
assert(load(source:sub(first, last - 1), "@hotkey/request", "t", setmetatable(environment, {__index = _G})))()
for _, index in ipairs({0, 5, 1.5, "1"}) do callback(client, index, "bandage") end
check(next(assignments) == nil, "Invalid hotkey indices cannot change character state")
callback(client, 1, {})
callback(client, 1, "unknown_item")
check(next(assignments) == nil, "Hotkeys accept only registered item IDs")
ownsItem = false
callback(client, 1, "bandage")
check(next(assignments) == nil, "Unowned items cannot be assigned")
ownsItem = true
now = 1
for index = 1, 4 do callback(client, index, "bandage") end
check(assignments[1] == "bandage" and assignments[4] == "bandage", "All four valid slots can be configured")
callback(client, 1, "nil")
check(assignments[1] == "bandage", "Repeated changes to one slot are rate limited")
now = 2
callback(client, 1, "nil")
check(assignments[1] == "nil", "None clears a hotkey")
function client:GetCharacter() return nil end
callback(client, 2, "nil")
check(assignments[2] == "bandage", "Requests without a current character are ignored")

source = read("gamemodes/ix_cotz/schema/derma/cl_inventory.lua")
first = assert(source:find("function PANEL:PaintDragPreview(", 1, true))
last = assert(source:find("\nend", first, true)) + 3
local methods = {}
local rectangles = {}
local item = {}
local icon = {gridW = 2, gridH = 3, GetItemTable = function() return item end}
function icon:GetWide() return 300 end
function icon:GetTall() return 400 end
local grid = setmetatable({iconSize = 48, invID = 1}, {__index = methods})
function grid:GetWide() return 400 end
function grid:GetPadding() return 20 end
function grid:IsEmpty() return true end
local previewEnvironment = {
	PANEL = methods,
	ix = {item = {inventories = {[1] = {GetSize = function() return 8, 8 end}}}},
	Color = function() return {} end, ColorAlpha = function(value) return value end,
	derma = {GetColor = function() return {} end},
	surface = {SetDrawColor = function() end, DrawRect = function(x, y, w, h)
		rectangles[#rectangles + 1] = {x = x, y = y, w = w, h = h}
	end},
}
assert(load(source:sub(first, last), "@inventory/preview", "t",
	setmetatable(previewEnvironment, {__index = _G})))()
grid:PaintDragPreview(400, 400, 100, 150, icon)
check(#rectangles == 1 and rectangles[1].w == 96 and rectangles[1].h == 144,
	"Drag preview fits destination cells even when the source icon has a different display size")
grid:PaintDragPreview(400, 400, 1, 1, icon)
check(#rectangles == 1, "Out-of-bounds footprints are not painted")
source = read("gamemodes/ix_cotz/plugins/equipmentslots/cl_plugin.lua")
first = assert(source:find("function PANEL:AddEquipmentIcon(", 1, true))
last = assert(source:find("\nend", first, true)) + 3
local dragging = false
local choices = 0
local sent
local imageDraws, backgroundDraws = 0, 0
local iconMethods = {}
local card = {}
local function noop() end
function card:Add(class)
	if class == "DButton" then return {SetText = noop, SetTooltip = noop} end
	local result = {
		Icon = {SetVisible = noop}, SetInventoryID = noop, SetItemTable = noop, SetHelixTooltip = noop,
		OnMousePressed = function(this, code) this.pressed = code end,
		OnMouseReleased = function(this, code) this.released = code end,
	}

	return result
end
local view = setmetatable({
	inventoryID = 1,
	inventoryPanel = {cotzEquipmentInventoryGrid = {GetIconSize = function() return 64 end}},
	ChooseSlotItem = function() choices = choices + 1 end,
}, {__index = iconMethods})
local equipped = {id = 5, width = 1, height = 1}
local iconEnvironment = {
	PANEL = iconMethods,
	PLUGIN = {SendEquipmentAction = function(_, item, slot, equipping, x, y)
		sent = {item = item, slot = slot, equipping = equipping, x = x, y = y}
	end},
	MOUSE_LEFT = 1,
	IsValid = function(value) return type(value) == "table" end,
	dragndrop = {IsDragging = function() return dragging end},
	ix = {util = {GetItemIcon = function() return {} end}},
	color_white = {},
	surface = {
		SetMaterial = noop, SetDrawColor = noop,
		DrawRect = function() backgroundDraws = backgroundDraws + 1 end,
		DrawTexturedRect = function() imageDraws = imageDraws + 1 end,
	},
}
assert(load(source:sub(first, last), "@equipment/icon", "t",
	setmetatable(iconEnvironment, {__index = _G})))()
view:AddEquipmentIcon(card, equipped, 2)
card:OnMousePressed(1)
check(card.icon.pressed == 1, "Pressing the outer card initiates the item's drag handling")
card:OnMouseReleased(1)
check(card.icon.released == 1 and choices == 1, "A click still opens compatible item choices")
dragging = true
card:OnMouseReleased(1)
check(choices == 1, "Completing a drag does not open the item picker")
card.icon:OnDrop(true, {}, {GetID = function() return 1 end}, 4, 5)
check(sent and sent.item == equipped and not sent.equipping and sent.x == 4 and sent.y == 5,
	"Backpack drop forwards its preview coordinates to the server")
card.icon:Paint(64, 64)
check(imageDraws == 1 and backgroundDraws == 0, "Equipped images render without a dark inset background")
print("Equipment interactions: " .. checks .. " checks passed")
