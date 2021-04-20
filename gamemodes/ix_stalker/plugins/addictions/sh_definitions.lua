
--[[
	ADDICTION STRUCTURE:
	
	PLUGIN.addictionDefinitions["Light Alcoholic"] = {
		name 			= string,   -- "Pretty" name, for showing to the users (maybe)
		checkChance 	= number, -- Chance in percentage that the addiction will progress a stage worse when ticked (every PLUGIN.addictionInterval seconds)
		satisfyStruct   = { string, number, number } -- A struct containing the trigger and chance the addiction will be satisfied and the amount the addiction will be satisfied by
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

local ADDICTION_STATE_OK = 1
local ADDICTION_STATE_NEED = 2
local ADDICTION_STATE_WITHDRAWAL = 4
local ADDICTION_STATE_HEAVYWITHDRAWAL = 8
local ADDICTION_STATE_WORSTWITHDRAWAL = 11

--[[
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
}]]

PLUGIN.addictionDefinitions["LightAlcoholic"] = {
	name = "Alcoholic (Light)",
	checkChance = 60,
	satisfyStruct = {{"CheapAlcohol", 75, 2}, {"MediumAlcohol", 100, 2}, {"ExpensiveAlcohol", 100, 4}},
	updateFunction 	= function(ply, oldlvl, newlvl)
		if (newlvl >= ADDICTION_STATE_HEAVYWITHDRAWAL) then
			ply:DamagePsyHealth(20)
		end

		if (newlvl < oldlvl) then
			ply:DamagePsyHealth(-15 * (oldlvl - newlvl))
		end
	end,
	tickFunction 	= function(ply, lvl)
		if (lvl >= ADDICTION_STATE_NEED) then
			ply:Notify("I could really go for a drink right now...")
		end

		if (lvl >= ADDICTION_STATE_WORSTWITHDRAWAL) then
			ply:DamagePsyHealth(10)
		end

		if (lvl >= ADDICTION_STATE_WITHDRAWAL) then
			ply:DamagePsyHealth(lvl - ADDICTION_STATE_NEED)
		end
	end,
}

PLUGIN.addictionDefinitions["StrongAlcoholic"] = {
	name = "Alcoholic (Strong)",
	checkChance = 60,
	satisfyStruct = {{"CheapAlcohol", 50, 1}, {"MediumAlcohol", 75, 2}, {"ExpensiveAlcohol", 100, 3}},
	updateFunction 	= function(ply, oldlvl, newlvl)
		if (newlvl >= ADDICTION_STATE_HEAVYWITHDRAWAL) then
			ply:DamagePsyHealth(35)
		end

		if (newlvl < oldlvl) then
			ply:DamagePsyHealth(-20 * (oldlvl - newlvl))
		end
	end,
	tickFunction 	= function(ply, lvl)
		if (lvl >= ADDICTION_STATE_NEED) then
			ply:Notify("I could really go for a drink right now...")
		end

		if (lvl >= ADDICTION_STATE_WORSTWITHDRAWAL) then
			ply:DamagePsyHealth(10)
		end

		if (lvl >= ADDICTION_STATE_WITHDRAWAL) then
			ply:DamagePsyHealth((lvl - ADDICTION_STATE_NEED)*2)
		end
	end,
}

PLUGIN.addictionDefinitions["LightSmoker"] = {
	name = "Smoker (Light)",
	checkChance = 100,
	satisfyStruct = {{"WeakSmokes", 50, 1}, {"StrongSmokes", 75, 3}, {"SpecialSmokes", 100, 6}},
	updateFunction 	= function(ply, oldlvl, newlvl)
		if (newlvl >= ADDICTION_STATE_HEAVYWITHDRAWAL) then
			ply:DamagePsyHealth(20)
		end

		if (newlvl < oldlvl) then
			ply:DamagePsyHealth(-10 * (oldlvl - newlvl))
		end
	end,
	tickFunction 	= function(ply, lvl)
		if (lvl >= ADDICTION_STATE_NEED) then
			ply:Notify("I could really go for a smoke right now...")
		end

		if (lvl >= ADDICTION_STATE_WORSTWITHDRAWAL) then
			ply:DamagePsyHealth(10)
		end

		if (lvl >= ADDICTION_STATE_WITHDRAWAL) then
			ply:DamagePsyHealth((lvl - ADDICTION_STATE_NEED)*2)
		end
	end,
}

PLUGIN.addictionDefinitions["StrongSmoker"] = {
	name = "Smoker (Strong)",
	checkChance = 100,
	satisfyStruct = {{"WeakSmokes", 25, 1}, {"StrongSmokes", 50, 4}, {"SpecialSmokes", 100, 6}},
	updateFunction 	= function(ply, oldlvl, newlvl)
		if (newlvl >= ADDICTION_STATE_HEAVYWITHDRAWAL) then
			ply:DamagePsyHealth(20)
		end

		if (newlvl < oldlvl) then
			ply:DamagePsyHealth(-10 * (oldlvl - newlvl))
		end
	end,
	tickFunction 	= function(ply, lvl)
		if (lvl >= ADDICTION_STATE_NEED) then
			ply:Notify("I could really go for a smoke right now...")
		end

		if (lvl >= ADDICTION_STATE_WORSTWITHDRAWAL) then
			ply:DamagePsyHealth(10)
		end

		if (lvl >= ADDICTION_STATE_WITHDRAWAL) then
			ply:DamagePsyHealth((lvl - ADDICTION_STATE_NEED)*2)
		end
	end,
}

PLUGIN.addictionDefinitions["DrugUser"] = {
	name = "Drug User",
	checkChance = 100,
	satisfyStruct = {{"PrescriptionDrugs", 75, 2}, {"Marijuana", 100, 2}, {"StrongerDrugs", 100, 6}},
	updateFunction 	= function(ply, oldlvl, newlvl)
		if (newlvl >= ADDICTION_STATE_HEAVYWITHDRAWAL) then
			ply:DamagePsyHealth(20)
		end

		if (newlvl < oldlvl) then
			ply:DamagePsyHealth(-10 * (oldlvl - newlvl))
		end
	end,
	tickFunction 	= function(ply, lvl)
		if (lvl >= ADDICTION_STATE_NEED) then
			ply:Notify("I could really go for a hit of something right now...")
		end

		if (lvl >= ADDICTION_STATE_WORSTWITHDRAWAL) then
			ply:DamagePsyHealth(10)
		end

		if (lvl >= ADDICTION_STATE_WITHDRAWAL) then
			ply:DamagePsyHealth((lvl - ADDICTION_STATE_NEED)*2)
		end
	end,
}