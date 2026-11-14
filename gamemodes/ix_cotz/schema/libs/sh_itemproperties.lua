ix.itemProperties = ix.itemProperties or {}

-- Cosmetic Anomaly-style scales. See docs/item-properties.md for normalization and source attribution.
local UNITS = {
	nutrition = {10, "kcal"}, hydration = {10, "mL equivalent"},
	healthRate = {10, "%"}, health = {1, "HP"}, psychicRate = {1, "%/s"},
	radiationRate = {300, "mSv/s"}, radiationAmount = {300, "mSv"},
	clotting = {1500, "mL/min"}, staminaRate = {1000, "µg/s"},
	thermal = {300, "kW/m²"}, electrical = {480, "V"}, chemical = {100, "%"}, anomalous = {100, "%"},
	ballistics = {2500, "J"}, rupture = {2500, "J"}, gravitational = {2500, "J"},
	psychic = {300, "mT"}, radiation = {3000, "mSv"},
	distance = {0.0254, "m"}, jumpSpeed = {0.0254, "m/s"},
	weight = {1, "kg"}, duration = {1, "s"}, percent = {1, "%"}, number = {1, ""},
}

function ix.itemProperties.Convert(kind, value)
	local definition = assert(UNITS[kind], "Unknown item property unit: " .. tostring(kind))
	assert(type(value) == "number" and value == value and math.abs(value) < math.huge, "Invalid property value")

	return value * definition[1], definition[2]
end

function ix.itemProperties.Format(kind, value, signed)
	local converted, unit = ix.itemProperties.Convert(kind, value)
	local text = string.format("%.2f", converted):gsub("0+$", ""):gsub("%.$", "")
	if text == "-0" then text = "0" end
	local whole, fraction = text:match("^(-?%d+)(.*)$")
	whole = whole:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""):gsub("^-%,", "-")
	text = whole .. fraction
	if signed and converted > 0 then text = "+" .. text end
	if unit ~= "" then text = text .. (unit == "%" and "" or " ") .. unit end

	return text
end

