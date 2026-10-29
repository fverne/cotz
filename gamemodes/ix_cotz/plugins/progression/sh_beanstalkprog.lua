ix.progression.Register("beanstalkItemDelivery_Documents_stage1", {
	name = "STORY: Well Documented - 1/3",
	description = "STORY: Well Documented - 1/3",
	keyNpc = "'Beanstalk'",
	progMap = "rp_marsh_cs",
	defaultActive = true,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "small_electronics", quantity = 6},
	},
	nextProgressions = {"beanstalkItemDelivery_Documents_stage2"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "beanstalkItemDelivery_Documents",
	stageIndex = 1,
	stageCount = 3,
	briefing = (
		"Egghead wants a clean archive, and I've been given the dirty work. Bring the "
		.. "electronic parts first so I can get the records station functioning."
	),
	completionMessage = (
		"Logged, packed and finally off my desk. Thanks for making this expedition a little "
		.. "less chaotic."
	),
})

ix.progression.Register("beanstalkItemDelivery_Documents_stage2", {
	name = "STORY: Well Documented - 2/3",
	description = "STORY: Well Documented - 2/3",
	keyNpc = "'Beanstalk'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "small_electronics", quantity = 4},
		{pool = "documents_field", quantity = 6},
	},
	nextProgressions = {"beanstalkItemDelivery_Documents"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	milestoneGroup = "beanstalkItemDelivery_Documents",
	stageIndex = 2,
	stageCount = 3,
	briefing = (
		"The station is coming together. Now I need field records and the remaining "
		.. "electronics before I can pass a coherent archive upstairs."
	),
	completionMessage = (
		"Logged, packed and finally off my desk. Thanks for making this expedition a little "
		.. "less chaotic."
	),
})

ix.progression.Register("beanstalkExpedition1", {
	name = "Expedition outfitting",
	description = "Expedition outfitting",
	keyNpc = "'Beanstalk'",
	progMap = "rp_marsh_cs",
	defaultActive = true,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "field_instruments", quantity = 5},
	},
	nextProgressions = {},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	briefing = (
		"The next research party needs instruments, not another crate of rifles. Bring the "
		.. "field equipment and I'll release a small scientific resupply for your own trip."
	),
	completionMessage = (
		"Logged, packed and finally off my desk. Thanks for making this expedition a little "
		.. "less chaotic."
	),
	completionBenefits = {items = {{item = "medic_antirad_1"}, {item = "medic_psyheal_1"}}},
	prerequisites = {"beanstalkItemDelivery_Documents"},
})
