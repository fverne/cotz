--[[
	ix.npcbarter.Register("'Old Timer'", "testbarter", {
		name = "Shot for tails", -- Currently unused
		description = "A box of .410 buck for 3 blind dog tails, or 1 pseudodog tail.", -- Description that will be shown in the dialogue
		defaultActive = true, -- Is this active by default

		barterItem = {"45acp41", 1, {["quantity"] = 5}}, -- Item that will awarded when barter is completed

		-- Only one type of item can be required at a time
		reqItem = { -- This means that this configuration will add 2 barters, one requiring 3 dog tails and one requiring a single pseudodog tail
			{"part_blinddog", 3}, 
			{"part_pseudodog", 1}
		}
	})
]]--

-- ix.npcbarter.Register("'Old Timer'", "testbarter", {
-- 	name = "Shot for tails",
-- 	description = "A box of .410 buck for 3 blind dog tails, or 1 pseudodog tail.",
-- 	defaultActive = true,

-- 	-- Item that will awarded when barter is completed
-- 	barterItem = {"45acp41"},

-- 	-- Only one type of item can be required at a time
-- 	reqItem = {
-- 		{"part_blinddog", 3},
-- 		{"part_pseudodog", 1}
-- 	}
-- })

-- ix.npcbarter.Register("'Old Timer'", "testbarter2", {
-- 	name = "USSR Surplus",
-- 	description = "10 shots of 7.62x54 for 4 capacitors.",
-- 	defaultActive = true,

-- 	-- Item that will awarded when barter is completed
-- 	barterItem = {"762x54hp", 1, {["quantity"] = 10}},

-- 	-- Only one type of item can be required at a time
-- 	reqItem = {
-- 		{"value_capacitors", 4},
-- 	}
-- })

-- ix.npcbarter.Register("'Old Timer'", "testbarter3", {
-- 	name = "Medical Bolts",
-- 	description = "3 medkits for an anomalous bolt.",
-- 	defaultActive = true,

-- 	-- Item that will awarded when barter is completed
-- 	barterItem = {"medic_medkit_1", 3},

-- 	-- Only one type of item can be required at a time
-- 	reqItem = {
-- 		{"artifact_bolt"},
-- 	}
-- })

ix.npcbarter.Register("'Old Timer'", "newbiebarter1", {
	name = "Decomposing Bullets",
	description = "I'll give you a box of .410 Buckshot for 4 pieces of Decomposing Meat.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"45acp41", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"meat_human", 4},
	}
})

ix.npcbarter.Register("'Old Timer'", "newbiebarter2", {
	name = "Decomposing Bullets",
	description = "I'll give you a box of 22LR for 2 pieces of Decomposing Meat.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"22lr", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"meat_human", 2},
	}
})

ix.npcbarter.Register("'Old Timer'", "newbiebarter3", {
	name = "Decomposing Bullets",
	description = "I'll give you a box of .45ACP for 3 pieces of Decomposing Meat.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"45acp", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"meat_human", 3},
	}
})

ix.npcbarter.Register("'Old Timer'", "newbiebarter4", {
	name = "Decomposing Bullets",
	description = "I'll give you a box of 9x18mm for 2 pieces of Decomposing Meat.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"9x18", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"meat_human", 2},
	}
})

ix.npcbarter.Register("'Old Timer'", "newbiebarter5", {
	name = "Decomposing Gear",
	description = "I'll give you a bandage for 1 pieces of Decomposing Meat.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"medic_bandage_1", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"meat_human", 2},
	}
})

ix.npcbarter.Register("'Old Timer'", "newbiebarter6", {
	name = "Decomposing Gear",
	description = "I'll give you a bottle of dirty water for 1 piece of Decomposing Meat.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"drink_bottlewaterdirty", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"meat_human", 1},
	}
})



ix.npcbarter.Register("'Cleaner'", "newbiebartercleaner1", {
	name = "Eurofunny",
	description = "I'll give you a box of .22lr for 10 Euros.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"22lr", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"value_currency_euro", 10},
	}
})

ix.npcbarter.Register("'Cleaner'", "newbiebartercleaner2", {
	name = "Eurofunny 2",
	description = "I'll give you a box of 12 Gauge Buckshot for 35 Euros.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"12gauge", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"value_currency_euro", 35},
	}
})

ix.npcbarter.Register("'Cleaner'", "newbiebartercleaner3", {
	name = "Eurofunny 3",
	description = "I'll give you a box of .410 Buckshot for 20 Euros.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"45acp41", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"value_currency_euro", 20},
	}
})

ix.npcbarter.Register("'Cleaner'", "newbiebartercleaner4", {
	name = "Eurofunny",
	description = "I'll give you 10 Euro for a lost note.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"value_currency_euro", 1, {["quantity"] = 10}},

	-- Only one type of item can be required at a time
	reqItem = {
		{"hidestash_1", 1},
	}
})

ix.npcbarter.Register("'Cleaner'", "newbiebartercleaner5", {
	name = "Eurofunny",
	description = "I'll give you 15 Euro for a lost rookie PDA.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"value_currency_euro", 1, {["quantity"] = 15}},

	-- Only one type of item can be required at a time
	reqItem = {
		{"hidestash_2", 1},
	}
})

ix.npcbarter.Register("'Cleaner'", "newbiebartercleaner6", {
	name = "Eurofunny",
	description = "I'll give you 25 Euro for a lost veteran PDA.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"value_currency_euro", 1, {["quantity"] = 25}},

	-- Only one type of item can be required at a time
	reqItem = {
		{"hidestash_3", 1},
	}
})

