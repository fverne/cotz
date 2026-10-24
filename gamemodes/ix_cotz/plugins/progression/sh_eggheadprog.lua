local MAP = "rp_marsh_cs"

ix.progression.Register("eggheadItemDelivery_Detector1", {
	name = "Detecting Anomalous Materials Part 1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Egghead'",
	defaultActive = true,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Egghead'", args = { "detectorecho", nil, 10, "SELLANDBUY", 10, 1, 10 } },
	},
	nextProgressions = {
		"eggheadItemDelivery_Detector2",
		"eggheadItemDelivery_Suit1",
		"eggheadItemDelivery_Aid1",
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = "## PLACEHOLDER ## - Unlocks Echo Detector:\n"

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
		{ pool = "common_artifacts", quantity = 1 },
		{ pool = "electrical_artifacts", quantity = 1 },
		{ pool = "chemical_artifacts", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Egghead'"
			local message = (
				"I've had a breakthrough! It is now possible to detect anomalous "
				.. "substances, come by and pick up a detector!"
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("eggheadItemDelivery_Detector2", {
	name = "Detecting Anomalous Materials Part 2",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Egghead'",
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Egghead'", args = { "detectorbear", nil, 10, "SELLANDBUY", 10, 1, 10 } },
	},
	nextProgressions = { "eggheadItemDelivery_Detector3" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = "## PLACEHOLDER ## - Unlocks Bear Detector:\n"

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
		{ pool = "rare_field_artifacts", quantity = 1 },
		{ pool = "rare_electrical_artifacts", quantity = 1 },
		{ pool = "chemical_artifacts", quantity = 1 },
		{ pool = "gravitational_artifacts", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Egghead'"
			local message = (
				"Thanks to your dilligence, I was able to improve on the "
				.. "design of the detectors, allowing one to more accurately "
				.. "pinpoint the location. Oh, and the new detectors are of "
				.. "course for sale."
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("eggheadItemDelivery_Detector3", {
	name = "Detecting Anomalous Materials Part 3",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Egghead'",
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Egghead'", args = { "detectorveles", nil, 10, "SELLANDBUY", 10, 1, 10 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = "## PLACEHOLDER ## - Unlocks Veles Detector:\n"

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
		{ pool = "exceptional_artifacts", quantity = 1 },
		{ pool = "bubble_artifacts", quantity = 1 },
		{ pool = "burner_artifacts", quantity = 1 },
		{ pool = "rare_electrical_artifacts", quantity = 1 },
		{ pool = "chemical_artifacts", quantity = 1 },
		{ pool = "gravitational_artifacts", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Egghead'"
			local message = (
				"I was able to improve on the design of the detectors, allowing "
				.. "one to more precisely pinpoint the location."
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("eggheadItemDelivery_Suit1", {
	name = "Anomalous Protection Part 1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Egghead'",
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Egghead'", args = { "suit_ssp99", nil, 10, "SELLANDBUY", 10, 1, 10 } },
	},
	nextProgressions = { "eggheadItemDelivery_Suit2" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = "## PLACEHOLDER ## - Unlocks SSP99:\n"

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
		{ pool = "predator_hides", quantity = 1 },
		{ pool = "common_hides", quantity = 1 },
		{ pool = "common_parts", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Egghead'"
			local message = "## PLACEHOLDER ## - SSP99 unlocked."
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("eggheadItemDelivery_Suit2", {
	name = "Anomalous Protection Part 2",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Egghead'",
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Egghead'", args = { "suit_ssp99m", nil, 10, "SELLANDBUY", 10, 1, 10 } },
	},
	nextProgressions = { "eggheadItemDelivery_Suit3" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = "## PLACEHOLDER ## - Unlocks SSP99m:\n"

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
		{ pool = "predator_hides", quantity = 1 },
		{ pool = "elite_hides", quantity = 1 },
		{ pool = "exotic_parts", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Egghead'"
			local message = "## PLACEHOLDER ## - SSP99m unlocked."
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("eggheadItemDelivery_Suit3", {
	name = "Anomalous Protection Part 3",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Egghead'",
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Egghead'", args = { "suit_seva", nil, 10, "SELLANDBUY", 10, 1, 10 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = "## PLACEHOLDER ## - Unlocks SEVA:\n"

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
		{ pool = "predator_hides", quantity = 1 },
		{ pool = "brains", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Egghead'"
			local message = "## PLACEHOLDER ## - SEVA unlocked."
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("eggheadItemDelivery_Aid1", {
	name = "Scientific Aid Part 1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Egghead'",
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Egghead'", args = { "medic_stimpak_1", nil, 10, "SELLANDBUY", 10, 1, 10 } },
		{ npc = "'Egghead'", args = { "medic_antirad_2", nil, 10, "SELLANDBUY", 10, 1, 10 } },
		{ npc = "'Egghead'", args = { "medic_psyheal_2", nil, 10, "SELLANDBUY", 10, 1, 10 } },
	},
	nextProgressions = { "eggheadItemDelivery_Aid2" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = ("## PLACEHOLDER ## - Unlocks Stimpak MkI, Antiradiation " .. "Drugs, Psyheal Drugs:\n")

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
		{ pool = "exotic_parts", quantity = 2 },
		{ pool = "chemical_artifacts", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Egghead'"
			local message = (
				"## PLACEHOLDER ## - Stimpak MkI, Antiradiation Drugs, Psyheal " .. "Drugs unlocked."
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("eggheadItemDelivery_Aid2", {
	name = "Scientific Aid Part 2",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Egghead'",
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Egghead'", args = { "medic_stimpak_2", nil, 10, "SELLANDBUY", 10, 1, 10 } },
		{ npc = "'Egghead'", args = { "medic_antipsychotic_2", nil, 10, "SELLANDBUY", 10, 1, 10 } },
	},
	nextProgressions = { "eggheadItemDelivery_Aid3" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = "## PLACEHOLDER ## - Unlocks Stimpak MkII, Psyblock Drugs:\n"

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
		{ pool = "exotic_parts", quantity = 2 },
		{ pool = "rare_electrical_artifacts", quantity = 2 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Egghead'"
			local message = "## PLACEHOLDER ## - Stimpak MkII, Psyblock Drugs unlocked."
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("eggheadItemDelivery_Aid3", {
	name = "Scientific Aid Part 3",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Egghead'",
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Egghead'", args = { "medic_stimpak_3", nil, 10, "SELLANDBUY", 10, 1, 10 } },
		{ npc = "'Egghead'", args = { "medic_antipsychotic_3", nil, 10, "SELLANDBUY", 10, 1, 10 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = "## PLACEHOLDER ## - Unlocks Stimpak MkIII, Psyblock Drugs:\n"

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
		{ pool = "brains", quantity = 1 },
		{ pool = "rare_field_artifacts", quantity = 1 },
		{ pool = "exceptional_electrical_artifacts", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Egghead'"
			local message = "## PLACEHOLDER ## - Stimpak MkIII, Psyblock Drugs unlocked."
			ix.progression.Notify(character, name, message)
		end)
	end,
})
