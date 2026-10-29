-- Run from the addon root: luatex --luaonly tests/headgear_durability_spec.lua
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

local function loadMethod(path, signature, environment)
	local source = readSource(path)
	local first = assert(source:find(signature, 1, true))
	local last = assert(source:find("\nend", first, true)) + 3
	local method = source:sub(first, last):gsub("!=", "~="):gsub("!", "not ")
	assert(load(method, "@" .. path, "t", environment))()
end

SERVER = true
math.Clamp = function(value, minimum, maximum) return math.max(minimum, math.min(maximum, value)) end
IsValid = function(value) return type(value) == "table" and not value.invalid end
local damageNames = {
	"BULLET", "SLASH", "CLUB", "CRUSH", "FALL", "SHOCK", "BURN", "ACID", "BLAST", "DROWN",
	"POISON", "NERVEGAS", "SLOWBURN", "RADIATION", "SONIC", "AIRBOAT",
}
DMG_GENERIC = 0
for index, name in ipairs(damageNames) do _G["DMG_" .. name] = 2 ^ (index - 1) end
ix = {util = {GetMaterial = function() end}, temp = {Corpses = {}}}
dofile("gamemodes/ix_cotz/plugins/suits/sh_durability.lua")
ITEM = {}
local gearPath = "gamemodes/ix_cotz/schema/items/base/sh_gear.lua"
local gearSource = readSource(gearPath)
local prefixEnd = assert(gearSource:find("ITEM.miscSlots", 1, true)) - 1
assert(load(gearSource:sub(1, prefixEnd), "@gear/base", "t", _G))()
for _, method in ipairs({"getBR", "getFBR", "getRadProt"}) do
	loadMethod(gearPath, "function ITEM:" .. method .. "(", _G)
end
ITEM.__index = ITEM
function ITEM:GetData(key, default)
	local value = self.data[key]
	if value == nil then return default end

	return value
end
function ITEM:SetData(key, value) self.data[key] = value end
local function gear(flags, durability)
	flags.data = {equip = true, durability = durability}

	return setmetatable(flags, ITEM)
end

local helmet = gear({isHelmet = true, br = 0.2, fbr = 4, radProt = 0.5}, 100)
local mask = gear({isGasmask = true}, 100)
local combined = gear({isHelmet = true, isGasmask = true}, 100)
local suit = gear({isBodyArmor = true, isHelmet = true}, 100)
local backpack = gear({isBackpack = true}, 100)
local spare = gear({isHelmet = true}, 100)
spare.data.equip = false
local unlimited = gear({isHelmet = true}, 100)
unlimited.data.unlimitedDurability = true
local items = {helmet, mask, combined, suit, backpack, spare, unlimited}
local inventory = {GetItems = function() return items end}
local character = {
	GetInventory = function() return inventory end,
	GetData = function(_, _, default) return default end,
}
local client = {
	Alive = function() return true end,
	GetCharacter = function() return character end,
	RecalculateResistances = function(self) self.recalculations = (self.recalculations or 0) + 1 end,
	IsPlayer = function() return true end,
	GetNWFloat = function() return 1 end,
	GetNWInt = function() return 0 end,
	getPercentageRadResist = function() return 1 end,
	getFlatRadResist = function() return 0 end,
}
local world = {IsPlayer = function() return false end, IsNPC = function() return false end}
local function hit(damageType, amount, attacker)
	local info = {damageType = damageType, damage = amount}
	function info:IsDamageType(flag) return math.floor(self.damageType / flag) % 2 == 1 end
	function info:GetDamageType() return self.damageType end
	function info:GetDamage() return self.damage end
	function info:GetAttacker() return attacker or world end
	ix.util.DamageHeadgear(client, info)
end

for _, damageType in ipairs({DMG_BULLET, DMG_SLASH, DMG_CLUB, DMG_CRUSH}) do hit(damageType, 100) end
check(helmet.data.durability == 99 and mask.data.durability == 99, "Combat wears helmets and masks slowly")
check(combined.data.durability == 99, "Combined headgear wears once per hit")
check(suit.data.durability == 100 and backpack.data.durability == 100, "Other equipment is unaffected")
check(spare.data.durability == 100 and unlimited.data.durability == 100, "Only vulnerable equipped gear wears")
for _, damageType in ipairs({DMG_BURN, DMG_ACID, DMG_RADIATION, DMG_SONIC, DMG_AIRBOAT}) do
	hit(damageType, 100)