ix.npcbarter.Register("'Cleaner'", "stashbartercleaner1", {
	name = "Eurofunny",
	description = "I'll give you a lost note for 25 Euro.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"hidestash_1", 1, },

	-- Only one type of item can be required at a time
	reqItem = {
		{"value_currency_euro", 25},
	}
})

ix.npcbarter.Register("'Cleaner'", "stashbartercleaner2", {
	name = "Eurofunny",
	description = "I'll give you a rookie PDA for 50 Euro.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"hidestash_2", 1, },

	-- Only one type of item can be required at a time
	reqItem = {
		{"value_currency_euro", 50},
	}
})

ix.npcbarter.Register("'Cleaner'", "stashbartercleaner3", {
	name = "Eurofunny",
	description = "I'll give you a veteran PDA for 100 Euro.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"hidestash_3", 1, },

	-- Only one type of item can be required at a time
	reqItem = {
		{"value_currency_euro", 100},
	}
})

ix.npcbarter.Register("'Haggler'", "newbiebarterhaggler1", {
	name = "Ammo",
	description = "I'll give you a box of low tier ammo for some red gunpowder.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"kit_reward_ammo_tier01", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"value_gunpowder_red", 1},
	}
})

ix.npcbarter.Register("'Haggler'", "newbiebarterhaggler2", {
	name = "Ammo",
	description = "I'll give you a box of mid tier ammo for some green gunpowder.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"kit_reward_ammo_tier02", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"value_gunpowder_green", 1},
	}
})

ix.npcbarter.Register("'Haggler'", "newbiebarterhaggler3", {
	name = "Ammo",
	description = "I'll give you a box of high tier ammo for some blue gunpowder.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"kit_reward_ammo_tier03", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"value_gunpowder_blue", 1},
	}
})

ix.npcbarter.Register("'Quartermaster'", "foreignammobarterquartermaster1", {
	name = "ForeignAmmo",
	description = "I'll give you a box of foreign ammo for some green gunpowder.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"kit_ammo_rare", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"value_gunpowder_green", 3},
	}
})

ix.npcbarter.Register("'Quartermaster'", "foreignammobarterquartermaster2", {
	name = "ForeignAmmo",
	description = "I'll give you a large box of foreign ammo for some blue gunpowder.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"kit_ammo_m_rare", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"value_gunpowder_blue", 3},
	}
})

ix.npcbarter.Register("'Quartermaster'", "rareammobarterquartermaster1", {
	name = "RareAmmo",
	description = "I'll give you a box of 5.56 SS190 for 20 dollar.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"556x45ap", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"value_currency_dollar", 20},
	}
})

ix.npcbarter.Register("'Quartermaster'", "rareammobarterquartermaster2", {
	name = "RareAmmo",
	description = "I'll give you a box of 5.56 Overpressure for 20 dollar.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"556x45hp", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"value_currency_dollar", 20},
	}
})

ix.npcbarter.Register("'Quartermaster'", "rareammobarterquartermaster3", {
	name = "RareAmmo",
	description = "I'll give you a box of .44 Magnum AP for 25 dollasr.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"44magnumap", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"value_currency_dollar", 25},
	}
})

ix.npcbarter.Register("'Quartermaster'", "rareammobarterquartermaster4", {
	name = "RareAmmo",
	description = "I'll give you a box of .44 Magnum HP for 25 dollars.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"44magnumhp", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"value_currency_dollar", 25},
	}
})

ix.npcbarter.Register("'Quartermaster'", "rareammobarterquartermaster5", {
	name = "RareAmmo",
	description = "I'll give you a box of 7.62x51 M993 AP for 30 dollars.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"762x51ap", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"value_currency_dollar", 30},
	}
})

ix.npcbarter.Register("'Quartermaster'", "rareammobarterquartermaster6", {
	name = "RareAmmo",
	description = "I'll give you a box of 7.62x51mm M118 BTHP HP for 30 dollars.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"762x51hp", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"value_currency_dollar", 30},
	}
})

ix.npcbarter.Register("'Spicy Lemon'", "spicylemonaidbarter1", {
	name = "FoodAndDrugs",
	description = "I'll give you a bottle of medicinal tea for some sprig stew.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"miscaid_swampbrew", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"meal_sprig", 3},
	}
})

ix.npcbarter.Register("'Spicy Lemon'", "spicylemonaidbarter2", {
	name = "FoodAndDrugs",
	description = "I'll give you a glucose shot for some hellhound chops.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"drug_glucose", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"meal_hellhound", 1},
	}
})

ix.npcbarter.Register("'Spicy Lemon'", "spicylemonaidbarter3", {
	name = "FoodAndDrugs",
	description = "I'll give you an Ecologist stimpak for some pseudogiant steak.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"medic_stimpak_2", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"meal_pseudogiant", 1},
	}
})

ix.npcbarter.Register("'Spicy Lemon'", "spicylemonfoodbarter1", {
	name = "FoodAndDrugs",
	description = "I'll give you a Ukrainian MRE for some morphine.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"food_mre_ukraine", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"drug_morphine", 3},
	}
})

ix.npcbarter.Register("'Spicy Lemon'", "spicylemonfoodbarter2", {
	name = "FoodAndDrugs",
	description = "I'll give you a Russian MRE for some classic Monster.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"food_mre_russia", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"drink_energydrink_5", 1},
	}
})

ix.npcbarter.Register("'Spicy Lemon'", "spicylemonfoodbarter3", {
	name = "FoodAndDrugs",
	description = "I'll give you an American MRE for some glucose.",
	defaultActive = true,

	-- Item that will awarded when barter is completed
	barterItem = {"food_mre_usa", 1},

	-- Only one type of item can be required at a time
	reqItem = {
		{"drug_glucose", 1},
	}
})