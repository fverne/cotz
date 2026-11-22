ix.itemProperties = ix.itemProperties or {}

-- Cosmetic Anomaly-style scales. See docs/item-properties.md for normalization and source attribution.
local UNITS = {
	nutrition = {10, "kcal"}, hydration = {10, "mL equivalent"},
	healthRate = {1, "%"}, health = {1, "HP"}, psychicRate = {1, "%/s"},
	radiationRate = {300, "mSv/s"}, radiationAmount = {300, "mSv"},
	clotting = {1500, "mL/min"}, staminaRate = {1000, "µg/s"},
	-- Protection readings are resistance fractions shown as percentages.
	thermal = {100, "%"}, electrical = {100, "%"}, chemical = {100, "%"}, anomalous = {100, "%"},
	ballistics = {100, "%"}, rupture = {100, "%"}, gravitational = {100, "%"},
	psychic = {100, "%"}, radiation = {100, "%"},
	distance = {1, "units"}, jumpSpeed = {1, "units/s"},
	weight = {1, "kg"}, duration = {1, "s"}, percent = {1, "%"}, number = {1, ""},
}

function ix.itemProperties.Convert(kind, value)
	local definition = assert(UNITS[kind], "Unknown item property unit: " .. tostring(kind))
	assert(type(value) == "number" and value == value and math.abs(value) < math.huge, "Invalid property value")

	return value * definition[1], definition[2]
end

