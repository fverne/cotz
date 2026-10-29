local MAP = "rp_marsh_cs"

ix.progression.Register("cleanerItemDelivery_Storage", {
	name = "Storage",
	description = "Cleaner has an offer for you.",
	keyNpc = "'Cleaner'",
	defaultActive = true,
	progMap = MAP,
	BuildResponse = function(self, npcName, status, character)
		local data = status or {}

		local itemIDs = ix.progression.GetRequirements(character, self.id)

		local str = (
			"Greetings, stalker. If you've noticed, you aren't capable "
			.. "of carrying everything you own; it's simply impossible. "
			.. "Stashes are risky, but I've got a little side business "
			.. "that I'm putting together that I think could be beneficial "
			.. "for you. I'm working on getting together some private storage, "
			.. "but require an investment or two from some willing patrons. "
			.. "Are you interested?\n\nREQUIRED ITEMS:"
		)

		for item, amount in pairs(itemIDs) do
			local currentAmount = 0
			if data and data[item] then
				currentAmount = data[item]
			end
			str = str .. string.format("\n%d %s", amount - currentAmount, ix.item.list[item].name)
		end

		return str
	end,
	lootMapTier = 1,
	requirementSlots = {
		{ pool = "common_artifacts", quantity = 1 },
	},
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Cleaner'"
			local message = string.format(
				"%s, you came through for me, so here's our arrangement: I'll store your belongings "
				.. "for a fee. Come see me when you need something kept safe.",
				character:GetName()
			)
			ix.progression.Notify(character, name, message)
		end)
	end,
})

ix.progression.Register("cleanerLogistics1", {
	name = "Local recovery",
	description = "Local recovery",
	keyNpc = "'Cleaner'",
	progMap = "rp_marsh_cs",
	defaultActive = true,
	lootMapTier = 1,
	requirementSlots = {
		{pool = "workshop_supplies", quantity = 2},
	},
	nextProgressions = {"cleanerLogistics2"},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	prerequisites = {"cleanerItemDelivery_Storage"},
	briefing = (
		"My shelves aren't held up by goodwill. Bring the workshop supplies and I'll put a "
		.. "little credit against your next storage expansion."
	),
	completionMessage = (
		"Delivery checked. Your storage arrangement is on the books; keep the next consignment "
		.. "in order."
	),
	completionBenefits = {services = {{npc = "'Cleaner'", service = "storage", amount = 300}}},
})

ix.progression.Register("cleanerLogistics2", {
	name = "Delivery preparation",
	description = "Delivery preparation",
	keyNpc = "'Cleaner'",
	progMap = "rp_marsh_cs",
	defaultActive = false,
	lootMapTier = 1,
	requirementSlots = {
		{pool = "field_maintenance", quantity = 2},
	},
	nextProgressions = {},
	BuildResponse = ix.progression.BuildDeliveryResponse,
	prerequisites = {"cleanerItemDelivery_Storage"},
	briefing = (
		"Deliveries arrive in every condition imaginable. Bring the field maintenance supplies "
		.. "and I'll improve our storage arrangement. The normal size limits still apply."
	),
	completionMessage = (
		"Delivery checked. Your storage arrangement is on the books; keep the next consignment "
		.. "in order."
	),
	completionBenefits = {services = {{npc = "'Cleaner'", service = "storage", amount = 600}}},
	serviceDiscounts = {{npc = "'Cleaner'", service = "storage", fraction = 0.05}},
})
