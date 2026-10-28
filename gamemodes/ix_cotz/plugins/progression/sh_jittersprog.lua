local MAP = "rp_marsh_cs"

ix.progression.Register("jittersItemDelivery_medical1_stage1", {
	name = "Due Treatment 1 - 1/2",
	description = "Due Treatment 1 - 1/2",
	keyNpc = "'Jitters'",
	progMap = "rp_marsh_cs",
	defaultActive = true,
	lootMapTier = 1,
	requirementSlots = {
		{pool = "tobacco", quantity = 1},
	},
	nextProgressions = {"jittersItemDelivery_medical1"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "jittersItemDelivery_medical1",
	stageIndex = 1,
	stageCount = 2,
	vendorUnlocks = {
		{npc = "'Jitters'", args = {"medic_medkit_1", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"I can patch a wound, but I can't conjure a supply shipment. Bring what I've listed "
		.. "and I'll reserve the basic field kits for you."
	),
	completionMessage = "That's one less shortage in the clinic. Take care of yourself out there.",
})

ix.progression.Register("jittersItemDelivery_medical1", {
	name = "Due Treatment 1",
	description = "Jitters takes a good look at you.",
	keyNpc = "'Jitters'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Jitters'", args = {"medic_medkit_2", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	nextProgressions = {"jittersItemDelivery_medical2_stage1"},
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
		{pool = "tobacco", quantity = 1},
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
	milestoneGroup = "jittersItemDelivery_medical1",
	stageIndex = 2,
	stageCount = 2,
})

ix.progression.Register("jittersItemDelivery_medical2_stage1", {
	name = "Due Treatment 2 - 1/3",
	description = "Due Treatment 2 - 1/3",
	keyNpc = "'Jitters'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 1,
	requirementSlots = {
		{pool = "cigarettes", quantity = 1},
	},
	nextProgressions = {"jittersItemDelivery_medical2_stage2"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "jittersItemDelivery_medical2",
	stageIndex = 1,
	stageCount = 3,
	vendorUnlocks = {
		{npc = "'Jitters'", args = {"medic_bandage_2", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"My suppliers still insist on their little comforts. Help settle this delivery and I "
		.. "can keep the better dressings on the shelf for you."
	),
	completionMessage = "That's one less shortage in the clinic. Take care of yourself out there.",
})

ix.progression.Register("jittersItemDelivery_medical2_stage2", {
	name = "Due Treatment 2 - 2/3",
	description = "Due Treatment 2 - 2/3",
	keyNpc = "'Jitters'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 1,
	requirementSlots = {
		{pool = "antirad", quantity = 1},
	},
	nextProgressions = {"jittersItemDelivery_medical2"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "jittersItemDelivery_medical2",
	stageIndex = 2,
	stageCount = 3,
	vendorUnlocks = {
		{npc = "'Jitters'", args = {"medic_antirad_1", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"The dressings are sorted. Radiation sickness is another matter. Bring the requested "
		.. "treatments so I can secure the next batch for the clinic."
	),
	completionMessage = "That's one less shortage in the clinic. Take care of yourself out there.",
})

ix.progression.Register("jittersItemDelivery_medical2", {
	name = "Due Treatment 2",
	description = "Jitters takes a good look at you.",
	keyNpc = "'Jitters'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Jitters'", args = {"medic_medkit_3", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	nextProgressions = {"jittersItemDelivery_medical3_stage1"},
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
		{pool = "rare_drugs", quantity = 1},
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
	milestoneGroup = "jittersItemDelivery_medical2",
	stageIndex = 3,
	stageCount = 3,
	stockUnlocks = {
		{
			npc = "'Jitters'",
			bonus = 1,
			items = {
				"medic_bandage_1",
				"medic_bandage_2",
				"medic_bandage_3",
				"medic_medkit_1",
				"medic_medkit_2",
				"medic_medkit_3",
				"medic_medkit_4",
				"medic_medkit_5",
				"medic_medkit_6",
			},
		},
	},
})

ix.progression.Register("jittersItemDelivery_medical3_stage1", {
	name = "Due Treatment 3 - 1/2",
	description = "Due Treatment 3 - 1/2",
	keyNpc = "'Jitters'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 1,
	requirementSlots = {
		{pool = "common_meals", quantity = 1},
		{pool = "premium_cigarettes", quantity = 1},
	},
	nextProgressions = {"jittersItemDelivery_medical3"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "jittersItemDelivery_medical3",
	stageIndex = 1,
	stageCount = 2,
	vendorUnlocks = {
		{npc = "'Jitters'", args = {"medic_bandage_3", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"A clinic needs food for its patients and something to keep its suppliers cooperative. "
		.. "Bring the requested provisions; better bleeding control comes first."
	),
	completionMessage = "That's one less shortage in the clinic. Take care of yourself out there.",
})

ix.progression.Register("jittersItemDelivery_medical3", {
	name = "Due Treatment 3",
	description = "Jitters takes a good look at you.",
	keyNpc = "'Jitters'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Jitters'", args = {"medic_medkit_4", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	nextProgressions = {"jittersItemDelivery_medical4_stage1"},
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
		{pool = "stimulants", quantity = 1},
		{pool = "antirad", quantity = 1},
		{pool = "cigarettes", quantity = 1},
		{pool = "rare_drugs", quantity = 1},
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
	milestoneGroup = "jittersItemDelivery_medical3",
	stageIndex = 2,
	stageCount = 2,
	serviceDiscounts = {{npc = "'Jitters'", service = "treatment", fraction = 0.05}},
})

ix.progression.Register("jittersItemDelivery_medical4_stage1", {
	name = "Due Treatment 4 - 1/3",
	description = "Due Treatment 4 - 1/3",
	keyNpc = "'Jitters'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "common_meals", quantity = 1},
		{pool = "tobacco", quantity = 1},
	},
	nextProgressions = {"jittersItemDelivery_medical4_stage2"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "jittersItemDelivery_medical4",
	stageIndex = 1,
	stageCount = 3,
	vendorUnlocks = {
		{npc = "'Jitters'", args = {"medic_medkit_5", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"The advanced kits don't arrive with a handshake. Cover these provisions and I can "
		.. "release the first part of the specialist medical shipment."
	),
	completionMessage = "That's one less shortage in the clinic. Take care of yourself out there.",
})

ix.progression.Register("jittersItemDelivery_medical4_stage2", {
	name = "Due Treatment 4 - 2/3",
	description = "Due Treatment 4 - 2/3",
	keyNpc = "'Jitters'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "antirad", quantity = 1},
		{pool = "stimulants", quantity = 1},
		{pool = "cigarettes", quantity = 1},
	},
	nextProgressions = {"jittersItemDelivery_medical4"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "jittersItemDelivery_medical4",
	stageIndex = 2,
	stageCount = 3,
	vendorUnlocks = {
		{npc = "'Jitters'", args = {"medic_medkit_6", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"I've secured the first kits. Now I need the medicines and supplier goods on this list "
		.. "before I can extend your clinical supplies further."
	),
	completionMessage = "That's one less shortage in the clinic. Take care of yourself out there.",
})

ix.progression.Register("jittersItemDelivery_medical4", {
	name = "Due Treatment 4",
	description = "Jitters takes a good look at you.",
	keyNpc = "'Jitters'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Jitters'", args = {"medic_antirad_2", nil, 1, "SELLANDBUY", 1, 48, 1}},
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
		{pool = "premium_cigarettes", quantity = 1},
		{pool = "cigar", quantity = 1},
		{pool = "rare_drugs", quantity = 1},
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
	milestoneGroup = "jittersItemDelivery_medical4",
	stageIndex = 3,
	stageCount = 3,
	stockUnlocks = {
		{
			npc = "'Jitters'",
			bonus = 2,
			items = {
				"medic_bandage_1",
				"medic_bandage_2",
				"medic_bandage_3",
				"medic_medkit_1",
				"medic_medkit_2",
				"medic_medkit_3",
				"medic_medkit_4",
				"medic_medkit_5",
				"medic_medkit_6",
			},
		},
	},
})