local function add(rows, id, label, kind, value, signed, duration)
	if value == nil then return end

	local text = label .. ": " .. ix.itemProperties.Format(kind, value, signed)
	if duration then text = text .. " for " .. ix.itemProperties.Format("duration", duration) end
	rows[#rows + 1] = {id = id, text = text}
end

local function addText(rows, id, text)
	rows[#rows + 1] = {id = id, text = text}
end

function ix.itemProperties.GetProtection(item)
	local rows = {}
	local function protection(id, label, reduction, flat)
		local text = label .. ": " .. ix.itemProperties.Format(id, reduction)
		if flat ~= nil then
			text = text .. "; absorption " .. ix.itemProperties.Format(id, flat / 100)
		end
		rows[#rows + 1] = {id = "protection/" .. id, text = text}
	end
	if item.getBR then
		local function reduction(method, field)
			local value = item[method](item, field)

			return item.isBodyArmor and 1 - value or value
		end
		protection("ballistics", "Ballistics", reduction("getBR"), item:getFBR())
		protection("rupture", "Rupture", reduction("getSR"), item:getFSR())
		if item.isBodyArmor then
			for _, definition in ipairs(ix.suits.anomalyTypes) do
				protection(definition.network, definition.name, reduction("getAR", definition.field),
					item:getFAR(definition.flatField))
			end
		else
			-- Installed headgear uses its broad anomaly pair for each damage family.
			for _, definition in ipairs(ix.suits.anomalyTypes) do
				local value = item[definition.field]
				local flat = item[definition.flatField]
				local scale = item:GetDurabilityScale()
				protection(definition.network, definition.name, value and value * scale or item:getAR(),
					flat and flat * scale or item:getFAR())
			end
		end
		protection("psychic", "Psychic", reduction("getPR"), item:getFPR())
		protection("radiation", "Radiation", item:getRadProt(), item:GetFlatRadProt())
	elseif item.attachName and ix.armortables and ix.armortables.attachments[item.attachName] then
		local attachment = ix.armortables.attachments[item.attachName]
		for _, entry in ipairs({
			{"ballistics", "Ballistics", "br", "fbr"}, {"rupture", "Rupture", "sr", "fsr"},
			{"thermal", "Thermal", "ar", "far"}, {"electrical", "Electrical", "ar", "far"},
			{"chemical", "Chemical", "ar", "far"}, {"gravitational", "Gravitational", "ar", "far"},
			{"psychic", "Psychic", "pr", "fpr"}, {"radiation", "Radiation", "radProt", "flatRadProt"},
		}) do
			if attachment[entry[3]] or attachment[entry[4]] then
				protection(entry[1], entry[2], attachment[entry[3]] or 0, attachment[entry[4]])
			end
		end
	end

	return rows
end

local EFFECTS = {
	buff_slowheal = {"Health restoration", "healthRate", 1},
	buff_rapidheal = {"Health restoration", "healthRate", 2},
	buff_staminarestore = {"Stamina restoration", "staminaRate", 2},
	buff_radiationremoval = {"Radiation removal", "radiationRate", -2},
	debuff_radiation = {"Radiation exposure", "radiationRate", 2},
	buff_psyheal = {"Psychic recovery", "psychicRate", 2},
	debuff_psy = {"Psychic damage", "psychicRate", -2},
	buff_psyblock = {"Psychic shielding", "psychic", 0.01},
	buff_hijump = {"Jump boost", "jumpSpeed", 1},
}

function ix.itemProperties.GetEffects(item)
	local rows = {}
	local effects = item.GetPropertyEffects and item:GetPropertyEffects() or {}
	for index, effect in ipairs(effects) do
		local definition = EFFECTS[effect.buff]
		local id = "effect/" .. index
		if definition then
			add(rows, id, definition[1], definition[2], effect.amount * definition[3], true, effect.duration)
		elseif effect.buff == "buff_sprintboost" then
			add(rows, id, "Sprint speed", "percent", (effect.multiplier - 1) * 100, true, effect.duration)
		elseif effect.buff == "buff_psysuppress" then
			add(rows, id, "Psychic suppression", "duration", effect.duration)
		elseif effect.buff == "debuff_psypillmovement" then
			add(rows, id, "Movement impairment", "duration", effect.duration)
		elseif effect.buff == "buff_meditation" then
			addText(rows, id, "Meditation while stationary")
		end
	end

	return rows
end

function ix.itemProperties.GetFilterRows(item)
	local rows = {}
	if not item.filterType and not item.isGasmaskFilter then return rows end
	local definition = item.isGasmaskFilter and item or ix.item.list["gasmask_filter_" .. item.filterType]
	local condition = item.isGasmaskFilter and item:GetData("filterCondition", 100)
		or item:GetFilterCondition()
	local label = item.isAirTank and "Air tank" or definition.name
	if condition == false then
		addText(rows, "filter", label .. ": No filter")
	else
		add(rows, "filter", label, "percent", condition)
	end

	return rows
end

function ix.itemProperties.GetRows(item)
	local rows = {}
	local hunger = item.GetHunger and item:GetHunger() or item.hunger
	local thirst = item.GetThirst and item:GetThirst() or item.thirst
	if hunger and hunger ~= 0 then add(rows, "nutrition", "Nutritional energy", "nutrition", hunger, true) end
	if thirst and thirst ~= 0 then add(rows, "hydration", "Hydration", "hydration", thirst, true) end
	if item.alcohol and item.alcohol ~= 0 then
		add(rows, "alcohol", "Intoxication", "number", item.alcohol, true)
	end
	local initialQuantity = item.ammoAmount or item.quantity
	if initialQuantity ~= nil then
		local label = item.isAmmo and "Rounds remaining" or "Uses remaining"
		local current = item:GetData("quantity", initialQuantity)
		addText(rows, "quantity", label .. ": " .. current .. "/" .. (item.maxStack or initialQuantity))
	end
	if item.bleedRestore then
		add(rows, "clotting", "Clotting", "clotting", item.bleedRestore / item.restoreduration)
		add(rows, "clottingDuration", "Effect duration", "duration", item.restoreduration)
		add(rows, "healing", "Completion healing", "health", item.restore, true)
		add(rows, "application", "Application time", "duration", item.applicationTime)
	end
	if item.isWeapon then
		local weapon = weapons.Get(item.class)
		local owner = item.GetOwner and item:GetOwner()
		if IsValid(owner) and owner:IsPlayer() and item:GetData("equip") then
			local equipped = owner:GetWeapon(item.class)
			if IsValid(equipped) then weapon = equipped end
		end
		if weapon and weapon.Primary then
			local primary = weapon.Primary
			addText(rows, "cartridge", "Cartridge: " .. (item:GetData("ammoRechamber", {}).ammotypeName
				or primary.Ammo or "Unknown"))
			local capacity = primary.ClipSize or weapon.ClipSize
			if capacity and capacity > 0 then add(rows, "magazine", "Magazine capacity", "number", capacity) end
			local delay = weapon.FireDelay or primary.Delay
			local rpm = primary.RPM or (delay and delay > 0 and 60 / delay)
			if rpm then addText(rows, "fireRate", "Cyclic rate: " .. ix.itemProperties.Format("number", rpm) .. " rpm") end
		end
		if item.base == "base_newweapons" or item:GetData("durability") ~= nil then
			add(rows, "durability", "Durability", "percent", item:GetData("durability", 100))
		end
		if item.base == "base_newweapons" then
			add(rows, "cleanliness", "Cleanliness", "percent", item:GetData("wear", 100))
		end
	elseif item.isBodyArmor or item.isHelmet or item.isGasmask then
		add(rows, "durability", "Durability", "percent", item:GetData("durability", 100))
	end
	if item.ammo then addText(rows, "cartridge", "Cartridge: " .. item.ammo) end
	for _, row in ipairs(ix.itemProperties.GetFilterRows(item)) do rows[#rows + 1] = row end
	if item.GetCarryInc then
		local carry = item:GetCarryInc()
		if carry and carry ~= 0 then add(rows, "carry", "Carrying capacity", "weight", carry, true) end
	end
	if item.GetWeight then add(rows, "weight", "Weight", "weight", item:GetWeight()) end
	if CLIENT and ix.option and ix.option.Get("imperial", false) then
		for _, row in ipairs(rows) do
			if row.id == "weight" then row.text = "Weight: " .. ix.weight.WeightString(item:GetWeight(), true) end
			if row.id == "carry" then
				row.text = "Carrying capacity: " .. ix.weight.WeightString(item:GetCarryInc(), true)
			end
		end
	end
	if item.fueltier then add(rows, "fuelTier", "Cooking fuel grade", "number", item.fueltier) end
	if item.cookertier then
		add(rows, "cookerTier", "Cooking grade", "number", item.cookertier)
		add(rows, "fuel", "Fuel remaining", "number", item:GetData("fuel", item.maxFuel))
	end
	if item.isPoachKnife then
		add(rows, "knifeTier", "Poaching tier", "number", ix.poaching.GetKnifeTier(item))
		add(rows, "sharpnessCondition", "Sharpness", "percent", ix.poaching.GetSharpness(item))
	elseif item.knifetier then
		add(rows, "knifeTier", "Poaching tier", "number", item.knifetier)
	end
	if item.sharpnessRestored then
		add(rows, "sharpness", "Sharpness restored", "percent", item.sharpnessRestored, true)
		add(rows, "sharpnessLimit", "Sharpness limit", "percent", ix.poaching.Sharpness.maximum)
	end
	for _, row in ipairs(ix.itemProperties.GetEffects(item)) do rows[#rows + 1] = row end
	if item.GetIndividualProperties then
		for _, row in ipairs(item:GetIndividualProperties()) do rows[#rows + 1] = row end
	end

	return rows
end