end
check(helmet.data.durability == 94, "Environmental damage wears headgear faster")
hit(DMG_SHOCK + DMG_BURN, 100)
check(helmet.data.durability == 93, "Combined environmental flags wear only once")
hit(DMG_FALL, 100)
hit(DMG_FALL + DMG_BURN, 100)
hit(DMG_BULLET, 0)
hit(DMG_BULLET, -100)
check(helmet.data.durability == 93, "Falling and nonpositive damage do not wear gear")
hit(DMG_GENERIC, 100, client)
check(helmet.data.durability == 92.75, "Generic punches use combat wear")
hit(DMG_GENERIC, 100)
check(helmet.data.durability == 91.75, "Generic environmental effects use environmental wear")
ix.temp.Corpses[client] = {}
hit(DMG_BULLET, 100)
check(helmet.data.durability == 91.75, "Protected corpses do not wear headgear")
ix.temp.Corpses[client] = nil
helmet.data.durability = nil
hit(DMG_BULLET, 100)
check(helmet.data.durability == 99.75, "Existing gear without condition starts at full durability")
helmet.data.durability = 40
check(helmet:GetDurabilityScale() == 0.5, "Protection scales below 80 percent")
check(helmet:getBR() == 0.1 and helmet:getFBR() == 2, "Tooltip ballistic values scale with condition")
check(helmet:getRadProt() == 0.25, "Radiation protection scales with condition")
hit(DMG_BURN, 100000)
check(helmet.data.durability == 0 and helmet:getBR() == 0, "Broken headgear gives no protection")
helmet.data.durability = 100
check(helmet:GetDurabilityScale() == 1 and helmet.canRepair, "Repairs restore full protection")
check(backpack:GetDurabilityScale() == 1, "Other gear keeps its original protection")
check(client.recalculations > 0, "Wear refreshes cached player resistances")

local playerMeta = {}
FindMetaTable = function() return playerMeta end
ix.util.Include = function() end
ix.config = {Add = function() end, Get = function(_, default) return default end}
PLUGIN = {}
local suitsPath = "gamemodes/ix_cotz/plugins/suits/sh_plugin.lua"
local suitsSource = readSource(suitsPath)
suitsSource = suitsSource:gsub("!=", "~="):gsub("!", "not ")
assert(load(suitsSource, "@" .. suitsPath, "t", _G))()
client.GetNWFloat = function() return 1 end
client.GetNWInt = function() return 0 end
client.getEquippedBodyArmor = function() return nil end
local saved = helmet.data.durability
local blocked = {
	GetAttacker = function() return {IsPlayer = function() return true end} end,
}
PLUGIN:EntityTakeDamage(client, blocked)
check(helmet.data.durability == saved, "Disabled PVP cannot wear equipment")
setmetatable(client, {__index = playerMeta})
items = {helmet, backpack}
helmet.data.durability = 40
check(math.abs(client:getPercentageBulletRes() - 0.9) < 0.000001, "Player bullet resistance uses condition")
check(client:getFlatBulletRes() == 2, "Player flat resistance uses condition")

local suitsPlugin = PLUGIN
local function overrideDamage(damageType)
	return {
		value = 100,
		GetDamage = function(self) return self.value end,
		SetDamage = function(self, value) self.value = value end,
		GetDamageType = function() return damageType end,
		IsDamageType = function(_, flag) return damageType == flag end,
		GetAttacker = function() return world end,
	}
end

ix.plugin = {list = {}}
MOVETYPE_NOCLIP = 8
client.GetMoveType = function() return 0 end
client.getPercentageRadResist = function() return 1 end
client.getFlatRadResist = function() return 0 end
client.hasGeiger = function() return false end
client.addRadiation = function() end
PLUGIN = {}
loadMethod("gamemodes/ix_cotz/plugins/radiation/sh_plugin.lua", "function PLUGIN:EntityTakeDamage(", _G)
helmet.data.durability = 100
local radiation = overrideDamage(DMG_RADIATION)
suitsPlugin:EntityTakeDamage(client, radiation)
PLUGIN:EntityTakeDamage(client, radiation)
check(helmet.data.durability == 99 and radiation.value == 0, "Radiation wears gear before zeroing health damage")
helmet.data.durability = 100
radiation.value = 100
PLUGIN:EntityTakeDamage(client, radiation)
suitsPlugin:EntityTakeDamage(client, radiation)
check(helmet.data.durability == 99, "Radiation wear is independent of hook order")
PLUGIN = {}
loadMethod("gamemodes/ix_cotz/plugins/psyhealth.lua", "function PLUGIN:EntityTakeDamage(", _G)
client.DamagePsyHealth = function() end
client.GetPsyHealth = function() return 100 end
helmet.data.durability = 100
local psychic = overrideDamage(DMG_SONIC)
suitsPlugin:EntityTakeDamage(client, psychic)
PLUGIN:EntityTakeDamage(client, psychic)
check(helmet.data.durability == 99 and psychic.value == 0, "Psychic effects wear gear once before health override")
-- Compare actual condition loss against suits with substantial percentage and flat protection.
client.getEquippedBodyArmor = function() return suit end
items = {helmet, suit}
client.GetNWFloat = function() return 0.2 end
client.GetNWInt = function() return 10 end
for _, damageType in ipairs({DMG_BULLET, DMG_SLASH, DMG_BURN, DMG_ACID}) do
	helmet.data.durability = 100
	suit.data.durability = 100
	local damage = overrideDamage(damageType)
	suitsPlugin:EntityTakeDamage(client, damage)
	local headgearWear = 100 - helmet.data.durability
	local suitWear = 100 - suit.data.durability
	local ratio = (damageType == DMG_BULLET or damageType == DMG_SLASH) and 0.25 or 0.5
	check(suitWear > 0 and math.abs(headgearWear / suitWear - ratio) < 0.000001,
		"Headgear wears slower than suits after protection: " .. damageType)
end
helmet.data.durability = 100
client.GetNWInt = function() return 100 end
suitsPlugin:EntityTakeDamage(client, overrideDamage(DMG_BULLET))
check(helmet.data.durability == 100, "Fully blocked damage does not wear headgear")
print("Headgear durability checks passed:", checks)
