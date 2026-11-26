-- Run from the addon root: luatex --luaonly tests/valuable_items_spec.lua
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end

local function read(path)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()

	return source
end

local function copy(value, seen)
	if type(value) ~= "table" then return value end
	seen = seen or {}
	if seen[value] then return seen[value] end
	local result = setmetatable({}, getmetatable(value))
	seen[value] = result
	for key, entry in pairs(value) do result[key] = copy(entry, seen) end

	return result
end

table.Copy = copy
table.Merge = function(target, source)
	for key, value in pairs(source) do
		if type(value) == "table" and type(target[key]) == "table" then
			table.Merge(target[key], value)
		else
			target[key] = value
		end
	end

	return target
end

isnumber = function(value) return type(value) == "number" end
istable = function(value) return type(value) == "table" end
IsValid = function(value) return type(value) == "table" and value.valid == true end
Vector = function(...) return {...} end
Angle = Vector
Format = string.format
CLIENT = false
SERVER = true
ErrorNoHalt = error
local now = 0
CurTime = function() return now end
ix = {item = {list = {}, base = {}, instances = {}, inventories = {}}, util = {}, meta = {item = {}}}
ix.meta.item.__index = ix.meta.item
function ix.meta.item:GetData(key, default)
	if self.data and self.data[key] ~= nil then return self.data[key] end

	return default
end
function ix.meta.item:SetData(key, value)
	self.data = self.data or {}
	self.data[key] = value
end
dofile("gamemodes/ix_cotz/schema/meta/sh_itemstack.lua")

-- Exercise the installed registration and inheritance code, translating only its GLua operators.
local loader = read("gamemodes/helix/gamemode/core/libs/sh_item.lua")
local start = assert(loader:find("function ix.item.Register(", 1, true))
local finish = assert(loader:find("\nend", start, true)) + 3
local registerSource = loader:sub(start, finish):gsub("!=", "~="):gsub("!", "not ")
assert(load(registerSource, "@Helix item registration"))()
ix.util.Include = function(path)
	local source = read(path):gsub("!=", "~="):gsub("!", "not ")
	assert(load(source, "@" .. path))()
