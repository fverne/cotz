local map = "rp_marsh_cs"

ix.progression.Register("cleanerItemDelivery_Storage", {
	name = "Storage",
	description = "Cleaner has an offer for you.",
	keyNpc = "'Cleaner'",
	defaultActive = true,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		local dat = status or {}

		local itemids = self:GetItemIds()

		local str = "Greetings, stalker. If you've noticed, you aren't capble of carrying everything you own; it's simply impossible. Stashes are risky, but I've got a little side business that I'm putting together that I think could be beneficial for you. I'm working on getting together some private storage, but require an investment or two from some willing patrons. Are you interested?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_bolt"] = 1,
		}

		return itemids
	end,
	OnComplete = function(character)
		timer.Simple(60, function()
			local name = "'Cleaner'"
			local message = "For a small fee, you can now get your stuff stored by yours truly."
			ix.progression.Notify(character, name, message)
		end)
	end
})
