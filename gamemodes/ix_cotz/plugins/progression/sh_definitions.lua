hook.Add(
	"ix_OnJobComplete",
	"cotz/progression/old-timer-kill-intro",
	function(client, npcIdentifier, identifier)
		local isCorrectTaskType = false

		local KILL_CATEGORIES = {
			["mutantkillgroupeasy"] = true,
			["mutantkillgroupmedium"] = true,
			["mutantkillgrouphard"] = true,
			["mutantkilleasy"] = true,
			["mutantkillmedium"] = true,
			["mutantkillhard"] = true,
		}

		for _, v in pairs(ix.jobs.list[identifier].categories) do
			if KILL_CATEGORIES[v] then
				isCorrectTaskType = true
			end
		end

		if npcIdentifier == "'Old Timer'" and isCorrectTaskType then
			if ix.progression.IsActive(client:GetCharacter(), "oldTimerKillIntro") then
				ix.progression.AddProgressionValue(client:GetCharacter(), "oldTimerKillIntro", 1)
			end
		end
	end
)

hook.Add("ix_OnJobComplete", "cotz/progression/boss-data-tasks", function(client, npcIdentifier, identifier)
	local isCorrectTaskType = false

	local categories = {
		["dataextracteasy"] = true,
		["dataextractmedium"] = true,
		["dataextracthard"] = true,
	}

	for _, v in pairs(ix.jobs.list[identifier].categories) do
		if categories[v] then
			isCorrectTaskType = true
		end
	end

	if npcIdentifier == "'Boss'" and isCorrectTaskType then
		if ix.progression.IsActive(client:GetCharacter(), "boss_dataTasks") then
			ix.progression.AddProgressionValue(client:GetCharacter(), "boss_dataTasks", 1)
		end
	end
end)

hook.Add("ix_OnJobComplete", "cotz/progression/smartass-rf-tasks", function(client, npcIdentifier, identifier)
	local isCorrectTaskType = false

	local categories = {
		["scanRFeasy"] = true,
		["scanRFmedium"] = true,
		["scanRFhard"] = true,
	}

	for _, v in pairs(ix.jobs.list[identifier].categories) do
		if categories[v] then
			isCorrectTaskType = true
		end
	end

	if npcIdentifier == "'Smartass'" and isCorrectTaskType then
		if ix.progression.IsActive(client:GetCharacter(), "smartass_rfTasks") then
			ix.progression.AddProgressionValue(client:GetCharacter(), "smartass_rfTasks", 1)
		end
	end
end)

hook.Add(
	"ix_OnJobComplete",
	"cotz/progression/computer-artifact-tasks",
	function(client, npcIdentifier, identifier)
		local isCorrectTaskType = false

		local categories = {
			["artifactcollect_computer"] = true,
		}

		for _, v in pairs(ix.jobs.list[identifier].categories) do
			if categories[v] then
				isCorrectTaskType = true
			end
		end

		if npcIdentifier == "'Computer'" and isCorrectTaskType then
			if ix.progression.IsActive(client:GetCharacter(), "computer_artifactTasks") then
				ix.progression.AddProgressionValue(client:GetCharacter(), "computer_artifactTasks", 1)
			end
		end
	end
)

hook.Add(
	"ix_OnJobComplete",
	"cotz/progression/intern-gas-analyzer-readings",
	function(client, npcIdentifier, identifier)
		local isCorrectTaskType = false

		local categories = {
			["scanareahard"] = true, -- pripyat only
		}

		for _, v in pairs(ix.jobs.list[identifier].categories) do
			if categories[v] then
				isCorrectTaskType = true
			end
		end

		if npcIdentifier == "'Intern'" and isCorrectTaskType then
			if ix.progression.IsActive(client:GetCharacter(), "intern_gasAnalyzerReadings") then
				ix.progression.AddProgressionValue(client:GetCharacter(), "intern_gasAnalyzerReadings", 1)
			end
		end
	end
)

local MAP = "rp_marsh_cs"

