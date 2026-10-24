local MAP = "rp_waystation"

ix.progression.Register("bossItemDelivery_1", {
	name = "Cleaning Inventory 1",
	description = "Help Boss amass parts.",
	keyNpc = "'Boss'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Boss'", args = { "suit_io7a", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	nextProgressions = { "bossItemDelivery_2" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I have a ton of stockpile sitting here collecting dust "
			.. "in the research station. I'm willing to sell some to you "
			.. "if you help me out. First off the bat is a mercenary suit.\n\nREQUIRED "
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
		{ pool = "common_parts", quantity = 1 },
		{ pool = "small_parts", quantity = 1 },
		{ pool = "humanoid_parts", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(15, function()
			local name = "'Boss'"
			local message = "IO7a's now available for purchase."
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
		{ npc = "'Boss'", args = { "suit_ps5m", nil, 5, "SELLANDBUY", 5, 1, 5 } },
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
		{ pool = "small_parts", quantity = 1 },
		{ pool = "common_parts", quantity = 1 },
		{ pool = "large_parts", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(15, function()
			local name = "'Boss'"
			local message = "PS5M's now available for purchase."
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
		{ npc = "'Boss'", args = { "suit_berill", nil, 5, "SELLANDBUY", 5, 1, 5 } },
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
		{ pool = "rare_parts", quantity = 1 },
		{ pool = "small_parts", quantity = 1 },
		{ pool = "humanoid_parts", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(15, function()
			local name = "'Boss'"
			local message = "Berill-5M's now available for purchase."
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
		{ npc = "'Boss'", args = { "suit_skat10", nil, 5, "SELLANDBUY", 5, 1, 5 } },
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
		{ pool = "exotic_parts", quantity = 2 },
		{ pool = "large_parts", quantity = 1 },
		{ pool = "humanoid_parts", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(15, function()
			local name = "'Boss'"
			local message = "Skat-10 Armoured Suits are now available for purchase."
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
		{ npc = "'Boss'", args = { "suit_skat9", nil, 5, "SELLANDBUY", 5, 1, 5 } },
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
		{ pool = "elite_parts", quantity = 1 },
		{ pool = "chimera_part", quantity = 1 },
		{ pool = "exotic_parts", quantity = 1 },
		{ pool = "large_parts", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(15, function()
			local name = "'Boss'"
			local message = "Skat-9 Armoured Suits are now available for purchase."
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
		{ npc = "'Boss'", args = { "suit_radsuit", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Boss'", args = { "headwear_rad", nil, 5, "SELLANDBUY", 5, 1, 5 } },
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
		{ pool = "brains", quantity = 1 },
		{ pool = "elite_parts", quantity = 1 },
		{ pool = "rare_parts", quantity = 1 },
		{ pool = "exotic_parts", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(15, function()
			local name = "'Boss'"
			local message = "Radsuits are now available for purchase."
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
		{ npc = "'Boss'", args = { "suit_exoskeleton", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Boss'", args = { "headwear_spartan", nil, 5, "SELLANDBUY", 5, 1, 5 } },
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
		{ pool = "elite_parts", quantity = 1 },
		{ pool = "hellhound_part", quantity = 1 },
		{ pool = "brains", quantity = 1 },
		{ pool = "large_parts", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(15, function()
			local name = "'Boss'"
			local message = "Exoskeletons and protoype Spartan helmets are now available for purchase."
			ix.progression.Notify(character, name, message)
		end)
	end,
})
