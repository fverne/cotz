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
local function newCharacter()
	local value = {data = {}, GetInventory = function() return inventory end}
	function value:GetData(key, default) return self.data[key] or default end
	function value:SetData(key, entry)
		self.data[key] = entry
		self.saved = table.Copy(self.data)
	end

	return value
end
local character = newCharacter()
local client = {valid = true, GetCharacter = function() return character end}
function client:Notify(message) self.notification = message end
function LocalPlayer() return client end
local usb = {id = 1, player = client, mapID = "swamps"}
items[usb.id] = usb
local device = pda(2, false)
items[device.id] = device

check(action.name == "Add to Maps", "Right-click action names the main menu destination")
check(action.OnCanRun(usb), "Map USB works without an equipped PDA")
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
character = newCharacter()
local tabs = {}
plugin:CreateMenuButtons(tabs)
check(tabs.maps == nil, "Maps tab is absent before installing a map")

check(action.OnRun(usb) == true, "Successful action permits Helix to consume the USB")
check(character.data.cotzMaps.swamps and character.saved.cotzMaps.swamps, "Map is persisted on the character")
check(client.notification:find("Swamps", 1, true), "Installation confirms the map")
check(not action.OnCanRun(usb), "Already installed map hides the install action")
check(action.OnRun(usb) == false, "Repeated request retains a duplicate USB")
plugin:CreateMenuButtons(tabs)
check(type(tabs.maps) == "function", "Installed map enables Maps tab")

items[device.id] = nil
check(plugin:GetInstalledMaps(client)[1].id == "swamps", "Removing the PDA preserves map access")
local owner = character
character = newCharacter()
check(#plugin:GetInstalledMaps(client) == 0, "Another character does not inherit unlocked maps")
character = owner
character.data = table.Copy(character.saved)
check(plugin:GetInstalledMaps(client)[1].id == "swamps", "Restored character retains map access")
plugin.maps.legacy = {name = "Legacy"}
device.data.cotzMaps = {legacy = true}
items[device.id] = device
plugin:PlayerLoadedCharacter(client, character)
check(character.data.cotzMaps.legacy and character.data.cotzMaps.swamps,
	"Legacy PDA maps merge without replacing character unlocks")
plugin:PlayerLoadedCharacter(client, character)
check(character.data.cotzMaps.legacy, "Legacy migration is repeatable")
plugin.maps.legacy = nil
plugin.maps.garbage = {name = "Garbage", urlConfig = "pdaMapGarbageURL"}
usb.mapID = "garbage"
check(action.OnRun(usb) == false, "Rapid map unlock is rate-limited")
now = now + 1
check(action.OnRun(usb) == true, "Additional map USB unlocks another character map")
check(character.data.cotzMaps.swamps and character.data.cotzMaps.garbage, "Installing another map preserves prior maps")
local collection = plugin:GetInstalledMaps(client)
check(#collection == 2 and collection[1].id == "garbage", "Installed map choices are sorted by name")
character.data.cotzMaps.unknown = true
check(#plugin:GetInstalledMaps(client) == 2, "Unknown saved map IDs are not displayed")
plugin.maps.garbage = nil
usb.mapID = "swamps"

check(configs.pdaMapSwampsURL:find("cotz_swamp.png", 1, true), "Supplied Swamps image is the default")
Schema = {folder = "ix_cotz"}
local disk, requests = {}, {}
file = {
	Read = function(path) return disk[path] end,
	Write = function(path, value) disk[path] = value end,
	CreateDir = function() end,
}
util = {
	SHA256 = function(url) return url:gsub("[^%w]", "_") end,
	Base64Encode = function() return "aW1hZ2U=" end,
}
http = {Fetch = function(url, success, failure)
	requests[#requests + 1] = {url = url, success = success, failure = failure}
end}
local result
local function receive(html) result = html end
plugin:LoadMapImage("test", "", receive)
check(result == nil and #requests == 0, "Blank URL does not fetch")
plugin:LoadMapImage("test", "javascript:alert(1)", receive)
check(#requests == 0, "Non-HTTP URL does not fetch")
plugin:LoadMapImage("test", "https://example.org/map.png", receive)
plugin:LoadMapImage("test", "https://example.org/map.png", receive)
check(#requests == 1, "Concurrent viewers share a request")
requests[1].success("image", 5, {["Content-Type"] = "image/webp"}, 200)
check(result:find("data:image/webp;base64,", 1, true), "Image is embedded locally with its format")
check(result:find("object-fit: contain", 1, true), "Map retains aspect ratio")
plugin:LoadMapImage("test", "https://example.org/map.png", receive)
check(#requests == 1, "Memory cache avoids repeat downloads")
dofile(base .. "cl_maps.lua")
plugin:LoadMapImage("test", "https://example.org/map.png", receive)
check(#requests == 1, "Disk cache survives client script reload")
plugin:LoadMapImage("test", "https://example.org/map.png?v=2", receive)
check(#requests == 2, "Changed URL downloads an updated image")
requests[2].success("error", 5, {}, 404)
check(result == nil, "HTTP errors are not cached")
plugin:LoadMapImage("test", "https://example.org/map.png?v=2", receive)
check(#requests == 3, "Failed downloads can be retried")
requests[3].failure("unavailable")

local image, selector, status
local container = {}
function container:Add(class)
	local panel = {valid = true}
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
check(image.allowLua == false and not image.visible, "Viewer disables Lua while loading")
local oldRequest = requests[#requests]
configs.pdaMapSwampsURL = "https://example.org/replacement.png"
selector:OnSelect(1, "Swamps", "swamps")
oldRequest.success("image", 5, {}, 200)
check(not image.visible, "Stale download cannot replace the selected map")
requests[#requests].success("image", 5, {}, 200)
check(image.visible and image.html:find("data:image/", 1, true), "Selected map displays cached data")
configs.pdaMapSwampsURL = ""
selector:OnSelect(1, "Swamps", "swamps")
check(not image.visible and status.visible, "Blank config displays a readable empty state")
configs.pdaMapSwampsURL = "https://example.org/closed.png"
selector:OnSelect(1, "Swamps", "swamps")
image.valid = false
requests[#requests].success("image", 5, {}, 200)
check(not image.visible, "Closing the menu safely ignores download completion")

print("PDA maps checks passed: " .. checks)
