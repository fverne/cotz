-- Run from the addon root: luatex --luaonly tests/anomaly_resistance_spec.lua
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

local function loadMethod(path, signature, environment)
	local source = read(path)
	local first = assert(source:find(signature, 1, true))
	local last = assert(source:find("\nend", first, true)) + 3
	assert(load(source:sub(first, last), "@" .. path, "t", environment or _G))()
end

SERVER = true
DMG_GENERIC = 0
for index, name in ipairs({
	"BULLET", "SLASH", "BURN", "SLOWBURN", "SHOCK", "ACID", "DROWN", "POISON", "NERVEGAS",
	"CRUSH", "BLAST", "FALL", "RADIATION", "SONIC", "AIRBOAT", "CLUB",
}) do
	_G["DMG_" .. name] = 2 ^ (index - 1)
end
math.Clamp = function(value, minimum, maximum) return math.max(minimum, math.min(maximum, value)) end
math.Round = function(value) return math.floor(value + 0.5) end
IsValid = function(value) return type(value) == "table" and not value.invalid end
hook = {Run = function() end}
ix = {
	util = {Include = function() end, GetMaterial = function() end},
	config = {Add = function() end, Get = function(_, default) return default end},
	temp = {Corpses = {}},
	armortables = {
		upgrades = {broad = {ar = 0.05, far = 2}},
		attachments = {broad = {ar = 0.2, far = 50}},
	},
}
dofile("gamemodes/ix_cotz/plugins/suits/sh_resistances.lua")
dofile("gamemodes/ix_cotz/plugins/suits/sh_durability.lua")
ITEM = {ar = 0, far = 0, miscSlots = {}, isBodyArmor = true}
loadMethod("gamemodes/ix_cotz/schema/items/base/sh_suit.lua", "function ITEM:getAR(")
loadMethod("gamemodes/ix_cotz/schema/items/base/sh_suit.lua", "function ITEM:getFAR(")
local suitBase = ITEM
suitBase.__index = suitBase
function suitBase:GetData(key, default)
	local value = self.data[key]
	if value == nil then return default end

	return value
end
function suitBase:SetData(key, value) self.data[key] = value end

local suit = setmetatable({ar = 0.3, far = 4, data = {equip = true, durability = 100}}, suitBase)
for _, definition in ipairs(ix.suits.anomalyTypes) do
	near(suit:getAR(definition.field), 0.7, "Legacy percentage fallback: " .. definition.name)
	near(suit:getFAR(definition.flatField), 4, "Legacy flat fallback: " .. definition.name)
end
suit.thermalRes, suit.flatThermalRes = 0.6, 8
suit.electricalRes, suit.flatElectricalRes = 0.4, 6
suit.chemicalRes, suit.flatChemicalRes = 0.2, 2
suit.gravitationalRes, suit.flatGravitationalRes = 0, 0
near(suit:getAR("thermalRes"), 0.4, "Thermal tuning is independent")
near(suit:getAR("electricalRes"), 0.6, "Electrical tuning is independent")
near(suit:getAR("chemicalRes"), 0.8, "Chemical tuning is independent")
near(suit:getAR("gravitationalRes"), 1, "Explicit zero overrides legacy percentage")
near(suit:getFAR("flatGravitationalRes"), 0, "Explicit zero overrides legacy flat protection")
suit.data.durability = 40
near(suit:getAR("thermalRes"), 0.7, "Durability tapers typed percentage protection")
near(suit:getFAR("flatThermalRes"), 4, "Durability tapers typed flat protection")
suit.data.durability = 0
near(suit:getAR("thermalRes"), 1, "Broken suits lose base percentage protection")
near(suit:getFAR("flatThermalRes"), 0, "Broken suits lose base flat protection")
suit.data.durability = 100
suit.data.upgrades = {"broad", "removed"}
suit.data.attachments = {exteriorSlots = {"broad", "removed"}, interiorSlots = false}
for _, definition in ipairs(ix.suits.anomalyTypes) do
	near(suit:getAR(definition.field), (1 - suit[definition.field] - 0.05) * 0.8,
		"Broad upgrades and attachments retain their formula: " .. definition.name)
	near(suit:getFAR(definition.flatField), suit[definition.flatField] + 2,
		"Broad flat upgrades retain their formula: " .. definition.name)
