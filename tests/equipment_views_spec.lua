-- Run from the addon root: luatex --luaonly tests/equipment_views_spec.lua
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end

PLUGIN = {equipmentViews = setmetatable({}, {__mode = "k"})}
dofile("gamemodes/ix_cotz/plugins/equipmentslots/cl_layout.lua")
local plugin = PLUGIN
local methods = {}
local timers = {}
local callbacks = {}
local clientInventory = {vars = {cotzEquipmentWidth = 8}, GetID = function() return 1 end}
local storageData = {}
local classes = {
	ixInventory = {AddIcon = function() return "original icon" end},
	ixStalkerInventoryPanel = {}, ixStorageView = {},
}
local function panel(parent, name)
	local result = {parent = parent, name = name or "Panel", width = 1200, height = 800, x = 0, y = 0}
	function result:GetParent() return self.parent end
	function result:SetParent(value) self.parent = value end
	function result:GetName() return self.name end
	function result:GetWide() return self.width end
	function result:GetTall() return self.height end
	function result:GetPos() return self.x, self.y end
	function result:SetPos(x, y) self.x, self.y = x, y end
	function result:SetWide(width) self.width = width end
	function result:SetSize(width, height) self.width, self.height = width, height end
	function result:SetZPos(value) self.z = value end
	function result:Dock() end
	function result:DockMargin() end
	function result:GetChildren() return self.children or {} end
	function result:MakePopup() self.popups = (self.popups or 0) + 1 end
	function result:MoveToFront() self.raised = true end
	function result:SetPaintedManually(value) self.manual = value end
	function result:SetKeyboardInputEnabled(value) self.keyboard = value end
	function result:InvalidateLayout() end
	function result:Rebuild() self.rebuilds = (self.rebuilds or 0) + 1 self.inventoryID = 1 end
	function result:Remove() self.removed = true end
	function result:Add(class)
		local child = panel(self, class)
		if class == "ixEquipmentSlots" then
			child.UpdatePageLayout = methods.UpdatePageLayout
			child.LayoutCompanion = methods.LayoutCompanion
		end
		self.children = self.children or {}
		self.children[#self.children + 1] = child

		return child
	end

	return result
end

local environment = {
	PLUGIN = plugin, PANEL = methods, RIGHT = "right",
	IsValid = function(value) return type(value) == "table" and not value.removed end,
	ScrW = function() return 1600 end, ScrH = function() return 900 end,
	LocalPlayer = function()
		return {GetCharacter = function() return {GetInventory = function() return clientInventory end} end}
	end,
	timer = {Simple = function(_, callback) timers[#timers + 1] = callback end},
	net = {Receive = function(name, callback) callbacks[name] = callback end, ReadUInt = function() return 1 end},
	vgui = {
		GetControlTable = function(name) return classes[name] end,
		Create = function(name) return panel(nil, name) end,
	},
	ix = {gui = {}, item = {inventories = {[1] = clientInventory, [2] = storageData}}},
	setBounds = function(target, bounds) target:SetPos(bounds.x, bounds.y) target:SetSize(bounds.w, bounds.h) end,
}
local sourceFile = assert(io.open("gamemodes/ix_cotz/plugins/equipmentslots/cl_plugin.lua"))
local source = sourceFile:read("*a")
sourceFile:close()
local function loadMethod(signature)
	local first = assert(source:find(signature, 1, true))
	local last = assert(source:find("\nend", first, true)) + 3
	assert(load(source:sub(first, last), "@equipment/client", "t", setmetatable(environment, {__index = _G})))()
end
for _, signature in ipairs({
	"function PANEL:UpdatePageLayout()", "function PANEL:LayoutCompanion()",
	"function PLUGIN:AttachInventoryEquipment(", "function PLUGIN:RaiseInventoryEquipment(",
	"function PLUGIN:InstallInventoryPanels()",
	"function PLUGIN:OnScreenSizeChanged()",
}) do loadMethod(signature) end

function plugin:CreateEquipmentFonts() end
local refreshStart = assert(source:find("net.Receive(\"cotz/equipment/refresh\"", 1, true))
assert(load(source:sub(refreshStart), "@equipment/refresh", "t", environment))()

function classes.ixStalkerInventoryPanel:Init()
	self.originalInit = true
	environment.ix.gui.inv1 = panel(self, "ixInventory")
end
function classes.ixStalkerInventoryPanel:OnRemove() self.originalRemoved = true end
function classes.ixStorageView:OnRemove() self.originalRemoved = true end
function plugin:RefreshInventoryPanel(grid, data)
	if data == storageData then
		grid.width = grid.iconSize * grid.gridW + 8
		grid.height = grid.iconSize * grid.gridH + 40
	else
		check(data == clientInventory, "Backpack refresh uses the character inventory")
		grid.refreshes = (grid.refreshes or 0) + 1
	end
end
plugin:InstallInventoryPanels()
local function runDeferred()
	local queued = timers
	timers = {}
	for _, callback in ipairs(queued) do callback() end
end
local function inventoryPanel(parent)
	local result = panel(parent, "ixStalkerInventoryPanel")
	result.width, result.height = 420, 740
	result.Init = classes.ixStalkerInventoryPanel.Init
	result.OnRemove = classes.ixStalkerInventoryPanel.OnRemove
	result:Init()

	return result
end

local storage = panel(nil, "ixStorageView")
storage.width, storage.height = 1600, 900
local grid = panel(storage, "ixInventory")
grid.width, grid.height = 800, 1000
grid.gridW, grid.gridH, grid.iconSize, grid.invID = 10, 12, 80, 2
function grid:GetIconSize() return self.iconSize end
function grid:SetIconSize(value) self.iconSize = value end
function grid:GetPadding() return 20 end
storage.storageInventory = grid
storage.OnRemove = classes.ixStorageView.OnRemove
local inventory = inventoryPanel(storage)
check(inventory.originalInit and not inventory.cotzEquipmentPanel, "Original init runs before deferred attachment")
runDeferred()
check(not inventory.cotzEquipmentPanel, "Storage, including Cleaner storage, has no equipment companion")
check(not storage.cotzEquipmentHost, "Storage keeps its original popup ownership")
check(grid.width == 800 and grid.height == 1000, "Equipment does not resize storage")
check(plugin:AttachInventoryEquipment(inventory) == nil, "Explicit attachment also excludes storage")
local world = panel(nil, "World")
local standalone = inventoryPanel(world)
runDeferred()
check(not standalone.cotzEquipmentPanel, "Standalone windows do not show the equipment menu")
local closedBeforeAttach = inventoryPanel(world)
closedBeforeAttach.removed = true
runDeferred()
check(not closedBeforeAttach.cotzEquipmentPanel, "Deferred attachment ignores an inventory already closed")
storage:OnRemove()
check(storage.originalRemoved, "Storage cleanup preserves the original callback")

local youPage = panel(nil, "ixSubpanel")
youPage.subpanelName = "you"
local youInventory = inventoryPanel(youPage)
youPage.children = {youInventory}
local youEquipment = plugin:AttachInventoryEquipment(youInventory)
runDeferred()
check(youInventory.cotzEquipmentPanel == youEquipment, "Menu population and deferred init share one companion")
check(not youEquipment.companion and youEquipment:GetParent() == youPage,
	"The You equipment remains embedded in the menu page")
check(not youEquipment.popups, "Embedded equipment never opens an extra popup")

local otherPage = panel(nil, "ixSubpanel")
otherPage.subpanelName = "you"
local otherInventory = inventoryPanel(otherPage)
runDeferred()
local otherEquipment = otherInventory.cotzEquipmentPanel
environment.ix.gui.inv1 = otherInventory.cotzEquipmentInventoryGrid
callbacks["cotz/equipment/refresh"]()
check(youEquipment.rebuilds == 2 and otherEquipment.rebuilds == 2, "Refresh updates all menu views")
check(youInventory.cotzEquipmentInventoryGrid.refreshes == 1, "Refresh updates the menu's own grid")
plugin:OnScreenSizeChanged()
check(youEquipment.rebuilds == 3 and otherEquipment.rebuilds == 3, "Resolution changes rebuild menu equipment")
otherInventory:OnRemove()
check(otherInventory.originalRemoved and otherEquipment.removed, "Closing a view removes its equipment")
check(not youEquipment.removed, "Independent menu views retain their equipment")
print("Equipment views: " .. checks .. " checks passed")
