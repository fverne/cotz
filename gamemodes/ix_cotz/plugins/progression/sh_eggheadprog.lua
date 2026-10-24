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
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["artifact_bolt"] = 5,
			["artifact_bonecluster"] = 1,
			["artifact_mementomori"] = 1,
		}

		return itemIDs
	end,
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
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["artifact_crystal"] = 5,
			["artifact_mamasbeads"] = 5,
			["artifact_capacitor"] = 1,
			["artifact_panacea"] = 4,
			["artifact_moonlight"] = 2,
		}

		return itemIDs
	end,
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
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["artifact_gmamasbeads"] = 4,
			["artifact_galaxy"] = 4,
			["artifact_arachno"] = 4,
			["artifact_halo"] = 2,
			["artifact_gaia"] = 3,
			["artifact_midas"] = 1,
		}

		return itemIDs
	end,
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
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["hide_pseudodog"] = 5,
			["hide_cat"] = 10,
			["hide_blinddog"] = 10,
		}

		return itemIDs
	end,
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
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["hide_bloodsucker"] = 5,
			["hide_vareshka"] = 5,
			["hide_chimera"] = 5,
			["hide_controller"] = 5,
		}

		return itemIDs
	end,
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
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["hide_pseudogiant"] = 5,
			["hide_electrocontroller"] = 5,
			["hide_karlik"] = 10,
		}

		return itemIDs
	end,
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
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["part_swampcontroller_2"] = 3,
			["part_tark"] = 15,
			["part_sprig"] = 15,
			["part_spider"] = 20,
			["part_snork_2"] = 5,
			["part_cat"] = 20,
		}

		return itemIDs
	end,
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
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["part_controller_2"] = 4,
			["part_vareshka"] = 20,
			["part_skeleton"] = 20,
			["part_karlik_2"] = 3,
			["part_burer_2"] = 4,
			["part_pseudodog"] = 30,
		}

		return itemIDs
	end,
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
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

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
	GetItemIds = function()
		local itemIDs = {
			["part_pseudogiant"] = 20,
			["part_electrocontroller_2"] = 4,
			["part_chimera"] = 40,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Egghead'"
			local message = "## PLACEHOLDER ## - Stimpak MkIII, Psyblock Drugs unlocked."
			ix.progression.Notify(character, name, message)
		end)
	end,
})
