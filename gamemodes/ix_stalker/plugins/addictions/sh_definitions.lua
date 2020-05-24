
--[[
	ADDICTION STRUCTURE:
	
	PLUGIN.addictionDefinitions["Light Alcoholic"] = {
		name 			= string,   -- "Pretty" name, for showing to the users (maybe)
		checkChance 	= number, -- Chance in percentage that the addiction will progress a stage worse when ticked (every PLUGIN.addictionInterval seconds)
		satisfyStruct   = { string, number } -- A struct containing the trigger and chance the addiction will be satisfied
		updateFunction 	= function(ply, oldlvl, newlvl) -- Called when the state of the addiction changes (ie when sated or when worsened)
		tickFunction 	= function(ply, lvl) -- Called every PLUGIN.addictionTickInterval
	}

	EXAMPLE:
	PLUGIN.addictionDefinitions["LightAlcoholic"] = {
	name = "Alcoholic (Light)",
	checkChance = 50,
	satisfyStruct = {{"AnyAlcohol", 75}, {"ExpensiveAlcohol", 100}},
	updateFunction 	= function(ply, oldlvl, newlvl)
		if (newlvl == ADDICTION_STATE_HEAVYWITHDRAWAL) then
			ply:DamagePsyHealth(20)
		end

		if (newlvl == ADDICTION_STATE_OK and oldlvl > ADDICTION_STATE_NEED) then
			ply:DamagePsyHealth(-40)
		end
	end,
	tickFunction 	= function(ply, lvl)
		if (lvl > ADDICTION_STATE_NEED) then
			ply:DamagePsyHealth(ADDICTION_STATE_NEED - lvl)
		end
	end,
}
]]--


PLUGIN.addictionDefinitions["LightAlcoholic"] = {
	name = "Alcoholic (Light)",
	checkChance = 50,
	satisfyStruct = {{"CheapAlcohol", 50}, {"MediumAlcohol", 75}, {"ExpensiveAlcohol", 100}},
	updateFunction 	= function(ply, oldlvl, newlvl)
		if (newlvl == ADDICTION_STATE_HEAVYWITHDRAWAL) then
			ply:DamagePsyHealth(20)
		end

		if (newlvl == ADDICTION_STATE_OK and oldlvl > ADDICTION_STATE_NEED) then
			ply:DamagePsyHealth(-40)
		end
	end,
	tickFunction 	= function(ply, lvl)
		if (lvl > ADDICTION_STATE_NEED) then
			ply:DamagePsyHealth(ADDICTION_STATE_NEED - lvl)
		end
	end,
}