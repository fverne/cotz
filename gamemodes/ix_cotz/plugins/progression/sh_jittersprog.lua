local MAP = "rp_marsh_cs"

ix.progression.Register("jittersItemDelivery_medical1", {
	name = "Due Treatment 1",
	description = "Jitters take a good look at you.",
	keyNpc = "'Jitters'",
	defaultActive = true,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Jitters'", args = { "medic_medkit_1", nil, 10, "SELLANDBUY", 10, 1, 10 } },
		{ npc = "'Jitters'", args = { "medic_medkit_2", nil, 10, "SELLANDBUY", 10, 1, 10 } },
	},
	nextProgressions = { "jittersItemDelivery_medical2" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Hey uhh, It's pretty tough out here, am I right? How about "
			.. "we help each other out.\n\nREQUIRED ITEMS:"
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
		{ pool = "tobacco", quantity = 2 },
		{ pool = "stimulants", quantity = 1 },
		{ pool = "common_meals", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Jitters'"
			local message = (
				"Jitters here. Thanks for the... uhm... medication. As a "
				.. "reward I have more medical equipment in stock."
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("jittersItemDelivery_medical2", {
	name = "Due Treatment 2",
	description = "Jitters take a good look at you.",
	keyNpc = "'Jitters'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Jitters'", args = { "medic_bandage_2", nil, 10, "SELLANDBUY", 10, 1, 10 } },
		{ npc = "'Jitters'", args = { "medic_medkit_3", nil, 10, "SELLANDBUY", 10, 1, 10 } },
		{ npc = "'Jitters'", args = { "medic_antirad_1", nil, 10, "SELLANDBUY", 10, 1, 10 } },
	},
	nextProgressions = { "jittersItemDelivery_medical3" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I feel like we are bonding. How about we help each other " .. "again?\n\nREQUIRED ITEMS:"
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
		{ pool = "cigarettes", quantity = 7 },
		{ pool = "rare_drugs", quantity = 6 },
		{ pool = "antirad", quantity = 6 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Jitters'"
			local message = (
				"Jitters here. Thanks again for your help. As a reward I "
				.. "have more medical equipment in stock. Come see me again "
				.. "soon!"
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("jittersItemDelivery_medical3", {
	name = "Due Treatment 3",
	description = "Jitters take a good look at you.",
	keyNpc = "'Jitters'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Jitters'", args = { "medic_bandage_3", nil, 10, "SELLANDBUY", 10, 1, 10 } },
		{ npc = "'Jitters'", args = { "medic_medkit_4", nil, 10, "SELLANDBUY", 10, 1, 10 } },
	},
	nextProgressions = { "jittersItemDelivery_medical4" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = "Hello friend! How about we help each other again?\n\nREQUIRED ITEMS:"

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
		{ pool = "premium_cigarettes", quantity = 2 },
		{ pool = "rare_drugs", quantity = 2 },
		{ pool = "stimulants", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Jitters'"
			local message = (
				"Jitters here. I have a stock of army syrette kits and new " .. "bandages for you."
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("jittersItemDelivery_medical4", {
	name = "Due Treatment 4",
	description = "Jitters take a good look at you.",
	keyNpc = "'Jitters'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Jitters'", args = { "medic_medkit_5", nil, 10, "SELLANDBUY", 10, 1, 10 } },
		{ npc = "'Jitters'", args = { "medic_medkit_6", nil, 10, "SELLANDBUY", 10, 1, 10 } },
		{ npc = "'Jitters'", args = { "medic_antirad_2", nil, 10, "SELLANDBUY", 10, 1, 10 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = "Hello friend! How about we help each other again?\n\nREQUIRED ITEMS:"

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
		{ pool = "cigar", quantity = 1 },
		{ pool = "rare_drugs", quantity = 1 },
		{ pool = "tobacco", quantity = 1 },
		{ pool = "antirad", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Jitters'"
			local message = "Jitters here. I have a stock of scientist stuff. Don't tell them!"
			ix.progression.Notify(character, name, message)
		end)
	end,
})
