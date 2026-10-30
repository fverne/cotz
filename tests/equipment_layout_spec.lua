-- Run from the addon root: luatex --luaonly tests/equipment_layout_spec.lua
PLUGIN = {}
dofile("gamemodes/ix_cotz/plugins/equipmentslots/cl_layout.lua")
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end

local function overlaps(a, b)
	local epsilon = 0.01

	return a.x < b.x + b.w - epsilon and b.x < a.x + a.w - epsilon
		and a.y < b.y + b.h - epsilon and b.y < a.y + a.h - epsilon
end

local resolutions = {
	{1024, 768}, {1280, 720}, {1366, 768}, {1600, 900}, {1920, 1080},
	{2560, 1440}, {3440, 1440}, {3840, 2160},
}
for _, resolution in ipairs(resolutions) do
	for _, inventoryScale in ipairs({0.8, 1, 1.25}) do
		for _, journal in ipairs({false, true}) do
			local screenWidth, screenHeight = resolution[1], resolution[2]
			local scale = math.max(0.75, math.min(2, screenWidth / 1920, screenHeight / 1080))
			local pageWidth = screenWidth * 0.67
			local backpackWidth = screenWidth * 0.28 * inventoryScale
			local available = pageWidth - backpackWidth - screenWidth * 0.016
			local width = (journal and available * 0.72 or available) - 16 * scale - 15
			local height = screenHeight * 0.78 - 50 * scale
			local layout = PLUGIN:GetEquipmentLayout(width, height, scale)
			local context = screenWidth .. "x" .. screenHeight .. " inventory scale " .. inventoryScale
			check(layout.footerHeight < height, context .. ": protection footer fits the page")
			check(#layout.footer == 5, context .. ": every protection type remains visible")
			check(#layout.cards == 15, context .. ": every equipment slot is laid out")

			for index, card in ipairs(layout.cards) do
				check(card.w > 0 and card.h > 0, context .. ": positive card size")
				check(card.x >= 0 and card.x + card.w <= width + 0.01, context .. ": card fits width")
				check(card.y + card.h <= layout.contentHeight, context .. ": card fits scroll content")
				for otherIndex = index + 1, #layout.cards do
					check(not overlaps(card, layout.cards[otherIndex]), context .. ": cards do not overlap")
				end
				for _, header in ipairs(layout.groups) do
					check(not overlaps(card, header), context .. ": cards do not cover group headings")
				end
			end

			for index, bar in ipairs(layout.footer) do
				check(bar.x + bar.w <= width + 0.01, context .. ": protection bar fits width")
				check(bar.y + bar.h <= layout.footerHeight, context .. ": protection bar fits footer")
				for otherIndex = index + 1, #layout.footer do
					check(not overlaps(bar, layout.footer[otherIndex]), context .. ": protection bars do not overlap")
				end
			end
		end
	end
end

local wide = PLUGIN:GetEquipmentLayout(900, 700, 1)
local narrow = PLUGIN:GetEquipmentLayout(280, 500, 0.75)
check(wide.cards[1].y == wide.cards[5].y, "Wide layouts show protection in one row")
check(wide.cards[9].y == wide.cards[15].y, "Wide layouts show devices in one row")
check(wide.cards[6].w > wide.cards[8].w, "Weapon slots get more space than the knife")
check(narrow.cards[5].y > narrow.cards[1].y, "Narrow layouts wrap protection")
check(narrow.cards[15].y > narrow.cards[9].y, "Narrow layouts wrap devices")
check(narrow.contentHeight > 500 - narrow.footerHeight, "Compact layouts scroll above the fixed footer")

local function loadClientMethod(signature, environment)
	local path = "gamemodes/ix_cotz/plugins/equipmentslots/cl_plugin.lua"
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()
	local first = assert(source:find(signature, 1, true))
	local last = assert(source:find("\nend", first, true)) + 3
	assert(load(source:sub(first, last), "@" .. path, "t", setmetatable(environment, {__index = _G})))()
end

local panelMethods = {}
PLUGIN.equipmentViews = setmetatable({}, {__mode = "k"})
local inventory = {vars = {cotzEquipmentWidth = 8}}
local inventoryPanel = {GetWide = function() return 420 end}
function inventoryPanel:SetZPos(value) self.z = value end
local environment = {
	PLUGIN = PLUGIN, PANEL = panelMethods, RIGHT = "right",
	IsValid = function(panel) return type(panel) == "table" and not panel.removed end,
	ScrW = function() return 1600 end,
	LocalPlayer = function()
		return {GetCharacter = function() return {GetInventory = function() return inventory end} end}
	end,
	ix = {gui = {menuInventoryFrame = inventoryPanel}},
}
loadClientMethod("function PANEL:UpdatePageLayout()", environment)
loadClientMethod("function PLUGIN:AttachInventoryEquipment(", environment)
loadClientMethod("function PLUGIN:MenuSubpanelCreated(", environment)

local function openYou(extraChildren)
	local page = {subpanelName = "you", GetWide = function() return 1200 end, GetTall = function() return 800 end}
	inventoryPanel.cotzEquipmentPanel = nil
	local children = {inventoryPanel}
	for _, child in ipairs(extraChildren or {}) do children[#children + 1] = child end
	function page:GetChildren() return children end
	function inventoryPanel:GetParent() return page end
	function inventoryPanel:GetName() return "ixStalkerInventoryPanel" end
	function page:Add()
		local panel = setmetatable({}, {__index = panelMethods})
		function panel:GetParent() return page end
		function panel:SetWide(width) self.width = width end
		function panel:SetZPos(value) self.z = value end
		function panel:Dock() end
		function panel:DockMargin() end
		function panel:Rebuild() end
		function panel:Remove() self.removed = true end

		return panel
	end
	PLUGIN:MenuSubpanelCreated("you", page)

	return PLUGIN.equipmentPanel
end

local direct = openYou({{GetName = function() return "DLabel" end}})
local switched = openYou()
check(not direct.hasJournal, "A title awaiting deferred removal is not a journal")
check(direct.width == switched.width, "Opening directly on You matches switching to You")
local stale = openYou({{removed = true}})
check(stale.width == switched.width, "Removed children cannot affect initial equipment width")
local journal = {GetName = function() return "ixCharacterJournalPanel" end}
function journal:SetZPos(value) self.z = value end
local withJournal = openYou({journal, {GetName = function() return "DLabel" end}})
check(withJournal.hasJournal and withJournal.width < switched.width, "A real journal still receives space")
check(inventoryPanel.z == 0 and withJournal.z == 1 and journal.z == 2, "Journal docking order is preserved")
print("Equipment layout: " .. checks .. " checks passed across 48 resolution/scale/journal combinations")
