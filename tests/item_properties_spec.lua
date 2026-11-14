-- Run from the addon root: luatex --luaonly tests/item_properties_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local function near(actual, expected, message)
	check(math.abs(actual - expected) < 0.000001, message)
end
ix = {util = {}, suits = {}, item = {list = {}}}
IsValid = function(value) return type(value) == "table" and not value.invalid end
Color = function() return {} end
Vector = function() return {} end
Angle = function() return {} end
Material = function() return {} end
CLIENT, SERVER = false, false
ix.util.GetMaterial = Material
weapons = {Get = function() return {Primary = {Ammo = "5.45x39MM", ClipSize = 30}, FireDelay = 0.1} end}
dofile("gamemodes/ix_cotz/schema/libs/sh_itemproperties.lua")
dofile("gamemodes/ix_cotz/schema/libs/cl_itemproperties.lua")
near(ix.itemProperties.Convert("nutrition", 9), 90, "COTZ hunger normalized to Anomaly kcal")
near(ix.itemProperties.Convert("radiationRate", -50 / 120), -125, "radiation rate uses actual seconds")
for index, total in ipairs({20, 50, 90}) do
	near(ix.itemProperties.Convert("clotting", total / 6), ({5000, 12500, 22500})[index], "clotting scale")
end
check(ix.itemProperties.Format("weight", -1234.5, true) == "-1,234.5 kg", "signed grouped weight")
check(ix.itemProperties.Format("nutrition", 9, true) == "+90 kcal", "positive signs")
check(ix.itemProperties.Format("percent", 0) == "0%", "explicit zero")
check(ix.itemProperties.Format("number", 0.001) == "0", "rounding does not show negative zero")
check(not pcall(ix.itemProperties.Convert, "weight", math.huge), "nonfinite readings rejected")
local function read(path)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()

	return source
end
local function item(path, base)
	ITEM = {
		functions = {}, data = {}, base = base,
		Hook = function() end, DecideFunction = function() end,
		GetData = function(self, key, default)
			if self.data[key] ~= nil then return self.data[key] end

			return default
		end,
	}
	local source = read(path):gsub("!=", "~="):gsub("!", "not "):gsub("//[^\n]*", "")
	assert(load(source, "@" .. path))()

	return ITEM
end
local function rowsById(value)
	local rows = {}
	for _, row in ipairs(ix.itemProperties.GetRows(value)) do rows[row.id] = row.text end

	return rows
end
local root = "gamemodes/ix_cotz/schema/items/"
local bread = item(root .. "consumables/sh_food_bread.lua", "base_consumables")
bread.data.quantity = 1
local rows = rowsById(bread)
check(rows.nutrition == "Nutritional energy: +90 kcal", "real bread restores per portion")
check(rows.quantity == "Uses remaining: 1/2", "saved quantity displayed")
local water = item(root .. "consumables/sh_drink_bottlewater.lua", "base_consumables")
check(rowsById(water).hydration == "Hydration: +170 mL equivalent", "water hydration is not physical volume")
for tier, health in ipairs({6, 9, 12}) do
	local bandage = item(root .. "aid/sh_medic_bandage_" .. tier .. ".lua", "base_aid")
	rows = rowsById(bandage)
	check(rows.healing == "Completion healing: +" .. health .. " HP", "bandage healing is direct HP")
	check(rows.clottingDuration == "Effect duration: 6 s", "bandage duration")
	check(not bandage.description:find("severity"), "bandage prose contains no raw severity")
end
local antirad = item(root .. "aid/sh_medic_antirad_1.lua", "base_aid")
check(rowsById(antirad)["effect/1"] == "Radiation removal: -125 mSv/s for 120 s", "real antirad callback rate")
local medkit = item(root .. "aid/sh_medic_medkit_2.lua", "base_aid")
check(rowsById(medkit)["effect/1"] == "Health restoration: +60% for 20 s", "rapid healing has two ticks per second")
local food = {data = {weight = 0.44}, GetData = bread.GetData, GetWeight = function(self) return self.data.weight end}
function food:GetHunger() return self:GetWeight() / 0.055 end
function food:GetThirst() return self:GetWeight() / -0.25 end
check(rowsById(food).nutrition == "Nutritional energy: +80 kcal", "rolled meat weight determines nutrition")
local gun = {isWeapon = true, base = "base_newweapons", class = "test", data = {wear = 42, durability = 64},
	GetData = bread.GetData}
