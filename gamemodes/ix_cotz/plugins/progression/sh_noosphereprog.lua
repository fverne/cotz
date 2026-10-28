ix.progression.Register("noosphereAttunement1", {
	name = "Attunement",
	description = "Attunement",
	keyNpc = "'???'",
	progMap = "rp_pripyat_remaster",
	defaultActive = true,
	lootMapTier = 3,
	requirementSlots = {
		{pool = "common_artifacts", quantity = 2},
	},
	nextProgressions = {"noosphereAttunement2"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	briefing = (
		"You have made the machine listen. Now let the Zone answer. Bring the lesser echoes "
		.. "before you ask it for anything more."
	),
	completionMessage = "Your offering is heard. What has been earned will not be forgotten.",
	completionBenefits = {},
	recognition = "Heard by the Noosphere",
})

ix.progression.Register("noosphereAttunement2", {
	name = "Anomalous proof",
	description = "Anomalous proof",
	keyNpc = "'???'",
	progMap = "rp_pripyat_remaster",
	defaultActive = false,
	lootMapTier = 3,
	requirementSlots = {
		{pool = "rare_field_artifacts", quantity = 2},
	},
	nextProgressions = {"noosphereAttunement3"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	briefing = (
		"Every wish has a cost. Bring these deeper impressions and part of a future payment "
		.. "will be forgiven. A free wish will consume none of that favour."
	),
	completionMessage = "Your offering is heard. What has been earned will not be forgotten.",
	completionBenefits = {services = {{npc = "'???'", service = "wish", amount = 25000}}},
})

ix.progression.Register("noosphereAttunement3", {
	name = "Noosphere recognition",
	description = "Noosphere recognition",
	keyNpc = "'???'",
	progMap = "rp_pripyat_remaster",
	defaultActive = false,
	lootMapTier = 3,
	requirementSlots = {
		{pool = "exceptional_artifacts", quantity = 1},
	},
	nextProgressions = {},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	briefing = (
		"One final proof. Bring what ordinary fields rarely surrender, and you will be "
		.. "recognised as one who has heard the silence between wishes."
	),
	completionMessage = "Your offering is heard. What has been earned will not be forgotten.",
	completionBenefits = {},
	recognition = "Witness of the Noosphere",
	serviceDiscounts = {{npc = "'???'", service = "wish", fraction = 0.025}},
})
