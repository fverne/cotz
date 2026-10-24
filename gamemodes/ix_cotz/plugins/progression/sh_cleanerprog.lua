local MAP = "rp_marsh_cs"

ix.progression.Register("cleanerItemDelivery_Storage", {
	name = "Storage",
	description = "Cleaner has an offer for you.",
	keyNpc = "'Cleaner'",
	defaultActive = true,
	progMap = MAP,
	BuildResponse = function(self, npcName, status)
		local data = status or {}

		local itemIDs = self:GetItemIds()

		local str = (
			"Greetings, stalker. If you've noticed, you aren't capble "
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
	GetItemIds = function()
		local itemIDs = {
			["artifact_bolt"] = 1,
		}

		return itemIDs
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Cleaner'"
			local message = "For a small fee, you can now get your stuff stored by yours truly."
			ix.progression.Notify(character, name, message)
		end)
	end,
})
