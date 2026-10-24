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
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["part_boar"] = 15,
			["part_blinddog"] = 15,
		}

		return itemIDs
	end,
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
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["part_cat"] = 20,
			["part_flesh"] = 20,
		}

		return itemIDs
	end,
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
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["part_snork_2"] = 20,
			["part_zombie_2"] = 20,
		}

		return itemIDs
	end,
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
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["part_tark"] = 25,
			["part_sprig"] = 25,
		}

		return itemIDs
	end,
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
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["part_controller_1"] = 30,
			["part_chimera"] = 30,
		}

		return itemIDs
	end,
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
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["part_controller_2"] = 5,
			["part_pseudogiant"] = 30,
		}

		return itemIDs
	end,
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
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["part_electrocontroller_1"] = 10,
			["part_hellhound"] = 35,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(15, function()
			local name = "'Boss'"
			local message = "Exoskeletons and protoype Spartan helmets are now available for purchase."
			ix.progression.Notify(character, name, message)
		end)
	end,
})
