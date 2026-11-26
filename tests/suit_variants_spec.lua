-- Run from the repository root: luatex --luaonly tests/suit_variants_spec.lua
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end
local function near(actual, expected, message, tolerance)
	check(math.abs(actual - expected) <= (tolerance or 0.000001),
		string.format("%s: %s ~= %s", message, tostring(actual), tostring(expected)))
end
local function read(path)
	local file = assert(io.open(path, "r"), path)
	local source = file:read("*a")
	file:close()

	return (source:gsub("\r\n", "\n"))
end
local function standardLua(source)
	return (source:gsub("!=", "~="):gsub("!", "not "):gsub("&&", "and"):gsub("||", "or")
		:gsub("//[^\n]*", ""):gsub("(%s)continue(%s)", "%1goto skip%2"))
end

-- Concrete definitions.
ix = {suitAppearance = {SkinOptions = function() return {} end}, util = {GetMaterial = function() end}}
local suits = {}
local paths = assert(io.popen("rg --files gamemodes/ix_cotz/schema/items/suit"))
for path in paths:lines() do
	ITEM = {functions = {}}
	assert(load(standardLua(read(path)), "@" .. path))()
	suits[path:match("sh_(suit_[%w_]+)%.lua$")] = ITEM
end
paths:close()

local TYPES = {"authority", "mercenary", "ecologist", "fanatic", "anarchist", "scavenger", "looted"}
local GEMS = {"ruby", "sapphire", "emerald", "amethyst", "diamond"}
local SIX = {"br", "sr", "impactRes", "thermalRes", "electricalRes", "chemicalRes"}
local FLATS = {"fbr", "fsr", "far", "flatImpactRes", "flatThermalRes", "flatElectricalRes",
	"flatChemicalRes", "flatRadProt"}
local FIXED_PRICE = {suit_exoskeleton = true, suit_nosorog = true}

local function anySix(item)
	local total = 0
	for _, key in ipairs(SIX) do total = total + item[key] end

	return total / #SIX
end

local families = 0
for id, base in pairs(suits) do
	check(base.fullRepairCost and base.fullRepairCost > 0, id .. " declares its full repair cost")
	if not base.suitVariant or base.baseSuit == id then
		local isBase = base.baseSuit == id or id == "suit_ssp99m"
		if isBase then
			-- Base impact is the mean of bullet and rupture. SEVA was lowered by hand afterwards.
			local expected = id == "suit_seva" and 0.235 or (base.br + base.sr) / 2
			near(base.impactRes, expected, id .. " base impact", 0.0006)
		end
	end
	if base.baseSuit == id and id ~= "suit_ssp99" then
		families = families + 1
		for _, kind in ipairs(TYPES) do
			local variant = suits[id .. "_" .. kind]
			check(variant, id .. " has a " .. kind .. " variant")
			check(variant.baseSuit == id, id .. " " .. kind .. " converts within its family")
			for _, key in ipairs(FLATS) do
				check(variant[key] == base[key], id .. " " .. kind .. " keeps base " .. key)
			end
			check(variant.fullRepairCost == base.fullRepairCost, id .. " " .. kind .. " repairs like its base")
			check(variant.extraSlots == base.extraSlots + (kind == "anarchist" and 1 or 0),
				id .. " " .. kind .. " misc slots")
			local price = FIXED_PRICE[id] and base.price or math.floor(base.price * 1.1 + 0.5)
			check(variant.price == price, id .. " " .. kind .. " price")
			if kind == "looted" then
				near(variant.meleeDamageBonus, anySix(base), id .. " melee bonus uses base stats", 0.0006)
			else
				check(variant.meleeDamageBonus == nil, id .. " " .. kind .. " has no melee perk")
			end
			if kind == "fanatic" then
				-- Psychic adds the mean of the variant's own six values, capped like the rest.
				near(variant.pr, math.min((base.pr or 0) + anySix(variant), 0.9), id .. " fanatic psychic", 0.0015)
			end
		end
	end
end
check(families == 21, "every suit family but SSP-99 offers all seven types")
for _, gem in ipairs(GEMS) do
	local variant = suits["suit_ssp99_" .. gem]
	check(variant and variant.baseSuit == "suit_ssp99" and variant.suitVariant == gem, "SSP-99 " .. gem)
	check(variant.price == math.floor(suits.suit_ssp99.price * 1.1 + 0.5), gem .. " price")
end
near(suits.suit_ssp99_diamond.impactRes, 0.3, "Diamond gives 30% impact protection")
near(suits.suit_seva.sr, 0.3, "SEVA rupture")
check(suits.suit_seva.price == 1500000, "SEVA price")
check(not suits.suit_ssp99m_authority and not suits.suit_ssp99m.baseSuit, "SSP-99M has no variants")
check(not suits.suit_trenchcoat_black, "the colour items are retired")

