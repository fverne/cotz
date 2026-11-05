-- Run from the repository root: luatex --luaonly tests/gear_rendering_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local function copy(value)
	if type(value) ~= "table" then return value end
	local result = {}
	for key, entry in pairs(value) do result[key] = copy(entry) end

	return result
end
table.Copy = copy
table.GetKeys = function(value)
	local result = {}
	for key in pairs(value) do result[#result + 1] = key end

	return result
end
local path = "gamemodes/ix_cotz/plugins/pac.lua"
local file = assert(io.open(path))
local source = file:read("*a"):gsub("!=", "~="):gsub("!", "not ")
file:close()
local now = 10
CurTime = function() return now end
IsValid = function(value) return type(value) == "table" and value.valid == true end
isfunction = function(value) return type(value) == "function" end
local players = {}
player = {Iterator = function() return ipairs(players) end}
local meta = {}
FindMetaTable = function() return meta end
CAMI = {RegisterPrivilege = function() end}
pace, pac = {}, {}
PLUGIN = {}
ix = {item = {list = {}}, util = {}}
net = {receivers = {}, sent = {}}
net.Receive = function(name, callback) net.receivers[name] = callback end
local data, cursor, message = {}, 1
net.Start = function(name) data, cursor, message = {}, 1, name end
for _, kind in ipairs({"Bool", "String", "UInt", "Entity", "Table"}) do
	net["Write" .. kind] = function(value) data[#data + 1] = value end
	net["Read" .. kind] = function() local value = data[cursor] cursor = cursor + 1 return value end
end
local function record(target)
	net.sent[#net.sent + 1] = {name = message, data = data, target = target}
end
net.Send, net.Broadcast, net.SendToServer = record, record, record
local function receive(name, values, client)
	data, cursor = values, 1
	net.receivers[name](0, client)
end
local serializations = 0
util = {AddNetworkString = function() end, TableToJSON = function()
	serializations = serializations + 1

	return "definition-v1"
end}
util.CRC = function(value)
	local hash = 0
	for index = 1, #value do hash = (hash * 31 + value:byte(index)) % 1000000007 end

	return tostring(hash)
end
dofile("gamemodes/ix_cotz/plugins/gearcustomization/sh_appearance.lua")
local item = {
	uniqueID = "helmet", id = 23, data = {gearAppearance = {skin = "black", bodygroups = {}}},
	width = 2, height = 2, model = "helmet.mdl",
	appearanceCustomization = {
		targets = {{1, 1}}, defaultSkin = "green", worldMaterialSlots = {0}, bodygroups = {},
		skins = {
			{id = "green", name = "Green", skin = 0, worldSkin = 0},
			{id = "black", name = "Black", skin = 1, worldSkin = 1, worldMaterials = {[0] = "black"}},
		},
	},
	pacData = {{self = {ClassName = "group", UniqueID = "shared"}, children = {
		{self = {ClassName = "model2", UniqueID = "shared", Model = "helmet.mdl", Skin = 0}, children = {}},
	}}},
}
function item:GetData(key, default) if self.data[key] == nil then return default end return self.data[key] end
function item:GetID() return self.id end
function item:GetModel() return self.model end
function item:GetMaterial() end
ix.item.list.helmet = item
local legacy = {uniqueID = "rifle", pacData = {{self = {UniqueID = "weapon"}, children = {}}}}
ix.item.list.rifle = legacy
local function wearer(index)
	local entity = setmetatable({valid = true, vars = {}, index = index, attached = {}, removed = {}}, {__index = meta})
	function entity:GetNetVar(key, default) return self.vars[key] or default end
	function entity:SetNetVar(key, value) self.vars[key] = copy(value) end
	function entity:EntIndex() return self.index end
	function entity:GetCharacter() return self.character end
	function entity:AttachPACPart(tree) self.attached[#self.attached + 1] = tree end
	function entity:RemovePACPart(tree) self.removed[#self.removed + 1] = tree end

	return entity
end
SERVER, CLIENT = true, false
assert(load(source, "@" .. path))()
local serverPlugin = PLUGIN
local owner = wearer(1)
players = {owner}
owner:AddPart("helmet", item)
check(owner:GetParts().helmet.itemID == 23, "Equipped state stores a per-instance appearance descriptor")
check(owner:GetParts().helmet.appearance.skin == "black", "Observers receive authoritative saved appearance")
local wearMessage = net.sent[#net.sent]
check(wearMessage.name == "ixPartWear" and wearMessage.data[3] == true and wearMessage.data[4] == 23,
	"The wear message encodes the descriptor with typed fields")
owner:AddPart("rifle", legacy)
check(owner:GetParts().rifle == true and net.sent[#net.sent].data[3] == false,
	"Legacy PAC items retain boolean state and their existing rendering path")
local observer = wearer(2)
local count = #net.sent
receive("cotz/gear-appearance/pac-ready", {}, observer)
check(#net.sent == count + 2 and net.sent[#net.sent].target == observer,
	"Readiness sends the current worn state to a late-joining client")
receive("cotz/gear-appearance/pac-ready", {}, observer)
check(#net.sent == count + 2, "Late-join synchronization is rate limited")
local character = {GetInventory = function() return {GetItems = function() return {[23] = item} end} end}
item.data.equip = true
serverPlugin:PlayerLoadedCharacter(owner, character)
check(owner:GetParts().helmet.itemID == 23 and not owner:GetParts().rifle,
	"Character loading resets old parts and restores equipped instance descriptors")
owner.character = character
serverPlugin:OnPlayerObserve(owner, true)
check(next(owner:GetParts()) == nil, "Entering observer removes worn visuals")
serverPlugin:OnPlayerObserve(owner, false)
check(owner:GetParts().helmet.itemID == 23, "Exiting observer restores instance appearance")

SERVER, CLIENT = false, true
PLUGIN = {}
local hooks, timers = {}, {}
hook = {Add = function(event, id, callback) hooks[id] = callback end, Remove = function(_, id) hooks[id] = nil end}
timer = {Simple = function(delay, callback) timers[#timers + 1] = {delay = delay, callback = callback} end}
concommand = {Add = function() end}
pac.SetupENT = function(entity)
	entity.pac_owner = "self"
	if not entity.AttachPACPart then entity.AttachPACPart = meta.AttachPACPart end
	if not entity.RemovePACPart then entity.RemovePACPart = meta.RemovePACPart end
end
assert(load(source, "@" .. path))()
PLUGIN:InitializedPlugins()
local viewer = wearer(10)
pac.LocalPlayer = viewer
players = {viewer}
hooks.ix_pacupdate()
check(not hooks.ix_pacupdate and net.sent[#net.sent].name == "cotz/gear-appearance/pac-ready",
	"The client requests a snapshot once PAC is ready without a recurring scan")
local function show(entity, id, appearance)
	local values = {entity, "helmet", true, id, appearance, 0}
	receive("ixPartWear", values)
end
show(viewer, 23, "black")
local firstTree = viewer.attached[#viewer.attached]
check(firstTree[1].children[1].self.Skin == 1, "Client visuals use replicated state without an inventory instance")
check(firstTree[1].self.UniqueID ~= firstTree[1].children[1].self.UniqueID,
	"Duplicate legacy IDs in one outfit become distinct part identities")
show(viewer, 23, "green")
check(viewer.removed[#viewer.removed] == firstTree, "Changing appearance removes the exact previously attached tree")
local secondTree = viewer.attached[#viewer.attached]
receive("ixPartRemove", {viewer, "helmet"})
check(viewer.removed[#viewer.removed] == secondTree, "Unequipping removes the instance tree, not a shared definition")
local another = wearer(11)
show(viewer, 23, "black")
show(another, 24, "green")
check(viewer.attached[#viewer.attached][1].self.UniqueID ~= another.attached[1][1].self.UniqueID,
	"Players wearing copies of one item type have isolated parts")
check(item.pacData[1].self.UniqueID == "shared" and item.pacData[1].children[1].self.Skin == 0,
	"Replicated appearances never alter the shared item definition")
receive("ixPartWear", {viewer, "rifle", false})
check(viewer.attached[#viewer.attached] == legacy.pacData, "Legacy weapon PAC data remains untouched")
receive("ixPartReset", {viewer, {helmet = true, rifle = true}})
check(viewer.removed[#viewer.removed] ~= nil, "Reset removes mixed legacy and customized parts")
local delayed = wearer(12)
delayed.AttachPACPart = false
show(delayed, 25, "black")
local attachCount = #delayed.attached
receive("ixPartRemove", {delayed, "helmet"})
timers[#timers].callback()
check(#delayed.attached == attachCount, "A delayed PAC setup cannot reattach already removed gear")
receive("ixPartWear", {{valid = false}, "helmet", true, 23, "black", 0})
check(timers[#timers].delay == 5.1, "Missing late-join entities schedule a bounded snapshot retry")
count = #net.sent
timers[#timers].callback()
check(#net.sent == count + 1, "The snapshot retry requests fresh current state")

PLUGIN = {}
local entity = {skin = 7, material = "original", materials = {[0] = "old"}}
function entity:GetSkin() return self.skin end
function entity:SetSkin(value) self.skin = value end
function entity:GetSubMaterial(index) return self.materials[index] or "" end
function entity:SetSubMaterial(index, value) self.materials[index] = value end
local rendered
ikon = {cache = {}, renderEntity = entity}
function ikon:GetIcon(name) return self.cache[name] end
function ikon:renderHook() rendered = {skin = entity.skin, material = entity.materials[0]} end
function ikon:renderIcon(name)
	self:renderHook()
	self.cache[name] = name
end
dofile("gamemodes/ix_cotz/plugins/gearcustomization/cl_icons.lua")
PLUGIN:InstallIconRenderer()
local blackIcon = ix.gearAppearance.GetIcon(item)
check(rendered.skin == 1 and rendered.material == "black", "Icons render the selected ground-model appearance")
check(entity.skin == 7 and entity.materials[0] == "old", "Icon rendering restores shared renderer state")
item.data.gearAppearance = {skin = "green", bodygroups = {}}
local greenIcon = ix.gearAppearance.GetIcon(item)
check(blackIcon ~= greenIcon, "Appearance-specific cache keys prevent shared-type icon contamination")
rendered = nil
check(ix.gearAppearance.GetIcon(item) == greenIcon and rendered == nil, "Existing appearance icons reuse the cache")
ikon:renderHook()
check(rendered.skin == 7 and rendered.material == "old", "Unrelated icons retain original renderer behavior")
ix.util.GetMaterial = function(value) return "image:" .. value end
dofile("gamemodes/ix_cotz/schema/libs/sh_iconhelper.lua")
item.data.img = "custom/image.png"
check(ix.util.GetItemIcon(item) == "image:custom/image.png", "Explicit image overrides retain priority")
item.data.img = nil
check(ix.util.GetItemIcon(item) == greenIcon, "Backpack and equipment icons share the same appearance cache")
check(serializations == 1, "Repeated icon paints serialize the shared definition only once")
print("Gear rendering: " .. checks .. " checks passed")