end
ix.armortables.upgrades.broad.thermalRes = 0
ix.armortables.upgrades.broad.flatThermalRes = 0
near(suit:getAR("thermalRes"), 0.32, "Typed zero upgrade overrides its broad bonus")
near(suit:getFAR("flatThermalRes"), 8, "Typed zero flat upgrade overrides its broad bonus")
suit.data.upgrades, suit.data.attachments = nil, nil

-- Load every concrete definition, including faction variants, and preserve its existing tuning.
local paths = assert(io.popen("rg --files gamemodes/ix_cotz/schema/items/suit"))
local suitCount = 0
for path in paths:lines() do
	ITEM = {skincustom = {}, bgcustom = {}, functions = {}}
	assert(load(read(path):gsub("!=", "~="):gsub("!", "not "), "@" .. path))()
	for _, definition in ipairs(ix.suits.anomalyTypes) do
		check(ITEM[definition.field] == ITEM.ar, path .. " preserves percentage: " .. definition.name)
		check(ITEM[definition.flatField] == ITEM.far, path .. " preserves flat protection: " .. definition.name)
	end
	suitCount = suitCount + 1
end
paths:close()
check(suitCount > 0, "Concrete suits were discovered for protection checks")

local playerMeta = {}
FindMetaTable = function() return playerMeta end
PLUGIN = {}
dofile("gamemodes/ix_cotz/plugins/suits/sh_plugin.lua")
local suitsPlugin = PLUGIN
local helmet = {
	ar = 0.2, far = 2, isHelmet = true, data = {equip = true, durability = 40},
	GetData = suitBase.GetData, SetData = suitBase.SetData,
	GetDurabilityScale = function(self) return math.Clamp(self.data.durability / 80, 0, 1) end,
}
local spare = setmetatable({ar = 0.9, far = 100, data = {equip = false}}, suitBase)
local items = {suit, helmet, spare}
local wishes = {}
local character = {
	GetInventory = function() return {GetItems = function() return items end} end,
	GetData = function(_, key, default) if key == "wishes" then return wishes end return default end,
}
local world = {IsPlayer = function() return false end, IsNPC = function() return false end}
local client = setmetatable({network = {}}, {__index = playerMeta})
function client:GetCharacter() return character end
function client:IsPlayer() return true end
function client:Alive() return true end
function client:GetNWFloat(key, default) return self.network[key] or default end
function client:GetNWInt(key, default) return self.network[key] or default end
function client:SetNWFloat(key, value) self.network[key] = value end
client.SetNWInt = client.SetNWFloat
for _, name in ipairs({
	"getPercentageBulletRes", "getFlatBulletRes", "getPercentageSlashRes", "getFlatSlashRes",
	"getPercentagePsyRes", "getFlatPsyRes",
}) do
	client[name] = function() return 0 end
end
for _, definition in ipairs(ix.suits.anomalyTypes) do
	near(client:getPercentageAnomalyRes(definition.field), (1 - suit[definition.field]) * 0.9,
		"Equipped headgear and suit percentage combine: " .. definition.name)
	near(client:getFlatAnomalyRes(definition.flatField), suit[definition.flatField] + 1,
		"Equipped headgear and suit flat combine: " .. definition.name)
end
wishes.far = true
client:RecalculateResistances()
for _, definition in ipairs(ix.suits.anomalyTypes) do
	near(client.network["ixper" .. definition.network .. "res"], (1 - suit[definition.field]) * 0.9,
		"Each percentage is networked independently: " .. definition.name)
	near(client.network["ixflat" .. definition.network .. "res"], suit[definition.flatField] + 6,
		"Wish flat protection applies to every type: " .. definition.name)
end
helmet.thermalRes, helmet.flatThermalRes = 0, 0
near(client:getPercentageAnomalyRes("thermalRes"), 0.4, "Typed zero headgear overrides broad protection")
near(client:getFlatAnomalyRes("flatThermalRes"), 13, "Typed zero headgear overrides broad flat protection")

local function damageInfo(damageType, amount)
	local info = {amount = amount or 100}
	function info:GetDamage() return self.amount end
	function info:SetDamage(value) self.amount = value end
	function info:GetDamageType() return damageType end
	function info:IsDamageType(flag) return math.floor(damageType / flag) % 2 == 1 end
	function info:GetAttacker() return world end

	return info
end

