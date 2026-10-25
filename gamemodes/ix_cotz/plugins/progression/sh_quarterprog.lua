local MAP = "rp_waystation"

ix.progression.Register("quartermasterItemDelivery_1", {
	name = "Gearing Up 1",
	description = "Introduce yourself to Quartermaster.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Quartermaster'", args = { "mp5", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Quartermaster'", args = { "mossberg500", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "quartermasterItemDelivery_11", "quartermasterItemDelivery_12" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"So, you're one of the hotshots from the Swamp that Haggler "
			.. "has been talking about. If you're interested in doing business "
			.. "with me, stalker, you'll need to prove your abilities and "
			.. "your worth first. I offer higher end equipment than that "
			.. "buffoon in the swamps can offer, but only to those who "
			.. "are worth my time. If you're interested in opening up my "
			.. "best stock, prove yourself by reducing the chimera population "
			.. "and then I'll consider doing proper business with you lot.\n\nREQUIRED "
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
		{ pool = "humanoid_parts", quantity = 4 },
		{ pool = "common_parts", quantity = 6 },
		{ pool = "small_parts", quantity = 6 },
		{ pool = "large_parts", quantity = 4 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Quartermaster'"
			local message = string.format(
				"%s, you've convinced me we can do business. I'll sell you my MP5s now. Come see me "
				.. "with your money when you're ready.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("quartermasterItemDelivery_11", {
	name = "Gearing Up 1.1",
	description = "Help Quartermaster secure a weapon shipment.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Quartermaster'", args = { "mateba", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Quartermaster'", args = { "ak74", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Quartermaster'", args = { "l85", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "quartermasterItemDelivery_111", "quartermasterItemDelivery_112" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Alright, you've proven yourself at least a bit useful. "
			.. "That means that it's time to move on from playing with "
			.. "SMGs and to move onto the real deal; assault weapons. That's "
			.. "why you're here, isn't it? Anyway, some of my people outside "
			.. "the Zone are getting ready to move some special hardware "
			.. "into the Zone and I need some extra guns to help seal the "
			.. "deal. Here's a list of what I need.\n\nREQUIRED ITEMS:"
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
		{ pool = "rimfire_rifles", quantity = 2 },
		{ pool = "maintenance", quantity = 3 },
		{ pool = "powder", quantity = 3 },
		{ pool = "industrial_supplies", quantity = 2 },
		{ pool = "documents_technical", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Quartermaster'"
			local message = string.format(
				"%s, your delivery cleared the shipment. You can buy the AK-74, L85 and Mateba .44 "
				.. "from me now. Bring your coin and take your pick.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("quartermasterItemDelivery_111", {
	name = "Gearing Up 1.1.1",
	description = "Help Quartermaster snatch a shipment.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Quartermaster'", args = { "lax44", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Quartermaster'", args = { "g36c", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "quartermasterItemDelivery_1111" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Got another job for you if you're interested in helping "
			.. "out. I've got a couple of people from outside the Zone "
			.. "who are interested in importing some G36c rifles into the "
			.. "Zone, but we're running into some competition from the "
			.. "local wildlife. In addition, I've gotten wind of the location "
			.. "of a stash of .44 lever actions; pretty useful stuff against "
			.. "mutants. I see a win-win here; help me arrange the retrieval "
			.. "of both shipments and I'll have some new stock for you.\n\nREQUIRED "
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
		{ pool = "common_parts", quantity = 8 },
		{ pool = "small_parts", quantity = 8 },
		{ pool = "humanoid_parts", quantity = 4 },
		{ pool = "large_parts", quantity = 5 },
		{ pool = "rare_parts", quantity = 2 },
		{ pool = "exotic_parts", quantity = 4 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Quartermaster'"
			local message = string.format(
				"%s, the stash is secure and your shipment came through. I'll sell you the .44 "
				.. "lever action and G36C now. Come see me if you want either.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("quartermasterItemDelivery_1111", {
	name = "Gearing Up 1.1.1.1",
	description = "Help Quartermaster clear his supply lines.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Quartermaster'", args = { "sg552", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"We've got a problem, stalker. My shipments are getting "
			.. "harassed, and I'm not sure by what. My couriers are turning "
			.. "up dead and my guards are reporting sustained contact from "
			.. "mutants and armed locals, I assume either bandits or the "
			.. "Ukrainian military. How's about you lot help me keep my "
			.. "supply lines clear? I'll pay you... hell, I'll even open "
			.. "up stock to one of my nicer rifles.\n\nREQUIRED ITEMS:"
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
		{ pool = "humanoid_parts", quantity = 5 },
		{ pool = "large_parts", quantity = 5 },
		{ pool = "rare_parts", quantity = 2 },
		{ pool = "common_parts", quantity = 8 },
		{ pool = "small_parts", quantity = 8 },
		{ pool = "exotic_parts", quantity = 4 },
		{ pool = "elite_parts", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Quartermaster'"
			local message = string.format(
				"%s, my people feel safer after your help. As promised, you can buy the SG552 from "
				.. "me now. A deal's a deal.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("quartermasterItemDelivery_112", {
	name = "Gearing Up 1.1.2",
	description = "Help Quartermaster close a sale with some shady customers.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Quartermaster'", args = { "aek971", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Quartermaster'", args = { "an94k", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "quartermasterItemDelivery_1121" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Got an interesting one for you; I've gotten an offer from "
			.. "some people outside the Zone... Russians, I think. They've "
			.. "got a list of some pretty exclusive intelligence they want "
			.. "in exchange for a shipment of unique rifles. Now, I'm not "
			.. "talking random AKMs here; I'm referring to Russian military "
			.. "issue equipment that have been santizied for distribution. "
			.. "I smell a solid opportunity here, and I want your help "
			.. "in making it happen.\n\nREQUIRED ITEMS:"
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
		{ pool = "documents_field", quantity = 4 },
		{ pool = "documents_research", quantity = 2 },
		{ pool = "administrative_documents", quantity = 2 },
		{ pool = "documents_technical", quantity = 1 },
		{ pool = "field_instruments", quantity = 1 },
		{ pool = "small_electronics", quantity = 5 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Quartermaster'"
			local message = string.format(
				"%s, your part of the deal cleared and I got the crates. I'll sell you the AEK-971 "
				.. "and AN-94K now. Straight out of the storehouses, with a price to match.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("quartermasterItemDelivery_1121", {
	name = "Gearing Up 1.1.2.1",
	description = "Help Quartermaster establish a new supply line.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Quartermaster'", args = { "rk95", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "quartermasterItemDelivery_11211" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Good timing; I've got work. Unfortunately, one of my suppliers "
			.. "has gone dark, and intel from outside suggests that he "
			.. "was found out and arrested by the SBU. That's bad enough; "
			.. "worse is that one of my supply lines has been cut off. "
			.. "I've been in talks for a while with a new one, and while "
			.. "things are going well I think they could use a little bit "
			.. "of extra motivation, you follow me? I've found out that "
			.. "he craves information, and I'm more than willing to provide "
			.. "that to him.\n\nREQUIRED ITEMS:"
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
		{ pool = "documents_field", quantity = 4 },
		{ pool = "documents_research", quantity = 2 },
		{ pool = "field_instruments", quantity = 2 },
		{ pool = "administrative_documents", quantity = 2 },
		{ pool = "documents_technical", quantity = 1 },
		{ pool = "small_electronics", quantity = 6 },
		{ pool = "repair_electrical", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Quartermaster'"
			local message = string.format(
				"%s, your help made the talks go smoothly. You can buy the SAKO RK 95 from me now. "
				.. "Come see me when you're ready to spend.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("quartermasterItemDelivery_11211", {
	name = "Gearing Up 1.1.2.1.1",
	description = "Help Quartermaster get friendly with the Russians.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Quartermaster'", args = { "ak12", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"The Russians are back in touch again, and their shopping "
			.. "list this time is even longer than the last one. On the "
			.. "bright side, however, they've got some damn nice hardware "
			.. "in stock; AK-12s are up for grabs. This is a big deal; "
			.. "these are Russian army issue, not just stored prototypes. "
			.. "They're requesting high grade gunpowders in exchange for "
			.. "the rifles; the kind of powder we don't have the tools "
			.. "to repack. Interested?\n\nREQUIRED ITEMS:"
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
		{ pool = "powder", quantity = 5 },
		{ pool = "maintenance", quantity = 4 },
		{ pool = "industrial_supplies", quantity = 2 },
		{ pool = "documents_technical", quantity = 2 },
		{ pool = "repair_electrical", quantity = 4 },
		{ pool = "fasteners", quantity = 20 },
		{ pool = "workshop_supplies", quantity = 4 },
		{ pool = "batteries", quantity = 12 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Quartermaster'"
			local message = string.format(
				"%s, that last delivery secured the AK-12 crate. I'll sell you one now. You've "
				.. "earned a look at the newer kit.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("quartermasterItemDelivery_12", {
	name = "Gearing Up 1.2",
	description = "Help Quartermaster expand his personal defence arsenal.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Quartermaster'", args = { "m3super90", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Quartermaster'", args = { "fiveseven", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "quartermasterItemDelivery_121", "quartermasterItemDelivery_122" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I've got no outstanding work right now, although... no, "
			.. "nevermind, I've got something for you; or, rather, you've "
			.. "got something for me. I don't get out there a lot, so I "
			.. "want to know what you're up against out there. I want data, "
			.. "intel, that sort of thing. That'll allow me to tailor my "
			.. "stock to better serve you lot.\n\nREQUIRED ITEMS:"
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
		{ pool = "stash_notes", quantity = 1 },
		{ pool = "administrative_documents", quantity = 1 },
		{ pool = "documents_field", quantity = 3 },
		{ pool = "documents_technical", quantity = 1 },
		{ pool = "documents_research", quantity = 2 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Quartermaster'"
			local message = string.format(
				"%s, your data was useful. I'll sell you the M3 Super 90 and FN Five-seveN now. "
				.. "Come pick something that'll help with your next job.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("quartermasterItemDelivery_121", {
	name = "Gearing Up 1.2.1",
	description = "Prove your worth to Quartermaster.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Quartermaster'", args = { "p90", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Quartermaster'", args = { "ump45", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"It's time for another test, stalker. You've proven yourself "
			.. "a reliable business partner so far, but I need to know "
			.. "that you have the skills to keep up. Psuedogiants are rare "
			.. "and very dangerous around here; I want you to find one, "
			.. "I want you to kill it, and I want you to bring me proof.\n\nREQUIRED "
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
		{ pool = "elite_parts", quantity = 2 },
		{ pool = "common_parts", quantity = 7 },
		{ pool = "small_parts", quantity = 6 },
		{ pool = "humanoid_parts", quantity = 4 },
		{ pool = "large_parts", quantity = 5 },
		{ pool = "rare_parts", quantity = 2 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Quartermaster'"
			local message = string.format(
				"%s, good work with that lead; the pseudogiant is dead. You can buy the P90 and "
				.. "UMP-45 from me now. You've earned access to both.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("quartermasterItemDelivery_122", {
	name = "Gearing Up 1.2.2",
	description = "Help Quartermaster work with his Western supplier.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Quartermaster'", args = { "lr300", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "quartermasterItemDelivery_1221" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"No, I don't need data this time, but I do need some help. "
			.. "My Western suppliers are finally willing to trade some "
			.. "of the nicer hardware and they've put an order out for "
			.. "some psydog fur. If this works out, they'll be sending "
			.. "some NATO weapons into the zone, starting with the LR 300 "
			.. "combat rifle. You have my back on this one?\n\nREQUIRED "
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
		{ pool = "brains", quantity = 1 },
		{ pool = "exotic_parts", quantity = 4 },
		{ pool = "common_parts", quantity = 7 },
		{ pool = "small_parts", quantity = 6 },
		{ pool = "humanoid_parts", quantity = 4 },
		{ pool = "large_parts", quantity = 5 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Quartermaster'"
			local message = string.format(
				"%s, your delivery got the LR-300s through. I'll sell you one now. Come see me if "
				.. "you want to take a look.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("quartermasterItemDelivery_1221", {
	name = "Gearing Up 1.2.2.1",
	description = "Help Quartermaster expand his Western operation.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Quartermaster'", args = { "m16a4", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "quartermasterItemDelivery_12211" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Alright, our friends from the West were very pleased with "
			.. "what we provided them. Unsurprisingly, they're asking for "
			.. "more supplies from the Zone; in this case, MREs. Believe "
			.. "it or not, it's actually cheaper to buy them per meal from "
			.. "us as opposed to by the case off the surplus market. This "
			.. "time, they've got M16A4 rifles up for grabs. I'm not sure "
			.. "where these guys are getting the stuff that the United "
			.. "States Marines get, but I'm interested in staying on their "
			.. "good side. Are you?\n\nREQUIRED ITEMS:"
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
		{ pool = "mre", quantity = 1 },
		{ pool = "common_meals", quantity = 8 },
		{ pool = "spirits", quantity = 3 },
		{ pool = "canned_food", quantity = 5 },
		{ pool = "local_refreshments", quantity = 5 },
		{ pool = "local_beer", quantity = 4 },
		{ pool = "tobacco", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Quartermaster'"
			local message = string.format(
				"%s, my Western contacts were pleased with your work. I'll sell you the M16A4 now. "
				.. "Bring your money when you're back this way.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("quartermasterItemDelivery_12211", {
	name = "Gearing Up 1.2.2.1.1",
	description = "Help Quartermaster further expand his Western operation.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Quartermaster'", args = { "fnfal", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"No direct import order this time, the Westerners have a "
			.. "delivery that they want me to help facilitate and I'm going "
			.. "to do just that. I have been given permission, however, "
			.. "to skim a couple of hundred rifles off the shipment they've "
			.. "got coming in. They're asking for a pseudogiant's hide "
			.. "in exchange, something about armour research. You in?\n\nREQUIRED "
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
		{ pool = "elite_hides", quantity = 1 },
		{ pool = "common_parts", quantity = 8 },
		{ pool = "small_parts", quantity = 8 },
		{ pool = "humanoid_parts", quantity = 5 },
		{ pool = "large_parts", quantity = 5 },
		{ pool = "rare_parts", quantity = 2 },
		{ pool = "exotic_parts", quantity = 4 },
		{ pool = "elite_parts", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Quartermaster'"
			local message = string.format(
				"%s, you came through for me, so I'm doing likewise. You can buy the FN FAL from me "
				.. "now. Come see me about the price.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("quartermasterItemDelivery_2", {
	name = "Gearing Up 2",
	description = "Help Quartermaster with his hand cannon problem.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Quartermaster'", args = { "swr8", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "quartermasterItemDelivery_21", "quartermasterItemDelivery_22" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Time for a data gathering mission. I've been getting complaints "
			.. "about the lack of heavy sidearms for sale, and I don't "
			.. "really know what would be most useful out there. Get out "
			.. "there, get me some more intel, and I'll tailor my stock "
			.. "accordingly. Try taking out some of the burer population.\n\n"
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
		{ pool = "large_parts", quantity = 4 },
		{ pool = "exotic_parts", quantity = 3 },
		{ pool = "humanoid_parts", quantity = 4 },
		{ pool = "common_parts", quantity = 6 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Quartermaster'"
			local message = string.format(
				"%s, your data helped settle the order. I'll sell you the S&W R8 now. Eight rounds "
				.. "of .357 and a dream, if you've got the money.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("quartermasterItemDelivery_21", {
	name = "Gearing Up 2.1",
	description = "Help Quartermaster complete his revolver supply.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Quartermaster'", args = { "taurusragingbull", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Quartermaster'", args = { "mp9a1", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "quartermasterItemDelivery_211", "quartermasterItemDelivery_212" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"The S&W R8 seems to satisfy most people, but I've found "
			.. "that some stalkers are turning up their nose at that idea "
			.. "and sticking with the shitty .44 Magnum cartridge instead. "
			.. "Rather than give the moron in the swamps my business, I "
			.. "want in on that action. Get me some more data and I'll "
			.. "reward you.\n\n"
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
		{ pool = "stash_notes", quantity = 1 },
		{ pool = "veteran_stash", quantity = 1 },
		{ pool = "administrative_documents", quantity = 1 },
		{ pool = "documents_technical", quantity = 1 },
		{ pool = "documents_field", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Quartermaster'"
			local message = string.format(
				"%s, your delivery earned you access to the Taurus Raging Bull and MP9. Come see me "
				.. "if you want to buy a hand cannon or something a bit quicker.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("quartermasterItemDelivery_211", {
	name = "Gearing Up 2.1.1",
	description = "Help Quartermaster fulfill his SMG stocks.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Quartermaster'", args = { "uzi", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Quartermaster'", args = { "pp1901vityaz", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I've gotten a request for some SMGs that are cheaper than "
			.. "the P90 or the like, and I have a few in mind. I've requested "
			.. "an order, but my supplier says that they're on backorder. "
			.. "The guy loves bacon, and so I suggest that we give the "
			.. "fat fuck exactly what he wants.\n\nREQUIRED ITEMS:"
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
		{ pool = "common_meat", quantity = 12 },
		{ pool = "common_parts", quantity = 8 },
		{ pool = "small_parts", quantity = 8 },
		{ pool = "humanoid_parts", quantity = 5 },
		{ pool = "large_parts", quantity = 6 },
		{ pool = "rare_parts", quantity = 2 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Quartermaster'"
			local message = string.format(
				"%s, your help loosened up my supplier. I'll sell you the UZI and Vityaz SMGs now. "
				.. "Funny how a completed order makes people find extra crates.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("quartermasterItemDelivery_212", {
	name = "Gearing Up 2.1.2",
	description = "Help Quartermaster fulfill a request from the West.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Quartermaster'", args = { "famas", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "quartermasterItemDelivery_2121" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"The West has reached out again, and they've got yet another "
			.. "shopping list of food that they require. Up for grabs this "
			.. "time is the FAMAS assault rifle; a French piece that's "
			.. "particularly useful in close quarters, being both a bullpup "
			.. "and automatic. If you want your very own bugle, now's the "
			.. "time to pitch in.\n\n"
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
		{ pool = "mre", quantity = 1 },
		{ pool = "local_beer", quantity = 5 },
		{ pool = "common_meals", quantity = 9 },
		{ pool = "canned_food", quantity = 5 },
		{ pool = "local_refreshments", quantity = 5 },
		{ pool = "spirits", quantity = 4 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Quartermaster'"
			local message = string.format(
				"%s, the FAMAS rifles arrived after your delivery. You can buy one from me now. "
				.. "Come see me if you're interested.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("quartermasterItemDelivery_2121", {
	name = "Gearing Up 2.1.2.1",
	description = "Help Quartermaster complete his Western contract.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Quartermaster'", args = { "aug", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"We've gotten about all we can from the West, and it's time "
			.. "to seal the deal. Up on offer is the AUG; a real space "
			.. "age piece of kit. My supplier's after computer parts, and "
			.. "I can only think of a few locals who can help out here.\n\nREQUIRED "
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
		{ pool = "computer_parts", quantity = 1 },
		{ pool = "advanced_parts", quantity = 1 },
		{ pool = "industrial_supplies", quantity = 2 },
		{ pool = "documents_technical", quantity = 1 },
		{ pool = "documents_field", quantity = 5 },
		{ pool = "documents_research", quantity = 2 },
		{ pool = "administrative_documents", quantity = 2 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Quartermaster'"
			local message = string.format(
				"%s, your work secured access to the Steyr AUG. I'll sell you one now. That's the "
				.. "last assault rifle this Western contact can offer us for a while.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("quartermasterItemDelivery_22", {
	name = "Gearing Up 2.2",
	description = "Help Quartermaster pick out some precision weapons.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Quartermaster'", args = { "rem870ae", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Quartermaster'", args = { "mr96", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "quartermasterItemDelivery_221", "quartermasterItemDelivery_222" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"A group of pretty influential mutant hunters have been "
			.. "in touch, and they're looking for some kit that's more "
			.. "accurate than your standard fare. Now, the Raging Bull "
			.. "hits like a goddamn freight train, but these guys are wanting "
			.. "something a bit more accurate. To that end, I'm contacting "
			.. "the West with a specific request; and I want you to supply "
			.. "me with the offering. In this case, i've picked up wind "
			.. "that the Westerners are wanting to do research into anomalous "
			.. "power sources, and I've got an idea of what they might "
			.. "want.\n\nREQUIRED ITEMS:"
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
		{ pool = "electrical_artifacts", quantity = 3 },
		{ pool = "elite_parts", quantity = 2 },
		{ pool = "chemical_artifacts", quantity = 2 },
		{ pool = "gravitational_artifacts", quantity = 1 },
		{ pool = "rare_electrical_artifacts", quantity = 2 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Quartermaster'"
			local message = string.format(
				"%s, the Western supplier was happy with your delivery. I'll sell you the Remington "
				.. "870AE and MR96 now. Come see what suits your next trip.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("quartermasterItemDelivery_221", {
	name = "Gearing Up 2.2.1",
	description = "Help Quartermaster appease the locals.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Quartermaster'", args = { "mp153", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I think it's time to expand my market into kit that's a "
			.. "little bit cheaper than the super high end stuff. The first "
			.. "thing that comes to mind is the Saiga shotgun, but I know "
			.. "that's a bit more money than your average stalker is willing "
			.. "to foot. To that end, I'm going to make another deal; this "
			.. "time, I'm after thermal artefacts and information about "
			.. "hellhounds. You know what to do.\n\nREQUIRED ITEMS:"
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
		{ pool = "rare_field_artifacts", quantity = 2 },
		{ pool = "hellhound_part", quantity = 6 },
		{ pool = "rare_electrical_artifacts", quantity = 2 },
		{ pool = "electrical_artifacts", quantity = 3 },
		{ pool = "chemical_artifacts", quantity = 2 },
		{ pool = "gravitational_artifacts", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Quartermaster'"
			local message = string.format(
				"%s, your delivery settled the shotgun deal. You can buy the MP-153 from me now. "
				.. "Come see me when you're ready.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("quartermasterItemDelivery_222", {
	name = "Gearing Up 2.2.2",
	description = "Help Quartermaster expand into the precision rifles market.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Quartermaster'", args = { "sv98", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "quartermasterItemDelivery_2221" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I've seen a lot of the swamp stalkers coming in with Mosin "
			.. "rifles and SAKO kit. While that's nice, they aren't modern "
			.. "precision rifles and they especially aren't hardened for "
			.. "use in the Zone. I have a shipment of decent bolt actions "
			.. "coming in, but the price they're offering is substantial. "
			.. "I'll need enough artefacts to sate them.\n\nREQUIRED ITEMS:"
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
		{ pool = "rare_field_artifacts", quantity = 2 },
		{ pool = "gravitational_artifacts", quantity = 1 },
		{ pool = "documents_field", quantity = 3 },
		{ pool = "electrical_artifacts", quantity = 3 },
		{ pool = "chemical_artifacts", quantity = 2 },
		{ pool = "rare_electrical_artifacts", quantity = 2 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Quartermaster'"
			local message = string.format(
				"%s, you've earned access to the SV-98. I'll sell you one if you want to try your "
				.. "hand at longer shots. Bring enough for the rifle.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("quartermasterItemDelivery_2221", {
	name = "Gearing Up 2.2.2.1",
	description = "Help Quartermaster top off his stock.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Quartermaster'", args = { "svd", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"It's been a long road together, but I have one last job "
			.. "for you to do. The SV-98 isn't selling as well as I'd like, "
			.. "so I've put in an order for something I know nobody else "
			.. "is going to be able to match. The asking price is very "
			.. "high, so to close the deal I intend to use artefacts rather "
			.. "than liquid currency. Crystals will be our best bet, I "
			.. "think.\n\n"
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
		{ pool = "rare_field_artifacts", quantity = 2 },
		{ pool = "chemical_artifacts", quantity = 2 },
		{ pool = "rare_electrical_artifacts", quantity = 2 },
		{ pool = "electrical_artifacts", quantity = 3 },
		{ pool = "gravitational_artifacts", quantity = 1 },
		{ pool = "bubble_artifacts", quantity = 1 },
		{ pool = "documents_research", quantity = 2 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Quartermaster'"
			local message = string.format(
				"%s, you saw the work through. You can buy the SVD from me now. That's the last job "
				.. "in this line, but you're welcome back as a customer.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})
