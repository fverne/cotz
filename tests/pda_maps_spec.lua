-- Run from the repository root: luatex --luaonly tests/pda_maps_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

function IsValid(value) return type(value) == "table" and value.valid == true end
function table.Copy(value)
	local copy = {}
	for key, entry in pairs(value) do
		copy[key] = type(entry) == "table" and table.Copy(entry) or entry
	end

	return copy
end

local now = 10
function CurTime() return now end
local configs = {}
ix = {
	config = {
		Add = function(key, value) configs[key] = value end,
		Get = function(key, default) return configs[key] or default end,
	},
	lang = {AddTable = function() end},
}
PLUGIN = {}
local plugin = PLUGIN
local base = "gamemodes/ix_cotz/plugins/pda/"
dofile(base .. "sh_maps.lua")
dofile(base .. "sv_maps.lua")
dofile(base .. "cl_maps.lua")
ITEM = {functions = {}}
dofile(base .. "items/base/sh_mapusb.lua")
local action = ITEM.functions.Install
-- Delayed callbacks must retain the owning plugin after Helix replaces the loader global.
PLUGIN = {}

local function pda(id, equipped)
	local item = {id = id, isPDA = true, data = {equip = equipped}}
	function item:GetData(key, default)
		if self.data[key] == nil then return default end

		return self.data[key]
	end
	function item:SetData(key, value)
		self.data[key] = value
		self.saved = table.Copy(self.data)
	end

	return item
end

local items = {}
local inventory = {}
function inventory:GetItems() return items end
function inventory:GetItemByID(id) return items[id] end
local character = {GetInventory = function() return inventory end}
local client = {valid = true, GetCharacter = function() return character end}
function client:Notify(message) self.notification = message end
function LocalPlayer() return client end
local usb = {id = 1, player = client, mapID = "swamps"}
items[usb.id] = usb
local device = pda(2, false)
items[device.id] = device

check(not action.OnCanRun(usb), "Detached PDA cannot install maps")
check(action.OnRun(usb) == false, "Server rejects detached PDA and retains USB")
device.data.equip = true
check(action.OnCanRun(usb), "Equipped PDA accepts map USB")
items[usb.id] = nil
check(action.OnRun(usb) == false, "USB from another inventory is rejected server-side")
items[usb.id] = usb
usb.entity = {valid = true}
check(action.OnRun(usb) == false, "World USB cannot be installed remotely")
usb.entity = nil
usb.mapID = "unknown"
check(action.OnRun(usb) == false, "Unknown map cannot be installed")
usb.mapID = "swamps"
character = nil
check(action.OnRun(usb) == false, "Character switching invalidates action")
character = {GetInventory = function() return inventory end}
local tabs = {}
plugin:CreateMenuButtons(tabs)
check(tabs.maps == nil, "Maps tab is absent before installing a map")

check(action.OnRun(usb) == true, "Successful action permits Helix to consume the USB")
check(device.data.cotzMaps.swamps and device.saved.cotzMaps.swamps, "Map is persisted on the equipped PDA")
check(client.notification:find("Swamps", 1, true), "Installation confirms the map")
check(not action.OnCanRun(usb), "Already installed map hides the install action")
check(action.OnRun(usb) == false, "Repeated request retains a duplicate USB")
plugin:CreateMenuButtons(tabs)
check(type(tabs.maps) == "function", "Installed map enables Maps tab")

local replacement = pda(3, true)
items[device.id] = nil
items[replacement.id] = replacement
check(#plugin:GetInstalledMaps(client) == 0, "A replacement PDA does not inherit another device's maps")
check(action.OnRun(usb) == false, "Rapid install into another device is rate-limited")
now = now + 1
check(action.OnRun(usb) == true, "A later install into a different PDA succeeds")
device.data = table.Copy(device.saved)
items[replacement.id] = nil
items[device.id] = device
check(plugin:GetInstalledMaps(client)[1].id == "swamps", "Restored PDA data preserves installed maps")
device.data.equip = false
check(#plugin:GetInstalledMaps(client) == 0, "Detaching PDA removes map access")
device.data.equip = true
local recipientInventory = {GetItems = function() return {[device.id] = device} end}
local recipientCharacter = {GetInventory = function() return recipientInventory end}
local recipient = {valid = true, GetCharacter = function() return recipientCharacter end}
items[device.id] = nil
check(#plugin:GetInstalledMaps(client) == 0, "Original owner loses maps after transferring the PDA")
check(plugin:GetInstalledMaps(recipient)[1].id == "swamps", "Map access follows PDA inventory ownership")
items[device.id] = device
plugin.maps.garbage = {name = "Garbage", urlConfig = "pdaMapGarbageURL"}
usb.mapID = "garbage"
now = now + 1
check(action.OnRun(usb) == true, "Additional map USB installs into the same PDA")
check(device.data.cotzMaps.swamps and device.data.cotzMaps.garbage, "Installing another map preserves prior maps")
local collection = plugin:GetInstalledMaps(client)
check(#collection == 2 and collection[1].id == "garbage", "Installed map choices are sorted by name")
device.data.cotzMaps.unknown = true
check(#plugin:GetInstalledMaps(client) == 2, "Unknown saved map IDs are not displayed")
plugin.maps.garbage = nil
usb.mapID = "swamps"

check(configs.pdaMapSwampsURL:find("cotz_swamp.png", 1, true), "Supplied Swamps image is the default")
check(plugin:BuildMapHTML("") == nil, "Blank image URL uses the empty state")
check(plugin:BuildMapHTML("javascript:alert(1)") == nil, "Non-image URL schemes are rejected")
check(plugin:BuildMapHTML("https://example.org/map\n.png") == nil, "Control whitespace is rejected")
local html = plugin:BuildMapHTML("https://example.org/map.png?a=1&b=2\"<img>")
check(html:find("&amp;b=2&quot;&lt;img&gt;", 1, true), "URL is escaped as an HTML attribute")
check(html:find("object-fit: contain", 1, true), "Map keeps its aspect ratio while resizing")
check(html:find("default-src 'none'", 1, true), "Viewer restricts remote resources to images")

local image, selector, status
local container = {}
function container:Add(class)
	local panel = {}
	function panel:Dock() end
	function panel:SetVisible(value) self.visible = value end
	if class == "DHTML" then
		image = panel
		function panel:SetAllowLua(value) self.allowLua = value end
		function panel:SetHTML(value) self.html = value end
	else
		selector = panel
		function panel:AddChoice(name, id) self.choice = {name, id} end
		function panel:ChooseOptionID() self:OnSelect(1, self.choice[1], self.choice[2]) end
	end

	return panel
end
ix.cotzUI = {
	StyleCombo = function(panel) return panel end,
	SetHeight = function() end,
	Label = function()
		status = {}
		function status:SetText(value) self.text = value end
		function status:SetVisible(value) self.visible = value end

		return status
	end,
}
plugin:PopulateMapMenu(container)
check(image.allowLua == false and image.visible, "Image viewer disables Lua and displays installed map")
check(image.html:find("cotz_swamp.png", 1, true), "Map selection uses its configured URL")
configs.pdaMapSwampsURL = "https://example.org/replacement.png"
selector:OnSelect(1, "Swamps", "swamps")
check(image.html:find("replacement.png", 1, true), "Config edits change the selected image")
configs.pdaMapSwampsURL = ""
selector:OnSelect(1, "Swamps", "swamps")
check(not image.visible and status.visible, "Blank config displays a readable empty state")

print("PDA maps checks passed: " .. checks)
