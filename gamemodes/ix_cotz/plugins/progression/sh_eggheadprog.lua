local MAP = "rp_marsh_cs"

ix.progression.Register("eggheadItemDelivery_Detector1", {
	name = "Detecting Anomalous Materials Part 1",
	description = "Scientific field research and equipment authorisation.",
	keyNpc = "'Egghead'",
	defaultActive = true,
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Egghead'", args = { "detectorecho", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = {
		"eggheadItemDelivery_Detector2_stage1",
		"eggheadItemDelivery_Suit1",
		"eggheadItemDelivery_Aid1_stage1",
	},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	lootMapTier = 2,
	requirementSlots = {
		{ pool = "common_artifacts", quantity = 21 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Egghead'"
			local message = string.format(
				"%s, your samples made the difference! I've completed the first anomalous substance "
				.. "detector. You may purchase one from me for your fieldwork.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	briefing = (
		"We have access to equipment again, but I still need a sound sample series. Bring the "
		.. "common anomalous materials on the list and I'll authorise Echo detector sales."
	),
})

ix.progression.Register("eggheadItemDelivery_Detector2_stage1", {
	name = "Detecting Anomalous Materials Part 2 - 1/2",
	description = "Detecting Anomalous Materials Part 2 - 1/2",
	keyNpc = "'Egghead'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "rare_field_artifacts", quantity = 3},
		{pool = "rare_electrical_artifacts", quantity = 2},
	},
	nextProgressions = {"eggheadItemDelivery_Detector2"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "eggheadItemDelivery_Detector2",
	stageIndex = 1,
	stageCount = 2,
	briefing = (
		"The first detector gave us a useful baseline. Bring these comparative anomalous "
		.. "samples so I can isolate what the improved receiver should actually detect."
	),
	completionMessage = "The material is logged. Thank you for bringing evidence rather than another confident guess.",
})

ix.progression.Register("eggheadItemDelivery_Detector2", {
	name = "Detecting Anomalous Materials Part 2",
	description = "Scientific field research and equipment authorisation.",
	keyNpc = "'Egghead'",
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Egghead'", args = {"detectorbear", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	nextProgressions = {"eggheadItemDelivery_Detector3_stage1"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "rare_electrical_artifacts", quantity = 2},
		{pool = "chemical_artifacts", quantity = 5},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Egghead'"
			local message = string.format(
				"%s, your diligence has paid off. I've improved the detector's ability to locate "
				.. "anomalous substances. You may purchase the revised model from me.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "eggheadItemDelivery_Detector2",
	stageIndex = 2,
	stageCount = 2,
	defaultActive = false,
	briefing = (
		"The first comparison is complete. Bring the remaining anomalous specimens so I can "
		.. "finish calibrating the Bear receiver and authorise its sale."
	),
})

ix.progression.Register("eggheadItemDelivery_Detector3_stage1", {
	name = "Detecting Anomalous Materials Part 3 - 1/3",
	description = "Detecting Anomalous Materials Part 3 - 1/3",
	keyNpc = "'Egghead'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "documents_research", quantity = 2},
		{pool = "documents_technical", quantity = 1},
	},
	nextProgressions = {"eggheadItemDelivery_Detector3_stage2"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "eggheadItemDelivery_Detector3",
	stageIndex = 1,
	stageCount = 3,
	briefing = (
		"Before another field trial, I need the research and technical records reconciled. "
		.. "Keep the later specimen list; this programme will cover several anomaly families."
	),
	completionMessage = "The material is logged. Thank you for bringing evidence rather than another confident guess.",
})

ix.progression.Register("eggheadItemDelivery_Detector3_stage2", {
	name = "Detecting Anomalous Materials Part 3 - 2/3",
	description = "Detecting Anomalous Materials Part 3 - 2/3",
	keyNpc = "'Egghead'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "burner_artifacts", quantity = 1},
	},
	nextProgressions = {"eggheadItemDelivery_Detector3"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "eggheadItemDelivery_Detector3",
	stageIndex = 2,
	stageCount = 3,
	briefing = (
		"The records expose a gap in our thermal calibration. Bring the requested Burner "
		.. "specimen now; the final trial still needs its own complete family comparison."
	),
	completionMessage = "The material is logged. Thank you for bringing evidence rather than another confident guess.",
})

ix.progression.Register("eggheadItemDelivery_Detector3", {
	name = "Detecting Anomalous Materials Part 3",
	description = "Scientific field research and equipment authorisation.",
	keyNpc = "'Egghead'",
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Egghead'", args = {"detectorveles", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "exceptional_artifacts", quantity = 1},
		{pool = "bubble_artifacts", quantity = 1},
		{pool = "burner_artifacts", quantity = 1},
		{pool = "rare_electrical_artifacts", quantity = 2},
		{pool = "chemical_artifacts", quantity = 2},
		{pool = "gravitational_artifacts", quantity = 1},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Egghead'"
			local message = string.format(
				"%s, the latest detector is ready. Your contributions helped me refine its "
				.. "precision further; come see me if you wish to purchase one.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "eggheadItemDelivery_Detector3",
	stageIndex = 3,
	stageCount = 3,
	defaultActive = false,
	briefing = (
		"The documents and thermal comparison are logged. The final Veles trial needs the full "
		.. "set of anomaly families on your list. Keep the specimens separate; one family cannot "
		.. "stand in for another."
	),
})

ix.progression.Register("eggheadItemDelivery_Suit1", {
	name = "Anomalous Protection Part 1",
	description = "Scientific field research and equipment authorisation.",
	keyNpc = "'Egghead'",
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Egghead'", args = { "suit_ssp99", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	nextProgressions = {"eggheadItemDelivery_Suit2_stage1"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	lootMapTier = 2,
	requirementSlots = {
		{ pool = "predator_hides", quantity = 3 },
		{ pool = "common_hides", quantity = 4 },
		{ pool = "common_parts", quantity = 17 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Egghead'"
			local message = string.format(
				"%s, your contribution to the research warrants better protection. I can now "
				.. "authorise you to purchase an SSP-99 scientific suit. Visit me before your next "
				.. "expedition.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	briefing = (
		"Our instruments tell us what is dangerous; a scientific suit buys us time to leave "
		.. "it. Bring the requested materials and I'll authorise the SSP-99."
	),
})

ix.progression.Register("eggheadItemDelivery_Suit2_stage1", {
	name = "Anomalous Protection Part 2 - 1/2",
	description = "Anomalous Protection Part 2 - 1/2",
	keyNpc = "'Egghead'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "predator_hides", quantity = 2},
		{pool = "elite_hides", quantity = 1},
		{pool = "exotic_parts", quantity = 3},
	},
	nextProgressions = {"eggheadItemDelivery_Suit2"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "eggheadItemDelivery_Suit2",
	stageIndex = 1,
	stageCount = 2,
	briefing = (
		"A scientific suit must survive more than a clean laboratory. Bring these biological "
		.. "materials so I can compare the protective layers before approving the next model."
	),
	completionMessage = "The material is logged. Thank you for bringing evidence rather than another confident guess.",
})

ix.progression.Register("eggheadItemDelivery_Suit2", {
	name = "Anomalous Protection Part 2",
	description = "Scientific field research and equipment authorisation.",
	keyNpc = "'Egghead'",
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Egghead'", args = {"suit_ssp99m", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	nextProgressions = { "eggheadItemDelivery_Suit3" },
	BuildResponse = ix.progression.BuildDeliveryResponse,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "exotic_parts", quantity = 2},
		{pool = "documents_research", quantity = 3},
		{pool = "documents_technical", quantity = 1},
		{pool = "field_instruments", quantity = 2},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Egghead'"
			local message = string.format(
				"%s, you've earned clearance to purchase the SSP-99M suit. Your continued "
				.. "assistance has been invaluable; come see me about the improved protection.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "eggheadItemDelivery_Suit2",
	stageIndex = 2,
	stageCount = 2,
	defaultActive = false,
	briefing = (
		"The field layers have passed their first comparison. Bring the remaining materials so "
		.. "I can approve the improved scientific suit for purchase."
	),
})

ix.progression.Register("eggheadItemDelivery_Suit3", {
	name = "Anomalous Protection Part 3",
	description = "Scientific field research and equipment authorisation.",
	keyNpc = "'Egghead'",
	progMap = MAP,
	vendorUnlocks = {
		{ npc = "'Egghead'", args = { "suit_seva", nil, 1, "SELLANDBUY", 1, 48, 1 } },
	},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	lootMapTier = 2,
	requirementSlots = {
		{ pool = "elite_hides", quantity = 1 },
		{ pool = "predator_hides", quantity = 2 },
		{ pool = "brains", quantity = 2 },
		{ pool = "documents_research", quantity = 2 },
		{ pool = "documents_technical", quantity = 1 },
		{ pool = "field_instruments", quantity = 2 },
		{ pool = "administrative_documents", quantity = 2 },
		{ pool = "small_electronics", quantity = 7 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Egghead'"
			local message = string.format(
				"%s, I can now authorise you to purchase a SEVA suit. Your work deserves proper "
				.. "equipment for the conditions you'll encounter out there.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	briefing = (
		"The SEVA combines protection systems that cannot be judged in isolation. Complete "
		.. "this mixed field delivery before I sign the final equipment release."
	),
})

ix.progression.Register("eggheadItemDelivery_Aid1_stage1", {
	name = "Scientific Aid Part 1 - 1/3",
	description = "Scientific Aid Part 1 - 1/3",
	keyNpc = "'Egghead'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "brains", quantity = 3},
	},
	nextProgressions = {"eggheadItemDelivery_Aid1_stage2"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "eggheadItemDelivery_Aid1",
	stageIndex = 1,
	stageCount = 3,
	vendorUnlocks = {
		{npc = "'Egghead'", args = {"medic_psyheal_2", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"These neural samples may explain the confusion our surveyors report near active "
		.. "fields. Bring the requested specimens intact; then I can release the improved psy "
		.. "treatment."
	),
	completionMessage = "The material is logged. Thank you for bringing evidence rather than another confident guess.",
})

ix.progression.Register("eggheadItemDelivery_Aid1_stage2", {
	name = "Scientific Aid Part 1 - 2/3",
	description = "Scientific Aid Part 1 - 2/3",
	keyNpc = "'Egghead'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "exotic_parts", quantity = 5},
	},
	nextProgressions = {"eggheadItemDelivery_Aid1"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "eggheadItemDelivery_Aid1",
	stageIndex = 2,
	stageCount = 3,
	vendorUnlocks = {
		{npc = "'Egghead'", args = {"medic_antirad_2", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"The psychic results are promising. Now I need comparative biological material before "
		.. "I can sign off on the stronger radiation treatment."
	),
	completionMessage = "The material is logged. Thank you for bringing evidence rather than another confident guess.",
})

ix.progression.Register("eggheadItemDelivery_Aid1", {
	name = "Scientific Aid Part 1",
	description = "Scientific field research and equipment authorisation.",
	keyNpc = "'Egghead'",
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Egghead'", args = {"medic_stimpak_1", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	nextProgressions = {"eggheadItemDelivery_Aid2_stage1"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "exotic_parts", quantity = 2},
		{pool = "chemical_artifacts", quantity = 5},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Egghead'"
			local message = string.format(
				"%s, thank you for the specimens. I can now supply you with Stimpak Mk I, "
				.. "antiradiation drugs and Psyheal drugs. See me to purchase what you need.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "eggheadItemDelivery_Aid1",
	stageIndex = 3,
	stageCount = 3,
	defaultActive = false,
	stockUnlocks = {{npc = "'Egghead'", bonus = 1, items = {"medic_psyheal_2", "medic_stimpak_1"}}},
	briefing = (
		"The early clinical comparisons are logged. Bring the remaining specimens and I'll "
		.. "release the first scientific stimulant as well as your earlier medicine "
		.. "authorisations."
	),
})

ix.progression.Register("eggheadItemDelivery_Aid2_stage1", {
	name = "Scientific Aid Part 2 - 1/2",
	description = "Scientific Aid Part 2 - 1/2",
	keyNpc = "'Egghead'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "brains", quantity = 2},
		{pool = "exotic_parts", quantity = 4},
	},
	nextProgressions = {"eggheadItemDelivery_Aid2"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "eggheadItemDelivery_Aid2",
	stageIndex = 1,
	stageCount = 2,
	vendorUnlocks = {
		{npc = "'Egghead'", args = {"medic_antipsychotic_2", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"A useful preparation must suppress the symptoms without concealing the cause. Bring "
		.. "the neurological and biological samples for the next clinical comparison."
	),
	completionMessage = "The material is logged. Thank you for bringing evidence rather than another confident guess.",
})

ix.progression.Register("eggheadItemDelivery_Aid2", {
	name = "Scientific Aid Part 2",
	description = "Scientific field research and equipment authorisation.",
	keyNpc = "'Egghead'",
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Egghead'", args = {"medic_stimpak_2", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	nextProgressions = {"eggheadItemDelivery_Aid3_stage1"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "exotic_parts", quantity = 1},
		{pool = "rare_electrical_artifacts", quantity = 2},
		{pool = "documents_research", quantity = 3},
		{pool = "documents_technical", quantity = 1},
		{pool = "field_instruments", quantity = 2},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Egghead'"
			local message = string.format(
				"%s, your latest specimens have advanced our work. I can now sell you Stimpak Mk II "
				.. "and Psyblock drugs. Please follow the dosage instructions.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "eggheadItemDelivery_Aid2",
	stageIndex = 2,
	stageCount = 2,
	defaultActive = false,
	briefing = (
		"The antipsychotic work is approved. Complete the rest of this sample series before I "
		.. "authorise the next stimulant formulation."
	),
})

ix.progression.Register("eggheadItemDelivery_Aid3_stage1", {
	name = "Scientific Aid Part 3 - 1/2",
	description = "Scientific Aid Part 3 - 1/2",
	keyNpc = "'Egghead'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "administrative_documents", quantity = 2},
		{pool = "elite_parts", quantity = 3},
		{pool = "brains", quantity = 1},
	},
	nextProgressions = {"eggheadItemDelivery_Aid3"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "eggheadItemDelivery_Aid3",
	stageIndex = 1,
	stageCount = 2,
	vendorUnlocks = {
		{npc = "'Egghead'", args = {"medic_antipsychotic_3", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	briefing = (
		"The strongest compounds need more than a persuasive anecdote. I need the requested "
		.. "records and specimens before approving another antipsychotic formulation."
	),
	completionMessage = "The material is logged. Thank you for bringing evidence rather than another confident guess.",
})

ix.progression.Register("eggheadItemDelivery_Aid3", {
	name = "Scientific Aid Part 3",
	description = "Scientific field research and equipment authorisation.",
	keyNpc = "'Egghead'",
	progMap = MAP,
	vendorUnlocks = {
		{npc = "'Egghead'", args = {"medic_stimpak_3", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "brains", quantity = 1},
		{pool = "rare_field_artifacts", quantity = 2},
		{pool = "documents_research", quantity = 2},
		{pool = "documents_technical", quantity = 1},
		{pool = "field_instruments", quantity = 2},
		{pool = "exceptional_electrical_artifacts", quantity = 1},
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Egghead'"
			local message = string.format(
				"%s, excellent work with those specimens. You now have clearance to purchase "
				.. "Stimpak Mk III and the stronger Psyblock drugs from me. Use them carefully.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
	milestoneGroup = "eggheadItemDelivery_Aid3",
	stageIndex = 2,
	stageCount = 2,
	defaultActive = false,
	briefing = (
		"The strongest preparations need the strongest evidence. Bring the remaining specimens "
		.. "and records before I authorise the final stimulant supply."
	),
})

ix.progression.Register("eggheadItemDelivery_artifacts_stage1", {
	name = "STORY: Ecstatic Artifacts - 1/2",
	description = "STORY: Ecstatic Artifacts - 1/2",
	keyNpc = "'Egghead'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "small_electronics", quantity = 6},
		{pool = "electrical_artifacts", quantity = 2},
	},
	nextProgressions = {"eggheadItemDelivery_artifacts"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "eggheadItemDelivery_artifacts",
	stageIndex = 1,
	stageCount = 2,
	briefing = (
		"Your fieldwork is producing useful leads. I need electrical samples and working "
		.. "components first, then we can assemble the broader research collection."
	),
	completionMessage = "The material is logged. Thank you for bringing evidence rather than another confident guess.",
})
