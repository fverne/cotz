local MAP = "rp_marsh_cs"

ix.progression.Register("spicylemonItemDelivery_Medical1", {
	name = "Medical Imports 1",
	description = "Spicy Lemon is interested in getting a side project going.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = true,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Spicy Lemon'", args = { "drug_mints", nil, 1, "SELLANDBUY", 1, 4, 1 } },
	},
	nextProgressions = { "spicylemonItemDelivery_Medical2" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Hello, stalker. You may not know it, but I am a chemist "
			.. "by trade; a type of chemist, at any rate. Are you interested "
			.. "in my services? If so, I will need your assistance with "
			.. "getting the tools necessary to get mixing. I am in touch "
			.. "with a laboratory with spare equipment, and they are willing "
			.. "to make an exchange. I require your help.\n\nREQUIRED ITEMS:"
		)

		for item, amount in pairs(itemIDs) do
			local currentAmount = 0
			if data and data[item] then
				currentAmount = data[item]
			end
			str = str .. string.format("\n%d %s", amount - currentAmount, ix.item.list[item].name)
		end

		return str
	end,
	lootMapTier = 1,
	requirementSlots = {
		{ pool = "common_meals", quantity = 1 },
		{ pool = "local_refreshments", quantity = 1 },
		{ pool = "canned_food", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Spicy Lemon'"
			local message = (
				"My laboratory is online and I now offer common breath mints. "
				.. "They are not much, but they are handy for radiation removal "
				.. "in a pinch."
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("spicylemonItemDelivery_Medical2", {
	name = "Medical Imports 2",
	description = "Spicy Lemon wants to expand his business.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Spicy Lemon'", args = { "drug_caffeine", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "spicylemonItemDelivery_Medical3", "spicylemonItemDelivery_Food" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"My new laboratory equipment shows great promise, but it "
			.. "is never a bad time to expand business. I have noticed "
			.. "many stalkers sleeping long hours and not getting as much "
			.. "field time as they would like; I would like to remedy this. "
			.. "Are you interested?\n\nREQUIRED ITEMS:"
		)

		for item, amount in pairs(itemIDs) do
			local currentAmount = 0
			if data and data[item] then
				currentAmount = data[item]
			end
			str = str .. string.format("\n%d %s", amount - currentAmount, ix.item.list[item].name)
		end

		return str
	end,
	lootMapTier = 1,
	requirementSlots = {
		{ pool = "common_meals", quantity = 2 },
		{ pool = "local_beer", quantity = 2 },
		{ pool = "canned_food", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Spicy Lemon'"
			local message = (
				"I now carry caffeine tablets for those stalkers wanting "
				.. "a little extra stamina in their travels. Come and see me."
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("spicylemonItemDelivery_Medical3", {
	name = "Medical Imports 3",
	description = "Spicy Lemon wants to help him help you stay safe.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Spicy Lemon'", args = { "medic_psyheal_1", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "spicylemonItemDelivery_Medical4", "spicylemonItemDelivery_Vodka" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Good day, stalker. You may have noticed, but the Swamps "
			.. "are home to a special variety of controller; the Swamp "
			.. "Controller. None of the others here carry the kind of medicines "
			.. "necessary to combat them short of smoking entire packs "
			.. "of cigarettes to clear the mind. As you may imagine, I "
			.. "am not interested in my clients becoming zombies. I am "
			.. "willing to help, but I require certain materials to mix.\n\nREQUIRED "
			.. "ITEMS:"
		)

		for item, amount in pairs(itemIDs) do
			local currentAmount = 0
			if data and data[item] then
				currentAmount = data[item]
			end
			str = str .. string.format("\n%d %s", amount - currentAmount, ix.item.list[item].name)
		end

		return str
	end,
	lootMapTier = 1,
	requirementSlots = {
		{ pool = "common_meals", quantity = 4 },
		{ pool = "predator_meals", quantity = 4 },
		{ pool = "local_refreshments", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Spicy Lemon'"
			local message = (
				"I have begun mixing batches of Modafine; though it is harsh "
				.. "on the system, it is a great anti-psy drug."
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("spicylemonItemDelivery_Medical4", {
	name = "Medical Imports 4",
	description = "Spicy Lemon is interested in preventing harm rather than treating it.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Spicy Lemon'", args = { "medic_antipsychotic_1", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "spicylemonItemDelivery_Medical5" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"While having Modafine is useful, it is better to avoid "
			.. "harm outright than to treat it. I have received requests "
			.. "for a preventative drug rather than a reactive one, and "
			.. "I am more than happy to serve... provided I am supplied "
			.. "with the appropriate materials.\n\nREQUIRED ITEMS:"
		)

		for item, amount in pairs(itemIDs) do
			local currentAmount = 0
			if data and data[item] then
				currentAmount = data[item]
			end
			str = str .. string.format("\n%d %s", amount - currentAmount, ix.item.list[item].name)
		end

		return str
	end,
	lootMapTier = 2,
	requirementSlots = {
		{ pool = "common_meals", quantity = 4 },
		{ pool = "predator_meals", quantity = 4 },
		{ pool = "spirits", quantity = 4 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Spicy Lemon'"
			local message = (
				"I now carry Asenapine tablets. They are useful for lowering "
				.. "the effect of psy fields and Controller attacks."
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("spicylemonItemDelivery_Medical5", {
	name = "Medical Imports 5",
	description = "Spicy Lemon is interested in pain control.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Spicy Lemon'", args = { "drug_painkillers", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "spicylemonItemDelivery_Medical6", "spicylemonItemDelivery_Spirits" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Do your wounds ache, stalker? I am saddened to hear it; "
			.. "my heart aches to see you all suffering. I believe it will "
			.. "be best for everyone involved if I help tend your wounds, "
			.. "provided I am furnished with the appropriate materials "
			.. "to facilitate the acquisition of supplies...\n\nREQUIRED "
			.. "ITEMS:"
		)

		for item, amount in pairs(itemIDs) do
			local currentAmount = 0
			if data and data[item] then
				currentAmount = data[item]
			end
			str = str .. string.format("\n%d %s", amount - currentAmount, ix.item.list[item].name)
		end

		return str
	end,
	lootMapTier = 2,
	requirementSlots = {
		{ pool = "predator_meals", quantity = 4 },
		{ pool = "common_meals", quantity = 4 },
		{ pool = "local_beer", quantity = 4 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Spicy Lemon'"
			local message = (
				"I now carry painkillers; more specifically, Codeine tablets. "
				.. "If you find yourself aching and desire a pick me up, come "
				.. "and see me."
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("spicylemonItemDelivery_Medical6", {
	name = "Medical Imports 6",
	description = "Spicy Lemon would like to expand into combat drugs.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Spicy Lemon'", args = { "drug_adrenaline", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "spicylemonItemDelivery_Medical7" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"The mutants out there are not getting easier to deal with, "
			.. "stalker. Between them and hostile stalkers, the dangers "
			.. "are many and the options to fight back few. I should like "
			.. "to step in and help provide something I think you might "
			.. "find quite useful. To purchase the mixing materials, however, "
			.. "I am having to reach deep into my own pockets. That is "
			.. "where you come in.\n\nREQUIRED ITEMS:"
		)

		for item, amount in pairs(itemIDs) do
			local currentAmount = 0
			if data and data[item] then
				currentAmount = data[item]
			end
			str = str .. string.format("\n%d %s", amount - currentAmount, ix.item.list[item].name)
		end

		return str
	end,
	lootMapTier = 3,
	requirementSlots = {
		{ pool = "predator_meals", quantity = 4 },
		{ pool = "exotic_meals", quantity = 4 },
		{ pool = "spirits", quantity = 4 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Spicy Lemon'"
			local message = (
				"I now offer Adrenaline autoinjectors for sale; these handy "
				.. "little pens should get you back in the fight and keep you "
				.. "in it for some time."
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("spicylemonItemDelivery_Medical7", {
	name = "Medical Imports 7",
	description = "Spicy Lemon would like to complete his stock of combat drugs.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Spicy Lemon'", args = { "drug_morphine", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "spicylemonItemDelivery_Brew" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Though Codeine is useful after combat, I am looking to "
			.. "furnish stalkers with something a bit stronger for use "
			.. "during combat. The first thing that comes to mind is morphine "
			.. "sulfate. It is both very powerful and very expensive, but "
			.. "if you are all willing to chip in I will arrange a sale.\n\nREQUIRED "
			.. "ITEMS:"
		)

		for item, amount in pairs(itemIDs) do
			local currentAmount = 0
			if data and data[item] then
				currentAmount = data[item]
			end
			str = str .. string.format("\n%d %s", amount - currentAmount, ix.item.list[item].name)
		end

		return str
	end,
	lootMapTier = 3,
	requirementSlots = {
		{ pool = "exotic_meals", quantity = 3 },
		{ pool = "predator_meals", quantity = 2 },
		{ pool = "energy_drinks", quantity = 2 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Spicy Lemon'"
			local message = (
				"I now offer Morphine injectors. Please use them responsibly; "
				.. "I would hate to see anyone overdose..."
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("spicylemonItemDelivery_Food", {
	name = "Food for the poor",
	description = "Spicy Lemon is interested in importing some food.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = true,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Spicy Lemon'", args = { "drink_bottlebeer_6", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Spicy Lemon'", args = { "drink_canwater", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Spicy Lemon'", args = { "drink_energydrink_4", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Spicy Lemon'", args = { "drink_energydrink_2", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Spicy Lemon'", args = { "food_cheese_2", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Spicy Lemon'", args = { "food_nuts_2", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Spicy Lemon'", args = { "food_can_tomato", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Spicy Lemon'", args = { "food_can_tushonka", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "spicylemonItemDelivery_Vodka" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Good day, stalker. You have no doubt encountered mutant "
			.. "meat in your time; most of it is irradiated if not borderline "
			.. "toxic. I have friends outside the Zone who are interested "
			.. "in such samples for research, however, and are willing "
			.. "to exchange purified food and drink for the less pleasant "
			.. "variety we have here. Up to it?\n\nREQUIRED ITEMS:"
		)

		for item, amount in pairs(itemIDs) do
			local currentAmount = 0
			if data and data[item] then
				currentAmount = data[item]
			end
			str = str .. string.format("\n%d %s", amount - currentAmount, ix.item.list[item].name)
		end

		return str
	end,
	lootMapTier = 1,
	requirementSlots = {
		{ pool = "local_refreshments", quantity = 1 },
		{ pool = "common_meals", quantity = 1 },
		{ pool = "canned_food", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Spicy Lemon'"
			local message = "I now offer purified food and drink from outside the Zone."
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("spicylemonItemDelivery_Vodka", {
	name = "Drinks for the poor",
	description = "Spicy Lemon has a discerning eye for new customers...",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Spicy Lemon'", args = { "drink_vodka_4", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Spicy Lemon'", args = { "drink_vodka_5", nil, 1, "SELLANDBUY", 1, 6, 1 } },
		{ npc = "'Spicy Lemon'", args = { "drink_vodka_6", nil, 1, "SELLANDBUY", 1, 6, 1 } },
	},
	nextProgressions = { "spicylemonItemDelivery_Spirits" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"One look at you tells me all I need to know, stalker. You "
			.. "are not interested in beers or store bought alcohol; you "
			.. "are looking for something a bit more discerning. Should "
			.. "you provide me with the resources necessary to start making "
			.. "some trades, I can bring in some fine local vodkas.\n\nREQUIRED "
			.. "ITEMS:"
		)

		for item, amount in pairs(itemIDs) do
			local currentAmount = 0
			if data and data[item] then
				currentAmount = data[item]
			end
			str = str .. string.format("\n%d %s", amount - currentAmount, ix.item.list[item].name)
		end

		return str
	end,
	lootMapTier = 1,
	requirementSlots = {
		{ pool = "local_refreshments", quantity = 1 },
		{ pool = "common_meals", quantity = 1 },
		{ pool = "spirits", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Spicy Lemon'"
			local message = (
				"The first imports of high shelf local vodka have arrived. "
				.. "Come and see the brands for yourselves."
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("spicylemonItemDelivery_Spirits", {
	name = "Drinks for the rich",
	description = "Spicy Lemon would like to expand his vodka stocks.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Spicy Lemon'", args = { "drink_spirit_1", nil, 1, "SELLANDBUY", 1, 6, 1 } },
		{ npc = "'Spicy Lemon'", args = { "drink_spirit_2", nil, 1, "SELLANDBUY", 1, 6, 1 } },
		{ npc = "'Spicy Lemon'", args = { "drink_spirit_3", nil, 1, "SELLANDBUY", 1, 6, 1 } },
		{ npc = "'Spicy Lemon'", args = { "drink_wine", nil, 1, "SELLANDBUY", 1, 6, 1 } },
	},
	nextProgressions = { "spicylemonItemDelivery_Brew" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Not satisfied with local vodka? This is no issue; I completely "
			.. "understand the desire for something a bit more... exotic. "
			.. "I have seen some stalkers carrying foreign imported spirits; "
			.. "expensive, difficult to buy... except I have found just "
			.. "the person to buy them from. They would like some proof "
			.. "of my good intentions, however, so now is the time to give "
			.. "them an appetizer of sorts.\n\nREQUIRED ITEMS:"
		)

		for item, amount in pairs(itemIDs) do
			local currentAmount = 0
			if data and data[item] then
				currentAmount = data[item]
			end
			str = str .. string.format("\n%d %s", amount - currentAmount, ix.item.list[item].name)
		end

		return str
	end,
	lootMapTier = 1,
	requirementSlots = {
		{ pool = "local_refreshments", quantity = 1 },
		{ pool = "predator_meals", quantity = 1 },
		{ pool = "local_beer", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Spicy Lemon'"
			local message = (
				"Fine international spirits have just arrived from the Cordon. "
				.. "Grab a bottle and kick back with your friends."
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("spicylemonItemDelivery_Brew", {
	name = "Drinks for the smart",
	description = "Spicy Lemon is interested in medicinal brews.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Spicy Lemon'", args = { "miscaid_swampbrew", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Hello, stalker. My interest does not lie with chemistry "
			.. "and brewing alone; I like to mix the two crafts from time "
			.. "to time, and I believe it may be time for me to start bringing "
			.. "in my own medicinal teas. The Swamps provide everything "
			.. "we need to make a very special kind of brew.\n\nREQUIRED "
			.. "ITEMS:"
		)

		for item, amount in pairs(itemIDs) do
			local currentAmount = 0
			if data and data[item] then
				currentAmount = data[item]
			end
			str = str .. string.format("\n%d %s", amount - currentAmount, ix.item.list[item].name)
		end

		return str
	end,
	lootMapTier = 2,
	requirementSlots = {
		{ pool = "elite_meals", quantity = 4 },
		{ pool = "exotic_meals", quantity = 3 },
		{ pool = "spirits", quantity = 3 },
		{ pool = "local_refreshments", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Spicy Lemon'"
			local message = (
				"Though it has taken some experimentation, I have finished "
				.. "a medicinal brew that I believe will be perfect for the "
				.. "Zone's conditions... although the taste leaves something "
				.. "to be desired."
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})
