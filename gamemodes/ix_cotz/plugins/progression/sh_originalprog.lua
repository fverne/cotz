ix.progression.Register("originalSurvival1", {
	name = "Field provisions",
	description = "Field provisions",
	keyNpc = "'The Original'",
	progMap = "rp_marsh_cs",
	defaultActive = true,
	lootMapTier = 1,
	requirementSlots = {
		{pool = "canned_food", quantity = 2},
	},
	nextProgressions = {"originalSurvival2"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	briefing = (
		"First rule: return with enough left to eat tomorrow. Bring a couple of provisions and "
		.. "I'll put together something simple for your next walk."
	),
	completionMessage = "You're learning. Keep enough for the return journey and we'll get along fine.",
	completionBenefits = {items = {{item = "food_can_tushonka"}, {item = "drink_bottlewater"}}},
})

ix.progression.Register("originalSurvival2", {
	name = "Cooking practice",
	description = "Cooking practice",
	keyNpc = "'The Original'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 1,
	requirementSlots = {
		{pool = "common_meals", quantity = 2},
	},
	nextProgressions = {"originalSurvival3"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	briefing = (
		"You can live on cold tins, but you don't have to. Show me you can bring back a cooked "
		.. "meal and I'll help keep your little stove going."
	),
	completionMessage = "You're learning. Keep enough for the return journey and we'll get along fine.",
	completionBenefits = {items = {{item = "lowtiercookerfuel"}}},
})

ix.progression.Register("originalSurvival3", {
	name = "Survival commission",
	description = "Survival commission",
	keyNpc = "'The Original'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 1,
	requirementSlots = {
		{pool = "common_parts", quantity = 3},
	},
	nextProgressions = {},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	briefing = (
		"A full belly isn't the whole lesson. Bring proof you've learned to deal with the "
		.. "local wildlife, and I'll send you off with proper field supplies."
	),
	completionMessage = "You're learning. Keep enough for the return journey and we'll get along fine.",
	completionBenefits = {items = {{item = "medic_bandage_2"}, {item = "food_can_tushonka"}}},
})
