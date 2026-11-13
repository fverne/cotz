-- Run from the addon root: luatex --luaonly tests/gasmask_filters_spec.lua
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end

local function near(actual, expected, message)
	check(math.abs(actual - expected) < 0.000001, message)
end

local function read(path)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()

	return source
end

local function standardLua(source)
	return source:gsub("!=", "~="):gsub("!", "not "):gsub("//[^\n]*", "")
end

local function method(path, signature)
	local source = read(path)
	local first = assert(source:find(signature, 1, true))
	local last = assert(source:find("\nend", first, true)) + 3
	assert(load(standardLua(source:sub(first, last)), "@" .. path))()
end

SERVER, CLIENT = true, false
math.Clamp = function(value, minimum, maximum) return math.max(minimum, math.min(value, maximum)) end
IsValid = function(value) return type(value) == "table" and not value.invalid end
istable = function(value) return type(value) == "table" end
isnumber = function(value) return type(value) == "number" end
Vector = function(...) return {...} end
Angle = Vector
local now, timers, creations = 0, {}, {}
CurTime = function() return now end
timer = {Simple = function(delay, callback) timers[#timers + 1] = {time = now + delay, callback = callback} end}
local veto
hook = {Run = function(event) if event == veto then return false end end}
ix = {
	util = {GetMaterial = function() end},
	item = {list = {}, instances = {}, inventories = {}},
	plugin = {list = {}},
	temp = {Corpses = {}},
	weight = {Update = function(character) character.weightUpdates = (character.weightUpdates or 0) + 1 end},
}
PLUGIN = {}
dofile("gamemodes/ix_cotz/plugins/suits/sh_filters.lua")
dofile("gamemodes/ix_cotz/plugins/suits/sv_filters.lua")
local filterPlugin = PLUGIN

local gearPath = "gamemodes/ix_cotz/schema/items/base/sh_gear.lua"
ITEM = {functions = {}}
local gearSource = read(gearPath)
local prefixEnd = assert(gearSource:find("function ITEM:RemovePart", 1, true)) - 1
assert(load(standardLua(gearSource:sub(1, prefixEnd)), "@gear/base"))()
for _, name in ipairs({"getRadProt", "getBR", "getFBR"}) do method(gearPath, "function ITEM:" .. name .. "(") end
local gearBase = ITEM

local itemID = 0
local function instantiate(definition, data)
	itemID = itemID + 1
	local item = setmetatable({id = itemID, invID = 0, data = data or {}, writes = 0}, {__index = definition})
	function item:GetData(key, default)
		if self.data[key] ~= nil then return self.data[key] end

		return default
	end
	function item:SetData(key, value) self.data[key] = value self.writes = self.writes + 1 end
	function item:GetName() return self.name end
	function item:GetID() return self.id end
	function item:Remove()
		if self.failRemove then return false end
		local inventory = ix.item.inventories[self.invID]
		if inventory then inventory.items[self.id] = nil end
		ix.item.instances[self.id] = nil

		return true
	end
	ix.item.instances[item.id] = item

	return item
end

ITEM = {functions = {}}
dofile("gamemodes/ix_cotz/plugins/suits/items/base/sh_gasmaskfilters.lua")
local filterBase = ITEM
for _, tier in ipairs({"civilian", "military", "scientific"}) do
	ITEM = setmetatable({}, {__index = filterBase})
	dofile("gamemodes/ix_cotz/plugins/suits/items/gasmaskfilters/sh_gasmask_filter_" .. tier .. ".lua")
	ITEM.uniqueID = "gasmask_filter_" .. tier
	ix.item.list[ITEM.uniqueID] = ITEM
	check(ITEM.width == 1 and ITEM.height == 1 and ITEM.weight == 0.2 and ITEM.filterCondition == 100,
		"concrete filter dimensions, weight and initial condition: " .. tier)
end

local assignments = {
	civilian = {"mask_halfmask", "mask_respirator", "mask_gp5", "headwear_cs1", "headwear_cs2"},
	military = {"mask_eo20", "mask_pmk3", "mask_xm40", "headwear_cs4", "headwear_pracs", "headwear_psz12"},
	scientific = {"mask_m40", "mask_m50", "headwear_rad", "headwear_spartan", "headwear_screen"},
}
for tier, ids in pairs(assignments) do
	for _, id in ipairs(ids) do
		local source = read("gamemodes/ix_cotz/schema/items/gear/sh_" .. id .. ".lua")
		check(source:find('ITEM.filterType = "' .. tier .. '"', 1, true), "explicit compatibility: " .. id)
	end
end
for _, id in ipairs({"mask_cloth", "headwear_riot", "headwear_altyn"}) do
	check(read("gamemodes/ix_cotz/schema/items/gear/sh_" .. id .. ".lua"):find("ITEM.filterType = false", 1, true),
		"explicit exemption: " .. id)
end
for file in lfs.dir("gamemodes/ix_cotz/schema/items/suit") do
	if file:match("^sh_suit_seva") or file:match("^sh_suit_nbc") or file:match("^sh_suit_ssp99") then
		check(read("gamemodes/ix_cotz/schema/items/suit/" .. file):find('ITEM.filterType = "scientific"\nITEM.isAirTank = true\nITEM.filterWearDivisor = 1920', 1, true),
			"closed respiratory suit declares long-life tank: " .. file)
	end
end

local function newInventory(id)
	local inventory = {id = id, items = {}, width = 7, height = 7}
	function inventory:GetID() return self.id end
	function inventory:GetSize() return self.width, self.height end
	function inventory:GetItems() return self.items end
	function inventory:GetItemByID(id) return self.items[id] end
	function inventory:Iter()
		local key

		return function()
			local item
			key, item = next(self.items, key)
			if item then return item, item.gridX, item.gridY end
		end
	end
	function inventory:FindEmptySlot()
		if not self.full then return 6, 6 end
	end
	function inventory:Add(id, _, _, x, y)
		local item = ix.item.instances[id]
		if self.full or self.rejectAdd or filterPlugin:CanTransferItem(item) == false then return false end
		if self.atWeightLimit and item:GetWeight() > 0 then return false end
		item.invID, item.gridX, item.gridY = self.id, x, y
		self.items[id] = item

		return x, y, self.id
	end
	ix.item.inventories[id] = inventory

	return inventory
end

local inventory = newInventory(1)
local character = {GetID = function() return 1 end, GetInventory = function() return inventory end}
local client = {character = character, alive = true, notices = {}}
function client:GetCharacter() return self.character end
function client:Alive() return self.alive end
function client:GetNetVar() return self.busy or false end
function client:IsPlayer() return true end
function client:SteamID64() return "test-owner" end
function client:Notify(message) self.notices[#self.notices + 1] = message end
function client:EmitSound() end
function client:HasBuff(name) return name == "buff_townradprotect" and self.townProtected == true end
function client:RecalculateResistances() end
function client:GetNWFloat() return 1 end
function client:GetNWInt() return 0 end
function client:getPercentageRadResist() return 0 end
function client:getFlatRadResist() return 0 end

local function backpack(item)
	item.invID, item.gridX, item.gridY = inventory.id, 1, 1
	inventory.items[item.id] = item

	return item
end

local function newMask(tier, condition)
	local item = instantiate(gearBase, {durability = 100, filterCondition = condition})
	item.isGasmask, item.filterType = true, tier or "civilian"
	item.radProt, item.flatRadProt, item.br, item.fbr = 0.8, 0.02, 0.2, 4
	item.weight = 0.6

	return backpack(item)
end

local function newFilter(tier, condition)
	local item = instantiate(ix.item.list["gasmask_filter_" .. tier], {filterCondition = condition})
	item:OnInstanced()

	return backpack(item)
end

function ix.item.Instance(_, id, data, _, _, callback)
	creations[#creations + 1] = {id = id, data = data, callback = callback}
end
local function completeCreation()
	local request = table.remove(creations, 1)
	local output = instantiate(ix.item.list[request.id], request.data)
	request.callback(output)
	output:OnInstanced()

	return output
end
local function advance(seconds)
	local finish = now + (seconds or 1)
	while true do
		local nextIndex
		for index, entry in ipairs(timers) do
			if entry.time <= finish and (not nextIndex or entry.time < timers[nextIndex].time) then nextIndex = index end
		end
		if not nextIndex then break end
		local entry = table.remove(timers, nextIndex)
		now = entry.time
		entry.callback()
	end
	now = finish
end

function ix.util.PlayerPerformBlackScreenAction(player, text, duration, callback)
	player.busy, player.actionDuration = true, duration
	player.actionGeneration = (player.actionGeneration or 0) + 1
	local generation = player.actionGeneration
	timer.Simple(duration, function()
		if not player.busy or player.actionGeneration ~= generation then return end
		player.busy = false
		callback(player)
	end)
end
function ix.util.PlayerActionInterrupt(player)
	player.busy = false
	player.actionGeneration = (player.actionGeneration or 0) + 1
end

local mask = newMask()
check(mask:GetFilterCondition() == 100 and mask.data.filterCondition == 100, "legacy masks initialize and save once")
local writes = mask.writes
mask:GetFilterCondition()
check(mask.writes == writes, "reads do not repeatedly initialize saved state")
for _, entry in ipairs({{100, 1}, {80, 1}, {20, 1}, {10, 0.5}, {1, 0.05}, {0, 0}, {false, 0}}) do
	mask.data.filterCondition = entry[1]
	near(mask:GetFilterScale(), entry[2], "filter taper at " .. tostring(entry[1]))
	near(mask:getRadProt(), 0.8 * entry[2], "percentage radiation protection uses filter")
	near(mask:GetFlatRadProt(), 0.02 * entry[2], "flat radiation protection uses filter")
	near(mask:getBR(), 0.2, "filter does not affect ballistics")
end
mask.data.durability, mask.data.filterCondition = 50, 10
near(mask:getRadProt(), 0.8 * 0.3125, "50 percent mask and 10 percent filter give 31.25 percent protection")
near(mask:GetFlatRadProt(), 0.02 * 0.3125, "flat protection uses both scales")
near(mask:GetWeight(), 0.8, "installed cartridge contributes its mass")
mask.data.filterCondition = false
near(mask:GetWeight(), 0.6, "empty socket contributes no cartridge mass")
mask:OnRestored()
check(mask.data.filterCondition == false, "restore never refills an empty mask")
mask.data.filterCondition = 0
mask:OnRestored()
check(mask.data.filterCondition == 0, "restore never refills an exhausted filter")
mask.data.durability = 100
check(mask:GetFilterCondition() == 0, "ordinary repair does not refill a filter")

DMG_RADIATION, DMG_BULLET, DMG_FALL, DMG_GENERIC = 1, 2, 4, 0
DMG_SHOCK, DMG_BURN, DMG_ACID, DMG_BLAST, DMG_DROWN = 8, 16, 32, 64, 128
DMG_POISON, DMG_NERVEGAS, DMG_SLOWBURN, DMG_SONIC, DMG_AIRBOAT = 256, 512, 1024, 2048, 4096
DMG_CRUSH = 8192
dofile("gamemodes/ix_cotz/plugins/suits/sh_durability.lua")
local function damage(amount, kind)
	return {
		GetDamage = function() return amount end,
		GetDamageType = function() return kind end,
		IsDamageType = function(_, flag) return kind == flag end,
		GetAttacker = function() return client end,
	}
end
for _, entry in ipairs({{"civilian", 600}, {"military", 900}, {"scientific", 1200}}) do
	local item = newMask(entry[1], 100)
	item.data.equip = true
	ix.plugin.list.buffs, client.townProtected = {}, true
	local protectedWrites = item.writes
	ix.util.DamageGasmaskFilters(client, damage(120, DMG_RADIATION))
	check(item:GetFilterCondition() == 100 and item.writes == protectedWrites,
		"town NPC protection prevents filter wear and saved writes: " .. entry[1])
	ix.plugin.list.buffs, client.townProtected = nil, nil
	for _ = 1, entry[2] * 5 - 1 do ix.util.DamageGasmaskFilters(client, damage(4, DMG_RADIATION)) end
	check(item:GetFilterCondition() > 0, "filter lasts to its final exposure: " .. entry[1])
	ix.util.DamageGasmaskFilters(client, damage(4, DMG_RADIATION))
	near(item:GetFilterCondition(), 0, "reference lifetime: " .. entry[1])
	check(item.data.durability == 100, "radiation preserves mask durability")
	item.data.filterCondition = 100
	ix.util.DamageGasmaskFilters(client, damage(120, DMG_RADIATION))
	near(item:GetFilterCondition(), 100 - 120 / ix.item.list["gasmask_filter_" .. entry[1]].filterWearDivisor,
		"stronger exposure drains proportionally")
	local before = item:GetFilterCondition()
	ix.util.DamageGasmaskFilters(client, damage(100, DMG_BULLET))
	ix.util.DamageGasmaskFilters(client, damage(0, DMG_RADIATION))
	check(item:GetFilterCondition() == before, "other damage and clean areas do not drain filters")
	ix.util.DamageHeadgear(client, damage(100, DMG_RADIATION))
	check(item.data.durability == 100, "ordinary radiation wear skips filter equipment")
	ix.util.DamageHeadgear(client, damage(100, DMG_BULLET))
	near(item.data.durability, 99.75, "combat still wears ordinary durability")
	item.data.equip = false
end

mask = newMask("civilian", false)
local civilian = newFilter("civilian", 37)
local tank = newMask("scientific", 100)
tank.isAirTank = true
tank.filterWearDivisor = 1920
tank.data.equip = true
check(not ix.util.CanChangeGasmaskFilter(tank, client), "built-in tanks cannot accept or remove cartridges")
ix.util.DamageGasmaskFilters(client, damage(240, DMG_RADIATION))
near(tank:GetFilterCondition(), 99.875, "tank consumes one eighth of scientific filter condition")
tank.data.filterCondition = 100
ix.util.DamageGasmaskFilters(client, damage(192000, DMG_RADIATION))
near(tank:GetFilterCondition(), 0, "tank lasts 160 minutes at 20 raw damage per second")
tank.data.equip = false

local suitPath = "gamemodes/ix_cotz/schema/items/base/sh_suit.lua"
ITEM = {}
for _, signature in ipairs({"GetFilterCondition", "GetFilterScale", "GetFlatRadProt", "getRadProt"}) do
	local source = read(suitPath)
	local first = assert(source:find("function ITEM:" .. signature .. "(", 1, true))
	local last = assert(source:find("\nend", first, true)) + 3
	assert(load(standardLua(source:sub(first, last)):gsub("continue", "break")))()
end
local suit = instantiate(ITEM, {durability = 40, filterCondition = 10})
suit.filterType, suit.isAirTank = "scientific", true
suit.radProt, suit.flatRadProt, suit.miscSlots = 0.9, 0.02, {}
ix.armortables = {upgrades = {}, attachments = {}}
near(suit:getRadProt(), 0.225, "tank taper combines with suit durability")
near(suit:GetFlatRadProt(), 0.005, "flat suit protection follows both condition scales")
suit.data.filterCondition = 0
near(suit:getRadProt(), 0, "exhausted tank removes suit radiation protection")
near(suit:GetFlatRadProt(), 0, "exhausted tank removes flat radiation protection")
suit.data.filterCondition = nil
near(suit:GetFilterCondition(), 100, "legacy suit starts with a full tank")

local military = newFilter("military", 100)
local scientific = newFilter("scientific", 100)
local options = ix.util.GetGasmaskFilterOptions(mask, client)
check(#options == 1 and options[1].data[1] == civilian.id and options[1].name:find("37%%%%"),
	"picker lists only matching owned filters with escaped percentages")
for _, filter in ipairs({military, scientific}) do
	advance()
	ix.util.InstallGasmaskFilter(mask, client, {filter.id})
	check(mask:GetFilterCondition() == false and ix.item.instances[filter.id] == filter, "reject higher tier substitution")
end
local highMask = newMask("scientific", false)
advance()
ix.util.InstallGasmaskFilter(highMask, client, {civilian.id})
check(highMask:GetFilterCondition() == false, "reject lower tier substitution")
advance()
civilian.failRemove = true
ix.util.InstallGasmaskFilter(mask, client, {civilian.id})
advance(6)
check(mask:GetFilterCondition() == false, "failed consumption cannot install a filter")
civilian.failRemove = nil
advance()
ix.util.InstallGasmaskFilter(mask, client, {civilian.id})
check(mask:GetFilterCondition() == false and ix.item.instances[civilian.id] and client.actionDuration == 6,
	"installation starts a six-second action without consuming the cartridge")
advance(5)
check(mask:GetFilterCondition() == false and ix.item.instances[civilian.id], "installation cannot finish early")
advance(1)
check(mask:GetFilterCondition() == 37 and not ix.item.instances[civilian.id],
	"installation consumes one partial cartridge")
check(mask.data.durability == 100, "installation preserves ordinary durability")
advance()
local fullFilter = newFilter("civilian", 100)
ix.util.InstallGasmaskFilter(mask, client, {fullFilter.id})
check(mask:GetFilterCondition() == 37 and fullFilter:GetData("filterCondition") == 100,
	"replacement preserves both cartridges until the action finishes")
advance(6)
check(mask:GetFilterCondition() == 100 and fullFilter:GetData("filterCondition") == 37,
	"replacement returns the old cartridge in the incoming filter's cell")
ix.util.InstallGasmaskFilter(mask, client, {fullFilter.id})
advance(6)
check(mask:GetFilterCondition() == 37 and fullFilter:GetData("filterCondition") == 100,
	"swapping partial cartridges back preserves both conditions")

inventory.full = true
advance()
ix.util.RemoveGasmaskFilter(mask, client)
check(#creations == 0 and mask:GetFilterCondition() == 37, "full backpack retains installed cartridge")
inventory.full = false
advance()
ix.util.RemoveGasmaskFilter(mask, client)
check(#creations == 1 and mask:GetFilterCondition() == 37, "removal waits for database completion")
check(filterPlugin:CanTransferItem(mask) == false and filterPlugin:CanPlayerEquipItem(client, mask) == false,
	"pending removal blocks transfer and equipment")
check(filterPlugin:CanPlayerInteractItem(client, "RemoveFilter", mask.id) == false,
	"pending removal blocks repeated inventory actions")
advance()
ix.util.RemoveGasmaskFilter(mask, client)
check(#creations == 1, "duplicate removal does not create another item")
inventory.atWeightLimit = true
local returned = completeCreation()
inventory.atWeightLimit = false
check(returned.data.filterCondition == 37 and returned.filterType == "civilian" and mask:GetFilterCondition() == false,
	"removal returns the exact condition and tier even at the weight limit")
near(returned:GetWeight() + mask:GetWeight(), 0.8, "removal conserves total mass")
advance()
ix.util.InstallGasmaskFilter(mask, client, {returned.id})
advance(6)
check(mask:GetFilterCondition() == 37, "reinstalling cannot refresh condition")

local function failedRemoval(setup, reset, label)
	advance()
	ix.util.RemoveGasmaskFilter(mask, client)
	check(#creations == 1, label .. " begins")
	setup()
	local output = completeCreation()
	reset()
	check(mask:GetFilterCondition() == 37 and not ix.item.instances[output.id] and not mask.cotzFilterPending,
		label .. " preserves installed state and cleans output")
end
failedRemoval(function() inventory.full = true end, function() inventory.full = false end,
	"space filled during creation")
failedRemoval(function() inventory.rejectAdd = true end, function() inventory.rejectAdd = false end, "failed placement")
failedRemoval(function() client.character = {} end, function() client.character = character end, "character switched")
failedRemoval(function() client.invalid = true end, function() client.invalid = nil end, "player disconnected")
failedRemoval(function() mask.data.equip = true end, function() mask.data.equip = false end, "equipment changed")
failedRemoval(function() mask.invID = 999 end, function() mask.invID = inventory.id end, "ownership changed")

advance()
ix.util.RemoveGasmaskFilter(mask, client)
advance(16)
check(not mask.cotzFilterPending and mask:GetFilterCondition() == 37, "timeout releases lock and keeps filter")
local late = completeCreation()
check(not ix.item.instances[late.id] and mask:GetFilterCondition() == 37, "late completion cannot duplicate a filter")

for _, field in ipairs({"alive", "busy"}) do
	local original = client[field]
	client[field] = field == "busy"
	check(not ix.util.CanChangeGasmaskFilter(mask, client), "cannot change filters while " .. field)
	client[field] = original
end
mask.data.equip = true
check(ix.util.CanChangeGasmaskFilter(mask, client), "equipped owned masks allow filter changes")
mask.data.equip = false
mask.gridX = 32
check(not ix.util.CanChangeGasmaskFilter(mask, client), "reserved equipment cells are not backpack space")
mask.gridX = 1
local foreign = newFilter("civilian", 100)
inventory.items[foreign.id] = nil
advance()
mask.data.filterCondition = false
ix.util.InstallGasmaskFilter(mask, client, {foreign.id})
check(mask:GetFilterCondition() == false and ix.item.instances[foreign.id], "foreign item IDs are rejected")
advance()
ix.util.InstallGasmaskFilter(mask, client, {fullFilter.id})
advance(6)
check(mask:GetFilterCondition() == 100, "fresh replacement restores full filter condition")
mask.data.filterCondition = 0
advance()
ix.util.RemoveGasmaskFilter(mask, client)
local spent = completeCreation()
check(spent.data.filterCondition == 0 and mask:GetFilterCondition() == false, "exhausted cartridge is removable")

for _, tier in ipairs({"civilian", "military", "scientific"}) do
	local worn = newMask(tier, 37)
	local replacement = newFilter(tier, 100)
	worn.data.equip, worn.gridX, worn.data.durability = true, 32, 40
	replacement.player = client
	check(filterBase.functions.combine.OnCanRun(replacement, {worn.id}),
		"drag-and-drop accepts an equipped mask with a matching filter: " .. tier)
	inventory.full = true
	advance()
	check(filterBase.functions.combine.OnRun(replacement, {worn.id}) == false,
		"combine preserves the incoming cartridge while installation is pending")
	check(worn:GetFilterCondition() == 37 and replacement:GetData("filterCondition") == 100,
		"equipped replacement is not immediate")
	check(filterPlugin:CanTransferItem(replacement) == false
		and filterPlugin:CanPlayerUnequipItem(client, worn) == false,
		"both the spare and equipped mask are locked throughout installation")
	advance(3)
	ix.util.DamageGasmaskFilters(client, damage(120, DMG_RADIATION))
	local oldCondition = worn:GetFilterCondition()
	advance(3)
	check(worn:GetFilterCondition() == 100 and replacement:GetData("filterCondition") == oldCondition,
		"equipped replacement returns the actual old condition after exposure during installation")
	check(worn.data.equip == true and worn.gridX == 32 and worn.data.durability == 40,
		"filter replacement preserves equipment placement, ordinary durability and equipped state")
	near(worn:GetWeight() + replacement:GetWeight(), 1, "full-backpack swap conserves both cartridge masses")
	check(#creations == 0 and not worn.cotzFilterPending and not replacement.cotzFilterPending,
		"occupied sockets swap in the existing cell without an asynchronous inventory insert")
	inventory.full, worn.data.equip, replacement.player = false, false, nil
end

local timedMask = newMask("civilian", 37)
local timedFilter = newFilter("civilian", 100)
advance()
ix.util.InstallGasmaskFilter(timedMask, client, {timedFilter.id})
advance(2)
ix.util.PlayerActionInterrupt(client)
advance(0.2)
check(not timedMask.cotzFilterPending and not timedFilter.cotzFilterPending and not client.cotzFilterAction,
	"cancelling releases both items and the player action")
check(timedMask:GetFilterCondition() == 37 and timedFilter:GetData("filterCondition") == 100,
	"cancelling leaves both cartridge conditions unchanged")
advance(5)
check(timedMask:GetFilterCondition() == 37, "a cancelled timer cannot later complete the installation")

advance()
ix.util.InstallGasmaskFilter(timedMask, client, {timedFilter.id})
filterPlugin:PlayerDisconnected(client)
check(not client.busy and not client.cotzFilterAction and not timedFilter.cotzFilterPending,
	"disconnect hook cancels the shared action before the player entity becomes invalid")
advance(6)
check(timedMask:GetFilterCondition() == 37, "disconnected installation cannot complete later")

local function interruptedInstall(setup, reset, label)
	advance()
	ix.util.InstallGasmaskFilter(timedMask, client, {timedFilter.id})
	check(client.cotzFilterAction ~= nil, label .. " begins")
	setup()
	advance(0.2)
	reset()
	check(not timedMask.cotzFilterPending and not timedFilter.cotzFilterPending and not client.cotzFilterAction,
		label .. " releases all locks")
	advance(6)
	check(timedMask:GetFilterCondition() == 37 and timedFilter:GetData("filterCondition") == 100,
		label .. " leaves both items unchanged")
end
interruptedInstall(function() client.alive = false end, function() client.alive = true end, "death during installation")
interruptedInstall(function() client.character = {} end, function() client.character = character end,
	"character switch during installation")
interruptedInstall(function() client.invalid = true end, function() client.invalid = nil end,
	"disconnect during installation")
interruptedInstall(function() timedMask.invID = 999 end, function() timedMask.invID = inventory.id end,
	"mask ownership changed during installation")
interruptedInstall(function() timedFilter.invID = 999 end, function() timedFilter.invID = inventory.id end,
	"filter ownership changed during installation")
interruptedInstall(function() timedFilter.gridX = 2 end, function() timedFilter.gridX = 1 end,
	"filter moved inside the backpack during installation")
interruptedInstall(function() timedMask.gridY = 2 end, function() timedMask.gridY = 1 end,
	"mask moved inside the backpack during installation")
interruptedInstall(function() timedMask.data.equip = true end, function() timedMask.data.equip = false end,
	"equipment state changed during installation")
interruptedInstall(function() timedFilter.filterType = "scientific" end,
	function() timedFilter.filterType = "civilian" end, "compatibility changed during installation")
interruptedInstall(function() ix.item.instances[timedFilter.id] = nil end,
	function() ix.item.instances[timedFilter.id] = timedFilter end, "incoming filter removed during installation")

for _, event in ipairs({"CanPlayerInteractItem", "CanPlayerCombineItem"}) do
	advance()
	ix.util.InstallGasmaskFilter(timedMask, client, {timedFilter.id})
	advance(3)
	veto = event
	advance(3)
	veto = nil
	check(timedMask:GetFilterCondition() == 37 and timedFilter:GetData("filterCondition") == 100,
		"installation rechecks permission at completion: " .. event)
	check(not client.cotzFilterAction, "a rejected completion releases the player action")
end

advance()
ix.util.InstallGasmaskFilter(timedMask, client, {timedFilter.id})
local pending = client.cotzFilterAction
advance()
ix.util.InstallGasmaskFilter(timedMask, client, {timedFilter.id})
ix.util.InstallGasmaskFilter(mask, client, {fullFilter.id})
check(client.cotzFilterAction == pending and timedMask.cotzFilterPending == pending,
	"repeated requests cannot replace an in-flight installation or use another mask")
advance(5)
check(timedMask:GetFilterCondition() == 100 and timedFilter:GetData("filterCondition") == 37,
	"a cancelled or rejected installation can subsequently be retried")

timedMask.data.equip, timedMask.gridX = true, 32
advance()
ix.util.RemoveGasmaskFilter(timedMask, client)
ix.util.DamageGasmaskFilters(client, damage(120, DMG_RADIATION))
local removedCondition = timedMask:GetFilterCondition()
local removedWhileWorn = completeCreation()
check(timedMask:GetFilterCondition() == false and timedMask.data.equip
	and removedWhileWorn:GetData("filterCondition") == removedCondition,
	"removal from an equipped mask returns its condition at completion without recharging")
removedWhileWorn.player = client
check(not filterBase.functions.combine.OnCanRun(removedWhileWorn, {})
	and not filterBase.functions.combine.OnCanRun(removedWhileWorn, {"invalid"}),
	"malformed combine targets are rejected")
check(not filterBase.functions.combine.OnCanRun(removedWhileWorn, {scientific.id}),
	"filters cannot combine into unrelated items")

-- Exercise the actual radiation hook: protection is read before wear, then direct health damage is cleared.
PLUGIN = {}
method("gamemodes/ix_cotz/plugins/radiation/sh_plugin.lua", "function PLUGIN:EntityTakeDamage(")
MOVETYPE_NOCLIP = 8
function client:GetMoveType() return 0 end
function client:hasGeiger() return false end
function client:getPercentageRadResist() return 1 - mask:getRadProt() end
function client:getFlatRadResist() return mask:GetFlatRadProt() end
function client:addRadiation(value) self.receivedRadiation = value end
mask.data.filterCondition, mask.data.equip = 10, true
local info = {value = 120, IsDamageType = function(_, kind) return kind == DMG_RADIATION end}
function info:GetDamage() return self.value end
function info:SetDamage(value) self.value = value end
function info:GetDamageType() return DMG_RADIATION end
function info:GetAttacker() return client end
PLUGIN:EntityTakeDamage(client, info)
near(client.receivedRadiation, 12 * 0.6 - 0.01, "radiation uses pre-wear protection")
check(mask:GetFilterCondition() == 9 and info.value == 0, "raw exposure wears filter once before health override")
veto = nil
local originalRun = hook.Run
hook.Run = function(event) if event == "ShouldBlockSafeZoneDamage" then return true end end
info.value = 120
PLUGIN:EntityTakeDamage(client, info)
check(mask:GetFilterCondition() == 9 and info.value == 0, "safe zones preserve filters")
hook.Run = originalRun

-- Blessings and unequipped spares do not drain, even during a real radiation event.
mask.data.unlimitedDurability = true
info.value = 120
PLUGIN:EntityTakeDamage(client, info)
check(mask:GetFilterCondition() == 9, "unlimited durability also preserves filter condition")
mask.data.unlimitedDurability, mask.data.equip = nil, false
info.value = 120
PLUGIN:EntityTakeDamage(client, info)
check(mask:GetFilterCondition() == 9, "unequipped spare filters do not drain")
mask.data.equip = true
ix.temp.Corpses[client] = {}
info.value = 120
PLUGIN:EntityTakeDamage(client, info)
check(mask:GetFilterCondition() == 9, "protected corpses preserve filter condition")
ix.temp.Corpses[client] = nil

local radiationPlugin = PLUGIN
FindMetaTable = function() return {} end
ix.util.Include = function() end
ix.config = {Add = function() end, Get = function(_, default) return default end}
PLUGIN = {}
assert(load(standardLua(read("gamemodes/ix_cotz/plugins/suits/sh_plugin.lua")), "@suits/plugin"))()
for _, radiationFirst in ipairs({false, true}) do
	mask.data.filterCondition, mask.data.durability = 100, 100
	info.value = 120
	if radiationFirst then
		radiationPlugin:EntityTakeDamage(client, info)
		PLUGIN:EntityTakeDamage(client, info)
	else
		PLUGIN:EntityTakeDamage(client, info)
		radiationPlugin:EntityTakeDamage(client, info)
	end
	check(mask:GetFilterCondition() == 99 and mask.data.durability == 100,
		"radiation drains filter once regardless of plugin hook order")
end

mask.radProt, mask.flatRadProt, mask.data.filterCondition = 1, 0, 100
info.value = 120
radiationPlugin:EntityTakeDamage(client, info)
check(client.receivedRadiation == 0 and mask:GetFilterCondition() == 99,
	"fully blocked radiation still drains the installed filter")
mask.radProt, mask.flatRadProt = 0.8, 0.02

ix.plugin.list.buffs, client.townProtected = {}, true
info.value = 120
radiationPlugin:EntityTakeDamage(client, info)
check(client.receivedRadiation == 0 and mask:GetFilterCondition() == 99 and info.value == 0,
	"town NPC radiation protection also preserves filters through the radiation hook")
client.townProtected = false
info.value = 120
radiationPlugin:EntityTakeDamage(client, info)
check(client.receivedRadiation > 0 and mask:GetFilterCondition() == 98,
	"radiation and filter wear resume when town protection expires")
ix.plugin.list.buffs, client.townProtected = nil, nil

mask.data.filterCondition = 37
local restored = instantiate(gearBase, {filterCondition = mask.data.filterCondition, durability = 42})
restored.filterType = "civilian"
restored:OnRestored()
check(restored:GetFilterCondition() == 37 and restored:GetData("durability") == 42,
	"saved partial condition and ordinary durability survive restoration")
local exempt = newMask()
exempt.filterType = false
exempt.data.durability = 40
near(exempt:getRadProt(), 0.4, "exempt headgear retains durability-only radiation protection")
near(exempt:GetWeight(), exempt.weight, "exempt headgear gains no cartridge weight")
check(not gearBase.functions.InstallFilter.OnCanRun(exempt), "exempt headgear has no filter actions")

-- Render actual client helpers and equipment bars with lightweight drawing mocks.
SERVER, CLIENT = false, true
Color = function(r, g, b, a) return {r = r, g = g, b = b, a = a} end
local rectangles, currentColor = {}, nil
surface = {
	SetDrawColor = function(value) currentColor = value end,
	DrawRect = function(x, y, width, height)
		rectangles[#rectangles + 1] = {x = x, y = y, width = width, height = height, color = currentColor}
	end,
	DrawOutlinedRect = function() end,
}
derma = {SkinFunc = function() end}
dofile("gamemodes/ix_cotz/plugins/suits/sh_filters.lua")
local tooltip = {rows = {}}
function tooltip:AddRow(id)
	local row = {}
	function row:SetText(text) self.text = text end
	function row:SizeToContents() end
	self.rows[id] = row

	return row
end
mask.data.filterCondition = false
ix.util.PopulateGasmaskFilterTooltip(tooltip, mask)
check(tooltip.rows.gasmaskFilter.text == "Civilian Gasmask Filter: No filter", "empty socket tooltip")
mask.data.filterCondition = 37
ix.util.PopulateGasmaskFilterTooltip(tooltip, mask)
check(tooltip.rows.gasmaskFilter.text == "Civilian Gasmask Filter: 37%", "partial installed filter tooltip")
ix.util.PopulateGasmaskFilterTooltip(tooltip, spent)
check(tooltip.rows.gasmaskFilter.text == "Civilian Gasmask Filter: 0%", "spent loose cartridge tooltip")
ix.util.PaintGasmaskFilter(mask, 64, 64)
near(rectangles[#rectangles].width, 38 * 0.37, "backpack icon shows real filter condition")
mask.data.filterCondition = false
ix.util.PaintGasmaskFilter(mask, 64, 64)
check(rectangles[#rectangles].width == 0, "empty filter icon bar stays empty")
local equipmentSource = read("gamemodes/ix_cotz/plugins/equipmentslots/cl_plugin.lua")
local equipmentEnd = assert(equipmentSource:find("local function paintHeader", 1, true)) - 1
PLUGIN = {}
local conditions, paintCard = assert(load(equipmentSource:sub(1, equipmentEnd)
	.. "\nreturn itemConditions, paintCard", "@equipment/bars"))()
mask.data.durability = 80
local durability, filterCondition = conditions(mask)
check(durability == 80 and filterCondition == 0, "empty mask still displays both equipment bars")
mask.data.filterCondition = 40
rectangles = {}
local card = {item = mask, scale = 1, padding = 6, IsHovered = function() return false end}
paintCard(card, 200, 150)
local filledTop, filledBottom = 0, 0
for _, rectangle in ipairs(rectangles) do
	if rectangle.color.g ~= 43 then
		if rectangle.y == 140 then filledBottom = filledBottom + 1 end
		if rectangle.y == 133 then filledTop = filledTop + 1 end
	end
end
check(filledTop == 9 and filledBottom == 4, "equipment displays ordinary durability above filter condition")

print("Gasmask filter checks passed:", checks)
