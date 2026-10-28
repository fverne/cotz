ix.progression.Register("smartassRecon1", {
	name = "Reconnaissance equipment",
	description = "Reconnaissance equipment",
	keyNpc = "'Smartass'",
	progMap = "rp_waystation",
	defaultActive = true,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "common_optics", quantity = 1},
	},
	nextProgressions = {"smartassRecon2"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	briefing = (
		"A reconnaissance report begins with somebody seeing what is actually there. Bring the "
		.. "optics and I'll open a modest sighting-equipment catalogue for you."
	),
	completionMessage = (
		"Useful work. Your reconnaissance authorisations are updated; keep the next report "
		.. "just as precise."
	),
	completionBenefits = {},
	vendorUnlocks = {
		{npc = "'Smartass'", args = {"pso1", nil, 1, "SELLANDBUY", 1, 48, 1}},
		{npc = "'Smartass'", args = {"cmore", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
	prerequisites = {"boss_dataTasks"},
})

ix.progression.Register("smartassRecon2", {
	name = "Field intelligence",
	description = "Field intelligence",
	keyNpc = "'Smartass'",
	progMap = "rp_waystation",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "documents_field", quantity = 2},
	},
	nextProgressions = {"smartassRecon3"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	briefing = (
		"Glass shows you a ridge. Good records tell you what has been crossing it. Bring the "
		.. "field documents and I'll extend your scope purchase authorisations."
	),
	completionMessage = (
		"Useful work. Your reconnaissance authorisations are updated; keep the next report "
		.. "just as precise."
	),
	completionBenefits = {},
	vendorUnlocks = {
		{npc = "'Smartass'", args = {"acog", nil, 1, "SELLANDBUY", 1, 48, 1}},
		{npc = "'Smartass'", args = {"shortdot", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
})

ix.progression.Register("smartassRecon3", {
	name = "Advanced reconnaissance",
	description = "Advanced reconnaissance",
	keyNpc = "'Smartass'",
	progMap = "rp_waystation",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "suppressors", quantity = 2},
	},
	nextProgressions = {},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	briefing = (
		"The best observer leaves little evidence of being there. Deliver the suppressors on "
		.. "this list and I'll approve the specialist sighting and suppression equipment."
	),
	completionMessage = (
		"Useful work. Your reconnaissance authorisations are updated; keep the next report "
		.. "just as precise."
	),
	completionBenefits = {},
	vendorUnlocks = {
		{npc = "'Smartass'", args = {"nightforce", nil, 1, "SELLANDBUY", 1, 48, 1}},
		{npc = "'Smartass'", args = {"pbssuppressor", nil, 1, "SELLANDBUY", 1, 48, 1}},
		{npc = "'Smartass'", args = {"sakersuppressor", nil, 1, "SELLANDBUY", 1, 48, 1}},
		{npc = "'Smartass'", args = {"tundrasuppressor", nil, 1, "SELLANDBUY", 1, 48, 1}},
		{npc = "'Smartass'", args = {"cobrasuppressor", nil, 1, "SELLANDBUY", 1, 48, 1}},
	},
})
