ix.progression.Register("computerDelivery_main_stage1", {
	name = "STORY: Getting up and running - 1/3",
	description = "STORY: Getting up and running - 1/3",
	keyNpc = "'Computer'",
	progMap = "rp_pripyat_remaster",
	defaultActive = false,
	lootMapTier = 3,
	requirementSlots = {
		{pool = "small_electronics", quantity = 8},
	},
	nextProgressions = {"computerDelivery_main_stage2"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "computerDelivery_main",
	stageIndex = 1,
	stageCount = 3,
	briefing = (
		"EXTERNAL OPERATOR DETECTED. Control circuits incomplete. Supply the listed electronic "
		.. "components to restore the diagnostic interface."
	),
	completionMessage = (
		"DELIVERY VERIFIED. Operator record updated. Consult the next requirements or "
		.. "outstanding reward claims."
	),
})

ix.progression.Register("computerDelivery_main_stage2", {
	name = "STORY: Getting up and running - 2/3",
	description = "STORY: Getting up and running - 2/3",
	keyNpc = "'Computer'",
	progMap = "rp_pripyat_remaster",
	defaultActive = false,
	lootMapTier = 3,
	requirementSlots = {
		{pool = "small_electronics", quantity = 4},
		{pool = "workshop_supplies", quantity = 8},
		{pool = "fuel", quantity = 4},
	},
	nextProgressions = {"computerDelivery_main"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "computerDelivery_main",
	stageIndex = 2,
	stageCount = 3,
	briefing = (
		"DIAGNOSTIC INTERFACE ONLINE. Power and maintenance systems remain incomplete. Supply "
		.. "the listed components before final research integration."
	),
	completionMessage = (
		"DELIVERY VERIFIED. Operator record updated. Consult the next requirements or "
		.. "outstanding reward claims."
	),
})
