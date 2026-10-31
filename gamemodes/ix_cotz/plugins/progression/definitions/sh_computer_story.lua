local MAP = "rp_pripyat_remaster"

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

local PLUGIN = PLUGIN

function PLUGIN:ix_OnJobComplete(client, npc, identifier)
	if npc ~= "'Computer'" then return end
	local job = ix.jobs.list[identifier]
	if not job then return end
	for _, category in ipairs(job.categories or {}) do
		if category == "artifactcollect_computer" then
			ix.progression.AddProgressionValue(client:GetCharacter(), "computer_artifactTasks", 1)
			return
		end
	end
end
