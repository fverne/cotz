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
local equipment = inventory.cotzEquipmentPanel
check(equipment and equipment:GetParent() == storage, "Storage receives an equipment companion")
check(equipment.companion and equipment.manual, "Companion participates in manual storage painting")
check(inventory.cotzEquipmentInventoryGrid:GetParent() == inventory, "Each frame retains its own backpack grid")
check(grid:GetWide() <= 1600 * 0.3, "Large storage grids leave room for equipment")
check(grid.gridW == 10 and grid.gridH == 12, "Visual resizing does not change storage capacity")
check(grid.x + grid.width < equipment.x, "Equipment is to the right of storage")
check(equipment.x + equipment.width < inventory.x, "Equipment is to the left of the backpack")
check(equipment.y >= 0 and equipment.y + equipment.height <= storage.height, "Storage equipment fits vertically")
local host = storage.cotzEquipmentHost
check(host and host:GetName() == "EditablePanel" and host.popups == 1 and host.raised,
	"An editable popup host raises the storage group above existing dialogue popups")
check(storage:GetParent() == host, "The entire storage view shares the foreground popup")
check(plugin:AttachInventoryEquipment(inventory) == equipment, "Repeated attachment reuses the same companion")
check(host.popups == 1, "Repeated attachment does not steal focus again")

local world = panel(nil, "World")
world.width, world.height = 1600, 900
local standalone = inventoryPanel(world)
standalone:SetPos(1100, 80)
runDeferred()
check(standalone.cotzEquipmentPanel and standalone.cotzEquipmentPanel.popups == 1,
	"Standalone inventory creation also shows equipment")
check(standalone.cotzEquipmentPanel.x + standalone.cotzEquipmentPanel.width < standalone.x,
	"Standalone equipment uses available space beside its owner")
check(not equipment.removed, "Creating another view does not remove existing equipment")
environment.ix.gui.inv1 = standalone.cotzEquipmentInventoryGrid
callbacks["cotz/equipment/refresh"]()
check(equipment.rebuilds == 2 and standalone.cotzEquipmentPanel.rebuilds == 2,
	"State refresh updates every visible equipment view")
check(inventory.cotzEquipmentInventoryGrid.refreshes == 1
	and standalone.cotzEquipmentInventoryGrid.refreshes == 1, "Each view refreshes its own backpack grid once")
plugin:OnScreenSizeChanged()
check(equipment.rebuilds == 3 and standalone.cotzEquipmentPanel.rebuilds == 3,
	"Resolution changes update every equipment companion")
standalone:OnRemove()
check(standalone.originalRemoved and standalone.cotzEquipmentPanel.removed,
	"Owner cleanup removes its companion and preserves the original callback")
check(not equipment.removed, "Closing one inventory leaves other equipment views alone")
local closedBeforeAttach = inventoryPanel(world)
closedBeforeAttach.removed = true
runDeferred()
check(not closedBeforeAttach.cotzEquipmentPanel, "Deferred attachment ignores an inventory already closed")
storage:OnRemove()
check(storage.originalRemoved and host.removed, "Storage cleanup preserves the callback and removes its popup host")

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

for _, resolution in ipairs({{1024, 768}, {1280, 720}, {1920, 1080}, {3440, 1440}, {3840, 2160}}) do
	local width, height = resolution[1], resolution[2]
	local backpackWidth, backpackHeight = width * 0.28, height * 0.82
	local storageWidth, storageHeight = width * 0.30, height * 0.80
	local bounds = plugin:GetStorageEquipmentBounds(width, height, backpackWidth, backpackHeight,
		storageWidth, storageHeight)
	check(bounds.storage.x + storageWidth < bounds.equipment.x, "Storage and equipment never overlap")
	check(bounds.equipment.x + bounds.equipment.w < bounds.inventory.x, "Equipment and backpack never overlap")
	check(bounds.inventory.x + backpackWidth <= width, "Backpack stays on screen")
	check(bounds.equipment.y >= 0 and bounds.equipment.y + bounds.equipment.h <= height,
		"Equipment stays on screen")
end
print("Equipment views: " .. checks .. " checks passed")