end
local itemRoot = "gamemodes/ix_cotz/schema/items/"
ix.item.Register("base_valuable", nil, true, itemRoot .. "base/sh_valuable.lua")
ix.item.Register("base_valuables_test", nil, true, itemRoot .. "base/sh_valuables_test.lua")
ix.item.Register("base_zquests", nil, true, itemRoot .. "base/sh_zquests.lua")
local capacities = {value_pcpart_ram = 5, value_screws = 4, value_pcpart_cpu = 6}
ix.randomitems = {tables = {}, tableweights = {}}
local itemIDs = {
	"value_soap",
	"value_shampoo",
	"value_bleach",
	"value_chlorine",
	"value_draincleaner",
	"value_glasscleaner",
	"value_ratpoison",
	"value_officepaper",
	"value_screws",
	"value_metalparts",
	"value_plexiglass",
	"value_expandingfoam",
	"value_screwdriver",
	"value_pliers",
	"value_wrench",
	"value_pipewrench",
	"value_handdrill",
	"value_tapemeasure",
	"value_awl",
	"value_precisiontools",
	"value_fabric_aramid",
	"value_fabric_cordura",
	"value_fabric_fleece",
	"value_fabric_ripstop",
	"value_circuitboard",
	"value_pcpart_cpu",
	"value_pcpart_ram",
	"value_pcpart_cpufan",
	"value_pcpart_discdrive",
	"value_powercable",
	"value_powerfilter",
	"value_lamp_efficient",
	"value_lamp_uv",
	"value_gyroscope",
	"value_pressuregauge",
	"value_optical_lens",
	"value_militaryboard",
	"value_thermalmodule",
	"value_pcpart_laptop",
	"value_antique_teapot",
	"value_antique_vase",
	"value_woodclock",
	"value_skullring",
	"value_lighter_gold",
	"value_statue_raven",
	"value_pocketwatch",
	"value_bear_souvenir",
	"value_handbook_circuits",
	"value_handbook_materials",
	"value_archive_cassette",
}
for _, id in ipairs(itemIDs) do
	local folder = "valuables_test"
	local existing = io.open(itemRoot .. folder .. "/sh_" .. id .. ".lua")
	if existing then
		existing:close()
	else
		folder = "zquests"
		existing = io.open(itemRoot .. folder .. "/sh_" .. id .. ".lua")
		if existing then
			existing:close()
		else
			folder = "valuable"
		end
	end
	local path = itemRoot .. folder .. "/sh_" .. id .. ".lua"
	local expectedBase = "base_" .. folder
	ix.item.Register(id, expectedBase, false, path)
	local item = ix.item.list[id]
	check(item.base == expectedBase, "items use their configured valuable base")
	check(item.price > 0 and item.width >= 1 and item.height >= 1, "positive concrete tuning")
	check(item.longdesc:find("%S") and #item.description > 10, "both descriptions are supplied")
	check(not item.longdesc:find(item.description, 1, true), "long descriptions extend the short description")
	check(item.model:match("%.mdl$") and item.exRender == true, "model and extended icon are configured")
	check(#item.iconCam.pos == 3 and #item.iconCam.ang == 3 and item.iconCam.fov > 0, "complete camera")
	if capacities[id] then
		check(item.quantity == capacities[id], "requested stack capacity")
		check(item.initialQuantity == nil, "no replacement quantity convention")
		check(item.flatweight == 0 and item.weight > 0, "stack weight is entirely per unit")
		check(item.GetWeight == ix.item.base.base_valuable.GetWeight, "weight comes from the existing base")
		check(read(path):find("function ITEM:GetPrice()", 1, true), "pricing is defined on the item")
		check(read(path):find("function ITEM:OnInstanced()", 1, true), "initial quantity is defined on the item")
	else
		check(item.quantity == nil and item.flatweight > 0, "ordinary valuables remain fixed-weight objects")
	end
end
local properties = {}
ix.util.PropertyDesc = function(_, label) properties[#properties + 1] = label end
local tooltipItem = ix.item.list.value_soap
tooltipItem:PopulateTooltip({})
check(properties[1] == "Valuable" and properties[2] == "Cleaning Supplies",
	"inventory tooltips show the readable valuable category")
properties = {}
tooltipItem.entity = {}
tooltipItem:PopulateTooltip({})
check(#properties == 0, "world item tooltips retain their existing property visibility")
tooltipItem.entity = nil
check(#itemIDs == 50, "all 50 new definitions are registered")
check(ix.item.base.base_valuable.functions.combine == nil, "the valuable base adds no combine action")
check(ix.item.base.base_valuable_stack == nil, "no additional valuable base is registered")

local nextInventoryID = 0
local function container(receivers)
	nextInventoryID = nextInventoryID + 1
	local inventory = {id = nextInventoryID, items = {}, receivers = receivers}
	function inventory:GetItemByID(id) return self.items[id] end
	function inventory:OnCheckAccess(client) return self.receivers[client] == true end
	ix.item.inventories[inventory.id] = inventory

	return inventory
end
local function actor()
	local client = {valid = true}
	local inventory = container({[client] = true})
	local character = {inventory = inventory}
	function character:GetInventory() return self.inventory end
	client.character = character
	function client:GetCharacter() return self.character end
	function client:EmitSound() self.sounds = (self.sounds or 0) + 1 end

	return client, inventory
end
local client, inventory = actor()
local nextID = 0
local function instance(id, quantity, owner, targetInventory)
	nextID = nextID + 1
	local item = setmetatable({id = nextID, uniqueID = id, player = owner or client, data = {}}, {
		__index = ix.item.list[id],
	})
	if quantity ~= nil then item.data.quantity = quantity end
	ix.item.instances[item.id] = item
	local ownerInventory = targetInventory or inventory
	ownerInventory.items[item.id] = item
	item.invID = ownerInventory.id

	return item
end
for id, capacity in pairs(capacities) do
	local item = instance(id)
	item:OnInstanced()
	local initial = item:GetData("quantity")
	check(initial == 1 or initial == 2, "unseeded quantity rolls like spark plugs")
	check(item:GetPrice() == item.price * initial, "initial value uses rolled units")
	check(item:GetWeight() == item.weight * initial, "initial mass uses rolled units")
	item:SetData("quantity", capacity - 1)
	item:OnInstanced()
	check(item:GetData("quantity") == capacity - 1, "explicit or saved quantities do not reroll")
	check(item:GetPrice() == item.price * (capacity - 1), "price scales with remaining units")
	check(item:GetWeight() == item.weight * (capacity - 1), "weight scales with remaining units")
end
local function combine(source, target)
	now = now + 1

	return source.functions.combine.OnRun(source, {target.id})
end
local source = instance("value_pcpart_ram", 4)
local target = instance("value_pcpart_ram", 3)
local totalPrice, totalWeight = source:GetPrice() + target:GetPrice(), source:GetWeight() + target:GetWeight()
check(combine(source, target) == false, "partial merge keeps the source item")
check(source:GetData("quantity") == 2 and target:GetData("quantity") == 5, "merge stops at capacity")
check(source:GetPrice() + target:GetPrice() == totalPrice, "partial merge conserves value")
check(math.abs(source:GetWeight() + target:GetWeight() - totalWeight) < 0.000001, "merge conserves mass")
check(not source.functions.combine.OnCanRun(source, {target.id}), "full destination cannot be combined")
target:SetData("quantity", 3)
check(combine(source, target) == true, "complete merge asks Helix to remove the source")
check(source:GetData("quantity") == 0 and target:GetData("quantity") == 5, "complete merge consumes once")
check(combine(source, target) == false and target:GetData("quantity") == 5, "repeated request cannot duplicate")

source = instance("value_pcpart_cpu", 1)
target = instance("value_pcpart_cpu", 1)
check(not source.functions.combine.OnCanRun(source, {source.id}), "cannot combine an item with itself")
check(not source.functions.combine.OnCanRun(source, {}), "missing target is rejected")
check(not source.functions.combine.OnCanRun(source, {"1"}), "string target IDs are rejected")
check(not source.functions.combine.OnCanRun(source, {99999}), "deleted target is rejected")
check(not source.functions.combine.OnCanRun(source, {instance("value_screws", 1).id}), "different types cannot merge")
local otherClient, otherInventory = actor()
local foreign = instance("value_pcpart_cpu", 1, otherClient, otherInventory)
check(combine(source, foreign) == false, "foreign inventory target is rejected")
inventory.items[source.id] = nil
check(combine(source, target) == false, "source must belong to the current inventory")
inventory.items[source.id] = source
local stash = container({[client] = true})
local stashSource = instance("value_screws", 1, client, stash)
local stashTarget = instance("value_screws", 2, client, stash)
check(combine(stashSource, stashTarget) == true and stashTarget:GetData("quantity") == 3,
	"stacks combine inside an accessible container")
stash.receivers[client] = nil
stashSource = instance("value_screws", 1, client, stash)
check(combine(stashSource, stashTarget) == false, "inaccessible container is rejected")
local transferChecks = {}
local blockTransfer = false
hook = {Run = function(event, item, from, to)
	if event ~= "CanTransferItem" then return end
	transferChecks[#transferChecks + 1] = {item = item, from = from, to = to}
	if blockTransfer then return false end
end}
local ownerCharacter = {weightUpdates = 0}
function ownerCharacter:UpdateWeight() self.weightUpdates = self.weightUpdates + 1 end
ix.char = {loaded = {[77] = ownerCharacter}}
inventory.owner = 77
local cpuStash = container({[client] = true})
local stored = instance("value_pcpart_cpu", 2, client, cpuStash)
local carried = instance("value_pcpart_cpu", 3)
check(combine(stored, carried) == true and carried:GetData("quantity") == 5, "storage stack merges into inventory")
check(#transferChecks == 1 and transferChecks[1].from == cpuStash and transferChecks[1].to == inventory,
	"storage merges run inventory transfer rules")
check(ownerCharacter.weightUpdates == 1, "storage merge refreshes the character's carry weight")
local stashed = instance("value_pcpart_cpu", 5, client, cpuStash)
check(combine(carried, stashed) == false and carried:GetData("quantity") == 4 and stashed:GetData("quantity") == 6,
	"inventory stack partially merges into storage")
check(ownerCharacter.weightUpdates == 2, "inventory to storage merge refreshes carry weight")
blockTransfer = true
stored = instance("value_pcpart_cpu", 1, client, cpuStash)
check(combine(stored, carried) == false and stored:GetData("quantity") == 1 and carried:GetData("quantity") == 4,
	"blocked transfers leave both stacks unchanged")
blockTransfer = false
check(combine(source, instance("value_pcpart_cpu", 1, client, container({}))) == false,
	"inaccessible storage target is rejected")
check(combine(instance("value_pcpart_cpu", 1, client, container({})), carried) == false,
	"inaccessible storage source is rejected")
inventory.owner = nil
target.entity = {valid = true}
check(combine(source, target) == false, "world target is rejected")
target.entity = nil
source.entity = {valid = true}
check(combine(source, target) == false, "world source is rejected")
source.entity = nil
for _, quantity in ipairs({0, -1, 1.5, math.huge, 0 / 0, 7, "2"}) do
	source:SetData("quantity", quantity)
	check(combine(source, target) == false, "invalid source quantity is rejected")
	source:SetData("quantity", 1)
	target:SetData("quantity", quantity)
	check(combine(source, target) == false, "invalid target quantity is rejected")
	target:SetData("quantity", 1)
end
client.character = nil
check(combine(source, target) == false, "character changes invalidate ownership")
client.character = {GetInventory = function() return inventory end}
source:SetData("quantity", 3)
target:SetData("quantity", 1)
check(combine(source, target) == true, "valid CPU merge succeeds")
local another = instance("value_pcpart_cpu", 1)
check(another.functions.combine.OnRun(another, {target.id}) == false, "per-player server cooldown applies")
check(another:GetData("quantity") == 1 and target:GetData("quantity") == 4, "cooldown preserves quantities")

ix.util.GetMaterial = ix.util.GetMaterial or function(path) return path end
ix.item.Register("value_bolts", "base_valuable", false, itemRoot .. "valuable/sh_value_bolts.lua")
ix.item.Register("value_kerosene", "base_valuable", false, itemRoot .. "valuable/sh_value_kerosene.lua")
check(ix.item.list.value_bolts.functions.combine ~= nil, "original valuable stacks declare their own combine")
check(ix.item.list.value_soap.functions.combine == nil, "items without a combine action stay uncombinable")
local stash = container({[client] = true})
local bolts = instance("value_bolts", 15, client, stash)
local boltTarget = instance("value_bolts", 10, client, stash)
check(combine(bolts, boltTarget) == false and bolts:GetData("quantity") == 5 and boltTarget:GetData("quantity") == 20,
	"original valuable stacks merge to capacity inside containers")
check(not bolts.functions.combine.OnCanRun(bolts, {boltTarget.id}), "full original stacks cannot be combined")
local fuel = instance("value_kerosene", 3, client, stash)
local fuelTarget = instance("value_kerosene", 4, client, stash)
check(combine(fuel, fuelTarget) == true and fuelTarget:GetData("quantity") == 7, "fuel stacks use the base merge")
local cooker = instance("value_bolts", 1, client, stash)
cooker.cookertier, cooker.maxFuel = 2, 3
fuel = instance("value_kerosene", 1, client, stash)
check(fuel.functions.combine.OnCanRun(fuel, {cooker.id}), "fuel can still be combined into a matching cooker")
check(combine(fuel, cooker) == true and cooker:GetData("fuel") == 1, "refuelling consumes one unit of fuel")
check(not fuel.functions.combine.OnCanRun(fuel, {99999}), "fuel rejects a missing combine target")

-- Other quantity families keep their own combine declarations and share the item-meta helpers.
Vector = Vector or function(...) return {...} end
Angle = Angle or function(...) return {...} end
local include = ix.util.Include
ix.util.Include = function(path)
	-- Older item files use GMod line comments, which standard Lua cannot parse.
	local source = read(path):gsub("%s//[^\n]*", ""):gsub("!=", "~="):gsub("!", "not ")
	assert(load(source, "@" .. path))()
end
ix.item.Register("base_newammo", nil, true, itemRoot .. "base/sh_newammo.lua")
ix.item.Register("556x45hp", "base_newammo", false, itemRoot .. "newammo/sh_556x45hp.lua")
ix.item.Register("bagrubles", nil, false, itemRoot .. "miscellaneous/sh_bagrubles.lua")
ix.item.Register("medic_antipsychotic_1", nil, false, itemRoot .. "aid/sh_medic_antipsychotic_1.lua")
ix.util.Include = include
check(ix.item.list.medic_antipsychotic_1.functions.combine == nil, "use-count items such as asenapine stay uncombinable")
local ammo = instance("556x45hp", nil, client, stash)
local ammoTarget = instance("556x45hp", 290, client, stash)
check(ammo:GetStackQuantity() == 100 and ammo:GetStackCapacity() == 300, "ammo stacks use ammoAmount and maxStack")
check(combine(ammo, ammoTarget) == false and ammo:GetData("quantity") == 90 and ammoTarget:GetData("quantity") == 300,
	"ammo merges up to its stack limit")
local rubles = instance("bagrubles", 100, client, stash)
check(not rubles.functions.combine.OnCanRun(rubles, {boltTarget.id}), "rubles only combine with rubles")
local moreRubles = instance("bagrubles", 50, client, stash)
check(combine(rubles, moreRubles) == true and moreRubles:GetData("quantity") == 150, "ruble bundles merge")

ix.taskRewards = {}
ix.jobs = ix.jobs or {}
ix.jobs.field = ix.jobs.field or {}
ix.taskRewards = ix.taskRewards or {}
for _, name in ipairs({"settings", "rewardsettings", "fieldsettings", "killcredit", "regionalcatalogue"}) do
	dofile("gamemodes/ix_cotz/plugins/jobsystem/definitions/sh_" .. name .. ".lua")
end
dofile("gamemodes/ix_cotz/plugins/jobsystem/libs/sh_taskrewards.lua")
for id in pairs(capacities) do
	local item = ix.item.list[id]
	check(ix.taskRewards.UnitValue(id) == item.price, "task unit quote uses per-unit stack value")
	check(ix.taskRewards.ExpectedValue(id) == item.price * 1.5, "task estimate uses the mean of the 1-2 spawn roll")
	check(ix.taskRewards.ExpectedValue(id, {quantity = 2}) == item.price * 2, "explicit reward quantity is retained")
end
local questFiles = assert(io.popen("rg --files " .. itemRoot .. "zquests"))
local questCount = 0
for path in questFiles:lines() do
	local id = assert(path:match("/sh_(.+)%.lua$"))
	check(not read(path):find("ITEM.base", 1, true), "quest definitions inherit through their folder")
	ix.item.Register(id, "base_zquests", false, path)
	local item = ix.item.list[id]
	check(item.base == "base_zquests", "quest items use the folder base")
	check(item.GetWeight == ix.item.base.base_valuable.GetWeight, "quest items retain valuable mechanics")
	questCount = questCount + 1
end
questFiles:close()
check(questCount > 0, "quest candidates are registered")
print("valuable_items_spec: " .. checks .. " checks passed")
