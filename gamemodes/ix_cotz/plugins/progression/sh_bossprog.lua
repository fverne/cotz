local MAP = "rp_waystation"

ix.progression.Register("bossItemDelivery_1", {
	name = "Cleaning Inventory 1",
	description = "Help Boss amass parts.",
	keyNpc = "'Boss'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Boss'", args = { "suit_io7a", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "bossItemDelivery_2" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I have a ton of stockpile sitting here collecting dust "
			.. "in the research station. I'm willing to sell some to you "
			.. "if you help me out. First is the IO7a, a basic vest and uniform. "
			.. "It's budget protection, not an upgrade over the heavier suits Technut sells.\n\nREQUIRED ITEMS:"
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
		{ pool = "common_parts", quantity = 6 },
	},
	OnComplete = function(character)
		timer.Simple(15, function()
			local name = "'Boss'"
			local message = string.format(
				"%s, you delivered. I'll sell you the IO7a suits now. Bring the money when you're "
				.. "ready.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("bossItemDelivery_2", {
	name = "Cleaning Inventory 2",
	description = "Help Boss amass parts.",
	keyNpc = "'Boss'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Boss'", args = { "suit_ps5m", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "bossItemDelivery_3" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I have more suits in my stockpile. Next up is a lightweight "
			.. "Universal Protection Suit.\n\nREQUIRED ITEMS:"
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
		{ pool = "small_parts", quantity = 10 },
		{ pool = "common_parts", quantity = 12 },
	},
	OnComplete = function(character)
		timer.Simple(15, function()
			local name = "'Boss'"
			local message = string.format(
				"%s, you've held up your end. The PS5M suits are open to you now. See me if you "
				.. "want to buy one.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("bossItemDelivery_3", {
	name = "Cleaning Inventory 3",
	description = "Help Boss amass parts.",
	keyNpc = "'Boss'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Boss'", args = { "suit_berill", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "bossItemDelivery_4" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I have more suits in my stockpile. Next up is the military "
			.. "standard issue Berill-5M.\n\nREQUIRED ITEMS:"
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
		{ pool = "rare_parts", quantity = 3 },
		{ pool = "small_parts", quantity = 8 },
		{ pool = "humanoid_parts", quantity = 5 },
		{ pool = "common_meat", quantity = 13 },
	},
	OnComplete = function(character)
		timer.Simple(15, function()
			local name = "'Boss'"
			local message = string.format(
				"%s, good work. You've earned access to my Berill-5M suits. Protection costs money; "
				.. "you know where to find me.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("bossItemDelivery_4", {
	name = "Cleaning Inventory 4",
	description = "Help Boss amass parts.",
	keyNpc = "'Boss'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Boss'", args = { "suit_skat10", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "bossItemDelivery_5" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I have more suits in my stockpile. Next up is the prototype " .. "Skat10.\n\nREQUIRED ITEMS:"
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
		{ pool = "exotic_parts", quantity = 5 },
		{ pool = "large_parts", quantity = 6 },
		{ pool = "humanoid_parts", quantity = 5 },
		{ pool = "common_meat", quantity = 13 },
		{ pool = "common_hides", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(15, function()
			local name = "'Boss'"
			local message = string.format(
				"%s, I can count on you. I'll sell you a Skat-10 armoured suit now. Come prepared "
				.. "to pay for it.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("bossItemDelivery_5", {
	name = "Cleaning Inventory 5",
	description = "Help Boss amass parts.",
	keyNpc = "'Boss'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Boss'", args = { "suit_skat9", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "bossItemDelivery_6" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I have more suits in my stockpile. Next up is the exclusive " .. "Skat9.\n\nREQUIRED ITEMS:"
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
		{ pool = "elite_parts", quantity = 3 },
		{ pool = "chimera_part", quantity = 5 },
		{ pool = "exotic_parts", quantity = 5 },
		{ pool = "large_parts", quantity = 6 },
		{ pool = "common_meat", quantity = 15 },
		{ pool = "common_hides", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(15, function()
			local name = "'Boss'"
			local message = string.format(
				"%s, you've earned a place among my serious customers. I'll sell you the Skat-9 "
				.. "suits. Make the protection count.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("bossItemDelivery_6", {
	name = "Cleaning Inventory 6",
	description = "Help Boss amass parts.",
	keyNpc = "'Boss'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Boss'", args = { "suit_radsuit", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Boss'", args = { "headwear_rad", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = { "bossItemDelivery_7" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = ("I have more suits in my stockpile. Next up is the Radsuit.\n\nREQUIRED " .. "ITEMS:")

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
		{ pool = "brains", quantity = 2 },
		{ pool = "elite_parts", quantity = 3 },
		{ pool = "rare_parts", quantity = 3 },
		{ pool = "exotic_parts", quantity = 5 },
		{ pool = "common_meat", quantity = 16 },
		{ pool = "common_hides", quantity = 3 },
		{ pool = "predator_hides", quantity = 2 },
	},
	OnComplete = function(character)
		timer.Simple(15, function()
			local name = "'Boss'"
			local message = string.format(
				"%s, our arrangement now includes radsuits. Come see me if you want to buy one "
				.. "before your next trip.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("bossItemDelivery_7", {
	name = "Cleaning Inventory 7",
	description = "Help Boss amass parts.",
	keyNpc = "'Boss'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Boss'", args = { "suit_exoskeleton", nil, 1, "SELLANDBUY", 1, 48, 1 } },
		{ npc = "'Boss'", args = { "headwear_spartan", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = ("I have one last suit in my repository - the exoskeleton. " .. "\n\nREQUIRED ITEMS:")

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
		{ pool = "elite_parts", quantity = 4 },
		{ pool = "hellhound_part", quantity = 12 },
		{ pool = "brains", quantity = 2 },
		{ pool = "large_parts", quantity = 8 },
		{ pool = "common_meat", quantity = 18 },
		{ pool = "common_hides", quantity = 3 },
		{ pool = "predator_hides", quantity = 2 },
		{ pool = "elite_hides", quantity = 2 },
	},
	OnComplete = function(character)
		timer.Simple(15, function()
			local name = "'Boss'"
			local message = string.format(
				"%s, you've proved reliable enough for my best equipment. I'll sell you "
				.. "exoskeletons and prototype Spartan helmets. Bring serious money.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})