-- Prices follow the score of bullet, rupture, impact and one anomaly value.
local listed = {"anorak", "mailjacket", "trenchcoat", "sunrise", "io7a", "cs1", "wind", "ps5m", "expedition",
	"cs2", "cs3", "berill", "cs4", "cs5", "seva", "skat10", "skat9", "radsuit"}
local previousScore, previousPrice, previousRepair = 0, 0, 0
for _, name in ipairs(listed) do
	local item = suits["suit_" .. name]
	local score = (item.br + item.sr + item.impactRes + item.ar) / 4
	check(score > previousScore and item.price > previousPrice, name .. " price follows its score")
	check(item.fullRepairCost >= previousRepair, name .. " repair bill follows its score")
	previousScore, previousPrice, previousRepair = score, item.price, item.fullRepairCost
end

-- Suit base: repair charges and saved slot limits.
CLIENT, SERVER = false, true
local function loadChunk(path, first, last)
	local source = read(path)
	local start = assert(source:find(first, 1, true), first)
	local _, finish = source:find(last, start, true)
	assert(load(standardLua(source:sub(start, finish)), "@" .. path))()
end
ITEM = {functions = {}}
for _, name in ipairs({"GetRepairCost", "GetDefinitionSlots", "GetMiscSlotLimit", "RefreshMiscSlotLimits"}) do
	loadChunk("gamemodes/ix_cotz/schema/items/base/sh_suit.lua", "function ITEM:" .. name .. "(", "\nend")
end
local base = ITEM
local function instance(definition, data)
	local item = setmetatable({data = data or {}}, {__index = function(_, key)
		if definition[key] ~= nil then return definition[key] end

		return base[key]
	end})
	function item:GetData(key, default)
		if self.data[key] == nil then return default end

		return self.data[key]
	end
	function item:SetData(key, value) self.data[key] = value end

	return item
end

local radsuit = instance(suits.suit_radsuit)
-- Services charge per missing point and double it.
check(math.floor(100 * radsuit:GetRepairCost() + 0.5) * 2 == suits.suit_radsuit.fullRepairCost,
	"a full repair costs the declared amount, not a share of the price")
check(instance({price = 1000}):GetRepairCost() == 1000 ^ (1 / 3), "definitions without it keep the old charge")

local owned = instance(suits.suit_anorak_anarchist,
	{maxMiscSlots = {exteriorSlots = 1, interiorSlots = 0, extraSlots = 0}})
check(owned:GetMiscSlotLimit("extraSlots") == 0, "an owned suit keeps its saved limit")
owned:RefreshMiscSlotLimits()
check(owned:GetMiscSlotLimit("extraSlots") == 1, "equipping again takes the definition's new slot")
check(instance(suits.suit_anorak_anarchist):GetMiscSlotLimit("extraSlots") == 1,
	"a suit without saved limits shows its definition")
local equipSource = read("gamemodes/ix_cotz/schema/items/base/sh_suit.lua")
local equipStart = assert(equipSource:find("ITEM.functions.Equip = {", 1, true))
check(equipSource:find("item:RefreshMiscSlotLimits()", equipStart, true), "the Equip action refreshes limits")
local loadoutStart = assert(equipSource:find("function ITEM:OnLoadout()", 1, true))
check(not equipSource:sub(loadoutStart, equipSource:find("\nend", loadoutStart)):find("MiscSlot"),
	"spawning does not refresh limits")

-- Protection cap.
ix.suits = nil
dofile("gamemodes/ix_cotz/plugins/suits/sh_resistances.lua")
near(ix.suits.CapDamageMultiplier(0.02), 0.1, "worn protection stops at 90%")
near(ix.suits.CapDamageMultiplier(-0.4), 0.1, "over-stacked protection cannot heal")
near(ix.suits.CapDamageMultiplier(0.6), 0.6, "lower protection is untouched")
local pluginSource = read("gamemodes/ix_cotz/plugins/suits/sh_plugin.lua")
for _, name in ipairs({"Bullet", "Slash", "Anomaly", "Psy"}) do
	local start = assert(pluginSource:find("function playerMeta:getPercentage" .. name .. "Res(", 1, true))
	local finish = pluginSource:find("\nend", start, true)
	check(pluginSource:sub(start, finish):find("return ix.suits.CapDamageMultiplier(res)", 1, true),
		name .. " totals are capped")
end

-- Looted melee perk.
DMG_SLASH, DMG_CLUB, DMG_BULLET = 4, 128, 2
IsValid = function(value) return value ~= nil end
weapons = {IsBasedOn = function(class, parent) return parent == "tfa_nmrimelee_base" and class == "machete" end}
PLUGIN = {}
dofile("gamemodes/ix_cotz/plugins/suits/sv_meleeperk.lua")
local perk = PLUGIN

