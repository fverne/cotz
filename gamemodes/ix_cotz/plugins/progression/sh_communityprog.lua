ix.progression.Register("communitySupport1", {
	name = "Community provisions",
	description = "Community provisions",
	keyNpc = "NPC",
	progMap = "*",
	defaultActive = true,
	lootMapTier = 1,
	requirementSlots = {
		{pool = "canned_food", quantity = 2},
	},
	nextProgressions = {"communitySupport2"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	briefing = (
		"Cheese is good. A stocked cupboard is better. Bring food for the people passing "
		.. "through, and there will be a little water and tea for you."
	),
	completionMessage = "Useful things. Reliable person. The community remembers.",
	completionBenefits = {items = {{item = "drink_bottlewater"}, {item = "drink_bottletea"}}},
})

ix.progression.Register("communitySupport2", {
	name = "Workshop contribution",
	description = "Workshop contribution",
	keyNpc = "NPC",
	progMap = "*",
	defaultActive = false,
	lootMapTier = 1,
	requirementSlots = {
		{pool = "fasteners", quantity = 6},
	},
	nextProgressions = {"communitySupport3"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	briefing = (
		"Things break. People leave. The tools stay if someone brings the fittings. Help keep "
		.. "the workshop together and take a field supply for the trouble."
	),
	completionMessage = "Useful things. Reliable person. The community remembers.",
	completionBenefits = {items = {{item = "medic_bandage_1"}}},
})

ix.progression.Register("communitySupport3", {
	name = "Sustained support",
	description = "Sustained support",
	keyNpc = "NPC",
	progMap = "*",
	defaultActive = false,
	lootMapTier = 1,
	requirementSlots = {
		{pool = "workshop_supplies", quantity = 4},
	},
	nextProgressions = {},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	briefing = (
		"You've brought more than promises. Help with this last workshop order and the "
		.. "community will remember you as a dependable supplier."
	),
	completionMessage = "Useful things. Reliable person. The community remembers.",
	completionBenefits = {items = {{item = "food_can_tushonka"}}},
	recognition = "Trusted Community Supplier",
})
