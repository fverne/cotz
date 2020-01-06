
// flashlight color

	CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT = "KK_FL"
	CustomizableWeaponry.colorableParts.colors[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT] = {
		{name = "kk_fl_white",	display = "White",		color = Color(255,255,255,255)},
		{name = "kk_fl_whitew",	display = "Warm White",	color = Color(255,255,200,255)},
		{name = "kk_fl_whitec",	display = "Cold White",	color = Color(200,255,255,255)},
	}

	CustomizableWeaponry.colorableParts.colorText[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT] = " (HOLD - change light color)"
	CustomizableWeaponry.colorableParts.defaultColors[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT] = CustomizableWeaponry.colorableParts.colors[CustomizableWeaponry.colorableParts.COLOR_TYPE_KK_FLASHLIGHT][1]

// Weapon Length

	CustomizableWeaponry.originalValue:add("WeaponLength", false, false)
	CustomizableWeaponry:registerRecognizedVariable(
		"WeaponLength",

		"Decreases weapon length by ",

		"Increases weapon length by ",

		CustomizableWeaponry.textColors.POSITIVE,

		CustomizableWeaponry.textColors.NEGATIVE,

		function(weapon, attachmentData)
			weapon.WeaponLength = (weapon.WeaponLength or 0) + attachmentData.WeaponLength
		end,

		function(weapon, attachmentData)
			weapon.WeaponLength = (weapon.WeaponLength or 0) - attachmentData.WeaponLength
		end,

		function(attachmentData, value, varData)
			if value > 0 then
				return varData.greater .. math.abs((math.Round(value * 0.0254, 2))) .. "M", varData.greaterColor
			end

			return varData.lesser .. math.abs((math.Round(value * 0.0254, 2))) .. "M", varData.lesserColor
		end
	)

// Holster

	// in seconds
	CustomizableWeaponry.originalValue:add("HolsterTime", false, false)
	CustomizableWeaponry:registerRecognizedVariable(
		"HolsterTime",

		"Decreases holster time by ",

		"Increases holster time by ",

		CustomizableWeaponry.textColors.POSITIVE,

		CustomizableWeaponry.textColors.NEGATIVE,

		function(wep, data)
			wep.HolsterTime = wep.HolsterTime + data.HolsterTime
		end,

		function(wep, data)
			wep.HolsterTime = wep.HolsterTime - data.HolsterTime
		end,

		function(att, val, self)
			if val > 0 then
				return self.greater .. math.Round(val, 2) .. "s", self.greaterColor
			end

			return self.lesser .. math.Round(val, 2) .. "s", self.lesserColor
		end
	)

	// in %s
	CustomizableWeaponry.originalValue:add("HolsterSpeed", true, false)
	CustomizableWeaponry:registerRecognizedStat(
		"HolsterSpeedMult",
		"Decreases holster speed",
		"Increases holster speed",
		CustomizableWeaponry.textColors.NEGATIVE,
		CustomizableWeaponry.textColors.POSITIVE
	)

	CustomizableWeaponry.originalValue:add("disableDropping", false, false)

// Bolt
	CustomizableWeaponry.originalValue:add("BoltActionSpeed", true)
	CustomizableWeaponry:registerRecognizedStat(
		"BoltActionSpeedMult",
		"Decreases bolt-action speed",
		"Increases bolt-action speed",
		CustomizableWeaponry.textColors.NEGATIVE,
		CustomizableWeaponry.textColors.POSITIVE
	)
