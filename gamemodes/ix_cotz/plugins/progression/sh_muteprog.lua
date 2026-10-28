local MAP = "rp_marsh_cs"

ix.progression.Register("muteItemDelivery_Binoc1", {
	name = "Looking ahead 1",
	description = "Mute eyes you expectantly.",
	keyNpc = "'Mute'",
	defaultActive = true,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Mute'", args = { "binoculars_2", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = {
		"muteItemDelivery_Binoc2",
		"muteItemDelivery_Anomaly",
		"muteItemDelivery_BlowoutWarning",
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Mute makes a series of frantic gestures before shoving "
			.. "a drawing of a set of binoculars into your hands.\n\nREQUIRED "
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
		{ pool = "basic_tools", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "Ilyuha Hobo"
			local message = string.format(
				"%s, Ilyuha Hobo here. Mute wanted you to know he'll sell you binoculars now. Seems "
				.. "your delivery made an impression; go see him if you want a pair.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("muteItemDelivery_Binoc2", {
	name = "Looking ahead 2",
	description = "Mute's eyes haven't left his binoculars since the moment you came in.",
	keyNpc = "'Mute'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Mute'", args = { "binoculars_1", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = {"muteItemDelivery_Binoc3_stage1", "muteItemDelivery_Broadcast_stage1"},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Mute tries and fails to articulate a concept before pointing "
			.. "to a pair of binoculars with a smiley face on them. It "
			.. "seems he wants to improve them.\n\nREQUIRED ITEMS:"
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
		{ pool = "industrial_supplies", quantity = 2 },
		{ pool = "workshop_supplies", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "Ilyuha Hobo"
			local message = string.format(
				"%s, it's Ilyuha again. Mute's letting you buy his rangefinding binoculars after "
				.. "that last delivery. Might save you guessing how far away those teeth are.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("muteItemDelivery_Binoc3_stage1", {
	name = "Looking ahead 3 - 1/2",
	description = "Looking ahead 3 - 1/2",
	keyNpc = "'Mute'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 1,
	requirementSlots = {
		{pool = "small_electronics", quantity = 3},
	},
	nextProgressions = {"muteItemDelivery_Binoc3"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "muteItemDelivery_Binoc3",
	stageIndex = 1,
	stageCount = 2,
	briefing = (
		"Better glass. Needs working electronics first. Bring the listed components. The rest "
		.. "of the assembly comes after."
	),
	completionMessage = "Received. Useful. Check what you still need for the next job.",
})

ix.progression.Register("muteItemDelivery_Binoc3", {
	name = "Looking ahead 3",
	description = "Mute's hands are twitchier as he works on a diagram.",
	keyNpc = "'Mute'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Mute'", args = {"binoculars_4", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	nextProgressions = {"muteItemDelivery_Binoc4_stage1"},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Mute simply points at a drawing on the table beside him. "
			.. "It appears to be the technical specs for a new set of binoculars "
			.. "and the materials list needed for them.\n\nREQUIRED ITEMS:"
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
		{pool = "workshop_supplies", quantity = 1},
		{pool = "repair_electrical", quantity = 1},
		{pool = "advanced_parts_map1", quantity = 1},
		{pool = "documents_technical", quantity = 1},
		{pool = "industrial_supplies", quantity = 1},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "Ilyuha Hobo"
			local message = string.format(
				"%s, Ilyuha here. Mute has the stronger binoculars ready for you to buy. You've "
				.. "earned a better look at whatever's waiting out there.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "muteItemDelivery_Binoc3",
	stageIndex = 2,
	stageCount = 2,
})

ix.progression.Register("muteItemDelivery_Binoc4_stage1", {
	name = "Looking ahead 4 - 1/2",
	description = "Looking ahead 4 - 1/2",
	keyNpc = "'Mute'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "small_electronics", quantity = 3},
		{pool = "workshop_supplies", quantity = 2},
		{pool = "batteries", quantity = 2},
	},
	nextProgressions = {"muteItemDelivery_Binoc4"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "muteItemDelivery_Binoc4",
	stageIndex = 1,
	stageCount = 2,
	briefing = (
		"Longer observation. More preparation. Components, workshop supplies, batteries. Bring "
		.. "those first; don't expect the final instrument unfinished."
	),
	completionMessage = "Received. Useful. Check what you still need for the next job.",
})

ix.progression.Register("muteItemDelivery_Binoc4", {
	name = "Looking ahead 4",
	description = (
		"Mute is busy tinkering with a pair of binoculars using " .. "some kind of electronic device"
	),
	keyNpc = "'Mute'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Mute'", args = {"binoculars_3", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Mute gestures toward his workbench, where a set of binoculars "
			.. "is partially disassembled. It looks like he's making his "
			.. "magnum opus. Maybe you could help him out?\n\nREQUIRED "
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
		{pool = "batteries", quantity = 4},
		{pool = "consumer_electronics", quantity = 2},
		{pool = "repair_electrical", quantity = 2},
		{pool = "advanced_parts", quantity = 1},
		{pool = "industrial_supplies", quantity = 1},
		{pool = "documents_technical", quantity = 1},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "Vadim Nasty"
			local message = string.format(
				"%s, Vadim Nasty here with Mute. Your delivery got you access to his night vision "
				.. "binoculars. Come buy a pair if you'd rather see what moves in the dark.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "muteItemDelivery_Binoc4",
	stageIndex = 2,
	stageCount = 2,
})

ix.progression.Register("muteItemDelivery_Anomaly", {
	name = "Anomaly Detector",
	description = "Mute is busy drawing pictures of anomalies.",
	keyNpc = "'Mute'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Mute'", args = { "anomalydetector", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = {"muteItemDelivery_Detector_stage1"},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Mute motions toward a disassembled geiger counter on his "
			.. "desk alongside pictures and crude sketches of various anomalies. "
			.. "Could he be building a detector of some variety?\n\nREQUIRED "
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
		{ pool = "basic_tools", quantity = 2 },
		{ pool = "small_electronics", quantity = 4 },
		{ pool = "electrical_artifacts", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "Ilyuha Hobo"
			local message = string.format(
				"%s, Ilyuha here. Mute says you can buy an anomaly detector from him now. Mine "
				.. "saved my bacon earlier; I'd take him up on it.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("muteItemDelivery_Detector_stage1", {
	name = "Echo Detector - 1/2",
	description = "Echo Detector - 1/2",
	keyNpc = "'Mute'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 1,
	requirementSlots = {
		{pool = "small_electronics", quantity = 3},
		{pool = "workshop_supplies", quantity = 2},
	},
	nextProgressions = {"muteItemDelivery_Detector"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "muteItemDelivery_Detector",
	stageIndex = 1,
	stageCount = 2,
	briefing = (
		"Sensing a disturbance isn't the same as finding its source. Bring the components for "
		.. "the calibration rig. Then the detector work can begin."
	),
	completionMessage = "Received. Useful. Check what you still need for the next job.",
})

ix.progression.Register("muteItemDelivery_Detector", {
	name = "Echo Detector",
	description = "Mute is busy drawing pictures of artifacts.",
	keyNpc = "'Mute'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Mute'", args = {"detectorecho", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Apparently the last detector was not enough. Mute is making "
			.. "various gestures on how he would be able to reverse engineer "
			.. "detectors to make his own, in order to detect artifacts.\n\nREQUIRED "
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
		{pool = "batteries", quantity = 5},
		{pool = "repair_electrical", quantity = 1},
		{pool = "industrial_supplies", quantity = 1},
		{pool = "detector", quantity = 1},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "Vadim Nasty"
			local message = string.format(
				"%s, Vadim here. Mute will sell you an artifact detector now, thanks to your help. "
				.. "Mine paid for itself already. Go see him if you want to try your luck.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "muteItemDelivery_Detector",
	stageIndex = 2,
	stageCount = 2,
})

ix.progression.Register("muteItemDelivery_Broadcast_stage1", {
	name = "Keeping tabs - 1/2",
	description = "Keeping tabs - 1/2",
	keyNpc = "'Mute'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 1,
	requirementSlots = {
		{pool = "small_electronics", quantity = 3},
	},
	nextProgressions = {"muteItemDelivery_Broadcast"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "muteItemDelivery_Broadcast",
	stageIndex = 1,
	stageCount = 2,
	briefing = (
		"A message is useless if nobody hears it. Electronics first. The expensive broadcast "
		.. "parts stay on the final installation list."
	),
	completionMessage = "Received. Useful. Check what you still need for the next job.",
})

ix.progression.Register("muteItemDelivery_Broadcast", {
	name = "Keeping tabs",
	description = "Mute is working on a server box.",
	keyNpc = "'Mute'",
	defaultActive = false,
	progMap = MAP,
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Mute shoves some kind of blueprint in your face. It looks "
			.. "really complicated, but whatever it is might be useful "
			.. "to help him build.\n\nREQUIRED ITEMS:"
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
		{pool = "consumer_electronics", quantity = 1},
		{pool = "repair_electrical", quantity = 1},
		{pool = "documents_technical", quantity = 1},
		{pool = "industrial_supplies", quantity = 1},
		{pool = "specialty_tools", quantity = 1},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Mute'"
			local message = string.format(
				"%s. Your access to mutant tracking is enabled. Check your PDA.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "muteItemDelivery_Broadcast",
	stageIndex = 2,
	stageCount = 2,
	vendorUnlocks = {
	},
})

ix.progression.Register("muteItemDelivery_BlowoutWarning", {
	name = "Blowout scanning",
	description = "Mute is working on advanced scanning hardware.",
	keyNpc = "'Mute'",
	defaultActive = false,
	progMap = MAP,
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Mute shoves some kind of schematics towards you. It looks "
			.. "like some kind of advanced scanner, maybe for blowouts?.\n\nREQUIRED "
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
		{ pool = "consumer_electronics", quantity = 3 },
		{ pool = "small_electronics", quantity = 4 },
		{ pool = "repair_electrical", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Mute'"
			local message = string.format(
				"%s. Your access to blowout warnings is enabled. Watch your PDA.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})
