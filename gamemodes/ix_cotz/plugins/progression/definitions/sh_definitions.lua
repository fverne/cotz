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
				local message = string.format(
					"%s, good work thinning out those mutants. You've made the camp a little safer. "
					.. "Come have a chat; I've got another task for you.",
					character:GetName()
				)
				ix.progression.Notify(character, name, message)

				timer.Simple(15, function()
					local name = "'Haggler'"
					local message = string.format(
						"%s, Haggler here. Old Timer tells me you can pull your weight. Come see me if you "
						.. "want to do business; I've got wares and work for you.",
						character:GetName()
					)
					ix.progression.Notify(character, name, message)
				end)
			end,
			RunOnce = true,
		},
	},
	progressthresholds = {1},
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
		{ pool = "common_meat", quantity = 8 },
	},
	OnComplete = function(character)
		timer.Simple(5, function()
			local name = "'Old Timer'"
			local message = string.format(
				"%s, your haul will help keep the camp fed. Good work. Go see my old friend Spicy "
				.. "Lemon; he'll help you make something of what you've brought back.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)

		timer.Simple(15, function()
			local name = "'Spicy Lemon'"
			local message = string.format(
				"%s, Old Timer told me about your hunting. Come see me with your food and we'll "
				.. "talk cooking. No sense wasting a good haul on a bad meal.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)

		timer.Simple(30, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, I heard you've been helping Old Timer. I could use that sort of help on a "
				.. "project of my own. Come find me in my cabin.",
				character:GetName()
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
		{ npc = "'Technut'", args = { "attachment_steelplate_1", nil, 1, "SELLANDBUY", 1, 3, 1 } },
		{ npc = "'Technut'", args = { "attachment_ceramicplate_1", nil, 1, "SELLANDBUY", 1, 3, 1 } },
		{ npc = "'Technut'", args = { "attachment_fabric_1", nil, 1, "SELLANDBUY", 1, 3, 1 } },
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
		{ pool = "repair_electrical", quantity = 1 },
		{ pool = "heavy_electrical_map1", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(15, function()
			local name = "'Technut'"
			local message = string.format(
				"%s, your components got my radio working! I've reached my contacts, and you can "
				.. "buy military grade fabrics and plates from me now. Come see what they've sent.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)

		timer.Simple(45, function()
			local name = "'Old Timer'"
			local message = string.format(
				"%s, your work on Technut's radio gave me an idea. Come see me; there's someone I "
				.. "think you could help me get in touch with.",
				character:GetName()
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
		{ pool = "common_parts", quantity = 4 },
	},
	OnComplete = function(character)
		timer.Simple(15, function()
			local name = "'Old Timer'"
			local message = string.format(
				"%s, the things you brought settled my arrangement with Mute. Go see him about the "
				.. "radio work. He's an old friend, but a little eccentric; keep that in mind.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)

		timer.Simple(45, function()
			local name = "'Mute'"
			local message = string.format(
				"%s. Come.",
				character:GetName()
			)
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
		{ pool = "repair_electrical", quantity = 4 },
		{ pool = "heavy_electrical_map1", quantity = 2 },
		{ pool = "small_electronics", quantity = 4 },
	},
	OnComplete = function(character)
		timer.Simple(45, function()
			local name = "'Mute'"
			local message = string.format(
				"%s. Tower working. You can buy the flash drive from me. Take it to Quartermaster "
				.. "in the deeper territory. He has information we need.",
				character:GetName()
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
		"quartermasterItemDelivery_1_stage1",
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
			local message = string.format(
				"%s, Mute's information checks out. You and I can talk business now. Come over and "
				.. "we'll discuss what you can do for me.",
				character:GetName()
			)
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
		{ pool = "spirits", quantity = 1 },
		{ pool = "premium_cigarettes", quantity = 1 },
		{ pool = "administrative_documents", quantity = 1 },
		{ pool = "small_electronics", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(5, function()
			local name = "'Quartermaster'"
			local message = string.format(
				"%s, thanks for the booze. You've earned my trust. Go talk to Boss; he might have "
				.. "some information worth your while.",
				character:GetName()
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
		[2] = {
			OnRun = function(self, character)
				local name = "'Boss'"
				local message = string.format(
					"%s, good work on those extractions. You've brought me useful information. I've "
					.. "passed your name to Smartass; go see what he needs.",
					character:GetName()
				)
				ix.progression.Notify(character, name, message)

				timer.Simple(10, function()
					local name = "'Smartass'"
					local message = string.format(
						"%s, Boss says you can get things done. Come see me. I've got some fieldwork "
						.. "that'll put that to the test.",
						character:GetName()
					)
					ix.progression.Notify(character, name, message)
				end)
			end,
			RunOnce = true,
		},
		[1] = {OnRun = function(self, character)
			ix.progression.CompleteCheckpoint(character, "boss_dataTasks", 1)
		end},
	},
	progressthresholds = {1, 4},
	checkpointBenefits = {{services = {{npc = "'Technut'", service = "repair", amount = 500}}}},
	checkpointMessages = {
		(
			"A clean extraction. I've put a small repair allowance on your account at Technut's. "
			.. "Bring me the remaining data before you meet my contact."
		),
	},
})

ix.progression.Register("smartass_rfTasks", {
	name = "STORY: Scanning the Zone",
	description = "Scanning the Zone",
	keyNpc = "'Smartass'",
	defaultActive = false,
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Boss'", args = {"accesscard_bunker", nil, 1, "SELLANDBUY", 1, 48, 1}},
		{npc = "'Smartass'", threshold = 3, args = {"pso1", nil, 1, "SELLANDBUY", 1, 48, 1}},
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
		[3] = {
			OnRun = function(self, character)
				local name = "'Smartass'"
				local message = string.format(
					"%s, I'm rarely surprised, but you finished those scans quicker than I expected. "
					.. "Good work. I've let Boss know you held up your end.",
					character:GetName()
				)
				ix.progression.Notify(character, name, message)

				timer.Simple(10, function()
					local name = "'Boss'"
					local message = string.format(
						"%s, you've done useful work for us. I'll sell you the unmarked bunker access cards "
						.. "we recovered underground. Come see me about one before your next trip.",
						character:GetName()
					)
					ix.progression.Notify(character, name, message)
				end)
			end,
			RunOnce = true,
		},
		[1] = {OnRun = function(self, character)
			ix.progression.CompleteCheckpoint(character, "smartass_rfTasks", 1)
		end},
		[2] = {OnRun = function(self, character)
			ix.progression.CompleteCheckpoint(character, "smartass_rfTasks", 2)
		end},
	},
	progressthresholds = {1, 3, 5},
	checkpointBenefits = {{items = {{item = "9x19"}}}, {}},
	checkpointMessages = {
		(
			"The first survey is usable. Take the reconnaissance ammunition; I need more than one "
			.. "reading before I trust the pattern."
		),
		(
			"Your records are consistent enough for a basic optic authorisation. The last surveys "
			.. "still decide access to the science team."
		),
	},
})

MAP = "rp_marsh_cs"
ix.progression.Register("beanstalkItemDelivery_Documents", {
	name = "STORY: Well Documented",
	description = "Beanstalk wants documents.",
	keyNpc = "'Beanstalk'",
	defaultActive = false,
	progMap = MAP,
	nextProgressions = {"eggheadItemDelivery_artifacts_stage1"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "documents_field", quantity = 2},
		{pool = "administrative_documents", quantity = 4},
		{pool = "documents_technical", quantity = 2},
		{pool = "documents_research", quantity = 4},
	},
	OnComplete = function(character) end,
	milestoneGroup = "beanstalkItemDelivery_Documents",
	stageIndex = 3,
	stageCount = 3,
	vendorUnlocks = {
	},
})

ix.progression.Register("eggheadItemDelivery_artifacts", {
	name = "STORY: Ecstatic Artifacts",
	description = "Egghead wants artifacts.",
	keyNpc = "'Egghead'",
	defaultActive = false,
	progMap = MAP,
	nextProgressions = { "intern_gasAnalyzerReadings" },
	BuildResponse = ix.progression.BuildDeliveryResponse,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "electrical_artifacts", quantity = 5},
		{pool = "repair_electrical", quantity = 7},
		{pool = "rare_electrical_artifacts", quantity = 5},
		{pool = "chemical_artifacts", quantity = 7},
		{pool = "burner_artifacts", quantity = 5},
	},
	OnComplete = function(character) end,
	milestoneGroup = "eggheadItemDelivery_artifacts",
	stageIndex = 2,
	stageCount = 2,
	vendorUnlocks = {
	},
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
		[4] = {
			OnRun = function(self, character)
				local name = "'Intern'"
				local message = string.format(
					"%s, thanks for helping me with the readings in Pripyat. I'm very grateful. I've "
					.. "sent your results to Egghead; I think he'll want a word with you.",
					character:GetName()
				)
				ix.progression.Notify(character, name, message)

				timer.Simple(10, function()
					local name = "'Egghead'"
					local message = string.format(
						"%s, your readings pinpointed the phenomena beneath Pripyat. You can now buy the "
						.. "computer access apparatus and laboratory keycard from me. See me before you leave, "
						.. "and good luck.",
						character:GetName()
					)
					ix.progression.Notify(character, name, message)
				end)
			end,
			RunOnce = true,
		},
		[1] = {OnRun = function(self, character)
			ix.progression.CompleteCheckpoint(character, "intern_gasAnalyzerReadings", 1)
		end},
		[2] = {OnRun = function(self, character)
			ix.progression.CompleteCheckpoint(character, "intern_gasAnalyzerReadings", 2)
		end},
		[3] = {OnRun = function(self, character)
			ix.progression.CompleteCheckpoint(character, "intern_gasAnalyzerReadings", 3)
		end},
	},
	progressthresholds = {2, 6, 11, 17},
	checkpointBenefits = {
		{items = {{item = "medic_antirad_1"}}},
		{items = {{item = "drink_bottletea"}, {item = "medic_medkit_1"}}},
		{items = {{item = "medic_psyheal_2"}}},
	},
	checkpointMessages = {
		(
			"Two Pripyat surveys logged! Please take the radiation treatment before the next trip. "
			.. "We still need the rest of the field programme."
		),
		(
			"Six surveys reconciled. I've put together a small expedition resupply. Keep the "
			.. "analyzer readings coming; the laboratory access isn't cleared yet."
		),
		(
			"Eleven surveys! These results are finally fitting together. Take the scientific "
			.. "treatment and finish the last six before I send the access recommendation."
		),
	},
})

MAP = "rp_pripyat_remaster"
ix.progression.Register("computerDelivery_activateItem", {
	name = "STORY: Getting Access",
	description = "Bring the secured container to the computer.",
	keyNpc = "'Computer'",
	defaultActive = true,
	progMap = MAP,
	nextProgressions = {"computerDelivery_main_stage1"},
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
	BuildResponse = ix.progression.BuildDeliveryResponse,
	lootMapTier = 3,
	requirementSlots = {
		{pool = "repair_electrical", quantity = 4},
		{pool = "radio_components", quantity = 4},
		{pool = "heavy_components", quantity = 4},
		{pool = "computer_parts", quantity = 4},
		{pool = "documents_technical", quantity = 4},
	},
	OnComplete = function(character) end,
	milestoneGroup = "computerDelivery_main",
	stageIndex = 3,
	stageCount = 3,
	vendorUnlocks = {
	},
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
		[3] = {
			OnRun = function(self, character)
				timer.Simple(5, function()
					local name = "'Egghead'"
					local message = string.format(
						"%s, I've detected a large energy release at the laboratory after your work with "
						.. "the computer. What's happening down there? Report back when you can.",
						character:GetName()
					)
					ix.progression.Notify(character, name, message)
				end)
			end,
			RunOnce = true,
		},
		[1] = {OnRun = function(self, character)
			ix.progression.CompleteCheckpoint(character, "computer_artifactTasks", 1)
		end},
		[2] = {OnRun = function(self, character)
			ix.progression.CompleteCheckpoint(character, "computer_artifactTasks", 2)
		end},
	},
	progressthresholds = {3, 8, 14},
	checkpointBenefits = {{items = {{item = "medic_antirad_1"}}}, {items = {{item = "medic_psyheal_2"}}}},
	checkpointMessages = {
		(
			"BATCH THREE VERIFIED. Field resupply authorised. Additional anomalous material "
			.. "required before the final energy analysis."
		),
		(
			"BATCH EIGHT VERIFIED. Operator support authorised. Six additional batches required. "
			.. "Restricted functions remain closed."
		),
	},
})