local function weapon(class)
	return {IsWeapon = function() return true end, GetClass = function() return class end}
end
local suit = {meleeDamageBonus = 0.2}
local attacker = {stamina = 0, active = weapon("machete")}
function attacker:IsPlayer() return true end
function attacker:getEquippedBodyArmor() return suit end
function attacker:GetActiveWeapon() return self.active end
function attacker:RestoreStamina(amount) self.stamina = self.stamina + amount end
local mutant = {IsPlayer = function() return false end, IsNPC = function() return true end,
	IsNextBot = function() return false end}
local crate = {IsPlayer = function() return false end, IsNPC = function() return false end,
	IsNextBot = function() return false end}
local function hit(inflictor, damageType)
	return {
		damage = 100,
		IsDamageType = function(_, flag) return flag == damageType end,
		GetAttacker = function() return attacker end,
		GetInflictor = function() return inflictor end,
		ScaleDamage = function(self, scale) self.damage = self.damage * scale end,
	}
end

local blade = weapon("machete")
blade.cotzSwingStamina = 10
local swing = hit(blade, DMG_SLASH)
perk:ApplyMeleePerk(mutant, swing)
near(swing.damage, 120, "melee damage is raised")
check(attacker.stamina == 10 and blade.cotzSwingStamina == nil, "the swing's stamina is returned")
perk:ApplyMeleePerk(mutant, hit(blade, DMG_SLASH))
check(attacker.stamina == 10, "one swing is returned only once")
local viaPlayer = hit(attacker, DMG_CLUB)
perk:ApplyMeleePerk(mutant, viaPlayer)
near(viaPlayer.damage, 120, "a bullet-path hit reporting the player uses the held weapon")

blade.cotzSwingStamina = 10
local onCrate = hit(blade, DMG_SLASH)
perk:ApplyMeleePerk(crate, onCrate)
check(onCrate.damage == 100 and attacker.stamina == 10, "props give no bonus or refund")
local fists = hit(weapon("ix_hands"), DMG_CLUB)
perk:ApplyMeleePerk(mutant, fists)
check(fists.damage == 100, "fists are excluded")
local gunshot = hit(attacker, DMG_BULLET)
perk:ApplyMeleePerk(mutant, gunshot)
check(gunshot.damage == 100, "other damage types are untouched")
suit = {}
local plain = hit(blade, DMG_SLASH)
perk:ApplyMeleePerk(mutant, plain)
check(plain.damage == 100, "suits without the perk are untouched")
local _, tracked = read("lua/weapons/tfa_nmrimelee_base/shared.lua"):gsub("self%.cotzSwingStamina = staminaUse", "")
check(tracked == 2, "both swing functions record the stamina they spend")

-- Merged coats keep their colour until repainted.
ix.suitAppearance = {}
dofile("gamemodes/ix_cotz/schema/libs/sh_suitappearance.lua")
local coat = {newModel = "coat.mdl", newSkin = 1, skincustom = ix.suitAppearance.SkinOptions(0, 8)}
local migrated = instance(coat, {legacyCoatSkin = 6})
check(ix.suitAppearance.GetSkin(migrated) == 6, "a merged coat keeps its old colour")
migrated.data.setSkin, migrated.data.setSkinModel = 3, "coat.mdl"
check(ix.suitAppearance.GetSkin(migrated) == 3, "a chosen finish replaces the old colour")

-- New suits stay out of progression; variants of existing suits are in it.
local equipment = read("gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_equipment.lua")
local contacts = equipment .. read("gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_technut.lua")
	.. read("gamemodes/ix_cotz/plugins/townnpcs/definitions/sh_suture.lua")
for _, id in ipairs({"suit_expedition", "suit_cs4"}) do
	check(not contacts:find(id .. "[^%w]"), id .. " has no progression, shop or conversion entry")
end
check(not equipment:find("\n\tsuit_cs3 = ") and not equipment:find("\n\tsuit_cs3_%a+ = {"),
	"the new Sky-3 has no seller or conversion unlock")
for _, id in ipairs({"suit_cs5_authority", "suit_trenchcoat_scavenger", "suit_ssp99_diamond", "suit_cs1_fanatic"}) do
	check(equipment:find("\n\t" .. id .. " = {", 1, true), id .. " can be unlocked")
end
for id, item in pairs(suits) do
	if item.suitVariant == "looted" then
		check(not equipment:find("\n\t" .. id .. " = {", 1, true), id .. " stays non-convertible")
	end
end

print(string.format("PASS: %d suit variant checks", checks))
