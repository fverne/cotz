local MAP = "rp_marsh_cs"

ix.progression.Register("technutItemDelivery_Suit1", {
	name = "Suiting Up Pt. 1",
	description = "Get Technut to help you make suits.",
	keyNpc = "'Technut'",
	defaultActive = true,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "suit_mailjacket", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "technutItemDelivery_Suit2" },
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["value_nuts"] = 50,
			["value_bolts"] = 50,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = (
				"The first product of our combined efforts are ready, come " .. "by and buy a mail jacket."
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
		{ npc = "'Technut'", args = { "suit_trenchcoat_black", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Technut'", args = { "suit_trenchcoat_brown", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Technut'", args = { "suit_trenchcoat_green", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Technut'", args = { "suit_trenchcoat_tan", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "technutItemDelivery_Suit3" },
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["value_paracord"] = 15,
			["hide_blinddog"] = 8,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = (
				"Come on over, I got some freshly finished trenchcoats for "
				.. "you all, for a price of course."
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Suit3", {
	name = "Suiting Up Pt. 3",
	description = "Get Technut to help you make suits.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "suit_sunrise", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = {
		"technutItemDelivery_SuitNBC",
		"technutItemDelivery_Suit4",
		"technutItemDelivery_Helmet1",
	},
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["value_documents_14"] = 1,
			["value_documents_13"] = 1,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = "Stalkers, I've got some fresh suit prototypes, ready for purchase."
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_SuitNBC", {
	name = "Closed Respiratory Upgrade",
	description = "Get Technut to help you make suits.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "suit_nbc", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["value_waterfilter"] = 10,
			["medic_antirad_1"] = 15,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = (
				"I finished the prototype of the closed respiratory variant "
				.. "of the sunrise suit. They're ready for purchase."
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Suit4", {
	name = "Suiting Up Pt. 4",
	description = "Get Technut to help you make suits.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "suit_cs1", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "technutItemDelivery_Suit5", "technutItemDelivery_Attachment1" },
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["drug_cigarette_4"] = 200,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = "I just finished a batch of armored suits, they're ready for purchase."
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
		{ npc = "'Technut'", args = { "suit_wind", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "technutItemDelivery_Suit6", "technutItemDelivery_AttachmentFabric1" },
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["drug_tobacco_1"] = 160,
			["drug_tobacco_2"] = 80,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = (
				"I just finished a batch of lightweight Wind suits, they're " .. "ready for purchase now."
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
		{ npc = "'Technut'", args = { "suit_cs2", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "technutItemDelivery_Suit7", "technutItemDelivery_AttachmentKevlar1" },
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["drink_spirit_3"] = 40,
			["drink_canbeer_3"] = 60,
			["drink_canbeer_4"] = 70,
			["drink_canbeer_5"] = 100,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = (
				"I just finished my work on the new iteration of the CS "
				.. "type suits, they're ready for purchase now."
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
		{ npc = "'Technut'", args = { "suit_cs3", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "technutItemDelivery_AttachmentFrame1", "technutItemDelivery_AttachmentCarbon" },
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["drink_wine"] = 20,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = (
				"I just finished a batch of heavily armored suits, the CS3's, "
				.. "they're ready for purchase now."
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
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["value_glue_2"] = 10,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = (
				"You've gotta pimp your suits, different patches and camouflages " .. "are now available."
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Helmet1", {
	name = "Wear Protection Pt. 1",
	description = "Help Technut get his hands on helmets.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "helm_steel_ger", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Technut'", args = { "helm_steel_rus", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Technut'", args = { "helm_steel_arab", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "technutItemDelivery_Helmet2" },
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["value_glue_3"] = 5, -- Placeholder?
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = "Steel helmets are up and available for purchase."
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
		{ npc = "'Technut'", args = { "headwear_cs1", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "technutItemDelivery_Helmet3" },
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["value_carbattery"] = 3,
			["value_wire_heavy"] = 2,
			["value_tape_electric"] = 15,
			["value_tape_duct"] = 10,
			["value_motorclean"] = 5,
			["value_gasoline"] = 10,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = "Prepare to fly through the Zone with the new headgear!"
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
		{ npc = "'Technut'", args = { "helm_operator_rus_1", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Technut'", args = { "helm_operator_rus_2", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "technutItemDelivery_Helmet4" },
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["artifact_droplet"] = 5,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = "Operator helmets now in store. Get them while they are hot!"
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
		{ npc = "'Technut'", args = { "headwear_cs2", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Technut'", args = { "headwear_cs4", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "technutItemDelivery_Helmet5" },
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["artifact_droplet"] = 20,
			["artifact_crystal"] = 12,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = "Frag helmets with respirator are now available, come and buy!"
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Helmet5", {
	name = "Wear Protection Pt. 5",
	description = "Help Technut get his hands on helmets.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "helm_sphere08", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "technutItemDelivery_Helmet6" },
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["artifact_bonecluster"] = 50,
			["artifact_arachno"] = 5,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = (
				"I've figured out how to reproduce Sphere-08 helmets! Come " .. "grab some noggin protection!"
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Helmet6", {
	name = "Wear Protection Pt. 6",
	description = "Help Technut get his hands on helmets.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "helm_sphere12", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Technut'", args = { "headwear_psz12", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "technutItemDelivery_Helmet7" },
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["artifact_slug"] = 25,
			["artifact_mica"] = 10,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = "I've now got Sphere-12 heavy helmets, and PSZ12's as an added bonus!"
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Helmet7", {
	name = "Wear Protection Pt. 7",
	description = "Help Technut get his hands on helmets.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "helm_operator_nato", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["artifact_mamasbeads"] = 15,
			["artifact_gmamasbeads"] = 3,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = (
				"I now carry ACH helmets! These babies from the West are "
				.. "both protective and lightweight!"
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
		{ npc = "'Technut'", args = { "mask_halfmask", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Technut'", args = { "mask_respirator", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "technutItemDelivery_Mask2" },
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["value_engine"] = 5,
			["value_waterfilter"] = 2,
			["value_tape_heavy"] = 4,
			["value_tape_duct"] = 12,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = (
				"I've managed to whip up a batch of respirators! Come grab "
				.. "one to keep yourself safe from radiation!"
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Mask2", {
	name = "Don't breathe this Pt. 2",
	description = "Help technut provide gasmasks.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "mask_gp5", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Technut'", args = { "mask_eo20", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "technutItemDelivery_Mask3" },
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["value_gasoline"] = 20,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = (
				"GP-5 and EO20 gas masks have been refit and are now safe " .. "for use! No asbestos for us!"
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Mask3", {
	name = "Don't breathe this Pt. 3",
	description = "Help technut provide gasmasks.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "mask_pmk3", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Technut'", args = { "mask_xm40", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "technutItemDelivery_Mask4" },
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["value_gasoline"] = 30,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = (
				"I've managed to refit the EO-20 to take 40mm external filters! " .. "Come and grab one!"
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Mask4", {
	name = "Don't breathe this Pt. 4",
	description = "Help technut provide gasmasks.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "mask_m40", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Technut'", args = { "mask_m50", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["value_techtool_3"] = 2,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = "I've got my hands on the best of the best, come get em!"
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Attachment1", {
	name = "Plating up Pt. 1",
	description = "Provide technut with materials for suit plates.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "attachment_steelplate_1", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Technut'", args = { "attachment_ceramicplate_1", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "technutItemDelivery_Attachment2" },
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["cmore"] = 5,
			["foregrip"] = 10,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = "I've managed to put together some basic steel and ceramic armour plates!"
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Attachment2", {
	name = "Plating up Pt. 2",
	description = "Provide technut with materials for suit plates.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "attachment_steelplate_2", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Technut'", args = { "attachment_ceramicplate_2", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "technutItemDelivery_Attachment3" },
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["cobrasuppressor"] = 5,
			["tundrasuppressor"] = 8,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = "I've managed to fabricate some better quality plates! Come grab them!"
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Attachment3", {
	name = "Plating up Pt. 3",
	description = "Provide technut with materials for suit plates.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "attachment_steelplate_3", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Technut'", args = { "attachment_ceramicplate_3", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["pbssuppressor"] = 5,
			["sakersuppressor"] = 4,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = "High quality ballistic inserts are now available for purchase!"
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_AttachmentFabric1", {
	name = "Patching Pt. 1",
	description = "Provide technut with materials for suit fabrics.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "attachment_fabric_1", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "technutItemDelivery_AttachmentFabric2" },
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["suit_io7a"] = 40,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = (
				"Insulating fabrics are now available! No burning to death " .. "if I can help it!"
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
		{ npc = "'Technut'", args = { "attachment_fabric_2", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["part_zombie_1"] = 100,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = "Heavy insulating fabric layers are now available! Come hit me up!"
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
		{ npc = "'Technut'", args = { "attachment_aluframe", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "technutItemDelivery_AttachmentFrame2" },
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["food_can_sprats"] = 200,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = (
				"Aluminium backpack frames are now available for sale! Come "
				.. "save your back some pain! Just be careful around anomalies, "
				.. "though..."
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
		{ npc = "'Technut'", args = { "attachment_steelframe", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["value_techtool_1"] = 10,
			["value_techtool_2"] = 5,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = (
				"Steel backpack frames are now available! Be extra careful " .. "around anomalies, though!"
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
		{ npc = "'Technut'", args = { "attachment_carbonfibre", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["value_toiletpaper"] = 110,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = (
				"Carbon fibre inserts are now available! They're really "
				.. "expensive, but you can find nothing better for anomaly "
				.. "protection!"
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
		{ npc = "'Technut'", args = { "attachment_kevlar_1", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "technutItemDelivery_AttachmentKevlar2" },
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["value_battery"] = 200,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = "K119 Kevlar plates are here to help keep you in the fight!"
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
		{ npc = "'Technut'", args = { "attachment_kevlar_2", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["value_9vbattery"] = 250,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Technut'"
			local message = (
				"K29 Kevlar plates are now in production! They're lightweight, "
				.. "comfortable, and have the bonus of keeping you alive!"
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})
