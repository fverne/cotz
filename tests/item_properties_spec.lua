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
Material = function(path) return path end
CLIENT, SERVER = false, false
LocalPlayer = function() return nil end
ix.util.GetMaterial = Material
ix.util.GetColorFromValue = function(value) return {value = value} end
color_white = Color(255, 255, 255)
math.Round = function(value, decimals)
	local scale = 10 ^ (decimals or 0)
	local result = math.floor(value * scale + 0.5) / scale

	return math.tointeger(result) or result
end
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
check(ix.itemProperties.Format("percent", 42.6) == "43%", "percentages round to whole numbers")
check(ix.itemProperties.Format("percent", 42.5) == "43%", "half percentages use GMod rounding")
check(ix.itemProperties.Format("psychicRate", -0.7) == "-1 %/s", "percentage rates round")
check(ix.itemProperties.Format("distance", 256) == "256 units", "distances keep Source units")
check(ix.itemProperties.Format("jumpSpeed", 150) == "150 units/s", "jump velocity keeps Source units")
check(ix.itemProperties.Format("number", 0.001) == "0", "rounding does not show negative zero")
check(not pcall(ix.itemProperties.Convert, "weight", math.huge), "nonfinite readings rejected")
local function read(path)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()

	return source
end
local function loadFunction(path, signature)
	local source = read(path)
	local start = assert(source:find(signature, 1, true))
	local finish = assert(source:find("\nend", start, true)) + 3
	assert(load(source:sub(start, finish)))()