-- Distinct cached values catch incorrect routing even though production suits start with equal ratings.
items = {suit, helmet}
for index, definition in ipairs(ix.suits.anomalyTypes) do
	client.network["ixper" .. definition.network .. "res"] = index / 10
	client.network["ixflat" .. definition.network .. "res"] = index
end
client.RecalculateResistances = function() end
for index, definition in ipairs(ix.suits.anomalyTypes) do
	for _, damageType in ipairs(definition.damageTypes) do
		suit.data.durability, helmet.data.durability = 100, 100
		local info = damageInfo(damageType)
		suitsPlugin:EntityTakeDamage(client, info)
		local expected = (100 - index) * index / 10
		near(info.amount, expected, "Damage selects matching protection: " .. damageType)
		near(suit.data.durability, 100 - expected / 50, "Suit wear uses matching damage: " .. damageType)
		near(helmet.data.durability, 100 - expected / 100, "Headgear wear uses matching damage: " .. damageType)
	end
end
near(ix.suits.GetAnomalyDamage(client, damageInfo(DMG_BURN + DMG_SHOCK)), 19.6,
	"Mixed families use weakest protection once")
near(ix.suits.GetAnomalyDamage(client, damageInfo(DMG_BURN + DMG_SLOWBURN)), 9.9,
	"Mixed flags from one family do not stack")
near(ix.suits.GetAnomalyDamage(client, damageInfo(DMG_BURN, 0)), 0, "Flat absorption cannot heal")
for _, damageType in ipairs({DMG_GENERIC, DMG_FALL, DMG_RADIATION, DMG_SONIC, DMG_BULLET, DMG_CLUB}) do
	check(ix.suits.GetAnomalyDamage(client, damageInfo(damageType)) == nil,
		"Other damage retains its existing handling: " .. damageType)
end
local unarmored = {GetNWFloat = function(_, _, default) return default end, GetNWInt = function() return 0 end}
near(ix.suits.GetAnomalyDamage(unarmored, damageInfo(DMG_BURN)), 100, "Missing cache means no protection")

-- Verify tooltip conversion reads independent effective values without changing the equipment summary.
dofile("gamemodes/ix_cotz/schema/libs/sh_itemproperties.lua")
for _, name in ipairs({"getBR", "getSR", "getPR"}) do suit[name] = function() return 1 end end
for _, name in ipairs({"getFBR", "getFSR", "getFPR", "GetFlatRadProt"}) do suit[name] = function() return 0 end end
suit.getRadProt = function() return 0 end
suit.isBodyArmor = true
suit.data.durability = 40
local rows = {}
for _, row in ipairs(ix.itemProperties.GetProtection(suit)) do rows[row.id] = row.text end
for _, definition in ipairs(ix.suits.anomalyTypes) do
	local reduction = suit[definition.field] / 2
	local flat = suit[definition.flatField] / 2
	local expected = definition.name .. ": " .. ix.itemProperties.Format(definition.network, reduction)
		.. "; absorption " .. ix.itemProperties.Format(definition.network, flat / 100)
	check(rows["protection/" .. definition.network] == expected, "Tooltip effective protection: " .. definition.name)
end
PLUGIN = {}
dofile("gamemodes/ix_cotz/plugins/equipmentslots/cl_layout.lua")
local panelMethods = {}
loadMethod("gamemodes/ix_cotz/plugins/equipmentslots/cl_plugin.lua", "function PANEL:UpdateProtection()",
	setmetatable({PLUGIN = PLUGIN, PANEL = panelMethods, LocalPlayer = function() return client end}, {__index = _G}))
local panel = {statistics = {}}
for index in ipairs(PLUGIN.protectionTypes) do
	panel.statistics[index] = {SetTooltip = function(self, value) self.tooltip = value end}
end
panelMethods.UpdateProtection(panel)
for index, definition in ipairs(PLUGIN.protectionTypes) do
	if definition.multiplier and definition.name ~= "Ballistic" and definition.name ~= "Rupture"
		and definition.name ~= "Psy" then
		near(panel.statistics[index].fraction, 1 - client.network[definition.multiplier],
			"Equipment summary reads typed percentage: " .. definition.name)
		check(panel.statistics[index].tooltip:find(client.network[definition.flat] .. " flat", 1, true),
			"Equipment tooltip reads typed flat protection: " .. definition.name)
	end
end

print("Anomaly resistance: " .. checks .. " checks passed across " .. suitCount .. " suits")
