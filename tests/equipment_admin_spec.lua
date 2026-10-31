-- Run from the addon root: luatex --luaonly tests/equipment_admin_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local allowed = true
local pending = false
local transfers = 0
local unequips = 0
local hasRoom = true
local transferAllowed = true
local packets = 0
IsValid = function(value) return type(value) == "table" and value.valid ~= false end
util = {AddNetworkString = function() end}
net = {Receive = function() end}
PLUGIN = {}
ix = {type = {character = 1}, char = {loaded = {}}, item = {instances = {}}, command = {}}
ix.command.Add = function() end
ix.command.HasAccess = function() return allowed end
local inventory = {items = {}}
function inventory:GetID() return 1 end
function inventory:GetItemByID(id) return self.items[id] end
local destination = {}
function destination:GetID() return 2 end
function destination:FindEmptySlot() if hasRoom then return 1, 1 end end
local owner = {Notify = function() end}
local target = {GetInventory = function() return inventory end, GetName = function() return "Target" end}
function target:GetPlayer() return owner end
function owner:GetCharacter() return target end
local character = {GetInventory = function() return destination end}
local client = {Notify = function() end, NotifyLocalized = function() end, Name = function() return "Admin" end}
function client:GetCharacter() return character end
ix.char.loaded[3] = target
local item = {id = 4, invID = 1, width = 1, height = 1, gridX = 1, functions = {EquipUn = {}}}
function item:GetData() return self.equipped end
function item:GetName() return "Item" end
function item:Transfer(id, x, y, actor)
	transfers = transfers + 1
	check(id == 2 and x == 1 and y == 1 and actor == client, "Take uses the admin's main backpack")
	if not transferAllowed then return false, "notAllowed" end
	inventory.items[self.id] = nil
	self.invID = id

	return true
end
inventory.items[4] = item
ix.item.instances[4] = item
ix.item.PerformInventoryAction = function(actor, action, id, inventoryID)
	check(actor == owner and action == "EquipUn" and id == 4 and inventoryID == 1,
		"Unequip uses the target's normal authoritative item action")
	unequips = unequips + 1
end
dofile("gamemodes/ix_cotz/plugins/equipmentslots/sv_admin.lua")
function PLUGIN:GetPending() return pending end
function PLUGIN:IsEquipmentCell(x) return x >= 32 end
function PLUGIN:QueueRefresh() end
function PLUGIN:SendAdminInventory() packets = packets + 1 end
allowed = false
PLUGIN:TakeAdminItem(client, 3, 4)
check(transfers == 0, "A forged non-admin request is rejected")
allowed = true
PLUGIN:TakeAdminItem(client, 3, 99)
check(transfers == 0, "Foreign and removed item IDs are rejected")
owner.valid = false
PLUGIN:TakeAdminItem(client, 3, 4)
check(transfers == 0, "Disconnected targets are rejected")
owner.valid = true
local savedTarget = target
function owner:GetCharacter() return {} end
PLUGIN:TakeAdminItem(client, 3, 4)
check(transfers == 0, "Targets who switched characters are rejected")
function owner:GetCharacter() return savedTarget end
hasRoom = false
PLUGIN:TakeAdminItem(client, 3, 4)
check(transfers == 0 and inventory.items[4] == item, "A full backpack leaves the item with its owner")
hasRoom = true
pending = true
PLUGIN:TakeAdminItem(client, 3, 4)
check(transfers == 0, "Pending equipment actions block taking an item")
pending = false
item.equipped = true
PLUGIN:TakeAdminItem(client, 3, 4)
check(unequips == 1 and transfers == 0, "Equipped items are unequipped before taking, including delayed actions")
item.equipped = false
transferAllowed = false
PLUGIN:TakeAdminItem(client, 3, 4)
check(transfers == 1 and inventory.items[4] == item, "A transfer veto leaves the original item intact")
transferAllowed = true
PLUGIN:TakeAdminItem(client, 3, 4)
check(transfers == 2 and inventory.items[4] == nil and packets == 2, "Successful take refreshes the item list")
PLUGIN:TakeAdminItem(client, 3, 4)
check(transfers == 2, "Repeated requests cannot take the same instance twice")
print("Equipment admin: " .. checks .. " checks passed")
