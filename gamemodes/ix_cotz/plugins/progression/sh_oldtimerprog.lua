local MAP = "rp_marsh_cs"

ix.progression.Register("oldtimerItemDelivery_Knife1", {
	name = "Backstabbing 1",
	description = "Prove your worth as a small game hunter to Old Timer.",
	keyNpc = "'Old Timer'",
	defaultActive = true,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Old Timer'", args = { "knife2", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "oldtimerItemDelivery_Knife2", "oldtimerItemDelivery_Hidestash1" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"You are still new to the Zone, stalker. You may have been "
			.. "out on a few trips, but you are still completely unprepared "
			.. "for what it can and will throw at you. If you are interested "
			.. "in proving your worth as a hunter, then get out there and "
			.. "show me what you can do with little more than a piece of "
			.. "rebar and your instincts.\n\nREQUIRED ITEMS:"
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
		{ pool = "common_hides", quantity = 2 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Old Timer'"
			local message = string.format(
				"%s, those trophies tell me you can handle more than stray dogs. You've earned a "
				.. "proper blade. Come see me; I'll sell you a hunting knife that'll hold up against "
				.. "tougher game.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("oldtimerItemDelivery_Knife2", {
	name = "Backstabbing 2",
	description = "Prove your worth as a big game hunter to Old Timer.",
	keyNpc = "'Old Timer'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Old Timer'", args = { "knife3", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "oldtimerItemDelivery_Knife3" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"You may have seen some of the game the Zone has to offer, "
			.. "but have you taken on a chimera? A pseudogiant? Multiple "
			.. "of them at once? i have a test for you and other would "
			.. "be hunters. Enter the Zone and bring me back proof that "
			.. "you have been to hell and back again.\n\nREQUIRED ITEMS:"
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
		{ pool = "predator_hides", quantity = 1 },
		{ pool = "brains", quantity = 1 },
		{ pool = "large_parts", quantity = 1 },
		{ pool = "common_parts", quantity = 2 },
		{ pool = "small_parts", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Old Timer'"
			local message = string.format(
				"%s, you've faced the larger beasts and lived to bring back proof. I'll sell you my "
				.. "best hunting knives. Keep your edge sharp and your wits sharper.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("oldtimerItemDelivery_Knife3", {
	name = "Backstabbing 3",
	description = "Prove your worth as a knife fighter to Old Timer.",
	keyNpc = "'Old Timer'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Old Timer'", args = { "knife4", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"You and yours are seasoned fighters; I can see it in your "
			.. "eyes. The way you carry yourselves, the way you walk... "
			.. "the cues are obvious to those well-versed enough to look "
			.. "for them. If you are searching for a blade better suited "
			.. "to combat than hunting, you must prove yourself worthy "
			.. "of bearing your steel. Show me what you are capable of.\n\nREQUIRED "
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
		{ pool = "elite_hides", quantity = 1 },
		{ pool = "brains", quantity = 1 },
		{ pool = "exotic_parts", quantity = 1 },
		{ pool = "common_parts", quantity = 2 },
		{ pool = "small_parts", quantity = 2 },
		{ pool = "large_parts", quantity = 1 },
		{ pool = "humanoid_parts", quantity = 1 },
		{ pool = "common_hides", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Old Timer'"
			local message = string.format(
				"%s, you've earned your place in the dance of blades. I'll sell you a bayonet now; "
				.. "that steel is made for a fight, not just dressing a carcass.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("oldtimerItemDelivery_Melee", {
	name = "Clubbing",
	description = "Prove your worth as a warrior to Old Timer.",
	keyNpc = "'Old Timer'",
	defaultActive = true,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Old Timer'", args = { "bat", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Old Timer'", args = { "fireaxe", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Old Timer'", args = { "fubar", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Old Timer'", args = { "hatchet", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Old Timer'", args = { "machete", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Do you carry a melee weapon with you, stalker? They are "
			.. "both economic solutions for poorer stalkers and useful "
			.. "kit to those who are able to dance in and out of battle "
			.. "with the claws of mutants. A well aimed blow with such "
			.. "weapons can instantly kill some threats. Take to the field "
			.. "of battle, stalker, and prove your worth.\n\nREQUIRED ITEMS:"
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
		{ pool = "melee_tools", quantity = 2 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Old Timer'"
			local message = string.format(
				"%s, there's a warrior's spirit in you. Come see me about axes, machetes and the "
				.. "rest of my melee weapons. I'll sell you something worthy of that spirit.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("oldtimerItemDelivery_Hidestash1", {
	name = "Hiding Secrets 1",
	description = "Prove your worth as a seeker to Old Timer",
	keyNpc = "'Old Timer'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Old Timer'", args = { "hidestasher_cleaningkit", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "oldtimerItemDelivery_Hidestash2" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Have you found some of the hidden secrets of the Zone, "
			.. "stalker? Not all of them are figuratively buried; some "
			.. "stashes are literally hidden underground. If you are interested "
			.. "in moving on from digging in the dirt with spoons, you "
			.. "must first demonstrate mastery.\n\nREQUIRED ITEMS:"
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
		{ pool = "common_artifacts", quantity = 1 },
		{ pool = "electrical_artifacts", quantity = 1 },
		{ pool = "common_hides", quantity = 1 },
		{ pool = "common_parts", quantity = 2 },
		{ pool = "small_parts", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Old Timer'"
			local message = string.format(
				"%s, you've got a seeker's eye and the dirt under your nails to prove it. I'll sell "
				.. "you a sturdier digging tool; you've earned better than a spoon.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("oldtimerItemDelivery_Hidestash2", {
	name = "Hiding Secrets 2",
	description = "Prove your worth as a treasure hunter to Old Timer.",
	keyNpc = "'Old Timer'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Old Timer'", args = { "hidestasher_shovel", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Have you grown tired of using small hand tools in your "
			.. "searches, stalker? Before man mastered gunpowder and the "
			.. "rifle, he mastered the sword with the riddle of steel, "
			.. "and before the sword came the stone. You must become a "
			.. "master with the stone before you may pick up the sword. "
			.. "Show me your skill.\n\nREQUIRED ITEMS:"
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
		{ pool = "common_artifacts", quantity = 1 },
		{ pool = "chemical_artifacts", quantity = 1 },
		{ pool = "predator_hides", quantity = 1 },
		{ pool = "common_parts", quantity = 1 },
		{ pool = "small_parts", quantity = 1 },
		{ pool = "large_parts", quantity = 1 },
		{ pool = "humanoid_parts", quantity = 1 },
		{ pool = "common_hides", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Old Timer'"
			local message = string.format(
				"%s, you've mastered the smaller tools. I'll sell you an entrenching shovel now. "
				.. "Use it wisely; the Zone doesn't give up its buried secrets easily.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})
