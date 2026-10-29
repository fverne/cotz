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
ix = {item = {list = {}, base = {}, instances = {}}, util = {}, meta = {item = {}}}
ix.meta.item.__index = ix.meta.item
function ix.meta.item:GetData(key, default)
	if self.data and self.data[key] ~= nil then return self.data[key] end

	return default
end
function ix.meta.item:SetData(key, value)
	self.data = self.data or {}
	self.data[key] = value
end

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
	local path = itemRoot .. "valuable/sh_" .. id .. ".lua"
	ix.item.Register(id, "base_valuable", false, path)
	local item = ix.item.list[id]
	check(item.base == "base_valuable", "all new items use the existing valuable base")
	check(item.price > 0 and item.width >= 1 and item.height >= 1, "positive concrete tuning")
	check(#item.longdesc > 200 and #item.description > 10, "both descriptions are supplied")
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
check(#itemIDs == 50, "all 50 new definitions are registered")
check(ix.item.base.base_valuable.functions.combine == nil, "existing valuable base has no new actions")
check(ix.item.base.base_valuable_stack == nil, "no additional valuable base is registered")

local function actor()
	local inventory = {items = {}}
	function inventory:GetItemByID(id) return self.items[id] end
	local character = {inventory = inventory}
	function character:GetInventory() return self.inventory end
	local client = {valid = true, character = character}
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

ix.taskRewards = {}
dofile("gamemodes/ix_cotz/plugins/jobsystem/libs/sh_taskrewards.lua")
for id in pairs(capacities) do
	local item = ix.item.list[id]
	check(ix.taskRewards.UnitValue(id) == item.price, "task unit quote uses per-unit stack value")
	check(ix.taskRewards.ExpectedValue(id) == item.price * 1.5, "task estimate uses the mean of the 1-2 spawn roll")
	check(ix.taskRewards.ExpectedValue(id, {quantity = 2}) == item.price * 2, "explicit reward quantity is retained")
end
print("valuable_items_spec: " .. checks .. " checks passed")
