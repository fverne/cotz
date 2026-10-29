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
	nextProgressions = {"bossItemDelivery_2_stage1"},
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

ix.progression.Register("bossItemDelivery_2_stage1", {
	name = "Cleaning Inventory 2 - 1/2",
	description = "Cleaning Inventory 2 - 1/2",
	keyNpc = "'Boss'",
	progMap = "rp_waystation",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "small_parts", quantity = 22},
	},
	nextProgressions = {"bossItemDelivery_2"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "bossItemDelivery_2",
	stageIndex = 1,
	stageCount = 2,
	briefing = (
		"Better protection is an investment in someone who comes back. Bring the first field "
		.. "specimens; the armour authorisation waits on the rest of the proof."
	),
	completionMessage = "That delivery is accounted for. Keep your next operation disciplined.",
})

ix.progression.Register("bossItemDelivery_2", {
	name = "Cleaning Inventory 2",
	description = "Help Boss amass parts.",
	keyNpc = "'Boss'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Boss'", args = {"suit_ps5m", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	nextProgressions = {"bossItemDelivery_3_stage1"},
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
		{pool = "small_parts", quantity = 2},
		{pool = "common_parts", quantity = 30},
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
	milestoneGroup = "bossItemDelivery_2",
	stageIndex = 2,
	stageCount = 2,
})

ix.progression.Register("bossItemDelivery_3_stage1", {
	name = "Cleaning Inventory 3 - 1/2",
	description = "Cleaning Inventory 3 - 1/2",
	keyNpc = "'Boss'",
	progMap = "rp_waystation",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "common_meat", quantity = 42},
	},
	nextProgressions = {"bossItemDelivery_3"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "bossItemDelivery_3",
	stageIndex = 1,
	stageCount = 2,
	briefing = (
		"Before I commit heavier equipment, I need the support shipment covered. Feed the "
		.. "field team first. Then we'll finish the protection requisition."
	),
	completionMessage = "That delivery is accounted for. Keep your next operation disciplined.",
})

ix.progression.Register("bossItemDelivery_3", {
	name = "Cleaning Inventory 3",
	description = "Help Boss amass parts.",
	keyNpc = "'Boss'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Boss'", args = {"suit_berill", nil, 1, "SELLANDBUY", 1, 48, 1}},
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
		{pool = "common_meat", quantity = 3},
		{pool = "small_parts", quantity = 28},
		{pool = "humanoid_parts", quantity = 17},
		{pool = "rare_parts", quantity = 10},
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
	milestoneGroup = "bossItemDelivery_3",
	stageIndex = 2,
	stageCount = 2,
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
		{ pool = "exotic_parts", quantity = 20 },
		{ pool = "large_parts", quantity = 24 },
		{ pool = "humanoid_parts", quantity = 20 },
		{ pool = "common_meat", quantity = 52 },
		{ pool = "common_hides", quantity = 12 },
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
	nextProgressions = {"bossItemDelivery_6_stage1"},
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
		{ pool = "elite_parts", quantity = 13 },
		{ pool = "chimera_part", quantity = 22 },
		{ pool = "exotic_parts", quantity = 22 },
		{ pool = "large_parts", quantity = 27 },
		{ pool = "common_meat", quantity = 67 },
		{ pool = "common_hides", quantity = 13 },
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

ix.progression.Register("bossItemDelivery_6_stage1", {
	name = "Cleaning Inventory 6 - 1/2",
	description = "Cleaning Inventory 6 - 1/2",
	keyNpc = "'Boss'",
	progMap = "rp_waystation",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "common_meat", quantity = 70},
	},
	nextProgressions = {"bossItemDelivery_6"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "bossItemDelivery_6",
	stageIndex = 1,
	stageCount = 2,
	vendorUnlocks = {
		{npc = "'Boss'", args = {"headwear_rad", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"Radiation doesn't care how thick your armour is. Keep the field team fed while I "
		.. "check the headgear seals. The suit comes after the remaining inspection."
	),
	completionMessage = "That delivery is accounted for. Keep your next operation disciplined.",
})

ix.progression.Register("bossItemDelivery_6", {
	name = "Cleaning Inventory 6",
	description = "Help Boss amass parts.",
	keyNpc = "'Boss'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Boss'", args = {"suit_radsuit", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	nextProgressions = {"bossItemDelivery_7_stage1"},
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
		{pool = "common_meat", quantity = 10},
		{pool = "brains", quantity = 10},
		{pool = "elite_parts", quantity = 15},
		{pool = "rare_parts", quantity = 15},
		{pool = "exotic_parts", quantity = 25},
		{pool = "common_hides", quantity = 15},
		{pool = "predator_hides", quantity = 10},
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
	milestoneGroup = "bossItemDelivery_6",
	stageIndex = 2,
	stageCount = 2,
})

ix.progression.Register("bossItemDelivery_7_stage1", {
	name = "Cleaning Inventory 7 - 1/2",
	description = "Cleaning Inventory 7 - 1/2",
	keyNpc = "'Boss'",
	progMap = "rp_waystation",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "common_meat", quantity = 99},
		{pool = "elite_parts", quantity = 11},
	},
	nextProgressions = {"bossItemDelivery_7"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "bossItemDelivery_7",
	stageIndex = 1,
	stageCount = 2,
	vendorUnlocks = {
		{npc = "'Boss'", args = {"headwear_spartan", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"An exoskeleton is only useful if the operator survives the first hit. Prove you can "
		.. "support a field unit, and I'll authorise the Spartan helmet first."
	),
	completionMessage = "That delivery is accounted for. Keep your next operation disciplined.",
})

ix.progression.Register("bossItemDelivery_7", {
	name = "Cleaning Inventory 7",
	description = "Help Boss amass parts.",
	keyNpc = "'Boss'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Boss'", args = {"suit_exoskeleton", nil, 1, "SELLANDBUY", 1, 48, 1}},
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
		{pool = "elite_parts", quantity = 11},
		{pool = "hellhound_part", quantity = 66},
		{pool = "brains", quantity = 11},
		{pool = "large_parts", quantity = 44},
		{pool = "common_hides", quantity = 16},
		{pool = "predator_hides", quantity = 11},
		{pool = "elite_hides", quantity = 11},
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
	milestoneGroup = "bossItemDelivery_7",
	stageIndex = 2,
	stageCount = 2,
})
