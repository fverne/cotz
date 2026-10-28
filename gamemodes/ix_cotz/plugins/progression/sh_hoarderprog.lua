ix.progression.Register("hoarderCollection1", {
	name = "Appraisal",
	description = "Appraisal",
	keyNpc = "'Hoarder'",
	progMap = "*",
	defaultActive = true,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "small_valuables", quantity = 1},
	},
	nextProgressions = {"hoarderCollection2"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	briefing = (
		"Small things pass through many hands. Bring one worth my attention. I may have "
		.. "ammunition for a weapon less ordinary than yours."
	),
	completionMessage = "Accepted. The interesting parts of our arrangement are now recorded.",
	completionBenefits = {items = {{item = "500magnum"}}},
})

ix.progression.Register("hoarderCollection2", {
	name = "Collectors commission",
	description = "Collectors commission",
	keyNpc = "'Hoarder'",
	progMap = "*",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "attachments", quantity = 2},
	},
	nextProgressions = {"hoarderCollection3"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	briefing = (
		"An interesting fitting is worth more to me than another story. Bring the requested "
		.. "attachments, and I will consider selling you the large revolver."
	),
	completionMessage = "Accepted. The interesting parts of our arrangement are now recorded.",
	completionBenefits = {items = {{item = "500magnum"}}},
	vendorUnlocks = {{npc = "'Hoarder'", args = {"sw500", nil, 1, "SELLANDBUY", 1, 48, 1}}},
})

ix.progression.Register("hoarderCollection3", {
	name = "Advanced collection",
	description = "Advanced collection",
	keyNpc = "'Hoarder'",
	progMap = "*",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "suppressors", quantity = 2},
	},
	nextProgressions = {"hoarderCollection4"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	briefing = (
		"Quiet work leaves useful objects behind. Bring the suppressors I request. The VSSK "
		.. "will become available to purchase when our business is settled."
	),
	completionMessage = "Accepted. The interesting parts of our arrangement are now recorded.",
	completionBenefits = {items = {{item = "127x55"}}},
	vendorUnlocks = {{npc = "'Hoarder'", args = {"vssk", nil, 1, "SELLANDBUY", 1, 48, 1}}},
})

ix.progression.Register("hoarderCollection4", {
	name = "Prized collection",
	description = "Prized collection",
	keyNpc = "'Hoarder'",
	progMap = "*",
	defaultActive = false,
	lootMapTier = 2,
	requirementSlots = {
		{pool = "rare_field_artifacts", quantity = 2},
	},
	nextProgressions = {},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	briefing = (
		"Rarity alone does not make an object interesting. Bring the anomalous pieces on this "
		.. "list. Then I will open the Nitro offer. You will still need to afford it."
	),
	completionMessage = "Accepted. The interesting parts of our arrangement are now recorded.",
	completionBenefits = {items = {{item = "700nitro"}}},
	vendorUnlocks = {{npc = "'Hoarder'", args = {"nitro", nil, 1, "SELLANDBUY", 1, 48, 1}}},
})
