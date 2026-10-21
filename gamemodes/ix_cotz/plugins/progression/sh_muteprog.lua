local map = "rp_marsh_cs"

ix.progression.Register("muteItemDelivery_Binoc1", {
	name = "Looking ahead 1",
	description = "Mute eyes you expectantly.",
	keyNpc = "'Mute'",
	defaultActive = true,
	progMap = map,
	vendorUnlocks = {
		{npc = "'Mute'", args = {"binoculars_2", nil, 5, "SELLANDBUY", 5, 1, 5}}
	},
	nextProgressions = {"muteItemDelivery_Binoc2", "muteItemDelivery_Anomaly", "muteItemDelivery_BlowoutWarning"},
	BuildResponse = function(self, npcname, status)
		local dat = status or {}

		local itemids = self:GetItemIds()

		local str = "Mute makes a series of frantic gestures before shoving a drawing of a set of binoculars into your hands.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_techtool_1"] = 2,
			["value_wire_light"] = 25,
			["value_tape_duct"] = 40,
		}

		return itemids
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "Ilyuha Hobo"
			local message = "Ilyuha Hobo here. Mute seems to have found some binoculars somewhere and is selling them."
			ix.progression.Notify(character, name, message)
		end)
	end
})

ix.progression.Register("muteItemDelivery_Binoc2", {
	name = "Looking ahead 2",
	description = "Mute's eyes haven't left his binoculars since the moment you came in.",
	keyNpc = "'Mute'",
	defaultActive = false,
	progMap = map,
	vendorUnlocks = {
		{npc = "'Mute'", args = {"binoculars_1", nil, 5, "SELLANDBUY", 5, 1, 5}}
	},
	nextProgressions = {"muteItemDelivery_Binoc3", "muteItemDelivery_Broadcast"},
	BuildResponse = function(self, npcname, status)
		local dat = status or {}

		local itemids = self:GetItemIds()

		local str = "Mute tries and fails to articulate a concept before pointing to a pair of binoculars with a smiley face on them. It seems he wants to improve them.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_techtool_1"] = 6,
		}

		return itemids
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "Ilyuha Hobo"
			local message = "Ilyuha Hobo here again. Mute's found himself some new binoculars somewhere. Looks like they're rangefinders."
			ix.progression.Notify(character, name, message)
		end)
	end
})

ix.progression.Register("muteItemDelivery_Binoc3", {
	name = "Looking ahead 3",
	description = "Mute's hands are twitchier as he works on a diagram.",
	keyNpc = "'Mute'",
	defaultActive = false,
	progMap = map,
	vendorUnlocks = {
		{npc = "'Mute'", args = {"binoculars_4", nil, 5, "SELLANDBUY", 5, 1, 5}}
	},
	nextProgressions = {"muteItemDelivery_Binoc4"},
	BuildResponse = function(self, npcname, status)
		local dat = status or {}

		local itemids = self:GetItemIds()

		local str = "Mute simply points at a drawing on the table beside him. It appears to be the technical specs for a new set of binoculars and the materials list needed for them.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_techtool_2"] = 2,
			["value_wire_copper"] = 50,
		}

		return itemids
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "Ilyuha Hobo"
			local message = "Ilyuha Hobo once again. Mute's apparently carrying a third variety of binoculars. I'm guessing they're more powerful than others."
			ix.progression.Notify(character, name, message)
		end)
	end
})

ix.progression.Register("muteItemDelivery_Binoc4", {
	name = "Looking ahead 4",
	description = "Mute is busy tinkering with a pair of binoculars using some kind of electronic device",
	keyNpc = "'Mute'",
	defaultActive = false,
	progMap = map,
	vendorUnlocks = {
		{npc = "'Mute'", args = {"binoculars_3", nil, 5, "SELLANDBUY", 5, 1, 5}}
	},
	BuildResponse = function(self, npcname, status)
		local dat = status or {}

		local itemids = self:GetItemIds()

		local str = "Mute gestures toward his workbench, where a set of binoculars is partially disassembled. It looks like he's making his magnum opus. Maybe you could help him out?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_techtool_2"] = 5,
			["value_frequencymodulator"] = 3,
			["value_wire_heavy"] = 30,
		}

		return itemids
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "Vadim Nasty"
			local message = "Vadim Nasty here with Mute. Looks like he's selling some binoculars with NVG modules in them. Useful!"
			ix.progression.Notify(character, name, message)
		end)
	end
})

ix.progression.Register("muteItemDelivery_Anomaly", {
	name = "Anomaly Detector",
	description = "Mute is busy drawing pictures of anomalies.",
	keyNpc = "'Mute'",
	defaultActive = false,
	progMap = map,
	vendorUnlocks = {
		{npc = "'Mute'", args = {"anomalydetector", nil, 5, "SELLANDBUY", 5, 1, 5}}
	},
	nextProgressions = {"muteItemDelivery_Detector"},
	BuildResponse = function(self, npcname, status)
		local dat = status or {}

		local itemids = self:GetItemIds()

		local str = "Mute motions toward a disassembled geiger counter on his desk alongside pictures and crude sketches of various anomalies. Could he be building a detector of some variety?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_techtool_1"] = 1,
			["value_wire_copper"] = 10,
		}

		return itemids
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "Ilyuha Hobo"
			local message = "Man, this anomaly detector Mute sold me earlier just saved my bacon! Should consider picking one up!"
			ix.progression.Notify(character, name, message)
		end)
	end
})

ix.progression.Register("muteItemDelivery_Detector", {
	name = "Echo Detector",
	description = "Mute is busy drawing pictures of artifacts.",
	keyNpc = "'Mute'",
	defaultActive = false,
	progMap = map,
	vendorUnlocks = {
		{npc = "'Mute'", args = {"detectorecho", nil, 5, "SELLANDBUY", 5, 1, 5}}
	},
	BuildResponse = function(self, npcname, status)
		local dat = status or {}

		local itemids = self:GetItemIds()

		local str = "Apparently the last detector was not enough. Mute is making various gestures on how he would be able to reverse engineer detectors to make his own, in order to detect artifacts.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["detectorecho"] = 1,
		}

		return itemids
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "Vadim Nasty"
			local message = "I just made fat cash from this artifact I found, all thanks to Mutes detector!"
			ix.progression.Notify(character, name, message)
		end)
	end
})

ix.progression.Register("muteItemDelivery_Broadcast", {
	name = "Keeping tabs",
	description = "Mute is working on a server box.",
	keyNpc = "'Mute'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		local dat = status or {}

		local itemids = self:GetItemIds()

		local str = "Mute shoves some kind of blueprint in your face. It looks really complicated, but whatever it is might be useful to help him build.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_frequencymodulator"] = 1,
			["value_techtool_3"] = 1,
			["value_wirelesstrans"] = 15,
		}

		return itemids
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Mute'"
			local message = "The Zone mutant tracking service is now operational."
			ix.progression.Notify(character, name, message)
		end)
	end
})

ix.progression.Register("muteItemDelivery_BlowoutWarning", {
	name = "Blowout scanning",
	description = "Mute is working on advanced scanning hardware.",
	keyNpc = "'Mute'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		local dat = status or {}

		local itemids = self:GetItemIds()

		local str = "Mute shoves some kind of schematics towards you. It looks like some kind of advanced scanner, maybe for blowouts?.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_frequencymodulator"] = 1,
			["value_techtool_3"] = 1,
			["value_wirelesstrans"] = 2,
		}

		return itemids
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Mute'"
			local message = "The Zone blowout warning system is now operational."
			ix.progression.Notify(character, name, message)
		end)
	end
})