ix.progression.Register("oldTimerKillIntro", {
	name = "STORY: Cleaning up the Zone",
	description = "Cleaning up the zone",
	keyNpc = "'Old Timer'",
	defaultActive = true,
	progMap = MAP,
	worldNPC = {
		template = "tradernpc",
		pos = Vector(-8224.509766, -11681.111328, 4944.531250),
		ang = Angle(0.000, 90, 0.000),
	},
	nextProgressions = { "oldTimerItemDelivery_mainMeat" },
	BuildResponse = function(self, npcName, status)
		local threshold = 0

		for _, v in ipairs(self.progressthresholds) do
			if v > status.value then
				threshold = v
				break
			end
		end

		return string.format(
			(
				"I need you to complete mutant kill tasks for me, %d tasks "
				.. "should do. This will allow us to get better supply lines, "
				.. "and make sure we wont get killed in our sleep by a wild "
				.. "dog."
			),
			threshold - status.value
		)
	end,
	progressfunctions = {
		[1] = {
			OnRun = function(self, character)
				local name = "'Old Timer'"
				local message = (
					"Good job, you've lowered the mutant population a bit, and "
					.. "as such we've gained a slight foothold in the zone. Come "
					.. "have a chat, I have a new task for you all."
				)
				ix.progression.Notify(character, name, message)

				timer.Simple(15, function()
					local name = "'Haggler'"
					local message = (
						"Hello everyone! I see you're all doing quite well for yourselves. "
						.. "I have some wares if you got the cash."
					)
					ix.progression.Notify(character, name, message)
				end)
			end,
			RunOnce = true,
		},
	},
	progressthresholds = {
		[1] = 1,
	},
})