end
ScrW = function() return 1920 end
ix.util.WrapText = function(text, width)
	local lines = {}
	while #text * 8 > width do
		local length = math.max(1, math.floor(width / 8))
		lines[#lines + 1] = text:sub(1, length)
		text = text:sub(length + 1)
	end
	lines[#lines + 1] = text

	return lines
end
loadFunction("gamemodes/ix_cotz/schema/libs/sh_descgen.lua", "function ix.util.SizePropertyRow(")
loadFunction("gamemodes/ix_cotz/schema/libs/sh_descgen.lua", "function ix.util.OrderPropertyRows(")
loadFunction("gamemodes/ix_cotz/schema/libs/sh_descgen.lua", "function ix.util.PropertyDesc2(")
loadFunction("gamemodes/ix_cotz/schema/libs/sh_descgen.lua", "function ix.util.PropertyDesc(")
ix.weight = {}
loadFunction("gamemodes/ix_cotz/plugins/weight/sh_plugin.lua", "function ix.weight.WeightString(")
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
check(rows.quantity == nil and bread.data.quantity == 1, "quantity omitted without changing instance state")
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
check(ix.itemProperties.GetEffects(antirad)[1].icon == "effect/radiationRemoval", "effects carry icon keys")
local medkit = item(root .. "aid/sh_medic_medkit_2.lua", "base_aid")
check(rowsById(medkit)["effect/1"] == "Health restoration: +3% per 0.5 second over 20 seconds", "rapid healing states amount per tick")
local food = {data = {weight = 0.44}, GetData = bread.GetData, GetWeight = function(self) return self.data.weight end}
function food:GetHunger() return self:GetWeight() / 0.055 end
function food:GetThirst() return self:GetWeight() / -0.25 end
check(rowsById(food).nutrition == "Nutritional energy: +80 kcal", "rolled meat weight determines nutrition")
local gun = {isWeapon = true, base = "base_newweapons", class = "test", data = {wear = 42.4, durability = 63.8},
	GetData = bread.GetData}
rows = rowsById(gun)
check(rows.cleanliness == "Cleanliness: 42%" and rows.durability == "Durability: 64%", "saved weapon condition")
check(rows.magazine == "Magazine capacity: 30" and rows.fireRate == "Cyclic rate: 600 rpm", "SWEP source values")
check(rows.cartridge == nil, "missing ammo definitions do not expose engine identifiers")
check(ix.itemProperties.GetFireModeGroup({FireModes = {"semi", "3burst", "auto"}}) == "auto", "fastest fire mode wins")
check(ix.itemProperties.GetFireModeGroup({FireModes = {"break", "2burst"}}) == "burst", "burst beats break action")
check(ix.itemProperties.GetFireModeGroup({FireModes = {"bolt"}}) == "bolt", "bolt action group")
check(ix.itemProperties.GetFireModeGroup({}) == nil, "weapons without CW fire modes have no group")
local ordered = ix.itemProperties.GetRows(gun)
local positions = {}
for index, row in ipairs(ordered) do positions[row.id] = index end
check(positions.cleanliness < positions.durability, "cleanliness precedes durability")
local registeredWeapon = weapons.Get
for _, definition in ipairs({
	{Type = "Melee", Primary = {Ammo = "pistol", RPM = 600, ClipSize = 10}},
	{IsMelee = true, Primary = {Ammo = "pistol"}},
	{Primary = {Ammo = ""}},
	{Primary = {Ammo = "none"}},
}) do
	weapons.Get = function() return definition end
	local meleeRows = rowsById(gun)
	check(meleeRows.cartridge == nil and meleeRows.fireRate == nil and meleeRows.magazine == nil,
		"melee or non-ammunition weapon has no firearm statistics")
end
weapons.Get = registeredWeapon
local ammo = {isAmmo = true, ammo = "5.45x39MM", ammoAmount = 30, data = {quantity = 7}, GetData = bread.GetData}
check(rowsById(ammo).quantity == nil and rowsById(ammo).cartridge == nil, "ammo omits calibre and quantity")
ammo.ammo = "5.45x39MM -HP-"
check(rowsById(ammo).ammoVariant == "Variant: Hollow Point", "ammo expands special variant names")
ammo.ammo = "5.45x39MM -AP-"
check(rowsById(ammo).ammoVariant == "Variant: Armor Piercing", "AP variant expands")
local slowHealing = {GetPropertyEffects = function()
	return {{buff = "buff_slowheal", amount = 2, duration = 300}}
end}
check(rowsById(slowHealing)["effect/1"] == "Health restoration: +2% per 1 second over 300 seconds",
	"slow healing states its one-second tick and duration")
ix.option = {Get = function() return false end}
CLIENT = true
local viewer = {GetMaxHealth = function() return 200 end}
LocalPlayer = function() return viewer end
for _, definition in ipairs({
	{"medic_medkit_1", "1", "1", 300},
	{"medic_medkit_2", "1.5", "0.5", 20},
	{"medic_medkit_3", "1.5", "1", 300},
	{"medic_medkit_4", "2", "0.5", 20},
	{"medic_medkit_5", "2", "1", 300},
	{"medic_medkit_6", "2", "0.5", 20},
	{"medic_stimpak_1", "5", "0.5", 2},
	{"medic_stimpak_2", "8.75", "0.5", 2},
	{"medic_stimpak_3", "12.5", "0.5", 2},
	{"drug_morphine", "3", "1", 5},
	{"drug_painkillers", "1", "1", 5},
	{"miscaid_swampbrew", "1.5", "1", 300, 3},
}) do
	local medicine = item(root .. "aid/sh_" .. definition[1] .. ".lua", "base_aid")
	local expected = "Health restoration: +" .. definition[2] .. "% per " .. definition[3]
		.. " second over " .. definition[4] .. " seconds"
	check(rowsById(medicine)["effect/" .. (definition[5] or 1)] == expected,
		definition[1] .. " uses viewer maximum health")
end
viewer.GetMaxHealth = function() return 125 end
check(rowsById(slowHealing)["effect/1"] == "Health restoration: +1.6% per 1 second over 300 seconds",
	"healing percentages follow maximum health changes without losing fractional strength")
CLIENT = false
LocalPlayer = function() return nil end
dofile("gamemodes/ix_cotz/schema/libs/sh_weapontables.lua")
for _, name in ipairs({"45acp", "45acpap", "45acphp", "45acp41"}) do
	local definition = item(root .. "newammo/sh_" .. name .. ".lua", "base_newammo")
	definition.isAmmo = true
	ix.item.list[name] = definition
end
local judgeSource = read("lua/weapons/cw_taurusjudge/shared.lua")
local judgeAmmo = assert(judgeSource:match('SWEP.Primary.Ammo%s*=%s*"([^"]+)"'))
local judgeAttachments = assert(judgeSource:match('SWEP.Attachments%s*=%s*(%b{})'))
local judgeDefinition = {Primary = {Ammo = judgeAmmo}, Attachments = assert(load("return " .. judgeAttachments))()}
weapons.Get = function() return judgeDefinition end
local judgeRows = rowsById(gun)
for _, name in ipairs({".45 ACP", ".45 ACP Hydro-Shok", ".45 ACP Armor-Piercing", ".410 Magnum Buck"}) do
	check(judgeRows.cartridge:find(name, 1, true), "Judge lists compatible ammo item: " .. name)
end
check(not judgeRows.cartridge:find("-41-", 1, true), "engine subtype is hidden")
local equippedJudge = {Primary = {Ammo = ".45 ACP -41-"}}
gun.GetOwner = function() return {
	IsPlayer = function() return true end, GetWeapon = function() return equippedJudge end,
} end
gun.data.equip = true
check(rowsById(gun).cartridge == judgeRows.cartridge, "equipped variant retains full compatible ammo list")
gun.GetOwner, gun.data.equip = nil, nil
check(rowsById(gun).attachments == "Compatible attachments: None" and rowsById(gun).installedAttachments == nil,
	"non-attachable firearm states no compatible attachments")
gun.canAttach, gun.validAttachments = true, {"md_kobra", "md_pbs1", "md_unknown"}
gun.data.attachments = {"md_pbs1"}
rows = rowsById(gun)
check(rows.attachments == "Compatible attachments: Kobra Sight, PBS Supressor", "compatible attachments by name")
check(rows.installedAttachments == "Installed attachments: PBS Supressor", "installed attachments by name")
positions = {}
for index, row in ipairs(ix.itemProperties.GetRows(gun)) do positions[row.id] = index end
check(positions.cartridge < positions.installedAttachments and positions.attachments < positions.cleanliness,
	"attachments follow ammunition readings and precede condition")
gun.canAttach, gun.validAttachments, gun.data.attachments = nil, nil, nil
weapons.Get = registeredWeapon
ix.option = {Get = function() return false end}
local weighted = {GetWeight = function() return 0.44 end, GetCarryInc = function() return 0.5 end}
CLIENT = true
rows = rowsById(weighted)
check(rows.weight == "Weight: 440 g", "legacy metric weight uses grams below one kilogram")
check(rows.carry == "Carry Capacity Increase: 500 g", "legacy carry label and formatting")
ix.option.Get = function() return true end
rows = rowsById(weighted)
check(rows.weight == "Weight: 15.52 oz" and rows.carry == "Carry Capacity Increase: 1.1 lbs",
	"legacy imperial formatting for weight and carry")
weighted.entity = {}
check(rowsById(weighted).carry == nil, "world item keeps legacy carry omission")
CLIENT = false
ix.item.list.gasmask_filter_civilian = {name = "Civilian filter"}
ix.util.GetInstalledFilterID = function(item) return "gasmask_filter_" .. item.filterType end
local tank = {filterType = "civilian", isAirTank = true, GetFilterCondition = function() return 72.7 end}
check(ix.itemProperties.GetFilterRows(tank)[1].text == "Civilian filter: 73%", "installed tank percentage rounds")
local suit = {isBodyArmor = true, scale = 1, GetData = bread.GetData, data = {},
	getBR = function(self) return 1 - 0.4 * self.scale end, getFBR = function(self) return 8 * self.scale end,
	getSR = function() return 1 end, getFSR = function() return 0 end,
	getAR = function(self) return 1 - 0.2 * self.scale end, getFAR = function() return 0 end,
	getPR = function() return 1 end, getFPR = function() return 0 end,
	getRadProt = function(self) return 0.5 * self.scale end, GetFlatRadProt = function() return 2 end,
}
ix.suits.anomalyTypes = {{network = "thermal", name = "Thermal", field = "thermalRes", flatField = "flatThermalRes"}}
local protection = ix.itemProperties.GetProtection(suit)
check(protection[1].text == "Ballistics: 40% + 8", "suit protection shows flat absorption")
for _, row in ipairs(protection) do
	check(row.id ~= "protection/rupture" and row.id ~= "protection/psychic", "zero protection rows omitted")
end
local gp5 = item(root .. "gear/sh_mask_gp5.lua")
gp5.GetDurabilityScale = function() return 1 end
gp5.getBR, gp5.getSR, gp5.getPR = function() return 0 end, function() return 0 end, function() return 0 end
gp5.getFBR, gp5.getFSR, gp5.getFPR = function() return 0 end, function() return 0 end, function() return 0 end
gp5.getFAR = function(self) return self.far or 0 end
gp5.getAR = function(self) return self.ar end
gp5.getRadProt = function(self) return self.radProt end
local maskRows = ix.itemProperties.GetProtection(gp5)
check(#maskRows == 1 and maskRows[1].id == "protection/radiation", "GP5 only shows actual resistance")
suit.scale = 0.5
check(ix.itemProperties.GetProtection(suit)[1].text == "Ballistics: 20% + 4", "effective condition")
local gear = {GetDurabilityScale = function() return 0.5 end}
for key, value in pairs(suit) do if gear[key] == nil then gear[key] = value end end
gear.isBodyArmor = false
check(ix.itemProperties.GetProtection(gear)[1].text == "Ballistics: 80% + 4", "gear shows flat absorption")
ix.armortables = {attachments = {plate = {br = 0.05, ar = -0.05}}}
local attachment = {attachName = "plate"}
local attachmentRows = ix.itemProperties.GetProtection(attachment)
check(attachmentRows[1].text == "Ballistics: 5%", "attachment resistance uses percentages")
check(attachmentRows[2].text == "Thermal: -5%", "attachment drawbacks remain negative")
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
		function row:SetContentAlignment() end
		function row:SizeToContents() end
		function row:GetTall() return self.height or 20 end
		function row:SetTall(height) self.height = height end
		function row:SetWide(width) self.width = width end
		function row:GetWide() return self.width end
		function row:Add(class)
			local child = {class = class}
			function child:SetMaterial(material) self.material = material end
			function child:SetWide(width) self.width = width end
			function child:SetWrap(wrap) self.wrap = wrap end
			function child:SizeToContentsY() self.height = math.ceil(#self.text * 8 / self.width) * 20 end
			function child:GetTall() return self.height or 20 end
			function child:SetImageColor() end
			function child:SetPos() end
			function child:SetSize(width, height) self.width, self.height = width, height end
			function child:GetWide() return self.width or #(self.text or "") * 8 end
			function child:MoveRightOf() end
			function child:SetText(text) self.text = text end
			function child:SetTextColor() end
			function child:SetFont() end
			function child:SetContentAlignment() end
			function child:SizeToContents()
				local width, lines = 0, 0
				for line in (self.text .. "\n"):gmatch("(.-)\n") do
					width = math.max(width, #line * 8)
					lines = lines + 1
				end
				self.width, self.height = width, lines * 20
			end

			return child
		end
		self.rows[id] = row

		return row
	end
	function value:AddRowAfter(after, id)
		local row = self:AddRow(id)
		if self.rows[after] then row:SetZPos(self.rows[after]:GetZPos() + 1) end

		return row
	end
	function value:SizeToContents() end

	return value
end
for _, context in ipairs({"inventory", "vendor", "equipment"}) do
	local panel = tooltip()
	bread.entity = context == "world" and {} or nil
	ix.itemProperties.Populate(panel, bread)
	local count = panel.count
	ix.itemProperties.Populate(panel, bread)
	check(panel.count == count and panel.rows["cotz/property/nutrition"], context .. " uses one property set")
	local gunPanel = tooltip()
	ix.itemProperties.Populate(gunPanel, gun)
	local nextPosition = gunPanel.rows["cotz/property/durability"].z
	local previous = gunPanel.rows["cotz/property/cleanliness"].z
	check(previous % 1 == 0 and nextPosition > previous, context .. " property order uses distinct integer Z positions")
	check(panel.rows["cotz/property/nutrition"].propertyImage.material
		== "vgui/ui/stalker/armorupgrades_grey/hunger.png", "mapped properties use their icon")
	ix.itemProperties.AddRow(panel, "unmapped", "Plain statistic")
	check(panel.rows["cotz/property/unmapped"].propertyBullet.class == "DLabel", "unmapped properties keep a bullet")
	count = panel.count
	local row = ix.itemProperties.AddRow(panel, "nutrition", "Updated energy")
	check(panel.count == count and row.propertyLabel.text == "  Updated energy", "semantic updates reuse icon rows")
	ix.itemProperties.PopulateProtection(panel, suit)
	check(not panel.rows["cotz/property/protectionHeader"], "no protection subheader")
	local protectionCount = panel.count
	ix.itemProperties.PopulateProtection(panel, suit)
	check(panel.count == protectionCount and panel.rows["cotz/property/protection/ballistics"].propertyImage,
		"protection reuses semantic icon rows")
	local weightedPanel = tooltip()
	ix.itemProperties.Populate(weightedPanel, weighted)
	local weightRow = weightedPanel.rows["cotz/property/weight"]
	ix.util.PropertyDesc(weightedPanel, "Old property")
	check(weightRow.z > weightedPanel.rows.propertyitem.z, "weight follows legacy rows")
	ix.itemProperties.AddRow(weightedPanel, "test", "New statistic")
	check(weightedPanel.rows["cotz/property/test"].z < weightedPanel.rows.propertyitem.z,
		"converted readings precede legacy rows added afterward")
end
local worldPanel = tooltip()
weighted.hunger, weighted.thirst = 10, 20
weighted.GetIndividualProperties = function() error("World tooltip must not evaluate converted providers") end
ix.itemProperties.Populate(worldPanel, weighted)
check(worldPanel.count == 2 and worldPanel.rows["cotz/property/weight"], "world shows only legacy weight")
check(worldPanel.rows["cotz/property/weight"].propertyImage.material
	== "vgui/ui/stalker/weaponupgrades_grey/weight.png", "legacy weight icon restored")
suit.entity = {}
ix.itemProperties.PopulateProtection(worldPanel, suit)
check(worldPanel.count == 2, "world protection helper does not add converted rows")
suit.entity = nil
local carryPanel = tooltip()
ix.itemProperties.AddRow(carryPanel, "carry", "Carry Capacity Increase: 5 kg")
check(carryPanel.rows["cotz/property/carry"].propertyImage.material
	== "vgui/ui/stalker/armorupgrades_grey/carryweightinc.png", "legacy carry icon restored")
local wrappedPanel = tooltip()
local wrappedRow = ix.itemProperties.AddRow(wrappedPanel, "cartridge", "Short")
wrappedRow.maxWidth = 240
ix.itemProperties.AddRow(wrappedPanel, "cartridge", judgeRows.cartridge)
check(wrappedRow.width <= 240 and wrappedRow:GetTall() > 20 and not wrappedRow.propertyLabel.wrap,
	"complete ammunition list wraps inside the tooltip width")
local wrappedHeight = wrappedRow:GetTall()
ix.itemProperties.AddRow(wrappedPanel, "cartridge", judgeRows.cartridge)
check(wrappedRow:GetTall() == wrappedHeight, "repeated property updates do not add blank lines")
ix.itemProperties.AddRow(wrappedPanel, "cartridge", "Short")
check(wrappedRow:GetTall() == 20, "shortened properties reset their wrapped row height")
check(not wrappedRow.propertyLabel.text:find("\n", 1, true), "short properties have no added newline")
local artifactPanel = tooltip()
local legacyMaterial = {}
local artifactRow = ix.util.PropertyDesc(artifactPanel, "Artifact", color_white, legacyMaterial)
check(artifactRow == artifactPanel.rows.propertyitem and artifactRow.cotzPropertyPriority == 2,
	"legacy material argument is ignored instead of treated as a semantic row ID")
local artifactCount = artifactPanel.count
local secondArtifactRow = ix.util.PropertyDesc(artifactPanel, "Artifact", color_white, legacyMaterial)
check(artifactPanel.count == artifactCount + 1 and secondArtifactRow ~= artifactRow,
	"legacy material arguments retain independent property rows")
local materialPanel = tooltip()
local function timedMaterial() return "placeholder", 0.01 end
local materialRow = ix.util.PropertyDesc2(materialPanel, "Gasmask", nil, timedMaterial())
local materialCount = materialPanel.count
local helmetRow = ix.util.PropertyDesc2(materialPanel, "Helmet", nil, timedMaterial())
check(materialPanel.count == materialCount + 1 and helmetRow ~= materialRow,
	"Material load times do not deduplicate legacy image rows")
check(materialRow.cotzPropertyPriority == 2 and helmetRow.propertyImage.material == "placeholder",
	"Material load times retain legacy priority and the supplied icon")
ix.util.OrderPropertyRows(materialPanel, {SetZPos = function() end}, 0.01)
check(#materialPanel.cotzPropertyRows == 3, "ordering accepts legacy numeric arguments")
local legacyPanel = tooltip()
ix.util.PropertyDesc2(legacyPanel, "Gasmask", nil, Material("placeholder"))
ix.itemProperties.AddRow(legacyPanel, "first", "First statistic")
check(legacyPanel.rows["cotz/property/first"].z < legacyPanel.rows.propertyitem2.z,
	"converted readings precede legacy rows created first")
local legacyCount = legacyPanel.count
ix.util.PropertyDesc2(legacyPanel, "Helmet", nil, Material("placeholder"))
check(legacyPanel.count == legacyCount + 1, "legacy helper calls retain independent rows without an ID")
loadFunction(root .. "base/sh_newammo.lua", "function ITEM:GetDescription()")
local describeAmmo = ITEM.GetDescription
for _, name in ipairs({"545x39", "45acp", "45acpap", "12gaugedt"}) do
	local ammoItem = item(root .. "newammo/sh_" .. name .. ".lua", "base_newammo")
	ammoItem.data.quantity = 7
	local shortDescription = string.format(ammoItem.quantdesc, 7)
	check(describeAmmo(ammoItem) == shortDescription .. "\n\n" .. ammoItem.longdesc,
		name .. " restores ammo-specific quantity and background")
	ammoItem.entity = {}
	check(describeAmmo(ammoItem) == shortDescription, name .. " restores short world description")
end
-- Description callbacks keep prose and custom instance text, without appended state/stat blocks.
for _, name in ipairs({"sh_newweapons", "sh_suit", "sh_newammo", "sh_aid", "sh_consumables"}) do
	local source = read(root .. "base/" .. name .. ".lua")
	local start = assert(source:find("function ITEM:GetDescription()", 1, true))
	local finish = assert(source:find("\nend", start, true)) + 3
	ITEM = {}
	assert(load(source:sub(start, finish):gsub("!", "not ")))()
	local value = {description = "Identification.", quantdesc = "A box with %d rounds.",
		longdesc = "Background.", data = {durability = 20},
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
for _, name in ipairs({"urchin", "kolobok", "eye", "flame", "sparkler", "flash", "moonlight", "bolt", "arachno",
	"grapes", "capacitor", "compass", "moon", "photo", "dwarfgalaxy", "galaxy", "gmamasbeads", "mamasbeads", "halo",
	"mycelia", "seraphim", "storm"}) do
	local artifact = item(root .. "artifacts/sh_artifact_" .. name .. ".lua")
	check(#artifact:GetIndividualProperties() > 0, name .. " exposes unique effects")
	if artifact.contactDamage then
		check(read(root .. "artifacts/sh_artifact_" .. name .. ".lua"):find("SetDamage(item.contactDamage)", 1, true),
			name .. " gameplay reads the same tuning as properties")
	end
end
print("item_properties_spec: " .. checks .. " checks passed")