rows = rowsById(gun)
check(rows.cleanliness == "Cleanliness: 42%" and rows.durability == "Durability: 64%", "saved weapon condition")
check(rows.magazine == "Magazine capacity: 30" and rows.fireRate == "Cyclic rate: 600 rpm", "SWEP source values")
local suit = {isBodyArmor = true, scale = 1, GetData = bread.GetData, data = {},
	getBR = function(self) return 1 - 0.4 * self.scale end, getFBR = function(self) return 8 * self.scale end,
	getSR = function() return 1 end, getFSR = function() return 0 end,
	getAR = function(self) return 1 - 0.2 * self.scale end, getFAR = function() return 0 end,
	getPR = function() return 1 end, getFPR = function() return 0 end,
	getRadProt = function(self) return 0.5 * self.scale end, GetFlatRadProt = function() return 2 end,
}
ix.suits.anomalyTypes = {{network = "thermal", name = "Thermal", field = "thermalRes", flatField = "flatThermalRes"}}
local protection = ix.itemProperties.GetProtection(suit)
check(protection[1].text == "Ballistics: 1,000 J; absorption 200 J", "resistance and absorption remain distinct")
suit.scale = 0.5
check(ix.itemProperties.GetProtection(suit)[1].text == "Ballistics: 500 J; absorption 100 J", "effective condition")
ix.armortables = {attachments = {plate = {br = 0.05, ar = -0.05}}}
local attachment = {attachName = "plate"}
local attachmentRows = ix.itemProperties.GetProtection(attachment)
check(attachmentRows[1].text == "Ballistics: 125 J", "attachment resistance uses common calibration")
check(attachmentRows[2].text == "Thermal: -15 kW/m²", "attachment drawbacks remain negative")
local function tooltip()
	local value = {rows = {}, count = 0}
	function value:GetRow(id) return self.rows[id] end
	function value:AddRow(id)
		self.count = self.count + 1
		local row = {z = self.count * 10}
		function row:SetText(text) self.text = text end
		function row:GetZPos() return self.z end
		function row:SetZPos(z) self.z = z end
		function row:SetFont() end
		function row:SetTextColor() end
		function row:SizeToContents() end
		self.rows[id] = row

		return row
	end

	return value
end
for _, context in ipairs({"inventory", "vendor", "equipment", "world"}) do
	local panel = tooltip()
	bread.entity = context == "world" and {} or nil
	ix.itemProperties.Populate(panel, bread)
	local count = panel.count
	ix.itemProperties.Populate(panel, bread)
	check(panel.count == count and panel.rows["cotz/property/nutrition"], context .. " uses one property set")
	local previous = panel.rows["cotz/property/nutrition"].z
	local nextPosition = panel.rows["cotz/property/quantity"].z
	check(previous % 1 == 0 and nextPosition > previous, context .. " property order uses distinct integer Z positions")
end
-- Description callbacks keep prose and custom instance text, without appended state/stat blocks.
for _, name in ipairs({"sh_newweapons", "sh_suit", "sh_newammo", "sh_aid", "sh_consumables"}) do
	local source = read(root .. "base/" .. name .. ".lua")
	local start = assert(source:find("function ITEM:GetDescription()", 1, true))
	local finish = assert(source:find("\nend", start, true)) + 3
	ITEM = {}
	assert(load(source:sub(start, finish):gsub("!", "not ")))()
	local value = {description = "Identification.", longdesc = "Background.", data = {durability = 20},
		GetData = bread.GetData, entity = {}}
	local description = ITEM.GetDescription(value)
	check(not description:find("Durability:") and not description:find("Cleanliness:"), name .. " clean description")
end
-- Providers must agree with the real callback expressions, including differing buff tick intervals.
local paths = assert(io.popen("rg -l 'function ITEM:GetPropertyEffects' gamemodes/ix_cotz/schema/items"))
local providerCount = 0
for path in paths:lines() do
	local concrete = item(path)
	local effects = concrete:GetPropertyEffects()
	providerCount = providerCount + 1
	local function evaluate(expression)
		return assert(load("return " .. expression, "@property/expression", "t",
			setmetatable({item = concrete}, {__index = _G})))()
	end
	for _, effect in ipairs(effects) do
		local matched = false
		for buff, duration, parameters in read(path):gmatch("AddBuff%(%s*\"([^\"]+)\"%s*,%s*([^,\n]+),%s*{([^}\n]*)}") do
			if buff == effect.buff and evaluate(duration) == effect.duration then
				local amount = parameters:match("amount%s*=%s*([^,]+)")
				local multiplier = parameters:match("multiplier%s*=%s*([^,]+)")
				if (not amount or evaluate(amount) == effect.amount)
					and (not multiplier or evaluate(multiplier) == effect.multiplier) then matched = true end
			end
		end
		check(matched, path .. " provider agrees with an implemented callback")
	end
	ix.itemProperties.GetRows(concrete)
end
paths:close()
check(providerCount >= 117, "all concrete effect providers exercised")
local flask = item(root .. "miscellaneous/sh_waterflask.lua")
flask.data.contains = 3
check(#flask:GetPropertyEffects() == 0, "clean flask advertises no contamination")
flask.data.contains = 2
check(#flask:GetPropertyEffects() == 1 and flask:GetPropertyEffects()[1].amount == 0.2, "boiled flask effects")
flask.data.contains = 1
check(#flask:GetPropertyEffects() == 2, "dirty flask effects")
for _, name in ipairs({"urchin", "kolobok", "eye", "flame", "sparkler", "flash", "moonlight"}) do
	local artifact = item(root .. "artifacts/sh_artifact_" .. name .. ".lua")
	check(#artifact:GetIndividualProperties() > 0, name .. " exposes unique effects")
	if artifact.contactDamage then
		check(read(root .. "artifacts/sh_artifact_" .. name .. ".lua"):find("SetDamage(item.contactDamage)", 1, true),
			name .. " gameplay reads the same tuning as properties")
	end
end
print("item_properties_spec: " .. checks .. " checks passed")
