local MAP = "rp_marsh_cs"

ix.progression.Register("hagglerItemDelivery_1", {
	name = "Kitting Up 1",
	description = "Help Haggler establish basic supply lines to smugglers inside the Zone.",
	keyNpc = "'Haggler'",
	defaultActive = true,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "fort12", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Haggler'", args = { "m1911", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Haggler'", args = { "brhp", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "hagglerItemDelivery_11", "hagglerItemDelivery_12" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I'll be honest, stalker, this place is kind of a slouch. "
			.. "We're surviving on particularly shitty pieces of kit: Makarovs, "
			.. "Lugers... basically whatever dumpster trash we can dredge "
			.. "up from the swamps. Luckily for us, I have a solution; "
			.. "I've gotten in touch with a couple of suppliers in the "
			.. "Ukrainian military who are willing to scratch our backs "
			.. "if we scratch theirs. That's where you come in; we've received "
			.. "a supply requisition from a supplier that can't get soldiers "
			.. "out this way to go find it. If we get him what he needs, "
			.. "he's got a shipment of sidearms from military storehouses "
			.. "that he can redirect our way. Get to it.\n\nREQUIRED ITEMS:"
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
		{ pool = "fasteners", quantity = 10 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, your delivery kept my supplier happy. I'll sell you Fort-12s, M1911s and "
				.. "Browning Hi-Powers now. Bring your rubles and we'll get you a better sidearm.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_11", {
	name = "Kitting Up 1.1",
	description = "Help Haggler set up a workshop.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "lax410s", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Haggler'", args = { "sten", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "hagglerItemDelivery_111", "hagglerItemDelivery_112" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"The shipment of pistols is handy, but they're only good "
			.. "for shooting at dogs and fleshes. We're going to need something "
			.. "with a bit more firepower. Now, as it stands, consistent "
			.. "shipments of long guns aren't viable. I can, however, produce "
			.. "some of my own stuff out here. If you bring me the necessary "
			.. "tools, I can get a basic workshop going and fix up something "
			.. "that's 'good enough.' Sound like a plan?\n\nREQUIRED ITEMS:"
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
		{ pool = "small_electronics", quantity = 5 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, your tools got the workshop running. I'll sell you the short lever action "
				.. "shotguns and STENs now. Rough around the edges, but they'll do the job.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_111", {
	name = "Kitting Up 1.1.1",
	description = "Help Haggler upgrade his workshop with a basic lathe.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "lax410", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "hagglerItemDelivery_1111" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Happy with my work in the shop so far? I am too, but my "
			.. "workshop can always be improved, and for that we're gonna "
			.. "need more space. We've got wood in abundance but we don't "
			.. "have the stuff to build with; I need nails for reinforcement, "
			.. "duct tape because duct tape is useful for everything, and "
			.. "we'll need hoses to run water, sewage, and all that good "
			.. "stuff. It'll go a long way to shoring up the shit shacks "
			.. "we call a vllage.\n\nREQUIRED ITEMS:"
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
		{ pool = "workshop_supplies", quantity = 2 },
		{ pool = "fasteners", quantity = 9 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, the lathe is running with your help. You can buy the long barrel lever action "
				.. "shotguns from me now. Come see what that extra barrel gets you.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_1111", {
	name = "Kitting Up 1.1.1.1",
	description = "Help Haggler expand his supply lines.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "swmodel29", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Haggler'", args = { "44magnum", nil, 150, "SELLANDBUY", 150, 1, 150 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I'm milking my supplies in the SBU for all they're worth, "
			.. "but there's only so much they can get to us right now. "
			.. "Luckily, though, I've made contact with some of the Zone's "
			.. "Mercenaries; a guy called Quartermaster is interested in "
			.. "helping us out. He's put out a requisition order to test "
			.. "the waters and is offering some real Dirty Harry kind of "
			.. "revolvers if we help him out. If you want to take the first "
			.. "step into big bore pistols, now's your time to shine, kid.\n\nREQUIRED "
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
		{ pool = "repair_electrical", quantity = 3 },
		{ pool = "cleaning", quantity = 2 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, my contact liked what you brought. I'll sell you the .44 Magnum revolvers now. "
				.. "Bring cash, and try not to blame me for your wrist afterwards.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_112", {
	name = "Kitting Up 1.1.2",
	description = "Help Haggler upgrade his workshop with a rivet gun.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "sterling", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I don't know if you've spent any time using it, but I really, "
			.. "really hate the STEN gun. It's bulky, takes up a lot of "
			.. "space, and is damn near impossible to carry comfortably. "
			.. "I've managed to barter for diagrams on how to make Sterling "
			.. "guns; the next step up from a normal STEN. However, I've "
			.. "run into a... slight problem. The guy who I sent to pay "
			.. "for the schematics hasn't showed up yet and my supplier "
			.. "is starting to get pissed. I'm gonna work ons scrabbling "
			.. "together something to get him off my ass, but for that "
			.. "I'll need some help for you. He's fond of showing off; "
			.. "go get some bling... and while you're at it, bring some "
			.. "loose wiring so I can work on my shop.\n\nREQUIRED ITEMS:"
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
		{ pool = "small_valuables", quantity = 1 },
		{ pool = "repair_electrical", quantity = 2 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, your supplies helped me refit the Sterlings. You've earned access to buy one. "
				.. "Come see me when you've got the rubles.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_12", {
	name = "Kitting Up 1.2",
	description = "Help Haggler con a mechanic.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "toz66", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Haggler'", args = { "toz66short", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "hagglerItemDelivery_121", "hagglerItemDelivery_122" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"If you've got time, I've got something you can help me "
			.. "with. One of my suppliers managed to get a shipment of "
			.. "TOZ-66 shotguns that never made it out of the Tula arsenal. "
			.. "Pretty good shit, right? Problem is that he isn't selling, "
			.. "but I know just the way to get him to cough it up. He's "
			.. "a gearhead, so I figure if we fork him auto components "
			.. "for his precious cars he'll be willing to deal. You get "
			.. "me some spark plugs and some glue and I'll handle the rest.\n\nREQUIRED "
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
		{ pool = "repair_electrical", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, that delivery got the TOZ-66 shipment through. I'll sell you one now. Come "
				.. "spend some of that hard-earned cash on the rookie's dream gun.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_121", {
	name = "Kitting Up 1.2.1",
	description = "Help Haggler deal with Quartermaster.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "sks", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Haggler'", args = { "rugermini14", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "hagglerItemDelivery_1211" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"So, I had the great idea to start importing some Cold War "
			.. "era weapons, starting SKS rifles from the Ukrainians and "
			.. "Mini-14s from Quartermaster. Seemed like a great idea, "
			.. "right? Intermediate caliber, accurate, reliable... only "
			.. "the entire fucking shipment came coated in cosmoline! Unfortunately, "
			.. "he's got us by the throat here. I don't know where he's "
			.. "based out of, but it's remote, and they lack hygenic supplies. "
			.. "He's requesting, of all things, toothpaste, and a handful "
			.. "of those bronze horse statuettes that seem to show up out "
			.. "of nowhere. This'll be big if we fill the order, so let's "
			.. "do this.\n\nREQUIRED ITEMS:"
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
		{ pool = "cleaning", quantity = 2 },
		{ pool = "statues", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, the SKS and Mini-14 rifles are cleaned up and ready for you to buy. Your "
				.. "delivery helped, but getting that damn grease off was still my problem.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_1211", {
	name = "Kitting Up 1.2.1.1",
	description = "Help Haggler expand his supply lines.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "saigasemi", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "hagglerItemDelivery_12111" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"So, I'm thinking that these imported arms are all well "
			.. "and good, but they're too damn expensive by far. The Russian "
			.. "gearhead is willing to deal, but he's wanting a bit more "
			.. "than last time. He wants full engline blocks this time; "
			.. "not the kind used in cars, but the motors that are used "
			.. "in stuff like garage doors. He wants these as well as nuts "
			.. "to use for fastening. If you're interested in Saiga semiauto "
			.. "rifles, you should spring.\n\nREQUIRED ITEMS:"
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
		{ pool = "heavy_components", quantity = 2 },
		{ pool = "fasteners", quantity = 13 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, your help with the supplier paid off. I'll sell you the Saiga shotguns now. "
				.. "Come see me when you're ready to put some money down.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_12111", {
	name = "Kitting Up 1.2.1.1.1",
	description = "Help Haggler organize a trade with Quartermaster.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "w9422357", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Haggler'", args = { "357magnum", nil, 15, "SELLANDBUY", 15, 1, 15 } },
	},
	nextProgressions = { "hagglerItemDelivery_121111" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"So, Quartermaster got in touch with me with an offer. We've "
			.. "got some stuff out here in the Swamps that he can't get "
			.. "where he is, and he wants some. He also knows that we're "
			.. "gonna need something a little more beefy than what we've "
			.. "got if we want to start pushing north. Like typical Quartermaster, "
			.. "though, he's offering to sell us the weapon without a reliable "
			.. "means of getting the ammo. He's wanting supplies for pistol "
			.. "reloads and workshop upkeep. You up to it?\n\nREQUIRED "
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
		{ pool = "powder", quantity = 3 },
		{ pool = "documents_technical", quantity = 1 },
		{ pool = "maintenance", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, you've earned access to the big bore rifles. Come see me if you want to buy "
				.. "some proper mutant hunting kit. The ammunition bill is your problem.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_121111", {
	name = "Kitting Up 1.2.1.1.1.1",
	description = "Help Haggler trade with a tourist.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "g2500mag", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Haggler'", args = { "500magnum", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"We've got a golden opportunity here, stalker! Word about "
			.. "what we're doing here is starting to spread, and a pretty "
			.. "rich tourist hit me up with a request. He's wanting to "
			.. "get some bling from the Zone, mostly because it costs a "
			.. "fraction of the price from here compared to the open market. "
			.. "He's after new phones and the big gold watches bandits "
			.. "like to wear. He's offering up .500 Magnum as a big bore "
			.. "hunting load for some of the nastier mutants. Want to help "
			.. "make a deal? \n\nREQUIRED ITEMS:"
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
		{ pool = "consumer_electronics", quantity = 3 },
		{ pool = "small_valuables", quantity = 2 },
		{ pool = "administrative_documents", quantity = 2 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, your delivery kept the tourists happy. I'll sell you the refit Contenders and "
				.. ".500 Magnum revolvers now. Either should give a boar a very bad day.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_122", {
	name = "Kitting Up 1.2.2",
	description = "Help Haggler make an exchange with his Russian supplier.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "kiparis", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Haggler'", args = { "kp31", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "hagglerItemDelivery_1221" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Yo, got another opportunity here. My Russian supplier came "
			.. "at me with an order for some Zone-acquired supplies. He's "
			.. "after detergent bottles and car batteries; apparently, "
			.. "the older detergents around here are more acidic than modern "
			.. "stuff or some shit like that. I don't ask questions, I "
			.. "just make deals. You in?\n\nREQUIRED ITEMS:"
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
		{ pool = "cleaning", quantity = 2 },
		{ pool = "heavy_electrical_map1", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, the crates got here thanks to your help. You can buy Kiparis machine pistols "
				.. "and Suomi SMGs from me now. Bring money, not promises.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_1221", {
	name = "Kitting Up 1.2.2.1",
	description = "Help Haggler get proper pistol tooling equipment.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "mac11", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "hagglerItemDelivery_12211" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Alright, I think I've about hit my limit with this hand "
			.. "machining shit. I'm gonna need proper tooling for the workshop "
			.. "to make better SMGs and machine pistols. What's tooling, "
			.. "you ask? Fuck, I don't have time to explain it, just fill "
			.. "my shopping list so I can start making calls.\n\nREQUIRED "
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
		{ pool = "filters", quantity = 2 },
		{ pool = "fasteners", quantity = 12 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, your supplies helped me upgrade the lathe. I'll sell you the Mac-11 machine "
				.. "pistols now. Fast little things; try to make the ammunition last.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_12211", {
	name = "Kitting Up 1.2.2.1.1",
	description = "Help Haggler get some precision components.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "m1911chic", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Good seeing you. You remember way back when we got the "
			.. "1911 pistols? Well, Quartermaster got a custom order that "
			.. "he wants us to fill. He's sent over the blueprints for "
			.. "a pistol he calls the Chicago; a modified variant of the "
			.. "1911 that's capable of firing in full auto. Could be useful "
			.. "if you want the rate of fire of a machine pistol but the "
			.. "power of something a little heavier. Wanna give it a shot "
			.. "with me?\n\nREQUIRED ITEMS:"
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
		{ pool = "advanced_parts", quantity = 1 },
		{ pool = "field_maintenance", quantity = 2 },
		{ pool = "documents_technical", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, Quartermaster was pleased with your delivery. I'll sell you the Colt Chicago "
				.. "now. If you want that custom little piece, come talk money.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_2", {
	name = "Kitting Up 2",
	description = "Help Haggler import a new type of shotgun.",
	keyNpc = "'Haggler'",
	defaultActive = true,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "toz34", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Haggler'", args = { "toz34short", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "hagglerItemDelivery_21", "hagglerItemDelivery_22" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"So, if you're like me, you're probably getting pretty goddamn "
			.. "tired of the peashooters chambered in .410. Well, my Russian "
			.. "supplier got back to me about a batch of TOZ-34 shotguns "
			.. "directly from the Tula Arsenal; no resale, no second hand, "
			.. "none of that shit. He's requesting some more mechanical "
			.. "parts for the trade. \n\nREQUIRED ITEMS:"
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
		{ pool = "fasteners", quantity = 10 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, your delivery came through, so I'll sell you the TOZ-34 over-under shotguns "
				.. "now. From Russia with love, eh? Love still costs rubles.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_21", {
	name = "Kitting Up 2.1",
	description = "Help Haggler rechamber some SAKO rifles.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "sako85nato", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "hagglerItemDelivery_211", "hagglerItemDelivery_212" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"You seen some of the shitty peashooters chambered in .22 "
			.. "around here? They aren't particularly useful other than "
			.. "shooting tushkano, and that isn't really sustainable for "
			.. "us right now. I'm working on getting them rechambered into "
			.. "5.56. I can try to load the ammo, but I'm gonna need rifle "
			.. "grade gunpowder. Go find some jars and let me see what "
			.. "I can do.\n\nREQUIRED ITEMS:"
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
		{ pool = "powder", quantity = 4 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, you've earned access to my SAKO-85 rifles in 5.56. Come buy one if you want to "
				.. "try a NATO cartridge. I expect payment either way.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_211", {
	name = "Kitting Up 2.1.1",
	description = "Help Haggler buy some woodworking tools.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "c96carbine", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "hagglerItemDelivery_2111" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"So, combining some of the knowledge that I gained working "
			.. "on the Chicago project, I'm ready to give a new homemade "
			.. "project a try. Did you know that the C96 Mauser had a carbine "
			.. "variant? Extraordinarily rare these days, but it's an interesting "
			.. "concept that I think we could apply here. I'm gonna need "
			.. "some help importing some specialist woodworking components "
			.. "so I can make my own stocks for these babies. I've found "
			.. "a guy willing to make the trade, but he's after yet more "
			.. "car batteries. Interested?\n\nREQUIRED ITEMS:"
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
		{ pool = "heavy_electrical_map1", quantity = 1 },
		{ pool = "small_electronics", quantity = 4 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, your supplies got the handmade C96 carbines finished. I'll sell you one now. "
				.. "Come admire the work, then open your wallet.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_2111", {
	name = "Kitting Up 2.1.1.1",
	description = "Help Haggler find a stash of PPSh SMGs.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "ppsh", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I've been seeing stalkers run around the the PPSh SMG; "
			.. "nice piece of kit, but they're rather uncommon right now. "
			.. "I've been hearing rumours from others about a stash of "
			.. "them from the war that were kept in a storehouse somewhere "
			.. "in the Zone, and I've found a stalker willing to sell a "
			.. "stash location. He's trustworthy, so I think it's worth "
			.. "a shot. He's asking for silicone tubing for some repairs "
			.. "at his camp.\n\nREQUIRED ITEMS:"
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
		{ pool = "workshop_supplies", quantity = 3 },
		{ pool = "adhesives", quantity = 4 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, your lead checked out; my guys found the stash. You've earned access to buy a "
				.. "PPSh from me. Come see me if you want one.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_212", {
	name = "Kitting Up 2.1.2",
	description = "Help Haggler trade for some pump-action shotguns.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "toz194", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "hagglerItemDelivery_2121" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I think we're starting to reach the point now where double "
			.. "barrel shotguns just aren't cutting it. The further north "
			.. "we go, the bigger mutant hordes and groups of nasties are "
			.. "getting. My Russian guy is interested in trading some pump "
			.. "action shotguns for some more 'locally acquired goods.' "
			.. "as it were. Want in on the action?\n\nREQUIRED ITEMS:"
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
		{ pool = "batteries", quantity = 5 },
		{ pool = "engine_care", quantity = 2 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, that delivery sorted the TOZ-194 shipment. I'll sell you the pump action "
				.. "shotguns now. Bring the money when you're back this way.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_2121", {
	name = "Kitting Up 2.1.2.1",
	description = "Help Haggler make another deal with Quartermaster.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "m1887", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "hagglerItemDelivery_21211" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Quartermaster has reached me with an offer for some vintage "
			.. "M1887 lever action shotguns. They're nice little coach "
			.. "guns, the same size as a sawed off but can carry more shells. "
			.. "I've got most of a shipment to him ready, but I'm gonna "
			.. "need some heavy cabling to put on the finishing touches. "
			.. "You know what to do, yeah?\n\nREQUIRED ITEMS:"
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
		{ pool = "heavy_electrical", quantity = 2 },
		{ pool = "small_electronics", quantity = 4 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, your help got the M1887s here. You can buy one from me now. Come have a look "
				.. "if you fancy a lever action with a little history.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_21211", {
	name = "Kitting Up 2.1.2.1.1",
	description = "Help Haggler import some western shotguns.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "ithaca37", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"The TOZ-194 is nice and all, but its lack of a stock and "
			.. "small magazine tube make it impractical for larger groups "
			.. "of mutants. Quartermaster reached out again with another "
			.. "offer; he's got some Ithaca shotguns from Vietnam up for "
			.. "grabs and I think I may bite. He's asking for some more "
			.. "electrical components; copper wire and batteries, mostly. "
			.. "Wonder what he's getting up to... \n\nREQUIRED ITEMS:"
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
		{ pool = "small_electronics", quantity = 5 },
		{ pool = "batteries", quantity = 8 },
		{ pool = "workshop_supplies", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, your delivery kept the deal moving. I'll sell you the Ithaca shotguns now. "
				.. "Come see me if you want one for the next trip.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_22", {
	name = "Kitting Up 2.2",
	description = "Help Haggler trade for rifle tooling for future projects.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "saigasemi545", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Haggler'", args = { "mp34", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "hagglerItemDelivery_221", "hagglerItemDelivery_222" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"So, if you're had any experience with the 7.62 rifles you'll "
			.. "know that the bullet is a little big and is punishing for "
			.. "newer shooters. I want to whip something up that's easier "
			.. "for our newer guys to handle. I've got a shipment of MP34 "
			.. "SMGs coming in from Quartermaster, but the opportunity "
			.. "has come up to get a set of 5.45 tooling with it. Want "
			.. "to help contribute to the deal?\n\nREQUIRED ITEMS:"
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
		{ pool = "workshop_supplies", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, your supplies paid off. I'll sell you the MP34s and rechambered Saiga 5.45s "
				.. "now. You've done your part; bring cash for mine.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_221", {
	name = "Kitting Up 2.2.1",
	description = "Help Haggler get some new Finnish hardware.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "sako85", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Haggler'", args = { "w1895", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "hagglerItemDelivery_2211" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I found out who my supplier was using to get the shitty "
			.. ".22 SAKO peashooters from and went around him, and now "
			.. "I've got access to the Finnish market. In short, that means "
			.. "that I can get Finnish firearms directly from the source; "
			.. "first on the docket, old Russian Empire era Winchester "
			.. "1895 lever actions and the actual SAKO rifles in 7.62x54. "
			.. "He's asking for a pretty substantial bribe on top of some "
			.. "wiring for a generator and the propane to fuel it, so it "
			.. "isn't gonna be cheap.\n\nREQUIRED ITEMS:"
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
		{ pool = "workshop_supplies", quantity = 2 },
		{ pool = "repair_electrical", quantity = 2 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, the Finn came through after your delivery. You can buy the original SAKO-85 "
				.. "and Winchester 1895 from me now. Come see which one suits you.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_2211", {
	name = "Kitting Up 2.2.1.1",
	description = "Help Haggler trade for some old Russian surplus.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "mosin", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "hagglerItemDelivery_22111" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"My Russian supplier has a two part shipment. The first "
			.. "is to trade for the Mosin-Nagant; it's so goddamn prominent "
			.. "that I don't need to give you an introduction. He's a technician, "
			.. "so he's asking for some paracord and a wireless transmitter; "
			.. "where the latter request comes from, I have no goddamn "
			.. "idea.\n\nREQUIRED ITEMS:"
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
		{ pool = "field_maintenance", quantity = 2 },
		{ pool = "consumer_electronics", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, your help got the Mosins here. I'll sell you one now. If you want to work on "
				.. "the second part of the shipment, I've got another job for you too.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_22111", {
	name = "Kitting Up 2.2.1.1.1",
	description = "Help Haggler finish his surplus trade.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "svt40", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Right, part two of the shipment. Bolt actions are all well "
			.. "and good, but semi autos with a magazine are even better. "
			.. "He's asking for an entire shipment of glue for repairs "
			.. "for the second half, so this is gonna take a lot of time "
			.. "but I think you'll appreciate the results.\n\nREQUIRED "
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
		{ pool = "adhesives", quantity = 3 },
		{ pool = "repair_electrical", quantity = 2 },
		{ pool = "workshop_supplies", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, your last delivery got the SVT-40s through. You can buy them from me now. "
				.. "That's probably the last my Russian supplier can manage for a while.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_222", {
	name = "Kitting Up 2.2.2",
	description = "Help Haggler refurbish some old SMGs.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "mp40", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "hagglerItemDelivery_2221" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"So, you've probably run into a MP40 or two in your time "
			.. "here. Now that we've got more ubiquitous 9x19 floating "
			.. "around, I think it may be time to start selling them myself. "
			.. "I'm gonna need some nails to build a new table and enough "
			.. "tools to start manufacturing everything I need.\n\nREQUIRED "
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
		{ pool = "basic_tools", quantity = 1 },
		{ pool = "workshop_supplies", quantity = 2 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, your tools got the MP40 repair bench working. I'll sell you the restored guns "
				.. "now. Come see what a little work can do for old steel.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_2221", {
	name = "Kitting Up 2.2.2.1",
	description = "Help Haggler make a deal with the Ukrainian Army.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "aks74u", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "hagglerItemDelivery_22211" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"After all this bullshit, it's finally time; it's finally "
			.. "time to start dealing in assault rifles. I've got a line "
			.. "through my Ukrainian contact on a batch of AKS-74u carbines "
			.. "taken directly from Ukrainian army stores that got here "
			.. "into the Zone. I'm not making the same mistake that I did "
			.. "with the SKS shipment; no fucking cosmoline for me. This "
			.. "is a personal request; bring me all the shit I need to "
			.. "clean them off and I'll start forking them out.\n\nREQUIRED "
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
		{ pool = "maintenance", quantity = 3 },
		{ pool = "powder", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, the SBU sent the AKS-74u crate after your delivery. I'll sell you one now. "
				.. "Come talk prices before my contact starts asking awkward questions.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("hagglerItemDelivery_22211", {
	name = "Kitting Up 2.2.2.1.1",
	description = "Help Haggler complete his shop.",
	keyNpc = "'Haggler'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Haggler'", args = { "akm", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"We've had a long and prosperous relationship together, "
			.. "stalker, and I'm running out of room to put things here. "
			.. "I've got one final job from my Ukrainian contacts that "
			.. "I'm wrapping up; this time, ironically enough, the UKM "
			.. "is asking for the cleaning materials. Let them do all the "
			.. "hard work, I say.\n\nREQUIRED ITEMS:"
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
		{ pool = "maintenance", quantity = 3 },
		{ pool = "fuel", quantity = 2 },
		{ pool = "repair_electrical", quantity = 2 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Haggler'"
			local message = string.format(
				"%s, you held up your end all the way through. I'll sell you the AKMs now. That's "
				.. "the best I can get for a while, so come see me if you want one.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})