function ix.itemProperties.Format(kind, value, signed)
	local converted, unit = ix.itemProperties.Convert(kind, value)
	local text
	if (unit == "%" or unit == "%/s") and kind ~= "healthRate" then
		text = string.format("%.0f", math.Round(converted))
	else
		text = string.format("%.2f", converted):gsub("0+$", ""):gsub("%.$", "")
	end
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
	local row = {id = id, text = text}
	rows[#rows + 1] = row

	return row
end

local function addText(rows, id, text)
	local row = {id = id, text = text}
	rows[#rows + 1] = row

	return row
end

function ix.itemProperties.GetProtection(item)
	local rows = {}
	local function protection(id, label, reduction, flat)
		if (reduction == nil or reduction == 0) and (flat == nil or flat == 0) then return end

		reduction = reduction or 0
		local valueText = ix.itemProperties.Format(id, reduction)
		if flat ~= nil then
			valueText = valueText .. " + " .. ix.itemProperties.Format("number", math.Round(flat, 1))
		end
		rows[#rows + 1] = {
			id = "protection/" .. id, text = label .. ": " .. valueText,
			label = label .. ":", valueText = valueText, value = reduction,
		}
	end
	if item.getBR then
		local function reduction(method, field)
			local value = item[method](item, field)

			if value == nil then return end

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
			-- Installed headgear uses its broad anomaly resistance for each damage family.
			local scale = item:GetDurabilityScale()
			for _, definition in ipairs(ix.suits.anomalyTypes) do
				local value = item[definition.field]
				local flat = item[definition.flatField]
				protection(definition.network, definition.name, value and value * scale or item:getAR(),
					flat and flat * scale or item:getFAR())
			end
		end
		protection("psychic", "Psychic", reduction("getPR"), item:getFPR())
		protection("radiation", "Radiation", item:getRadProt())
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
	buff_psyblock = {"Psychic shielding", "number", 1},
	buff_hijump = {"Jump boost", "jumpSpeed", 1},
}

-- Client icon keys for effect rows, whose row IDs are positional.
local EFFECT_ICONS = {
	buff_slowheal = "effect/healing",
	buff_rapidheal = "effect/healing",
	buff_staminarestore = "effect/stamina",
	buff_radiationremoval = "effect/radiationRemoval",
	debuff_radiation = "effect/radiationExposure",
	buff_psyheal = "effect/psychicRecovery",
	debuff_psy = "effect/psychicDamage",
	buff_psyblock = "effect/psychicRecovery",
	buff_psysuppress = "effect/psychicRecovery",
	buff_meditation = "effect/psychicRecovery",
	buff_hijump = "effect/movement",
	buff_sprintboost = "effect/movement",
	debuff_psypillmovement = "effect/movementImpairment",
}

-- CW 2.0 fire mode keys grouped by firing style; a weapon is shown by its fastest available group.
local FIRE_MODE_GROUPS = {
	auto = "auto", ["2burst"] = "burst", ["3burst"] = "burst", semi = "semi",
	pump = "pump", double = "break", ["break"] = "break", bolt = "bolt",
}
local FIRE_MODE_PRIORITY = {"auto", "burst", "semi", "pump", "break", "bolt"}

function ix.itemProperties.GetFireModeGroup(weapon)
	local available = {}
	for _, mode in ipairs(weapon.FireModes or {}) do
		local group = FIRE_MODE_GROUPS[mode]
		if group then available[group] = true end
	end
	for _, group in ipairs(FIRE_MODE_PRIORITY) do
		if available[group] then return group end
	end
end

function ix.itemProperties.GetEffects(item)
	local rows = {}
	local effects = item.GetPropertyEffects and item:GetPropertyEffects() or {}
	local client = CLIENT and LocalPlayer()
	local maxHealth = IsValid(client) and client:GetMaxHealth() or 100
	for index, effect in ipairs(effects) do
		local definition = EFFECTS[effect.buff]
		local id = "effect/" .. index
		if effect.buff == "buff_slowheal" or effect.buff == "buff_rapidheal" then
			local interval = effect.buff == "buff_rapidheal" and 0.5 or 1
			local percentage = (effect.amount or 1) / math.max(maxHealth, 1) * 100
			local text = "Health restoration: " .. ix.itemProperties.Format("healthRate", percentage, true)
			text = text .. " per " .. ix.itemProperties.Format("number", interval) .. " second"
			addText(rows, id, text .. " over " .. ix.itemProperties.Format("number", effect.duration) .. " seconds")
		elseif definition then
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
		local row = rows[#rows]
		if row and row.id == id then row.icon = EFFECT_ICONS[effect.buff] end
	end

	return rows
end

function ix.itemProperties.GetFilterRows(item)
	local rows = {}
	if not item.filterType and not item.isGasmaskFilter then return rows end
	local definition = item.isGasmaskFilter and item or ix.item.list[ix.util.GetInstalledFilterID(item)]
	local condition = item.isGasmaskFilter and item:GetData("filterCondition", 100)
		or item:GetFilterCondition()
	local label = definition.name
	if condition == false then
		addText(rows, "filter", label .. ": No filter")
	else
		add(rows, "filter", label, "percent", condition)
	end

	return rows
end

local AMMO_VARIANTS = {
	HP = "Hollow Point", AP = "Armor Piercing", SG = "Slug", TR = "Trishot",
	DT = "Dart", MG = "Magnum Buck", ["41"] = "Magnum Buck",
}

function ix.itemProperties.GetAmmoNames(item, weapon)
	local registered = weapons.Get(item.class) or weapon
	local rechamber = item:GetData("ammoRechamber", {})
	local ammo = rechamber.ammotypeName or registered.Primary.Ammo
	local baseAmmo = ammo:gsub(" %-%w+%-$", "")
	local allowed = {[baseAmmo] = true, [ammo] = true}
	local attachments = {}
	for _, slot in pairs(registered.Attachments or {}) do
		for _, attachment in ipairs(slot.atts or {}) do attachments[attachment] = true end
	end
	for subtype, definition in pairs(ix.weapontables and ix.weapontables.ammosubtypes or {}) do
		if attachments[definition.uID] then allowed[baseAmmo .. " -" .. subtype .. "-"] = true end
	end
	local names, seen = {}, {}
	for _, definition in pairs(ix.item.list) do
		if definition.isAmmo and allowed[definition.ammo] and not seen[definition.name] then
			names[#names + 1] = definition.name
			seen[definition.name] = true
		end
	end
	table.sort(names)

	return names
end

local function attachmentNames(ids)
	local definitions = ix.weapontables and ix.weapontables.attachments or {}
	local names = {}
	for _, id in ipairs(ids) do
		if definitions[id] then names[#names + 1] = definitions[id].name end
	end

	return names
end

function ix.itemProperties.GetAttachmentRows(item)
	local rows = {}
	local installed = attachmentNames(item:GetData("attachments", {}))
	if #installed > 0 then
		addText(rows, "installedAttachments", "Installed attachments: " .. table.concat(installed, ", "))
	end
	local compatible = item.canAttach and attachmentNames(item.validAttachments or {}) or {}
	local text = #compatible > 0 and table.concat(compatible, ", ") or "None"
	addText(rows, "attachments", "Compatible attachments: " .. text)

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
			local isMelee = weapon.Type == "Melee" or weapon.IsMelee or item.weaponCategory == "knife"
			if not isMelee and primary.Ammo and primary.Ammo ~= "" and primary.Ammo:lower() ~= "none" then
				local names = ix.itemProperties.GetAmmoNames(item, weapon)
				if #names > 0 then addText(rows, "cartridge", "Ammunition: " .. table.concat(names, ", ")) end
				local capacity = primary.ClipSize or weapon.ClipSize
				if capacity and capacity > 0 then add(rows, "magazine", "Magazine capacity", "number", capacity) end
				local delay = weapon.FireDelay or primary.Delay
				local rpm = primary.RPM or (delay and delay > 0 and 60 / delay)
				if rpm then
					local text = "Cyclic rate: " .. ix.itemProperties.Format("number", rpm) .. " rpm"
					addText(rows, "fireRate", text).variant = ix.itemProperties.GetFireModeGroup(weapon)
				end
			end
		end
		if item.base == "base_newweapons" then
			for _, row in ipairs(ix.itemProperties.GetAttachmentRows(item)) do rows[#rows + 1] = row end
			add(rows, "cleanliness", "Cleanliness", "percent", item:GetData("wear", 100))
		end
		if item.base == "base_newweapons" or item:GetData("durability") ~= nil then
			add(rows, "durability", "Durability", "percent", item:GetData("durability", 100))
		end
	elseif item.isBodyArmor or item.isHelmet or item.isGasmask then
		add(rows, "durability", "Durability", "percent", item:GetData("durability", 100))
	end
	if item.ammo and not item.isWeapon then
		local variant = AMMO_VARIANTS[item.ammo:match(" %-(%w+)%-$")]
		if variant then addText(rows, "ammoVariant", "Variant: " .. variant) end
	end
	for _, row in ipairs(ix.itemProperties.GetFilterRows(item)) do rows[#rows + 1] = row end
	local imperial = CLIENT and ix.option.Get("imperial", false) or false
	if item.GetCarryInc and not item.entity then
		local carry = item:GetCarryInc()
		if carry and carry ~= 0 then
			addText(rows, "carry", "Carry Capacity Increase: " .. ix.weight.WeightString(carry, imperial))
		end
	end
	local weight = item.GetWeight and item:GetWeight()
	if weight then
		addText(rows, "weight", "Weight: " .. ix.weight.WeightString(weight, imperial))
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
