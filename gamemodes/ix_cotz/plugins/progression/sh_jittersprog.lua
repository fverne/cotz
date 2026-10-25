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
			local message = string.format(
				"%s, Jitters here. Thanks for the... uhm... supplies. I'll sell you my basic "
				.. "medical kits now. Try to come back before you actually need one, alright?",
				character:GetName()
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
			local message = string.format(
				"%s, thanks for helping me out again. I can sell you better bandages, medical kits "
				.. "and some antirads now. Just... don't take everything at once.",
				character:GetName()
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
			local message = string.format(
				"%s, I put aside the better bandages and army syrette kits for you to buy. You've "
				.. "been good to me. I'd, uhm, like to keep you in one piece.",
				character:GetName()
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
			local message = string.format(
				"%s, you've earned a look at my scientific medical kits and stronger antirads. I'll "
				.. "sell them to you, but... maybe don't ask where I got them.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})
