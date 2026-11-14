-- Run from the repository root: luatex --luaonly tests/vendor_inspector_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local registry, methods, receivers = {}, {}, {}
registry.DFrame = {methods = {Think = function() end}}
local now, screenWidth, screenHeight, scale = 10, 1920, 1080, 1
local inventory, sent, confirmation, entry = {}, {}, nil, nil
local function lookup(class, key)
	local definition = registry[class]
	if definition then
		if definition.methods[key] then return definition.methods[key] end
		if definition.base then return lookup(definition.base, key) end
	end

	return methods[key]
end
local function create(class, parent)
	local object = setmetatable({ClassName = class, children = {}, visible = true, enabled = true,
		text = "", width = 100, height = 24}, {__index = function(_, key) return lookup(class, key) end})
	if parent then parent.children[#parent.children + 1] = object end
	if class == "ixVendorAdv" or class == "ixSherpaTrade" then
		object.lblTitle, object.btnClose = create("DLabel", object), create("DButton", object)
	end
	local init = lookup(class, "Init")
	if init then init(object) end

	return object
end
function methods:Add(class) return create(class, self) end
function methods:GetChildren() return self.children end
function methods:SetText(value) self.text = value end
function methods:GetText() return self.text end
function methods:SetTitle(value) self.title = value end
function methods:SetTall(value) self.height = value end
function methods:GetTall() return self.height end
function methods:SetWide(value) self.width = value end
function methods:GetWide() return self.width end
function methods:SetSize(width, height) self.width, self.height = width, height end
function methods:SetPos(x, y) self.x, self.y = x, y end
function methods:SetVisible(value) self.visible = value end
function methods:IsVisible() return self.visible end
function methods:SetEnabled(value) self.enabled = value end
function methods:IsEnabled() return self.enabled end
function methods:SetMaterial(value) self.material = value end
function methods:GetMaterial() return self.material end
function methods:LoadMaterial() end
function methods:PaintAt(x, y, width, height) self.drawn = {x, y, width, height} end
function methods:SetFont(value) self.font = value end
function methods:SetTextColor(value) self.color = value end
function methods:SetHelixTooltip(value) self.tooltip = value end
function methods:SizeToContentsY() self.height = 24 end
function methods:SizeToChildren() end
function methods:Remove()
	if self.removed then return end
	self.removed = true
	self:Clear()
	if self.OnRemove then self:OnRemove() end
end
function methods:Clear()
	for _, child in ipairs(self.children) do child:Remove() end
	self.children = {}
end
function methods:InvalidateLayout() end
function methods:GetVBar()
	if not self.bar then
		self.bar = create("DVScrollBar")
		self.bar.btnGrip = create("DButton")
	end

	return self.bar
end
for _, name in ipairs({"Dock", "DockMargin", "DockPadding", "SetPaintBackground", "SetWrap",
	"SetAutoStretchVertical", "SetContentAlignment", "SetSizable", "SetZPos", "SetKeepAspect",
	"SetMouseInputEnabled", "SetHideButtons", "InvalidateChildren", "MakePopup", "Center", "PerformLayout"}) do
	methods[name] = function() end
end
IsValid = function(value) return type(value) == "table" and not value.removed end
AccessorFunc = function(target, field, name)
	target["Set" .. name] = function(self, value) self[field] = value end
	target["Get" .. name] = function(self) return self[field] end
end
TOP, BOTTOM, LEFT, RIGHT, FILL, NODOCK = 1, 2, 3, 4, 5, 0
FORCE_BOOL = true
KEY_LSHIFT, KEY_RSHIFT, KEY_LCONTROL, KEY_RCONTROL, KEY_LALT, KEY_RALT = 79, 80, 83, 84, 81, 82
local heldKey, quickModifier
input = {IsKeyDown = function(key) return key == heldKey end}
Color = function(...) return {...} end
CurTime = function() return now end
ScrW, ScrH = function() return screenWidth end, function() return screenHeight end
isnumber = function(value) return type(value) == "number" end
SortedPairs = pairs
math.Clamp = function(value, low, high) return math.max(low, math.min(high, value)) end
surface = {SetFont = function() end, GetTextSize = function(text) return #text * 8, 20 end,
	CreateFont = function() end, SetDrawColor = function() end, DrawRect = function() end,
	DrawOutlinedRect = function() end, DrawLine = function() end}
vgui = {Create = create, Register = function(name, definition, base)
	registry[name] = {methods = definition, base = base}
end, GetControlTable = function(name) return registry[name].methods end}
net = {Receive = function(name, callback) receivers[name] = callback end,
	Start = function(name) sent[#sent + 1] = {name = name} end,
	WriteString = function(value) table.insert(sent[#sent], value) end,
	WriteUInt = function(value) table.insert(sent[#sent], value) end,
	WriteBool = function(value) table.insert(sent[#sent], value) end,
	WriteEntity = function(value) table.insert(sent[#sent], value) end,
	SendToServer = function() end}
local character = {GetInventory = function() return {GetItems = function() return inventory end} end,
	GetMoney = function() return 5000 end, HasMoney = function(_, amount) return amount <= 5000 end}
local currentCharacter = character
local player = {GetCharacter = function() return currentCharacter end,
	GetPos = function() return {DistToSqr = function() return 0 end} end}
LocalPlayer = function() return player end
ix = {gui = {}, item = {list = {}, instances = {}}, type = {number = 1},
	option = {Add = function() end, Get = function(key, default)
		if key == "vendorQuickTrade" then return quickModifier or default end
		return default
	end},
	currency = {Get = function(amount) return tostring(amount) .. " RU" end},
	util = {GetItemIcon = function(item) return "icon:" .. item.uniqueID end},
	hud = {PopulateItemTooltip = function() end},
	vendorStock = {FormatStock = function(count, maximum) return count .. "/" .. maximum end}}
dofile("gamemodes/ix_cotz/schema/libs/cl_cotzui.lua")
ix.cotzUI.GetScale = function() return scale end
ix.cotzUI.Scale = function(value) return value * scale end
ix.cotzUI.Query = function(_, _, _, callback) confirmation = callback end
ix.cotzUI.StringRequest = function(_, _, _, callback) entry = callback end
VENDOR_MODE, VENDOR_MAXSTOCK, VENDOR_STOCK, VENDOR_TASK_PROGRESS = 3, 4, 2, 8
VENDOR_BUYONLY, VENDOR_SELLONLY, VENDOR_SELLANDBUY = 3, 2, 1
local function item(id, uniqueID, title, data)
	return {id = id, uniqueID = uniqueID, GetID = function() return id end,
		GetName = function() return title end, GetDescription = function() return title .. " description" end,
		GetData = function(_, key, default) if data[key] ~= nil then return data[key] end return default end}
end
ix.item.list.rifle = item(nil, "rifle", "Rifle", {})
ix.item.list.medkit = item(nil, "medkit", "Medkit", {})
local ownedData = {condition = 63}
inventory[101] = item(101, "rifle", "Used rifle", ownedData)
ix.item.instances[101] = inventory[101]
local entity = {items = {rifle = {[VENDOR_MODE] = 1, [VENDOR_STOCK] = 2, [VENDOR_MAXSTOCK] = 3}},
	GetDisplayName = function() return "Trader" end,
	GetPrice = function(_, _, personal) return personal and 300 or 1200 end,
	GetBuyAll = function() return false end, GetClass = function() return "ix_hideout_vendor" end}
entity.GetPos = function() return {} end
dofile("gamemodes/ix_cotz/plugins/vendor_adv/derma/cl_vendor.lua")
local town = create("ixVendorAdv")
town:SetReadOnly(false)
town:Setup(entity)
check(town.stockTab.text == "Buy" and town.personalTab.text == "Sell", "Town traders use Buy/Sell tabs")
local row = town.sellingList.rifle
row:DoClick()
check(town.detailName.text == "Rifle" and town.vendorSell.enabled, "Catalogue selection enables purchasing")
local before = #sent
town:TradeSelected(false)
check(#sent == before + 1 and IsValid(row), "Sending a purchase keeps the row until server confirmation")
now = now + 1
town:Think()
check(town.selected == row and row.data.stock == 2,
	"A rejected purchase without stock updates keeps the selection and count")
check(sent[#sent][1] == "rifle" and sent[#sent][2] == 0 and sent[#sent][3] == false,
	"Catalogue purchases use definition ID and no instance")
town:SetTab("buying")
town.buyingList[101]:DoClick()
check(town.detailName.text == "Used rifle" and town.detailDescription.text:find("condition: 63", 1, true),
	"Selling inspects actual saved instance details")
now = now + 1
town:TradeSelected(true)
check(sent[#sent][2] == 101 and sent[#sent][3] == true and IsValid(town.buyingList[101]),
	"Sales send the precise instance and await synchronization")
town:SetTab("selling")
before = #sent
row:DoRightClick()
check(#sent == before, "Plain right click does not trade")
heldKey = KEY_LSHIFT
now = now + 1
row:DoRightClick()
check(#sent == before + 1 and sent[#sent][1] == "rifle" and sent[#sent][3] == false,
	"Shift right click purchases the clicked catalogue row")
row:DoRightClick()
check(#sent == before + 1, "Quick purchases retain the request cooldown")
now = now + 1
entity.items.rifle[VENDOR_STOCK] = 0
row:DoRightClick()
check(#sent == before + 1, "Quick purchases respect depleted stock")
entity.items.rifle[VENDOR_STOCK] = 2
town:SetReadOnly(true)
row:DoRightClick()
check(#sent == before + 1, "Read-only previews block quick trading")
town:SetReadOnly(false)
quickModifier = "Disabled"
row:DoRightClick()
check(#sent == before + 1, "The shortcut can be disabled")
quickModifier = "Ctrl"
row:DoRightClick()
check(#sent == before + 1, "A changed modifier rejects the default Shift key")
heldKey = KEY_RCONTROL
row:DoRightClick()
check(#sent == before + 2, "The configured modifier accepts the right-hand key")
quickModifier, heldKey = nil, KEY_RSHIFT
town:SetTab("buying")
now = now + 1
town.buyingList[101]:DoRightClick()
check(sent[#sent][2] == 101 and sent[#sent][3] == true,
	"Quick sales use the clicked personal instance with either Shift key")
heldKey = nil
town.activeSell = nil
town:SetTab("selling")
check(town.selected == nil, "Empty stock selection never falls through to the personal selection")
row:DoClick()
entity.items.rifle[VENDOR_STOCK] = 0
town:RefreshInspector()
check(not town.vendorSell.enabled, "Confirmed depletion disables purchasing")
entity.items.rifle[VENDOR_STOCK] = 2
town:RefreshInspector()
check(town.vendorSell.enabled, "Confirmed restock restores purchasing")
town:SetTab("buying")
town:SetReadOnly(true)
town:RefreshInspector()
check(not town.vendorBuy.enabled, "Editor preview disables sale actions")
before = #sent
town:TradeSelected(true)
check(#sent == before, "Read-only actions do not send trades")
town:SetReadOnly(false)
ownedData.equip = true
town:SyncPersonalItems()
town:RefreshInspector()
check(not town.buyingList[101] and not town.vendorBuy.enabled, "Equipping a selected instance clears its sale action")
ownedData.equip = false
town:SyncPersonalItems()
check(IsValid(town.buyingList[101]), "Newly eligible inventory instances appear without reopening")
inventory = {}
town:SyncPersonalItems()
town:RefreshInspector()
check(not town.buyingList[101], "Confirmed inventory removal removes the exact instance")
dofile("gamemodes/ix_cotz/plugins/sherpas/cl_trade.lua")
-- Capture the panel registered by the actual stock receiver, without requiring a network decoder.
local response = {entity, 7, "squad", "Squad", 1, 900, 5, 1, 2, 2,
	201, "rifle", "Named rifle", "condition: 43", 1500, 4,
	202, "medkit", "Stored medkit", "quantity: 1", 0, 1}
local cursor = 0
local function read() cursor = cursor + 1 return response[cursor] end
net.ReadEntity, net.ReadUInt, net.ReadString, net.ReadInt = read, read, read, read
receivers["cotz/sherpas/stock"]()
local sherpa = ix.gui.vendor
check(sherpa.ClassName == "ixSherpaTrade" and sherpa.personalTab.visible, "Squad officers have Stock/Donate tabs")
sherpa.sellingList[201]:DoClick()
check(sherpa.detailName.text == "Named rifle" and sherpa.detailDescription.text == "condition: 43",
	"Stock inspector displays server instance details without manufactured defaults")
for _, image in ipairs({row.icon, town.preview, sherpa.sellingList[201].icon, sherpa.preview}) do
	for _, texture in ipairs({{64, 64}, {512, 128}, {128, 512}, {64, 256}, {256, 64}}) do
		image.ActualWidth, image.ActualHeight = texture[1], texture[2]
		for _, bounds in ipairs({{44, 44}, {400, 100}, {80, 150}}) do
			image.drawn = nil
			image:Paint(bounds[1], bounds[2])
			local drawn = image.drawn
			check(drawn and drawn[1] >= 0 and drawn[2] >= 0
				and drawn[1] + drawn[3] <= bounds[1] + 0.001
				and drawn[2] + drawn[4] <= bounds[2] + 0.001,
				"Town and squad list/inspector icons stay inside both preview bounds")
			check(math.abs(drawn[3] / drawn[4] - texture[1] / texture[2]) < 0.001,
				"Wide, tall and square icons retain their aspect ratio")
			check(math.abs(drawn[1] * 2 + drawn[3] - bounds[1]) < 0.001
				and math.abs(drawn[2] * 2 + drawn[4] - bounds[2]) < 0.001,
				"Fitted icons remain centered in both previews")
		end
	end
end
check(sherpa.priceAction.visible and sherpa.recoverAction.enabled, "Officers have visible pricing and recovery")
sherpa.sellingList[202]:DoClick()
check(not sherpa.vendorSell.enabled and sherpa.recoverAction.enabled and not sherpa.unlistAction.enabled,
	"Unlisted stock permits recovery and pricing but cannot be purchased or unlisted again")
sherpa.sellingList[201]:DoClick()
sherpa:TradeSelected(false)
now = now + 1
confirmation()
check(sent[#sent][3] == 1 and sent[#sent][4] == 201 and sent[#sent][5] == 1500 and sent[#sent][6] == 4,
	"Purchase confirmation retains instance, quoted price and revision")
before, confirmation = #sent, nil
heldKey = KEY_LSHIFT
now = now + 1
sherpa.sellingList[202]:DoRightClick()
check(#sent == before, "Quick trading cannot purchase unlisted squad stock")
sherpa.sellingList[201]:DoRightClick()
check(#sent == before + 1 and not confirmation and sent[#sent][3] == 1
	and sent[#sent][4] == 201 and sent[#sent][5] == 1500 and sent[#sent][6] == 4,
	"Squad quick purchases bypass confirmation and retain instance, price and revision")
sherpa.sellingList[201]:DoRightClick()
check(#sent == before + 1, "Squad quick purchases retain the request cooldown")
heldKey = nil
sherpa:SetupStock(entity, 8, "squad", "Squad", 1, 900, 5, 1, 2, {
	{id = 201, uniqueID = "rifle", name = "Named rifle", description = "condition: 43", price = 1600, revision = 5}})
check(sherpa.selected == sherpa.sellingList[201] and sherpa.detailPrice.text:find("1600", 1, true),
	"Stock refresh preserves selection and updates price")
sherpa:EditSelectedPrice(false)
now = now + 1
entry("1750")
check(sent[#sent][3] == 3 and sent[#sent][5] == 1750 and sent[#sent][6] == 5,
	"Repricing uses the selected instance revision")
now = now + 1
sherpa:EditSelectedPrice(true)
check(sent[#sent][3] == 3 and sent[#sent][5] == 0, "Unlist sends a zero price")
inventory[101] = ix.item.instances[101]
inventory[102] = item(102, "medkit", "My medkit", {})
ix.item.instances[102] = inventory[102]
sherpa:SyncPersonalItems()
sherpa:SetTab("buying")
sherpa.buyingList[101]:DoClick()
before, confirmation = #sent, nil
heldKey = KEY_LSHIFT
now = now + 1
sherpa.buyingList[102]:DoRightClick()
check(#sent == before + 1 and not confirmation and sent[#sent][3] == 2 and sent[#sent][4] == 102,
	"Quick donations bypass confirmation and use the clicked instance rather than the old selection")
heldKey = nil
sherpa.buyingList[101]:DoClick()
sherpa:TradeSelected(true)
sherpa.buyingList[102]:DoClick()
now = now + 1
confirmation()
check(sent[#sent][3] == 2 and sent[#sent][4] == 101,
	"Donation confirmation sends the original instance even if selection changes")
sherpa:SetupStock(entity, 9, "squad", "Squad", 1, 900, 5, 1, 1, {})
check(sherpa.tab == "buying" and sherpa.selected == sherpa.buyingList[102],
	"Stock refresh preserves donation tab and selected personal item")
sherpa:SetupStock(entity, 9, "squad", "Squad", 0, 900, 5, 1, 1, {})
check(not sherpa.priceAction.visible and not sherpa.vendorSell.enabled,
	"Demotion and missing stock clear management actions")
sherpa:SetupStock(entity, 10, "squad", "Squad", -1, 0, 5, 1, 1, {})
sherpa:SetTab("buying")
check(not sherpa.personalTab.visible and sherpa.tab == "selling", "Visitors cannot enter the donation tab")
local function buttonNamed(parent, text)
	for _, child in ipairs(parent.children) do if child.text == text then return child end end
end
check(not buttonNamed(sherpa.managementTools, "Recent transactions"), "Visitors cannot see transaction history")
sherpa:SetupStock(entity, 11, "squad", "Squad", 1, 900, 5, 1, 1, {})
check(buttonNamed(sherpa.managementTools, "Recent transactions")
	and not buttonNamed(sherpa.managementTools, "Withdraw earnings"), "Officer history does not grant leader withdrawals")
sherpa:SetupStock(entity, 12, "squad", "Squad", 2, 900, 5, 1, 1, {})
check(buttonNamed(sherpa.managementTools, "Withdraw earnings"), "Leaders can access withdrawals")
for _, dimensions in ipairs({{1024, 768}, {1280, 720}, {1920, 1080}, {3440, 1440}, {3840, 2160}}) do
	screenWidth, screenHeight = dimensions[1], dimensions[2]
	for _, preference in ipairs({0.75, 1.1, 2}) do
		scale = math.Clamp(math.min(screenWidth / 1920, screenHeight / 1080), 0.75, 2) * preference
		sherpa:PostLayoutUpdate()
		check(sherpa.width <= screenWidth and sherpa.height <= screenHeight, "Trade frame remains inside the viewport")
		sherpa.body:PerformLayout(sherpa.width - 24 * scale, math.max(1, sherpa.height - 160 * scale))
		check(sherpa.inspector.width > 0 and sherpa.listPane.width > 0, "Both responsive panes retain positive width")
	end
end
currentCharacter = {}
now = now + 1
sherpa:Think()
check(sherpa.removed, "Character switches close the active stock session")
print("PASS: " .. checks .. " vendor inspector checks")
