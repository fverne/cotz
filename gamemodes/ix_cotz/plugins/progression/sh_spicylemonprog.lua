local MAP = "rp_marsh_cs"

ix.progression.Register("spicylemonItemDelivery_Medical1", {
	name = "Medical Imports 1",
	description = "Spicy Lemon is interested in getting a side project going.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = true,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Spicy Lemon'", args = { "drug_mints", nil, 2, "SELLANDBUY", 2, 12, 1 } },
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
		{ pool = "common_meals", quantity = 8 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Spicy Lemon'"
			local message = string.format(
				"%s, your delivery helped get my little laboratory working. I can sell you the "
				.. "antiradiation breath mints now. A modest start, but useful in a pinch.",
				character:GetName()
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
		{ npc = "'Spicy Lemon'", args = { "drug_caffeine", nil, 2, "SELLANDBUY", 2, 12, 1 } },
	},
	nextProgressions = {"spicylemonItemDelivery_Medical3", "spicylemonItemDelivery_Food_stage1"},
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
		{ pool = "common_meals", quantity = 5 },
		{ pool = "local_beer", quantity = 4 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Spicy Lemon'"
			local message = string.format(
				"%s, thanks for keeping my work supplied. I'll sell you caffeine tablets now if you "
				.. "need something for those long trips. Sleep is still a fine invention, though.",
				character:GetName()
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
		{ npc = "'Spicy Lemon'", args = { "medic_psyheal_1", nil, 2, "SELLANDBUY", 2, 12, 1 } },
	},
	nextProgressions = {"spicylemonItemDelivery_Medical4", "spicylemonItemDelivery_Vodka_stage1"},
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
		{ pool = "common_meals", quantity = 5 },
		{ pool = "predator_meals", quantity = 4 },
		{ pool = "local_refreshments", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Spicy Lemon'"
			local message = string.format(
				"%s, your supplies helped me prepare the Modafine. You can buy it from me now. "
				.. "Useful against psy exposure, but rather harsh on the system.",
				character:GetName()
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
		{ npc = "'Spicy Lemon'", args = { "medic_antipsychotic_1", nil, 2, "SELLANDBUY", 2, 12, 1 } },
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
		{ pool = "common_meals", quantity = 5 },
		{ pool = "predator_meals", quantity = 4 },
		{ pool = "spirits", quantity = 2 },
		{ pool = "exotic_meals", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Spicy Lemon'"
			local message = string.format(
				"%s, I can now sell you Asenapine tablets, thanks to your help. They may help you "
				.. "cope with psy fields and Controllers. Do read the label.",
				character:GetName()
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
		{ npc = "'Spicy Lemon'", args = { "drug_painkillers", nil, 2, "SELLANDBUY", 2, 12, 1 } },
	},
	nextProgressions = {"spicylemonItemDelivery_Medical6", "spicylemonItemDelivery_Spirits_stage1"},
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
		{ pool = "common_meals", quantity = 5 },
		{ pool = "local_beer", quantity = 3 },
		{ pool = "exotic_meals", quantity = 4 },
		{ pool = "elite_meals", quantity = 2 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Spicy Lemon'"
			local message = string.format(
				"%s, you've earned access to my Codeine tablets. Come see me to buy some for your "
				.. "medical pouch; I'd prefer you didn't have to limp all the way here.",
				character:GetName()
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
		{ npc = "'Spicy Lemon'", args = { "drug_adrenaline", nil, 2, "SELLANDBUY", 2, 12, 1 } },
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
		{ pool = "spirits", quantity = 2 },
		{ pool = "common_meals", quantity = 5 },
		{ pool = "elite_meals", quantity = 3 },
		{ pool = "local_refreshments", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Spicy Lemon'"
			local message = string.format(
				"%s, those supplies were just what I needed. I'll sell you adrenaline autoinjectors "
				.. "now. A handy addition to your kit when a trip takes a bad turn.",
				character:GetName()
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
		{ npc = "'Spicy Lemon'", args = { "drug_morphine", nil, 2, "SELLANDBUY", 2, 12, 1 } },
	},
	nextProgressions = {"spicylemonItemDelivery_Brew_stage1"},
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
		{ pool = "exotic_meals", quantity = 4 },
		{ pool = "predator_meals", quantity = 4 },
		{ pool = "energy_drinks", quantity = 1 },
		{ pool = "common_meals", quantity = 5 },
		{ pool = "elite_meals", quantity = 3 },
		{ pool = "local_refreshments", quantity = 3 },
		{ pool = "local_beer", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Spicy Lemon'"
			local message = string.format(
				"%s, I trust you enough to sell you morphine injectors now. Come see me if you need "
				.. "them, and please be responsible with the dosage.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("spicylemonItemDelivery_Food_stage1", {
	name = "Food for the poor - 1/4",
	description = "Food for the poor - 1/4",
	keyNpc = "'Spicy Lemon'",
	progMap = "rp_marsh_cs",
	defaultActive = true,
	lootMapTier = 1,
	requirementSlots = {
		{pool = "common_meals", quantity = 2},
	},
	nextProgressions = {"spicylemonItemDelivery_Food_stage2"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "spicylemonItemDelivery_Food",
	stageIndex = 1,
	stageCount = 4,
	vendorUnlocks = {
		{npc = "'Spicy Lemon'", args = {"drink_canwater", nil, 1, "SELLANDBUY", 1, 48, 1}},
		{npc = "'Spicy Lemon'", args = {"drink_bottlebeer_6", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"A hungry stalker is bad company, but a thirsty one is worse. Bring the cooked "
		.. "portions first and I'll sort the first drinks shipment for you."
	),
	completionMessage = "Now that's a useful delivery! I'll keep the kitchen moving; you keep coming back alive.",
})

ix.progression.Register("spicylemonItemDelivery_Food_stage2", {
	name = "Food for the poor - 2/4",
	description = "Food for the poor - 2/4",
	keyNpc = "'Spicy Lemon'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 1,
	requirementSlots = {
		{pool = "common_meals", quantity = 2},
	},
	nextProgressions = {"spicylemonItemDelivery_Food_stage3"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "spicylemonItemDelivery_Food",
	stageIndex = 2,
	stageCount = 4,
	vendorUnlocks = {
		{npc = "'Spicy Lemon'", args = {"food_nuts_2", nil, 1, "SELLANDBUY", 1, 48, 1}},
		{npc = "'Spicy Lemon'", args = {"food_cheese_2", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"Good, nobody's fainting at the table. Keep those meals coming and I can spare the "
		.. "better snacks for your next trip."
	),
	completionMessage = "Now that's a useful delivery! I'll keep the kitchen moving; you keep coming back alive.",
})

ix.progression.Register("spicylemonItemDelivery_Food_stage3", {
	name = "Food for the poor - 3/4",
	description = "Food for the poor - 3/4",
	keyNpc = "'Spicy Lemon'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 1,
	requirementSlots = {
		{pool = "common_meals", quantity = 1},
		{pool = "local_refreshments", quantity = 2},
	},
	nextProgressions = {"spicylemonItemDelivery_Food"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "spicylemonItemDelivery_Food",
	stageIndex = 3,
	stageCount = 4,
	vendorUnlocks = {
		{npc = "'Spicy Lemon'", args = {"food_can_tomato", nil, 1, "SELLANDBUY", 1, 48, 1}},
		{npc = "'Spicy Lemon'", args = {"food_can_tushonka", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"Hot food keeps this place alive; tins keep you alive when you leave it. Bring the "
		.. "next portions and drinks so I can put canned provisions aside."
	),
	completionMessage = "Now that's a useful delivery! I'll keep the kitchen moving; you keep coming back alive.",
})

ix.progression.Register("spicylemonItemDelivery_Food", {
	name = "Food for the poor",
	description = "Spicy Lemon is interested in importing some food.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Spicy Lemon'", args = {"drink_energydrink_4", nil, 1, "SELLANDBUY", 1, 48, 1}},
		{npc = "'Spicy Lemon'", args = {"drink_energydrink_2", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	nextProgressions = {"spicylemonItemDelivery_Vodka_stage1"},
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
		{pool = "local_refreshments", quantity = 1},
		{pool = "canned_food", quantity = 3},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Spicy Lemon'"
			local message = string.format(
				"%s, your help with the supplies has earned you a place on my import list. You can "
				.. "buy purified food and drink from me now. A little taste of life outside.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "spicylemonItemDelivery_Food",
	stageIndex = 4,
	stageCount = 4,
	stockUnlocks = {
		{
			npc = "'Spicy Lemon'",
			bonus = 1,
			items = {
				"drink_bottlewater",
				"drink_bottletea",
				"food_can_sprats",
				"food_cheese_2",
				"food_nuts_2",
				"food_can_tomato",
				"food_can_tushonka",
			},
		},
	},
})

ix.progression.Register("spicylemonItemDelivery_Vodka_stage1", {
	name = "Drinks for the poor - 1/2",
	description = "Drinks for the poor - 1/2",
	keyNpc = "'Spicy Lemon'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 1,
	requirementSlots = {
		{pool = "common_meals", quantity = 4},
		{pool = "local_refreshments", quantity = 1},
	},
	nextProgressions = {"spicylemonItemDelivery_Vodka"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "spicylemonItemDelivery_Vodka",
	stageIndex = 1,
	stageCount = 2,
	vendorUnlocks = {
		{npc = "'Spicy Lemon'", args = {"drink_vodka_4", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"There's vodka, and then there's the bottle I don't put out for just anyone. Help with "
		.. "this order and I'll show you the first of the better stuff."
	),
	completionMessage = "Now that's a useful delivery! I'll keep the kitchen moving; you keep coming back alive.",
})

ix.progression.Register("spicylemonItemDelivery_Vodka", {
	name = "Drinks for the poor",
	description = "Spicy Lemon has a discerning eye for new customers...",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Spicy Lemon'", args = {"drink_vodka_5", nil, 1, "SELLANDBUY", 1, 48, 1}},
		{npc = "'Spicy Lemon'", args = {"drink_vodka_6", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	nextProgressions = {"spicylemonItemDelivery_Spirits_stage1"},
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
		{pool = "local_refreshments", quantity = 2},
		{pool = "spirits", quantity = 2},
		{pool = "predator_meals", quantity = 4},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Spicy Lemon'"
			local message = string.format(
				"%s, your delivery went down well with my contacts. I'll sell you the better local "
				.. "vodkas now. Come take a look at the labels when you're back.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "spicylemonItemDelivery_Vodka",
	stageIndex = 2,
	stageCount = 2,
})

ix.progression.Register("spicylemonItemDelivery_Spirits_stage1", {
	name = "Drinks for the rich - 1/2",
	description = "Drinks for the rich - 1/2",
	keyNpc = "'Spicy Lemon'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 1,
	requirementSlots = {
		{pool = "common_meals", quantity = 5},
		{pool = "local_refreshments", quantity = 3},
		{pool = "predator_meals", quantity = 1},
	},
	nextProgressions = {"spicylemonItemDelivery_Spirits"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "spicylemonItemDelivery_Spirits",
	stageIndex = 1,
	stageCount = 2,
	vendorUnlocks = {
		{npc = "'Spicy Lemon'", args = {"drink_wine", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"Not every celebration has to taste like paint stripper. Bring the provisions on my "
		.. "list and we'll begin with the wine shipment."
	),
	completionMessage = "Now that's a useful delivery! I'll keep the kitchen moving; you keep coming back alive.",
})

ix.progression.Register("spicylemonItemDelivery_Spirits", {
	name = "Drinks for the rich",
	description = "Spicy Lemon would like to expand his vodka stocks.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Spicy Lemon'", args = {"drink_spirit_1", nil, 1, "SELLANDBUY", 1, 48, 1}},
		{npc = "'Spicy Lemon'", args = {"drink_spirit_2", nil, 1, "SELLANDBUY", 1, 48, 1}},
		{npc = "'Spicy Lemon'", args = {"drink_spirit_3", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	nextProgressions = {"spicylemonItemDelivery_Brew_stage1"},
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
		{pool = "predator_meals", quantity = 3},
		{pool = "local_beer", quantity = 3},
		{pool = "exotic_meals", quantity = 4},
		{pool = "elite_meals", quantity = 3},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Spicy Lemon'"
			local message = string.format(
				"%s, the bottles from the Cordon arrived safely. After your help, I'm happy to sell "
				.. "you the imported spirits. Perhaps save one for an evening with friends.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "spicylemonItemDelivery_Spirits",
	stageIndex = 2,
	stageCount = 2,
})

ix.progression.Register("spicylemonItemDelivery_Brew_stage1", {
	name = "Drinks for the smart - 1/2",
	description = "Drinks for the smart - 1/2",
	keyNpc = "'Spicy Lemon'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "common_meals", quantity = 6},
		{pool = "spirits", quantity = 3},
		{pool = "local_refreshments", quantity = 4},
		{pool = "predator_meals", quantity = 1},
	},
	nextProgressions = {"spicylemonItemDelivery_Brew"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "spicylemonItemDelivery_Brew",
	stageIndex = 1,
	stageCount = 2,
	briefing = (
		"My special brew doesn't begin with a mysterious bottle. It begins with good food, "
		.. "proper spirits and somebody reliable enough to bring both. Start there."
	),
	completionMessage = "Now that's a useful delivery! I'll keep the kitchen moving; you keep coming back alive.",
})

ix.progression.Register("spicylemonItemDelivery_Brew", {
	name = "Drinks for the smart",
	description = "Spicy Lemon is interested in medicinal brews.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Spicy Lemon'", args = {"miscaid_swampbrew", nil, 1, "SELLANDBUY", 1, 48, 1}},
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
		{pool = "predator_meals", quantity = 4},
		{pool = "local_beer", quantity = 4},
		{pool = "canned_food", quantity = 4},
		{pool = "elite_meals", quantity = 3},
		{pool = "exotic_meals", quantity = 5},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Spicy Lemon'"
			local message = string.format(
				"%s, your ingredients helped me finish the medicinal brew. You can buy it from me "
				.. "now. I think you'll appreciate the result rather more than the flavour.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "spicylemonItemDelivery_Brew",
	stageIndex = 2,
	stageCount = 2,
	stockUnlocks = {
		{
			npc = "'Spicy Lemon'",
			bonus = 2,
			items = {
				"drink_bottlewater",
				"drink_bottletea",
				"food_can_sprats",
				"food_cheese_2",
				"food_nuts_2",
				"food_can_tomato",
				"food_can_tushonka",
			},
		},
	},
})
