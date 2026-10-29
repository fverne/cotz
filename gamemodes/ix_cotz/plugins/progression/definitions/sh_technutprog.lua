local MAP = "rp_marsh_cs"

ix.progression.Register("technutItemDelivery_Suit1", {
	name = "Suiting Up Pt. 1",
	description = "Get Technut to help you make suits.",
	keyNpc = "'Technut'",
	defaultActive = true,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "suit_mailjacket", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "technutItemDelivery_Suit2" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I've been thinking about improving these jackets we're "
			.. "wearing, just adding some simple metal inlays should help "
			.. "against mutant bites and scratches. To accomplish this "
			.. "I'll need a couple of things:\n"
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
		{ pool = "fasteners", quantity = 8 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, the materials you brought are holding together nicely! I'll sell you a mail "
				.. "jacket now. Come have a look at what your work made possible.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Suit2", {
	name = "Suiting Up Pt. 2",
	description = "Get Technut to help you make suits.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "suit_trenchcoat_black", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Technut'", args = { "suit_trenchcoat_brown", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Technut'", args = { "suit_trenchcoat_green", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Technut'", args = { "suit_trenchcoat_tan", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = {"technutItemDelivery_Suit3_stage1"},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"You ever notice how tough the skin of some of these mutants "
			.. "are? I bet you we could fashion them into coats. I'll need "
			.. "the following:\n"
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
		{ pool = "field_maintenance", quantity = 1 },
		{ pool = "common_hides", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, your delivery let me finish the trenchcoats. You can buy them from me now. "
				.. "Pick a colour; looking miserable in the rain is optional.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Suit3_stage1", {
	name = "Suiting Up Pt. 3 - 1/2",
	description = "Suiting Up Pt. 3 - 1/2",
	keyNpc = "'Technut'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 1,
	requirementSlots = {
		{pool = "small_electronics", quantity = 1},
		{pool = "fasteners", quantity = 2},
	},
	nextProgressions = {"technutItemDelivery_Suit3"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "technutItemDelivery_Suit3",
	stageIndex = 1,
	stageCount = 2,
	briefing = (
		"The Sunrise needs proper fittings and functioning electrical parts. Bring those first "
		.. "while I prepare the rest of the suit work."
	),
	completionMessage = "That's a proper job. I'll put it to use here; don't undo my work the moment you leave.",
})

ix.progression.Register("technutItemDelivery_Suit3", {
	name = "Suiting Up Pt. 3",
	description = "Get Technut to help you make suits.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Technut'", args = {"suit_sunrise", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	nextProgressions = {
		"technutItemDelivery_SuitNBC_stage1",
		"technutItemDelivery_Suit4",
		"technutItemDelivery_Helmet1",
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"All this suit construction has given me some ideas for "
			.. "outfits. The first one is a fairly lightweight, as the "
			.. "most important thing is being nimble, right? I can start "
			.. "work on the prototype as soon as you bring me these items:\n"
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
		{pool = "fasteners", quantity = 3},
		{pool = "documents_technical", quantity = 1},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, your help got the Sunrise prototype finished. I'll sell you the suit now. Come "
				.. "see how it fits before you head back out.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "technutItemDelivery_Suit3",
	stageIndex = 2,
	stageCount = 2,
})

ix.progression.Register("technutItemDelivery_SuitNBC_stage1", {
	name = "Closed Respiratory Upgrade - 1/2",
	description = "Closed Respiratory Upgrade - 1/2",
	keyNpc = "'Technut'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "antirad", quantity = 4},
	},
	nextProgressions = {"technutItemDelivery_SuitNBC"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "technutItemDelivery_SuitNBC",
	stageIndex = 1,
	stageCount = 2,
	briefing = (
		"I'd rather test protective work here than learn about a bad seal from your corpse. "
		.. "Bring the radiation treatments for the workshop's safety supply first."
	),
	completionMessage = "That's a proper job. I'll put it to use here; don't undo my work the moment you leave.",
})

ix.progression.Register("technutItemDelivery_SuitNBC", {
	name = "Closed Respiratory Upgrade",
	description = "Get Technut to help you make suits.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Technut'", args = {"suit_nbc", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I have an idea for the sunrise that should make it more "
			.. "protective in radioactive areas. We can seal off many of "
			.. "the areas that allow for breathing, making it more uncomfortable "
			.. "to wear, but atleast you don't get irradiated as much. "
			.. "Here's what I need:\n"
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
		{pool = "antirad", quantity = 1},
		{pool = "filters", quantity = 3},
		{pool = "industrial_supplies", quantity = 3},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, the closed respiratory suit is finished, thanks to your supplies. You can buy "
				.. "the NBC variant from me now. Come take a look at the seals.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "technutItemDelivery_SuitNBC",
	stageIndex = 2,
	stageCount = 2,
})

ix.progression.Register("technutItemDelivery_Suit4", {
	name = "Suiting Up Pt. 4",
	description = "Get Technut to help you make suits.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "suit_cs1", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = {"technutItemDelivery_Suit5", "technutItemDelivery_Attachment1_stage1"},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"The next outfit I have in mind is a bit more heavily armored, "
			.. "mostly around the chest area. Should be able to take a "
			.. "couple of shots to the chest at least. Like before, I'll "
			.. "start working on the prototype as soon as you bring me "
			.. "these items:\n"
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
		{ pool = "cigarettes", quantity = 4 },
		{ pool = "workshop_supplies", quantity = 4 },
		{ pool = "adhesives", quantity = 4 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, your materials went into the CS1 design. I'll sell you one of those armoured "
				.. "suits now. Come see what I've put together.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Suit5", {
	name = "Suiting Up Pt. 5",
	description = "Get Technut to help you make suits.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "suit_wind", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "technutItemDelivery_Suit6", "technutItemDelivery_AttachmentFabric1" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I've heard from some of the guys that the CS1 is too heavy, "
			.. "and that moving around in it is too clunky. I've got a "
			.. "schematic for a lightweight, highly modular suit, that "
			.. "I think will be just the thing for you all. Like before, "
			.. "I'll start working on the prototype as soon as you bring "
			.. "me these items:\n"
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
		{ pool = "tobacco", quantity = 6 },
		{ pool = "documents_technical", quantity = 2 },
		{ pool = "workshop_supplies", quantity = 4 },
		{ pool = "fasteners", quantity = 24 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, I've finished the Wind suit with your help. You can buy it from me now if "
				.. "you'd like something lighter for your next trip.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Suit6", {
	name = "Suiting Up Pt. 6",
	description = "Get Technut to help you make suits.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "suit_cs2", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "technutItemDelivery_Suit7", "technutItemDelivery_AttachmentKevlar1" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"From seeing the previous model, CS1, in action, it's clear "
			.. "that it needs a little bit more oomph. I've got some plans "
			.. "for another model much like the CS1, but this time more "
			.. "armored. Like before, I'll start working on the prototype "
			.. "as soon as you bring me these items:\n"
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
		{ pool = "spirits", quantity = 7 },
		{ pool = "beer", quantity = 5 },
		{ pool = "field_maintenance", quantity = 7 },
		{ pool = "fasteners", quantity = 30 },
		{ pool = "workshop_supplies", quantity = 7 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, your delivery helped me finish the CS2 design. I'll sell you the improved suit "
				.. "now. Come see how the new armour sits.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Suit7", {
	name = "Suiting Up Pt. 7",
	description = "Get Technut to help you make suits.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "suit_cs3", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "technutItemDelivery_AttachmentFrame1", "technutItemDelivery_AttachmentCarbon" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"The CS2 is an improvement on the CS1, but it doesn't protect "
			.. "quite as well as I would like, so my idea is to make it "
			.. "even more armored. Like before, I'll start working on the "
			.. "prototype as soon as you bring me these items:\n"
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
		{ pool = "wine", quantity = 12 },
		{ pool = "industrial_supplies", quantity = 6 },
		{ pool = "documents_technical", quantity = 3 },
		{ pool = "fasteners", quantity = 39 },
		{ pool = "workshop_supplies", quantity = 9 },
		{ pool = "adhesives", quantity = 9 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, those materials did the trick. You can buy the heavy CS3 suit from me now. "
				.. "You'll feel the weight, but there's a reason for all that armour.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_SuitPainting", {
	name = "Colourful Fashion",
	description = "Get Technut to paint your suits.",
	keyNpc = "'Technut'",
	defaultActive = true,
	progMap = MAP,
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"It's a bit hard to tell you all apart with those balaclavas, "
			.. "so I'm thinking of establishing a way for you guys to get "
			.. "patches, other types of camouflage and so on on your suits. "
			.. "We'll need a couple of things for that:\n"
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
		{ pool = "adhesives", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, you've earned a little custom work. I can change your suit's patches and "
				.. "camouflage now. Come see me when you want a new look.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	serviceDiscounts = {{npc = "'Technut'", service = "repair", fraction = 0.05}},
})

ix.progression.Register("technutItemDelivery_Helmet1", {
	name = "Wear Protection Pt. 1",
	description = "Help Technut get his hands on helmets.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "helm_steel_ger", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Technut'", args = { "helm_steel_rus", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Technut'", args = { "helm_steel_arab", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "technutItemDelivery_Helmet2" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Fancy vests is good and all, but protected body won't save "
			.. "you from a bullet in your face. I have an idea for some "
			.. "simple headgear, but I need some items to make them.\n\nREQUIRED "
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
		{ pool = "adhesives", quantity = 4 },
		{ pool = "workshop_supplies", quantity = 4 },
		{ pool = "repair_electrical", quantity = 4 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, the steel helmets are ready after your delivery. I'll sell you one now. Better "
				.. "a dent in the helmet than a dent in your skull, eh?",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Helmet2", {
	name = "Wear Protection Pt. 2",
	description = "Help Technut get his hands on helmets.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "headwear_cs1", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "technutItemDelivery_Helmet3" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Well, I agree, a simple steel cap is not a good option. "
			.. "I've recovered some schematic for aviation helmets. They "
			.. "are light, comfy, and won't block your vision.\n\nREQUIRED "
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
		{ pool = "heavy_electrical", quantity = 4 },
		{ pool = "repair_electrical", quantity = 4 },
		{ pool = "computer_parts", quantity = 2 },
		{ pool = "fasteners", quantity = 24 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, your materials helped finish the CS headgear. You can buy it from me now. Come "
				.. "try it on before your next trip.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Helmet3", {
	name = "Wear Protection Pt. 3",
	description = "Help Technut get his hands on helmets.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "helm_operator_rus_1", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Technut'", args = { "helm_operator_rus_2", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "technutItemDelivery_Helmet4" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Flight helmets are good, but looks like we need more down-to-earth "
			.. "headgear. I can make some Ukraine military helmets, but "
			.. "I need soom items.\n\nREQUIRED ITEMS:"
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
		{ pool = "common_artifacts", quantity = 10 },
		{ pool = "electrical_artifacts", quantity = 10 },
		{ pool = "repair_electrical", quantity = 7 },
		{ pool = "fasteners", quantity = 32 },
		{ pool = "workshop_supplies", quantity = 7 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, thanks for the supplies. I'll sell you the operator helmets now. Come find one "
				.. "that fits your head and your budget.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Helmet4", {
	name = "Wear Protection Pt. 4",
	description = "Help Technut get his hands on helmets.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "headwear_cs2", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Technut'", args = { "headwear_cs4", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = {"technutItemDelivery_Helmet5_stage1"},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"You know what? Why don't I just combine a decent helmet "
			.. "and a respirator together? The creator of this schematic "
			.. "though the same, and I can recreate it. \n\nREQUIRED ITEMS:"
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
		{ pool = "common_artifacts", quantity = 12 },
		{ pool = "rare_field_artifacts", quantity = 6 },
		{ pool = "rare_electrical_artifacts", quantity = 6 },
		{ pool = "fasteners", quantity = 42 },
		{ pool = "workshop_supplies", quantity = 9 },
		{ pool = "adhesives", quantity = 12 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, the frag helmets and respirator headgear are ready. Your help earned you "
				.. "access to buy them; come see how they fit.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Helmet5_stage1", {
	name = "Wear Protection Pt. 5 - 1/2",
	description = "Wear Protection Pt. 5 - 1/2",
	keyNpc = "'Technut'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 3,
	requirementSlots = {
		{pool = "fasteners", quantity = 49},
	},
	nextProgressions = {"technutItemDelivery_Helmet5"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "technutItemDelivery_Helmet5",
	stageIndex = 1,
	stageCount = 2,
	briefing = (
		"The Sphere shell is only half the job. Bring the mounting hardware first; the "
		.. "remaining work decides whether I'll sell it as protection."
	),
	completionMessage = "That's a proper job. I'll put it to use here; don't undo my work the moment you leave.",
})

ix.progression.Register("technutItemDelivery_Helmet5", {
	name = "Wear Protection Pt. 5",
	description = "Help Technut get his hands on helmets.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Technut'", args = {"helm_sphere08", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	nextProgressions = {"technutItemDelivery_Helmet6_stage1"},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Hey! So, the PASGT is all well and good, but it isn't giving "
			.. "the kind of protection people like against bullets. Interested "
			.. "in helping me put together something a little better?\n\nREQUIRED "
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
		{pool = "fasteners", quantity = 17},
		{pool = "workshop_supplies", quantity = 14},
		{pool = "common_artifacts", quantity = 17},
		{pool = "chemical_artifacts", quantity = 10},
		{pool = "rare_electrical_artifacts", quantity = 10},
		{pool = "exceptional_artifacts", quantity = 3},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, your delivery helped me get the Sphere-08 helmets sorted. I'll sell you one "
				.. "now. Come get some proper noggin protection.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "technutItemDelivery_Helmet5",
	stageIndex = 2,
	stageCount = 2,
})

ix.progression.Register("technutItemDelivery_Helmet6_stage1", {
	name = "Wear Protection Pt. 6 - 1/2",
	description = "Wear Protection Pt. 6 - 1/2",
	keyNpc = "'Technut'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 3,
	requirementSlots = {
		{pool = "fasteners", quantity = 68},
	},
	nextProgressions = {"technutItemDelivery_Helmet6"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "technutItemDelivery_Helmet6",
	stageIndex = 1,
	stageCount = 2,
	vendorUnlocks = {
		{npc = "'Technut'", args = {"headwear_psz12", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"The PSZ assembly starts with the fittings. Bring the fasteners first; I won't release "
		.. "the heavier helmet until the rest of the protective work is checked."
	),
	completionMessage = "That's a proper job. I'll put it to use here; don't undo my work the moment you leave.",
})

ix.progression.Register("technutItemDelivery_Helmet6", {
	name = "Wear Protection Pt. 6",
	description = "Help Technut get his hands on helmets.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Technut'", args = {"helm_sphere12", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	nextProgressions = { "technutItemDelivery_Helmet7" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I've gotten a good look at one of the Spetsnaz Sphere-12 "
			.. "helmets and I'm pretty sure I can upgrade them, but I'm "
			.. "gonna need some special materials. Care to help me out?\n\nREQUIRED "
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
		{pool = "fasteners", quantity = 16},
		{pool = "workshop_supplies", quantity = 20},
		{pool = "adhesives", quantity = 24},
		{pool = "chemical_artifacts", quantity = 12},
		{pool = "burner_artifacts", quantity = 8},
		{pool = "rare_electrical_artifacts", quantity = 12},
		{pool = "exceptional_artifacts", quantity = 8},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, I've got the Sphere-12 helmets and PSZ12 headgear ready with your help. You "
				.. "can buy them from me now if you need heavier protection.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "technutItemDelivery_Helmet6",
	stageIndex = 2,
	stageCount = 2,
})

ix.progression.Register("technutItemDelivery_Helmet7", {
	name = "Wear Protection Pt. 7",
	description = "Help Technut get his hands on helmets.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "helm_operator_nato", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"So, the Sphere-08 project is going alright, but it's really "
			.. "friggin' heavy. I've got a few ideas to lighten it and "
			.. "improve on the PASGT design! What do you say?\n\nREQUIRED "
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
		{ pool = "rare_field_artifacts", quantity = 13 },
		{ pool = "bubble_artifacts", quantity = 9 },
		{ pool = "exceptional_electrical_artifacts", quantity = 4 },
		{ pool = "chemical_artifacts", quantity = 13 },
		{ pool = "fasteners", quantity = 117 },
		{ pool = "workshop_supplies", quantity = 27 },
		{ pool = "adhesives", quantity = 31 },
		{ pool = "cleaning", quantity = 22 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, your contribution got you access to the ACH helmets. I'll sell you one of "
				.. "these Western beauties; come feel how light they are.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Mask1", {
	name = "Don't breathe this Pt. 1",
	description = "Help technut provide gasmasks.",
	keyNpc = "'Technut'",
	defaultActive = true,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "mask_halfmask", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Technut'", args = { "mask_respirator", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = {"technutItemDelivery_Mask2_stage1"},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"So, the Swamps are pretty toxic... before we go much further "
			.. "into the Zone, we're gonna need some kind of radioprotectant. "
			.. "I have an idea, but I'm going to need some materials to "
			.. "make them.\n\nREQUIRED ITEMS:"
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
		{ pool = "heavy_components", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, the respirators are ready, thanks to your supplies. I'll sell you one now. "
				.. "Come find something to put between your lungs and the Zone.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Mask2_stage1", {
	name = "Don't breathe this Pt. 2 - 1/2",
	description = "Don't breathe this Pt. 2 - 1/2",
	keyNpc = "'Technut'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 1,
	requirementSlots = {
		{pool = "fuel", quantity = 1},
	},
	nextProgressions = {"technutItemDelivery_Mask2"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "technutItemDelivery_Mask2",
	stageIndex = 1,
	stageCount = 2,
	vendorUnlocks = {
		{npc = "'Technut'", args = {"mask_gp5", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"Fuel keeps the workshop moving while I service these old masks. Cover that first "
		.. "batch and I'll make the GP-5 available to you."
	),
	completionMessage = "That's a proper job. I'll put it to use here; don't undo my work the moment you leave.",
})

ix.progression.Register("technutItemDelivery_Mask2", {
	name = "Don't breathe this Pt. 2",
	description = "Help technut provide gasmasks.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Technut'", args = {"mask_eo20", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	nextProgressions = {"technutItemDelivery_Mask3_stage1"},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"So, respirators are nice, but they don't protect your eyes "
			.. "and ears! I'm busy refitting some GP-5 gas mask filters "
			.. "to not use asbestos, because we want the masks to avoid "
			.. "cancer, not get it! Want to help me out?\n\nREQUIRED ITEMS:"
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
		{pool = "filters", quantity = 1},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, I've finished refitting the GP-5 and EO-20 masks with your help. You can buy "
				.. "them from me now. No old asbestos surprises in these ones.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "technutItemDelivery_Mask2",
	stageIndex = 2,
	stageCount = 2,
})

ix.progression.Register("technutItemDelivery_Mask3_stage1", {
	name = "Don't breathe this Pt. 3 - 1/2",
	description = "Don't breathe this Pt. 3 - 1/2",
	keyNpc = "'Technut'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 1,
	requirementSlots = {
		{pool = "fuel", quantity = 1},
		{pool = "repair_electrical", quantity = 1},
	},
	nextProgressions = {"technutItemDelivery_Mask3"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "technutItemDelivery_Mask3",
	stageIndex = 1,
	stageCount = 2,
	vendorUnlocks = {
		{npc = "'Technut'", args = {"mask_pmk3", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"A cracked lead or a dry workshop can stop the whole mask line. Bring the fuel and "
		.. "electrical supplies before I sign off the PMK-3."
	),
	completionMessage = "That's a proper job. I'll put it to use here; don't undo my work the moment you leave.",
})

ix.progression.Register("technutItemDelivery_Mask3", {
	name = "Don't breathe this Pt. 3",
	description = "Help technut provide gasmasks.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Technut'", args = {"mask_xm40", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	nextProgressions = {"technutItemDelivery_Mask4_stage1"},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I don't know if you've noticed, but the filters on the "
			.. "PBF gas mask are a bit of a pain to find. I think I've "
			.. "figured out a way to refit them to accept 40mm filters "
			.. "and to trim some weight to boot! Can you grab me a few "
			.. "things to get the job done?\n\nREQUIRED ITEMS:"
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
		{pool = "repair_electrical", quantity = 1},
		{pool = "industrial_supplies", quantity = 1},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, your delivery helped me get the next masks ready. I'll sell you the PMK-3 and "
				.. "XM40 now. Come take a look before you head into the muck.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "technutItemDelivery_Mask3",
	stageIndex = 2,
	stageCount = 2,
})

ix.progression.Register("technutItemDelivery_Mask4_stage1", {
	name = "Don't breathe this Pt. 4 - 1/2",
	description = "Don't breathe this Pt. 4 - 1/2",
	keyNpc = "'Technut'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "fasteners", quantity = 7},
	},
	nextProgressions = {"technutItemDelivery_Mask4"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "technutItemDelivery_Mask4",
	stageIndex = 1,
	stageCount = 2,
	vendorUnlocks = {
		{npc = "'Technut'", args = {"mask_m40", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"A good seal still needs good fittings. Bring this hardware and I'll release the M40; "
		.. "the next mask waits on the specialist checks."
	),
	completionMessage = "That's a proper job. I'll put it to use here; don't undo my work the moment you leave.",
})

ix.progression.Register("technutItemDelivery_Mask4", {
	name = "Don't breathe this Pt. 4",
	description = "Help technut provide gasmasks.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Technut'", args = {"mask_m50", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I got my hands on new tools. I've been trying my best to "
			.. "clean up some prototype gasmasks. I need a few more things "
			.. "though.\n\nREQUIRED ITEMS:"
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
		{pool = "fasteners", quantity = 7},
		{pool = "documents_technical", quantity = 1},
		{pool = "specialty_tools", quantity = 1},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, you've helped me get hold of the M40 and M50 masks. I'll sell them to you now. "
				.. "Come see me if you're ready to upgrade.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "technutItemDelivery_Mask4",
	stageIndex = 2,
	stageCount = 2,
})

ix.progression.Register("technutItemDelivery_Attachment1_stage1", {
	name = "Plating up Pt. 1 - 1/2",
	description = "Plating up Pt. 1 - 1/2",
	keyNpc = "'Technut'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "fasteners", quantity = 16},
	},
	nextProgressions = {"technutItemDelivery_Attachment1"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "technutItemDelivery_Attachment1",
	stageIndex = 1,
	stageCount = 2,
	vendorUnlocks = {
		{npc = "'Technut'", args = {"attachment_steelplate_1", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"Steel is straightforward if the mounting is sound. Bring the fittings for the first "
		.. "plate set; ceramics need a separate finishing pass."
	),
	completionMessage = "That's a proper job. I'll put it to use here; don't undo my work the moment you leave.",
})

ix.progression.Register("technutItemDelivery_Attachment1", {
	name = "Plating up Pt. 1",
	description = "Provide technut with materials for suit plates.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Technut'", args = {"attachment_ceramicplate_1", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	nextProgressions = {"technutItemDelivery_Attachment2_stage1"},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"So, a lot of these suits have plate carriers, but we kinda "
			.. "need the plates to get the job done. I'm gonna make them, "
			.. "but I need the stuff to do it!\n\nREQUIRED ITEMS:"
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
		{pool = "fasteners", quantity = 8},
		{pool = "common_optics", quantity = 8},
		{pool = "maintenance", quantity = 6},
		{pool = "attachments", quantity = 4},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, those supplies let me put together the basic steel and ceramic armour inserts. "
				.. "You can buy them from me now. Come give your suit a little help.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "technutItemDelivery_Attachment1",
	stageIndex = 2,
	stageCount = 2,
})

ix.progression.Register("technutItemDelivery_Attachment2_stage1", {
	name = "Plating up Pt. 2 - 1/2",
	description = "Plating up Pt. 2 - 1/2",
	keyNpc = "'Technut'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 3,
	requirementSlots = {
		{pool = "fasteners", quantity = 25},
	},
	nextProgressions = {"technutItemDelivery_Attachment2"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "technutItemDelivery_Attachment2",
	stageIndex = 1,
	stageCount = 2,
	vendorUnlocks = {
		{npc = "'Technut'", args = {"attachment_steelplate_2", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"The next plate set needs better mounting work, not a thicker coat of paint. Bring the "
		.. "hardware and I'll approve the steel version first."
	),
	completionMessage = "That's a proper job. I'll put it to use here; don't undo my work the moment you leave.",
})

ix.progression.Register("technutItemDelivery_Attachment2", {
	name = "Plating up Pt. 2",
	description = "Provide technut with materials for suit plates.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Technut'", args = {"attachment_ceramicplate_2", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	nextProgressions = {"technutItemDelivery_Attachment3_stage1"},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"The handmade plates are okay, but they fold pretty quickly "
			.. "in a firefight. I know someone willing to sell me the plans "
			.. "for better ones, but he's got a steep shopping list for "
			.. "the components...\n\nREQUIRED ITEMS:"
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
		{pool = "fasteners", quantity = 7},
		{pool = "workshop_supplies", quantity = 7},
		{pool = "powder", quantity = 7},
		{pool = "repair_electrical", quantity = 7},
		{pool = "suppressors", quantity = 5},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, I've finished the improved steel and ceramic inserts with your materials. I'll "
				.. "sell you the new plates now; come take a look at the workmanship.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "technutItemDelivery_Attachment2",
	stageIndex = 2,
	stageCount = 2,
})

ix.progression.Register("technutItemDelivery_Attachment3_stage1", {
	name = "Plating up Pt. 3 - 1/2",
	description = "Plating up Pt. 3 - 1/2",
	keyNpc = "'Technut'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 3,
	requirementSlots = {
		{pool = "fasteners", quantity = 33},
	},
	nextProgressions = {"technutItemDelivery_Attachment3"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "technutItemDelivery_Attachment3",
	stageIndex = 1,
	stageCount = 2,
	vendorUnlocks = {
		{npc = "'Technut'", args = {"attachment_steelplate_3", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"Heavy plates punish a weak attachment. Cover the mounting hardware before I release "
		.. "this steel set, then we'll finish the ceramic work."
	),
	completionMessage = "That's a proper job. I'll put it to use here; don't undo my work the moment you leave.",
})

ix.progression.Register("technutItemDelivery_Attachment3", {
	name = "Plating up Pt. 3",
	description = "Provide technut with materials for suit plates.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Technut'", args = {"attachment_ceramicplate_3", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"As we're pushing further north, we're gonna need better "
			.. "steel and ceramic to help keep you guys alive. Interested "
			.. "in helping me make the best stuff money can buy?\n\nREQUIRED "
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
		{pool = "fasteners", quantity = 9},
		{pool = "workshop_supplies", quantity = 9},
		{pool = "adhesives", quantity = 12},
		{pool = "maintenance", quantity = 9},
		{pool = "suppressors", quantity = 6},
		{pool = "computer_parts", quantity = 3},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, your latest delivery was just what I needed for the best steel and ceramic "
				.. "inserts. You've earned access to buy them. Come see me about an upgrade.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "technutItemDelivery_Attachment3",
	stageIndex = 2,
	stageCount = 2,
})

ix.progression.Register("technutItemDelivery_AttachmentFabric1", {
	name = "Patching Pt. 1",
	description = "Provide technut with materials for suit fabrics.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "attachment_fabric_1", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "technutItemDelivery_AttachmentFabric2" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"If you're interested in going artefact hunting, you're "
			.. "gonna need proper protection. We don't exactly have SEVA "
			.. "suits sitting around right now, so I think instead I can "
			.. "get some thermal lining into your suits! I just need materials "
			.. "for the prototypes.\n\nREQUIRED ITEMS:"
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
		{ pool = "suit_materials", quantity = 5 },
		{ pool = "common_hides", quantity = 5 },
		{ pool = "adhesives", quantity = 7 },
		{ pool = "fasteners", quantity = 30 },
		{ pool = "workshop_supplies", quantity = 7 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, the insulating fabric is ready, thanks to your help. You can buy it from me "
				.. "now. Let's give your suit a little more protection from the heat.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_AttachmentFabric2", {
	name = "Patching Pt. 2",
	description = "Provide technut with materials for suit fabrics.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "attachment_fabric_2", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"How's the insulating fabric treating you? I managed to "
			.. "get my hands on plans for a heavier duty set, but I need "
			.. "more stuff to stitch them together! Wanna help me out?!:\n\nREQUIRED "
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
		{ pool = "humanoid_parts", quantity = 12 },
		{ pool = "common_hides", quantity = 6 },
		{ pool = "workshop_supplies", quantity = 9 },
		{ pool = "fasteners", quantity = 42 },
		{ pool = "adhesives", quantity = 12 },
		{ pool = "cleaning", quantity = 9 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, I've finished the heavy insulating fabric with your supplies. I'll sell you "
				.. "the thicker layers now. Come see what'll fit your suit.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_AttachmentFrame1", {
	name = "Framing Pt. 1",
	description = "Provide technut with materials for suit frames.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "attachment_aluframe", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "technutItemDelivery_AttachmentFrame2" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Even with big backpacks, have you noticed how damn heavy "
			.. "they can get when you pack them up kinda funky? So have "
			.. "I! I've taken some inspiration from the old ALICE backpacks "
			.. "and I think I can put together some frames that'll help "
			.. "take a load off!\n\nREQUIRED ITEMS:"
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
		{ pool = "canned_food", quantity = 21 },
		{ pool = "industrial_supplies", quantity = 7 },
		{ pool = "workshop_supplies", quantity = 14 },
		{ pool = "fasteners", quantity = 59 },
		{ pool = "adhesives", quantity = 17 },
		{ pool = "cleaning", quantity = 14 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, your delivery got the aluminium backpack frames finished. You can buy one from "
				.. "me now. Your back will thank you; just mind those anomalies.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_AttachmentFrame2", {
	name = "Framing Pt. 2",
	description = "Provide technut with materials for suit frames.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "attachment_steelframe", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"So, the aluminium frame is all well and good, but then "
			.. "it hit me; why get something decent from aluminium when "
			.. "you can get something great from steel! Bring me what I "
			.. "need and I'll make it happen!\n\nREQUIRED ITEMS:"
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
		{ pool = "basic_tools", quantity = 8 },
		{ pool = "advanced_parts", quantity = 4 },
		{ pool = "industrial_supplies", quantity = 8 },
		{ pool = "fasteners", quantity = 76 },
		{ pool = "workshop_supplies", quantity = 20 },
		{ pool = "adhesives", quantity = 20 },
		{ pool = "cleaning", quantity = 16 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, the steel backpack frames are ready with your help. I'll sell you one now. "
				.. "Sturdy kit, but be careful carrying all that metal near anomalies.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_AttachmentCarbon", {
	name = "Carbon Cabrón",
	description = "Provide technut with materials for suit carbon fibre.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "attachment_carbonfibre", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I got my hands on some plans for a lining even better than "
			.. "the insulating kind! It'll be very expensive to make, but "
			.. "I think I can do it! I just need prototype materials...\n\nREQUIRED "
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
		{ pool = "cleaning", quantity = 14 },
		{ pool = "adhesives", quantity = 17 },
		{ pool = "workshop_supplies", quantity = 14 },
		{ pool = "fasteners", quantity = 59 },
		{ pool = "repair_electrical", quantity = 14 },
		{ pool = "small_electronics", quantity = 21 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, your materials helped me finish the carbon fibre inserts. I'll sell them to "
				.. "you now. They're expensive, but worth a look for your anomaly protection.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_AttachmentKevlar1", {
	name = "Armoring up Pt. 1",
	description = "Provide technut with materials for suit kevlar.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "attachment_kevlar_1", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "technutItemDelivery_AttachmentKevlar2" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"So, steel and ceramic plates are good, but they're also "
			.. "really heavy. We're in the 2000s, we're well past the point "
			.. "of super heavy body armour! I think I can piece together "
			.. "something out of kevlar, but the prototypes so far haven't "
			.. "come out great. Wanna help me find materials?\n\nREQUIRED "
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
		{ pool = "batteries", quantity = 24 },
		{ pool = "industrial_supplies", quantity = 6 },
		{ pool = "workshop_supplies", quantity = 9 },
		{ pool = "fasteners", quantity = 39 },
		{ pool = "adhesives", quantity = 9 },
		{ pool = "cleaning", quantity = 9 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, the K119 Kevlar inserts are finished, thanks to your supplies. You can buy "
				.. "them from me now. Come see about fitting some to your kit.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_AttachmentKevlar2", {
	name = "Armoring up Pt. 2",
	description = "Provide technut with materials for suit kevlar.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "attachment_kevlar_2", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"The K119 seems to be doing the job well, but there's always "
			.. "room for improvement! Want to help me make them better? "
			.. "Bring me new materials to work with!\n\nREQUIRED ITEMS:"
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
		{ pool = "batteries", quantity = 38 },
		{ pool = "documents_technical", quantity = 3 },
		{ pool = "field_maintenance", quantity = 14 },
		{ pool = "fasteners", quantity = 59 },
		{ pool = "workshop_supplies", quantity = 14 },
		{ pool = "adhesives", quantity = 17 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, your help got the K29 Kevlar inserts ready. I'll sell you the new plates now. "
				.. "Light, comfortable, and a better use of your money than another funeral.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})