ix.progression.Register("oldTimerItemDelivery_mainMeat", {
	name = "STORY: Feeding the Hungry",
	description = "Collecting lots of meat for the Old Timer.",
	keyNpc = "'Old Timer'",
	defaultActive = false,
	progMap = MAP,
	worldNPC = {
		template = "cooknpc",
		pos = Vector(-6126.198730, -9746.725586, 4959.031250),
		ang = Angle(0.000, -178.989, 0.000),
	},
	nextProgressions = { "technutItemDelivery_Main" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"So, we're in need of a lot of food if we want to stay alive "
			.. "out here, especially with this many people around. So, "
			.. "here's what we need to feed everyone for a while:\n"
		)

		for item, amount in pairs(itemIDs) do
			local currentAmount = 0
			if data and data[item] then
				currentAmount = data[item]
			end
			str = str .. string.format("\n%d pieces of %s", amount - currentAmount, ix.item.list[item].name)
		end

		local str = str
			.. (
				"\n\nSo I need you to get out there and hunt some mutated "
				.. "animals. We have enough canned food for a couple days, "
				.. "but we have a lot of mouths to feed, and it wont last long."
			)

		return str
	end,
	lootMapTier = 1,
	requirementSlots = {
		{ pool = "common_meat", quantity = 4 },
		{ pool = "small_parts", quantity = 3 },
		{ pool = "common_parts", quantity = 3 },
	},
	OnComplete = function(character)
		timer.Simple(5, function()
			local name = "'Old Timer'"
			local message = (
				"We're good on food, for now. To everyone that contributed, "
				.. "great work. Go say hi to my old friend 'Spicy Lemon', he's "
				.. "here to help cook all the food you've worked so hard for."
			)
			ix.progression.Notify(character, name, message)
		end)

		timer.Simple(15, function()
			local name = "'Spicy Lemon'"
			local message = (
				"Hello everyone, please bring me all your food, I'll cook " .. "you the finest delicacies."
			)
			ix.progression.Notify(character, name, message)
		end)

		timer.Simple(30, function()
			local name = "'Technut'"
			local message = (
				"Everyone, come in. I need some help with one of my projects, " .. "find me in my cabin."
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("technutItemDelivery_Main", {
	name = "STORY: Technut's Radio Project",
	description = "Collecting important components for Technut.",
	keyNpc = "'Technut'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Technut'", args = { "steelplate_1", nil, 1, "SELLANDBUY", 1, 3, 1 } },
		{ npc = "'Technut'", args = { "ceramicplate_1", nil, 1, "SELLANDBUY", 1, 3, 1 } },
		{ npc = "'Technut'", args = { "fabricplate_1", nil, 1, "SELLANDBUY", 1, 3, 1 } },
	},
	nextProgressions = { "oldTimerItemDelivery_mainStatue" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"I'm currently working on setting up rudimentary radiocommunications, "
			.. "because I just lost contact with my last runner that I "
			.. "sent off a couple of days ago, and it is simply not sustainable "
			.. "to send people to their deaths over and over again just "
			.. "to deliver a message that could have been transmitted easily "
			.. "through the airwaves. Anyways, here's a list of what I "
			.. "need:\n"
		)

		for item, amount in pairs(itemIDs) do
			local currentAmount = 0
			if data and data[item] then
				currentAmount = data[item]
			end
			str = str .. string.format("\n%s: %d", ix.item.list[item].name, amount - currentAmount)
		end

		str = str
			.. ("\n\nHope you can help me soon, noone wants to take up the " .. "job as messenger anymore.")

		return str
	end,
	lootMapTier = 1,
	requirementSlots = {
		{ pool = "repair_electrical", quantity = 3 },
		{ pool = "heavy_electrical_map1", quantity = 3 },
		{ pool = "workshop_supplies", quantity = 2 },
		{ pool = "small_electronics", quantity = 2 },
	},
	OnComplete = function(character)
		timer.Simple(15, function()
			local name = "'Technut'"
			local message = (
				"Thank you all for your help with my radio project, my messages "
				.. "are finally getting through. I managed to strike a deal "
				.. "with some people I know, and they'll supply me with military "
				.. "grade fabrics and plates."
			)
			ix.progression.Notify(character, name, message)
		end)

		timer.Simple(45, function()
			local name = "'Old Timer'"
			local message = (
				"Hello everyone, the new radio equipment gave me an idea. "
				.. "Come see me, maybe we can work something out."
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("oldTimerItemDelivery_mainStatue", {
	name = "STORY: Enticing the Specialist",
	description = "Collecting statues for Old Timer.",
	keyNpc = "'Old Timer'",
	defaultActive = false,
	progMap = MAP,
	worldNPC = {
		template = "stalkernetnpc",
		pos = Vector(-7499.309570, -9437.489258, 5036.031250),
		ang = Angle(0.000, -116.989, 0.000),
	},
	nextProgressions = { "stalkerNetAdminDelivery_mainRadioTower" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Great work on Technut's little project, but it got me thinking. "
			.. "No offense to Technut, but he's more of a mechanical guy, "
			.. "his radio system is never going to reach very far. I got "
			.. "an old friend that is extremly knowledgeable in these things, "
			.. "but he's a bit of an oddball. He has a fascination with "
			.. "statuettes of animals made by a certain factory nearby. "
			.. "So, I'm going to need you to collect some of these statues:\n"
		)

		for item, amount in pairs(itemIDs) do
			local currentAmount = 0
			if data and data[item] then
				currentAmount = data[item]
			end
			str = str .. string.format("\n%s: %d", ix.item.list[item].name, amount - currentAmount)
		end

		str = str .. ("\n\nWith his help we can get a lot more information in " .. "and out of the zone.")

		return str
	end,
	lootMapTier = 1,
	requirementSlots = {
		{ pool = "statues", quantity = 1 },
		{ pool = "administrative_documents", quantity = 1 },
		{ pool = "common_parts", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(15, function()
			local name = "'Old Timer'"
			local message = (
				"Arrangements have been made, and my good friend, you can "
				.. "call him 'Mute', has arrived. He's a bit eccentric, so "
				.. "keep that in mind."
			)
			ix.progression.Notify(character, name, message)
		end)

		timer.Simple(45, function()
			local name = "'Mute'"
			local message = "Come."
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("stalkerNetAdminDelivery_mainRadioTower", {
	name = "STORY: Proper Radio Tower",
	description = "Helping to build a true radiocommunications center.",
	keyNpc = "'Mute'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Mute'", args = { "quest_flashdrive", nil, 1, "SELLANDBUY", 1, 3, 1 } },
	},
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"** The man looks around erratically, points at a schematic "
			.. "of what looks to be a large radio antenna, and then points "
			.. "to a piece of paper with a list: **\n"
		)

		for item, amount in pairs(itemIDs) do
			local currentAmount = 0
			if data and data[item] then
				currentAmount = data[item]
			end
			str = str .. string.format("\n%s: %d", ix.item.list[item].name, amount - currentAmount)
		end

		return str
	end,
	lootMapTier = 1,
	requirementSlots = {
		{ pool = "consumer_electronics", quantity = 2 },
		{ pool = "repair_electrical", quantity = 2 },
		{ pool = "heavy_electrical_map1", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(45, function()
			local name = "'Mute'"
			local message = (
				"I got some correspondence with a guy in a deeper territory, "
				.. "he calls himself 'Quartermaster'. We need his help arming "
				.. "ourselves. Please go see what he needs before he'll help "
				.. "us."
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

MAP = "rp_waystation"
ix.progression.Register("quarterMasterDelivery_activateItem", {
	name = "STORY: Making Connections",
	description = "Bring the flash drive to Quartermaster.",
	keyNpc = "'Quartermaster'",
	defaultActive = true,
	progMap = MAP,
	nextProgressions = {
		"quarterMasterDelivery_main",
		"quartermasterItemDelivery_1",
		"quartermasterItemDelivery_2",
		"bossItemDelivery_1",
	},
	BuildResponse = function(self, npcName, status, character)
		return (
			"I chatted with a guy, what was his name, Mute? He should "
			.. "have a flash drive with information for me. I ain't budging "
			.. "'till I get that."
		)
	end,
	lootMapTier = 2,
	requirementSlots = {
		{ pool = "flashdrive", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(5, function()
			local name = "'Quartermaster'"
			local message = "Alright, we can talk business, come over here."
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("quarterMasterDelivery_main", {
	name = "STORY: Whetting the Whistle",
	description = "Bring Quartermaster something to drink.",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	progMap = MAP,
	nextProgressions = { "boss_dataTasks" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Alright boys, lets see some hands, who likes booze? That's "
			.. "right, I do. I'm gonna need you to find some stuff to drink, "
			.. "and smoke. I made a little list for you so you wont forget:\n"
		)

		for item, amount in pairs(itemIDs) do
			local currentAmount = 0
			if data and data[item] then
				currentAmount = data[item]
			end
			str = str .. string.format("\n%d %s", amount - currentAmount, ix.item.list[item].name)
		end

		str = str .. "\n\nNow chop-chop, get going, that booze isn't gonna find itself."

		return str
	end,
	lootMapTier = 2,
	requirementSlots = {
		{ pool = "spirits", quantity = 2 },
		{ pool = "premium_cigarettes", quantity = 2 },
		{ pool = "administrative_documents", quantity = 2 },
	},
	OnComplete = function(character)
		timer.Simple(5, function()
			local name = "'Quartermaster'"
			local message = (
				"Thanks for the booze, you earned my trust. Go talk to Boss, "
				.. "he might have some juicy information for you."
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("boss_dataTasks", {
	name = "STORY: Extracting Information",
	description = "Extract data from various computers",
	keyNpc = "'Boss'",
	defaultActive = false,
	progMap = MAP,
	nextProgressions = { "smartass_rfTasks" },
	BuildResponse = function(self, npcName, status)
		local threshold = 0

		for _, v in ipairs(self.progressthresholds) do
			if v > status.value then
				threshold = v
				break
			end
		end

		return string.format(
			(
				"You'll need to complete %d contracts relating to extracting "
				.. "data from computers in the old underground complexes around "
				.. "the zone."
			),
			threshold - status.value
		)
	end,
	progressfunctions = {
		[1] = {
			OnRun = function(self, character)
				local name = "'Boss'"
				local message = "Good work stalkers, you've gotten me a lot of interesting information."
				ix.progression.Notify(character, name, message)

				timer.Simple(10, function()
					local name = "'Smartass'"
					local message = "Come see me."
					ix.progression.Notify(character, name, message)
				end)
			end,
			RunOnce = true,
		},
	},
	progressthresholds = {
		[1] = 4,
	},
})

ix.progression.Register("smartass_rfTasks", {
	name = "STORY: Scanning the Zone",
	description = "Scanning the Zone",
	keyNpc = "'Smartass'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Boss'", args = { "accesscard_bunker", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	BuildResponse = function(self, npcName, status)
		local threshold = 0

		for _, v in ipairs(self.progressthresholds) do
			if v > status.value then
				threshold = v
				break
			end
		end

		return string.format(
			(
				"Boss might think you're hot shit, and I know you gave Quartermaster "
				.. "those bottles of booze. How about you help me out, and "
				.. "gather some information about the nearby areas? %d times, "
				.. "to be exact."
			),
			threshold - status.value
		)
	end,
	progressfunctions = {
		[1] = {
			OnRun = function(self, character)
				local name = "'Smartass'"
				local message = "I'm rarely surprised, but that was quicker than I thought. Good job."
				ix.progression.Notify(character, name, message)

				timer.Simple(10, function()
					local name = "'Boss'"
					local message = (
						"You've been helping us out a lot, so thank you for that. "
						.. "Listen, don't tell anyone, but I can sell you some unmarked "
						.. "access cards we got while scavenging the underground. We "
						.. "have plenty, so it's not a big deal for us to give something "
						.. "back to you."
					)
					ix.progression.Notify(character, name, message)
				end)
			end,
			RunOnce = true,
		},
	},
	progressthresholds = {
		[1] = 4,
	},
})

MAP = "rp_marsh_cs"
ix.progression.Register("beanstalkItemDelivery_Documents", {
	name = "STORY: Well Documented",
	description = "Beanstalk wants documents.",
	keyNpc = "'Beanstalk'",
	defaultActive = true,
	progMap = MAP,
	nextProgressions = { "eggheadItemDelivery_artifacts" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Greetings. I won't ask how you got down here, who you are. "
			.. "You come from the outside, and we don't have the resources "
			.. "to leave the safety of the bunker. I need you to gather "
			.. "the following of various documents to aid our research:\n"
		)

		for item, amount in pairs(itemIDs) do
			local currentAmount = 0
			if data and data[item] then
				currentAmount = data[item]
			end
			str = str .. string.format("\n%d %s", amount - currentAmount, ix.item.list[item].name)
		end

		str = str .. "\n\nNow get going!"

		return str
	end,
	lootMapTier = 2,
	requirementSlots = {
		{ pool = "documents_technical", quantity = 1 },
		{ pool = "documents_research", quantity = 1 },
		{ pool = "documents_field", quantity = 1 },
		{ pool = "administrative_documents", quantity = 1 },
	},
	OnComplete = function(character) end,
})

ix.progression.Register("eggheadItemDelivery_artifacts", {
	name = "STORY: Ecstatic Artifacts",
	description = "Egghead wants artifacts.",
	keyNpc = "'Egghead'",
	defaultActive = false,
	progMap = MAP,
	nextProgressions = { "intern_gasAnalyzerReadings" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Hello. I have discovered some strange phenomena deep within "
			.. "the depths of the zone. If my calculations are correct, "
			.. "I need to melt certain artifacts together to achieve our "
			.. "goal. Find me the following artifacts:\n"
		)

		for item, amount in pairs(itemIDs) do
			local currentAmount = 0
			if data and data[item] then
				currentAmount = data[item]
			end
			str = str .. string.format("\n%d %s", amount - currentAmount, ix.item.list[item].name)
		end

		str = str
			.. (
				"\n\nApparently they can be found mostly in electrical anomalies, "
				.. "but you already know this, don't you?"
			)

		return str
	end,
	lootMapTier = 2,
	requirementSlots = {
		{ pool = "electrical_artifacts", quantity = 1 },
		{ pool = "rare_electrical_artifacts", quantity = 1 },
		{ pool = "chemical_artifacts", quantity = 1 },
		{ pool = "burner_artifacts", quantity = 1 },
	},
	OnComplete = function(character) end,
})

ix.progression.Register("intern_gasAnalyzerReadings", {
	name = "STORY: Analyzing Pripyat",
	description = "Scanning Pripyat",
	keyNpc = "'Intern'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Egghead'", args = { "quest_computeraccess", nil, 5, "SELLANDBUY", 5, 1, 5 } },
		{ npc = "'Egghead'", args = { "accesscard_laboratory", nil, 5, "SELLANDBUY", 5, 1, 5 } },
	},
	BuildResponse = function(self, npcName, status)
		local threshold = 0

		for _, v in ipairs(self.progressthresholds) do
			if v > status.value then
				threshold = v
				break
			end
		end

		return string.format(
			(
				"Hello! Glad you're here to help me out. They want me to "
				.. "take scannings of various locations in Pripyat, but truth "
				.. "be told, I can't even hold a gun, and I've never been out "
				.. "of the swamps! Can you help me out? I need to get %d orders "
				.. "done."
			),
			threshold - status.value
		)
	end,
	progressfunctions = {
		[1] = {
			OnRun = function(self, character)
				local name = "'Intern'"
				local message = "Thanks for 'accompanying' me to Pripyat. I'm very grateful for your help."
				ix.progression.Notify(character, name, message)

				timer.Simple(10, function()
					local name = "'Egghead'"
					local message = (
						"The apparatus is assembled and ready for use, I pinpointed "
						.. "the location of the phenomena to be in a laboratory underneath "
						.. "Pripyat. Hence, I have a keycard for the laboratory available "
						.. "as well. Best of luck."
					)
					ix.progression.Notify(character, name, message)
				end)
			end,
			RunOnce = true,
		},
	},
	progressthresholds = {
		[1] = 6,
	},
})

MAP = "rp_pripyat_remaster"
ix.progression.Register("computerDelivery_activateItem", {
	name = "STORY: Getting Access",
	description = "Bring the secured container to the computer.",
	keyNpc = "'Computer'",
	defaultActive = true,
	progMap = MAP,
	nextProgressions = { "computerDelivery_main" },
	BuildResponse = function(self, npcName, status, character)
		return "** 'ACCESS DENIED' is written in bold letters on the screen **"
	end,
	lootMapTier = 3,
	requirementSlots = {
		{ pool = "computer_case", quantity = 1 },
	},
	OnComplete = function(character) end,
})

ix.progression.Register("computerDelivery_main", {
	name = "STORY: Getting up and running",
	description = "Set up the supercomputer with components.",
	keyNpc = "'Computer'",
	defaultActive = false,
	progMap = MAP,
	nextProgressions = { "computer_artifactTasks" },
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"** The computer prints a list of items on the screen, and "
			.. "blinks some indicator lights in the area where it would "
			.. "like these components placed **\n"
		)

		for item, amount in pairs(itemIDs) do
			local currentAmount = 0
			if data and data[item] then
				currentAmount = data[item]
			end
			str = str .. string.format("\n[%s : %d]", ix.item.list[item].name, amount - currentAmount)
		end

		return str
	end,
	lootMapTier = 3,
	requirementSlots = {
		{ pool = "radio_components", quantity = 3 },
		{ pool = "heavy_components", quantity = 3 },
		{ pool = "fuel", quantity = 2 },
		{ pool = "computer_parts", quantity = 2 },
	},
	OnComplete = function(character) end,
})

ix.progression.Register("computer_artifactTasks", {
	name = "STORY: Analyzing Artifacts",
	description = "Analyzing Artifacts",
	keyNpc = "'Computer'",
	defaultActive = false,
	progMap = MAP,
	worldNPC = {
		template = "cconnpc",
		pos = Vector(847.604797, -10214.238281, -1478.968750),
		ang = Angle(0.000, -110, 0.000),
	},
	BuildResponse = function(self, npcName, status)
		local threshold = 0

		for _, v in ipairs(self.progressthresholds) do
			if v > status.value then
				threshold = v
				break
			end
		end

		return string.format(
			("** A message is on the screen: '%d batches of anomalous " .. "objects are needed' **"),
			threshold - status.value
		)
	end,
	progressfunctions = {
		[1] = {
			OnRun = function(self, character)
				timer.Simple(5, function()
					local name = "'Egghead'"
					local message = (
						"Stalkers, my readings are going crazy, a large release "
						.. "of energy was just detected at the laboratory. What's going "
						.. "on?"
					)
					ix.progression.Notify(character, name, message)
				end)
			end,
			RunOnce = true,
		},
	},
	progressthresholds = {
		[1] = 7,
	},
})
