-- Run from the addon root: luatex --luaonly tests/equipment_slots_spec.lua
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end

local function readSource(path)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()

	return source
end

local function loadMethod(path, signature, target)
	local source = readSource(path)
	local first = assert(source:find(signature, 1, true))
	local last = assert(source:find("\nend", first, true)) + 3
	local method = source:sub(first, last):gsub("!=", "~="):gsub("!", "not ")
	if signature == "function META:CanItemFit(" then
		method = method:gsub("continue", "goto nextFitCell")
		method = method:gsub("\n\t\tend\n\n\t\tif %(not canFit%)", "\n\t\t\t::nextFitCell::\n\t\tend\n\n\t\tif (not canFit)")
	end
	assert(not method:find("continue", 1, true))
	assert(load(method, "@" .. path, "t", setmetatable(target, {__index = _G})))()
end

SERVER = true
CLIENT = false
isnumber = function(value) return type(value) == "number" end
isfunction = function(value) return type(value) == "function" end
istable = function(value) return type(value) == "table" end
isentity = function() return false end
IsValid = function(value) return type(value) == "table" and value.valid == true end
local now = 0
CurTime = function() return now end
local timers = {}
timer = {Simple = function(delay, callback) timers[#timers + 1] = {time = now + delay, callback = callback} end}
local function advance(seconds)
	local finish = now + seconds

	while true do
		local nextIndex
		for index, entry in ipairs(timers) do
			if entry.time <= finish and (not nextIndex or entry.time < timers[nextIndex].time) then
				nextIndex = index
			end
		end
		if not nextIndex then break end
		local entry = table.remove(timers, nextIndex)
		now = entry.time
		entry.callback()
	end

	now = finish
end

local queries = {}
mysql = {Update = function(_, name)
	local query = {tableName = name, fields = {}}
	function query:Update(key, value) self.fields[key] = value end
	function query:Where(key, value) self.where = {key, value} end
	function query:Execute() queries[#queries + 1] = self end

	return query
end}
local receivers = {}
local reads = {}
local packets = {}
net = {
	Receive = function(name, callback) receivers[name] = callback end,
	Start = function(name) packets[#packets + 1] = name end,
	WriteUInt = function() end, WriteBool = function() end, Send = function() end,
	ReadUInt = function() return table.remove(reads, 1) end,
	ReadBool = function() return table.remove(reads, 1) end,
}
util = {AddNetworkString = function() end, TableToJSON = function() return "saved-data" end}
local blocked = {}
hook = {Run = function(name) return blocked[name] end}
table.Merge = function(target, source) for key, value in pairs(source) do target[key] = value end end
table.HasValue = function(values, target)
	for _, value in pairs(values) do if value == target then return true end end

	return false
end

local inventoryMeta = {}
local itemMeta = {}
itemMeta.__index = itemMeta
inventoryMeta.__index = inventoryMeta
ix = {meta = {inventory = inventoryMeta, item = itemMeta}, item = {inventories = {}, instances = {}, list = {}}}
ix.inventory = {}
ix.util = {Include = function(path)
	if path:sub(1, 3) == "sv_" then dofile("gamemodes/ix_cotz/plugins/equipmentslots/" .. path) end
end}
local inventoryPath = "gamemodes/helix/gamemode/core/meta/sh_inventory.lua"
for _, method in ipairs({
	"GetID", "GetSize", "SetSize", "GetItems", "GetItemByID", "GetItemAt", "GetBags",
	"CanItemFit", "FindEmptySlot", "Remove", "Iter",
}) do
	loadMethod(inventoryPath, "function META:" .. method .. "(", {META = inventoryMeta, ix = ix})
end
function inventoryMeta:GetReceivers() return self.client and {self.client} or {} end
function inventoryMeta:Sync() self.syncs = (self.syncs or 0) + 1 end
function inventoryMeta:OnCheckAccess(client) return self.client == client end
function inventoryMeta:Add() return "original-add" end
local function newInventory(id, width, height)
	local inventory = setmetatable({id = id, w = width or 8, h = height or 6, vars = {}, slots = {}}, inventoryMeta)
	ix.item.inventories[id] = inventory

	return inventory
end
local restoredRows = {}
local restoreCalls = 0
function ix.inventory.Restore(ids, width, height, callback)
	restoreCalls = restoreCalls + 1
	local dimensions = istable(ids) and ids or {[ids] = {width, height}}

	for id, size in pairs(dimensions) do
		local inventory = newInventory(id, size[1], size[2])
		for _, item in ipairs(restoredRows[id] or {}) do
			if item.gridX <= inventory.w and item.gridY <= inventory.h then
				inventory.slots[item.gridX] = inventory.slots[item.gridX] or {}
				inventory.slots[item.gridX][item.gridY] = item
			end
		end
		if callback then callback(inventory) end
	end
end
function itemMeta:GetData(key, default)
	if self.data[key] == nil then return default end

	return self.data[key]
end
function itemMeta:SetData(key, value) self.data[key] = value end
function itemMeta:GetPlayerID() end
function itemMeta:GetCharacterID() end
function itemMeta:Remove() self.removed = true end
function itemMeta:GetWeight() return self.weight or 0 end
unpack = table.unpack
loadMethod("gamemodes/helix/gamemode/core/meta/sh_item.lua", "function ITEM:Call(", {ITEM = itemMeta})
local itemSource = readSource("gamemodes/helix/gamemode/core/libs/sh_item.lua")
local actionStart = assert(itemSource:find("function ix.item.PerformInventoryAction(", 1, true))
local actionEnd = assert(itemSource:find("\n\t\tlocal function NetworkInventoryMove", actionStart, true)) - 1
local actionSource = itemSource:sub(actionStart, actionEnd):gsub("!=", "~="):gsub("!", "not ")
assert(load(actionSource, "@helix/item-action", "t", _G))()
function ix.util.PlayerPerformBlackScreenAction(client, _, duration, callback)
	client.blackScreen = true
	timer.Simple(duration, function()
		if not client.blackScreen then return end
		client.blackScreen = nil
		callback(client)
	end)
end

PLUGIN = {}
dofile("gamemodes/ix_cotz/plugins/equipmentslots/sh_plugin.lua")
local plugin = PLUGIN
plugin:InitializedPlugins()
local inventory = newInventory(1)
local character = {GetInventory = function() return inventory end, CanRemoveCarry = function() return true end}
local client = {valid = true, notices = {}}
function client:GetCharacter() return self.character or character end
function client:Alive() return not self.dead end
function client:GetNetVar() return self.blackScreen end
function client:Notify(message) self.notices[#self.notices + 1] = message end
function client:SteamID64() return "test-player" end
function character:GetID() return 1 end
inventory.client = client
plugin:OnCharacterCreated(client, character)
local function place(item, x, y)
	item.gridX, item.gridY, item.invID = x, y, inventory.id
	for column = x, x + item.width - 1 do
		inventory.slots[column] = inventory.slots[column] or {}
		for row = y, y + item.height - 1 do inventory.slots[column][row] = item end
	end
end
local nextID = 10
local function newItem(fields, x, y)
	nextID = nextID + 1
	local item = setmetatable(fields or {}, itemMeta)
	item.id, item.data = nextID, item.data or {}
	item.uniqueID = "test-item-" .. item.id
	item.width, item.height = item.width or 2, item.height or 2
	item.hooks, item.postHooks, item.functions = {}, {}, {}
	for _, action in ipairs({"Equip", "EquipUn"}) do
		local equipping = action == "Equip"
		item.functions[action] = {
			OnCanRun = function(target)
				return target.invID == target.player:GetCharacter():GetInventory():GetID()
					and (target:GetData("equip") == true) ~= equipping
			end,
			OnRun = function(target)
				local function finish(player)
					check(target.player == player, "Delayed callbacks keep their item player context")
					target:SetData("equip", equipping)
					target.effects = (target.effects or 0) + 1
				end
				if target.delayed then
					ix.util.PlayerPerformBlackScreenAction(target.player, "Equipment", 4, finish)
				else
					finish(target.player)
				end

				return false
			end,
		}
		item.postHooks[action] = function(target) target.postCalls = (target.postCalls or 0) + 1 end
	end
	item.functions.Inspect = {OnRun = function(target) target.inspected = true return false end}
	ix.item.instances[item.id] = item
	place(item, x or 1, y or 1)

	return item
end
local function perform(item, action)
	advance(0.3)

	return ix.item.PerformInventoryAction(client, action, item.id, inventory.id)
end

local helmet = newItem({isHelmet = true, isGasmask = true, weight = 3})
check(perform(helmet, "Equip") == false, "Bundled dispatcher action result is preserved")
check(helmet.data.equip and helmet.invID == 1 and plugin:IsEquipmentCell(helmet.gridX), "Equip keeps inventory ID")
check(inventory:GetItemAt(1, 1) == nil, "Equipping frees the original backpack cells")
check(inventory:GetItemByID(helmet.id, true) == helmet, "Main-only lookups still find equipment")
local occupied = plugin:GetSlotItems(inventory)
check(occupied[2] == helmet and occupied[3] == helmet, "Combined gear occupies both roles with one instance")
local count = 0
for _, item in pairs(inventory:GetItems(true)) do count = count + 1 end
check(count == 1, "Enumeration does not duplicate equipment")
local iterCount = 0
for item in inventory:Iter() do if item == helmet then iterCount = iterCount + 1 end end
check(iterCount == 1, "Bundled iterator finds equipment exactly once")
check(helmet.effects == 1 and helmet.postCalls == 1 and not helmet.removed, "Effects and post-hooks run once")
local query = queries[#queries]
check(query.fields.x == helmet.gridX and query.fields.data, "Position and state are persisted in the same update")
local width, height = inventory:GetSize()
check(width == 8 and height == 6, "Public backpack dimensions are unchanged")
check(not inventory:CanItemFit(32, 1, 1, 1), "Reserved cells reject normal moves")
check(not inventory:CanItemFit(8, 6, 2, 2), "Backpack edges reject overflow")
check(inventory:Add(helmet.id, 1, nil, 32, 1) == false, "Explicit adds cannot bypass reserved-cell protection")
check(inventory:Add(helmet.id, 1, nil, 3, 3) == "original-add", "Ordinary adds delegate to the original")
perform(helmet, "Inspect")
check(helmet.inspected, "Non-equipment item actions use the bundled dispatcher")
local competing = newItem({isGasmask = true}, 3, 1)
perform(competing, "Equip")
check(not competing.data.equip and not competing.effects, "Combined-slot conflicts reject before effects")
check(perform(helmet, "EquipUn") == false and not helmet.data.equip, "Unequip uses the existing action")
check(not plugin:IsEquipmentCell(helmet.gridX), "Unequipping returns the item to real backpack cells")

local foreignInventory = newInventory(2, 3, 3)
local foreign = newItem({isPDA = true}, 5, 1)
inventory:Remove(foreign.id, true, true, true)
foreign.invID = 2
foreignInventory.slots[1] = {[1] = foreign}
perform(foreign, "Equip")
check(not foreign.data.equip and not foreign.effects, "Foreign inventory items cannot be equipped")
check(foreignInventory:GetSize() == 3 and not foreignInventory.vars.cotzEquipmentWidth, "Containers are unchanged")
blocked.CanPlayerEquipItem = false
perform(competing, "Equip")
check(not competing.effects, "Framework permission vetoes run before equipment effects")
blocked.CanPlayerEquipItem = nil

inventory = newInventory(3)
inventory.client = client
plugin:ConfigureInventory(inventory)
local delayed = newItem({isBodyArmor = true, delayed = true})
perform(delayed, "Equip")
ix.item.PerformInventoryAction(client, "Equip", delayed.id, inventory.id)
check(not delayed.effects, "Repeated requests cannot complete a delayed operation twice")
client.character = {GetInventory = function() return foreignInventory end}
advance(4.1)
check(not delayed.effects and not delayed.data.equip, "Character switching invalidates delayed equipment")
client.character = nil
perform(delayed, "Equip")
client.dead = true
advance(4.1)
check(not delayed.effects, "Dying invalidates delayed equipment")
client.dead = nil
perform(delayed, "Equip")
advance(4.1)
check(delayed.data.equip and delayed.effects == 1, "A valid delayed equip completes once")
check(delayed.player == nil and plugin.pending[client] == nil, "Callback context and operation lock are released")
perform(delayed, "EquipUn")
local filler = newItem({width = 8, height = 6, weight = 5})
advance(4.1)
check(delayed.data.equip and delayed.effects == 1, "Space is rechecked before delayed unequip effects")
perform(delayed, "EquipUn")
check(not client.blackScreen, "Full backpack rejects unequip before starting its delay")
check(not inventory:FindEmptySlot(1, 1, true), "Normal fitting cannot use empty equipment regions")
inventory:Remove(filler.id, true, true, true)
perform(delayed, "EquipUn")
advance(4.1)
check(not delayed.data.equip and delayed.effects == 2, "Unequip succeeds when backpack space is available")
perform(delayed, "Equip")
client.blackScreen = nil
advance(4.1)
check(not delayed.data.equip and delayed.effects == 2, "Cancelled delays leave equipment unchanged")

local containerCalls = restoreCalls
ix.inventory.Restore(50, 4, 4)
check(restoreCalls == containerCalls + 1 and ix.item.inventories[50].w == 4, "Numeric restores delegate unchanged")
local saved = setmetatable({id = 100, invID = 51, width = 2, height = 2,
	gridX = 40, gridY = 1, data = {equip = true, durability = 73, ammo = 12}, isHelmet = true}, itemMeta)
restoredRows[51] = {saved}
plugin:ShouldRestoreInventory(1, "51", nil)
local restored
ix.inventory.Restore({[51] = {8, 6}, [52] = {4, 4, "bag"}}, nil, nil, function(value)
	if value.id == 51 then restored = value end
end)
check(restored:GetItemByID(saved.id, true) == saved, "Reconnect restore includes reserved item coordinates")
check(saved.data.durability == 73 and saved.data.ammo == 12, "Restore preserves saved instance state")
check(restored:GetSize() == 8 and restored.h >= 24, "Restored inventory retains backpack and storage dimensions")
check(ix.item.inventories[52].w == 4, "Typed inventory restore is unaffected")
local legacy = newItem({isHelmet = true, data = {equip = true}}, 5, 1)
check(not plugin:IsEquipmentCell(legacy.gridX), "Existing equipped items are not migrated")

local bag = newInventory(60, 2, 2)
local bagItem = newItem({isBag = true, width = 1, height = 1, data = {id = 60}}, 8, 6)
local originalSlots = inventory.slots
inventory.slots = {}
place(filler, 1, 1)
inventory.slots[8][6] = bagItem
local bagX, bagY, foundBag = inventory:FindEmptySlot(1, 1)
check(bagX == 1 and bagY == 1 and foundBag == bag, "Backpack fitting preserves the bundled bag search")
inventory.slots = originalSlots

inventory = newInventory(70)
inventory.client = client
plugin:ConfigureInventory(inventory)
local allEquipment = {}
for index, slot in ipairs(plugin.slots) do
	local fields = {width = 1, height = 1, weight = 2}
	if slot.field then fields[slot.field] = true else fields.weaponCategory = slot.category end
	local item = newItem(fields)
	item.attribBoosts = {stm = 1}
	item.OnLoadout = function(target) target.loadouts = (target.loadouts or 0) + 1 end
	item.OnSave = function(target) target.saves = (target.saves or 0) + 1 end
	perform(item, "Equip")
	allEquipment[#allEquipment + 1] = item
	local x, y = plugin:GetStoragePosition(index)
	check(item.gridX == x and item.gridY == y, slot.name .. " uses its assigned equipment region")
	check(item.gridX + item.width - 1 <= 63 and item.gridY + item.height - 1 <= 63,
		slot.name .. " fits within Helix's network coordinate limits")
end
local gm = {}
ix.config = {Get = function() return false end}
loadMethod("gamemodes/helix/gamemode/core/hooks/sv_hooks.lua", "function GM:PostPlayerLoadout(", {GM = gm})
loadMethod("gamemodes/helix/gamemode/core/hooks/sv_hooks.lua", "function GM:CharacterPreSave(", {GM = gm})
function character:AddBoost() self.boosts = (self.boosts or 0) + 1 end
function character:GetPlayer() return client end
function character:SetData() end
function client:Health() return 100 end
gm:PostPlayerLoadout(client)
gm:CharacterPreSave(character)
for _, item in ipairs(allEquipment) do
	check(item.loadouts == 1 and item.saves == 1, "Bundled lifecycle calls each equipped item once")
end
check(character.boosts == #allEquipment, "Bundled loadout applies each equipped item's boost once")
ix.weight = {}
loadMethod("gamemodes/ix_cotz/plugins/weight/sv_plugin.lua", "function ix.weight.CalculateWeight(", {ix = ix})
check(ix.weight.CalculateWeight(character) == #allEquipment * 2, "Existing weight calculation includes equipment once")

local pendingHelmet = allEquipment[2]
pendingHelmet.delayed = true
perform(pendingHelmet, "EquipUn")
local foreignCharacter = {GetInventory = function() return foreignInventory end}
client.character = foreignCharacter
advance(4.1)
check(pendingHelmet.data.equip, "Changing characters during unequip preserves original equipment")
client.character = nil

local extra = newItem({isHelmet = true}, 1, 1)
advance(0.3)
reads = {extra.id, 10, true}
receivers["cotz/equipment/action"](0, client)
check(not extra.effects, "Mismatched network slot IDs cannot equip an item")
advance(0.3)
reads = {foreign.id, 10, true}
receivers["cotz/equipment/action"](0, client)
check(not foreign.effects, "Network requests cannot equip another inventory's item")
advance(0.3)
reads = {pendingHelmet.id, 2, false}
receivers["cotz/equipment/action"](0, client)
local activeRequest = plugin.pending[client]
reads = {allEquipment[3].id, 3, false}
receivers["cotz/equipment/action"](0, client)
check(plugin.pending[client] == activeRequest, "Repeated network actions are rate limited on the server")
advance(4.1)

local failing = newItem({isHelmet = true}, 2, 1)
failing.functions.Equip.OnRun = function() error("expected item callback failure") end
advance(0.3)
local succeeded, failure = pcall(ix.item.PerformInventoryAction, client, "Equip", failing.id, inventory.id)
check(not succeeded and failure:find("expected item callback failure", 1, true), "Item errors remain visible")
check(plugin.actionContext == nil and plugin.pending[client] == nil,
	"Callback errors release context and operation locks")

inventory = newInventory(80)
inventory.client = client
plugin:ConfigureInventory(inventory)
local droppedItem = newItem({isHelmet = true})
perform(droppedItem, "Equip")
local dropFiller = newItem({width = 8, height = 6})
droppedItem.hooks.drop = function(target) target:SetData("equip", false) end
droppedItem.functions.drop = {OnRun = function(target)
	inventory:Remove(target.id, true, true, true)
	target.invID = 0
	target.dropped = true

	return false
end}
perform(droppedItem, "drop")
check(droppedItem.dropped and not droppedItem.data.equip, "Equipped items can drop directly with a full backpack")
check(inventory:GetItemByID(droppedItem.id, true) == nil, "A direct drop leaves no duplicate equipment reference")
inventory:Remove(dropFiller.id, true, true, true)
local vetoed = newItem({isHelmet = true})
perform(vetoed, "Equip")
place(dropFiller, 1, 1)
vetoed.functions.drop = {OnRun = function() return false end}
vetoed.hooks.drop = function(target) target:SetData("equip", false) end
perform(vetoed, "drop")
check(not vetoed.data.equip and plugin:GetSlotItems(inventory)[2] == vetoed,
	"A drop veto leaves the inactive item accessible in its slot")
local savedX = vetoed.gridX
vetoed.gridX = nil
check(plugin:GetSlotItems(inventory)[2] == vetoed, "Client anchor-only sync still displays inactive reserved items")
vetoed.gridX = savedX
inventory:Remove(dropFiller.id, true, true, true)
advance(0.3)
reads = {vetoed.id, 2, false}
receivers["cotz/equipment/action"](0, client)
check(not plugin:IsEquipmentCell(vetoed.gridX) and not vetoed.data.equip,
	"Inactive reserved items can return to the backpack without repeating unequip effects")

for _, name in ipairs({"sh_plugin.lua", "sv_plugin.lua", "cl_plugin.lua"}) do
	check(loadfile("gamemodes/ix_cotz/plugins/equipmentslots/" .. name) ~= nil, name .. " parses as standard Lua")
end
print("Equipment slots: " .. checks .. " checks passed")
