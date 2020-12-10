DIALOGUE.name = "Trader Test"

DIALOGUE.addTopic("GREETING", {
	response = "What is it?",
	options = {
		"TradeTopic",
		"BackgroundTopic",
		"InterestTopic",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("TradeTopic", {
	statement = "Want to trade?",
	response = "Yes",
	postCallback = function(self, client, target)
		if (SERVER) then
			local character = client:GetCharacter()

			target.receivers[#target.receivers + 1] = client

			local items = {}

			-- Only send what is needed.
			for k, v in pairs(target.items) do
				if (!table.IsEmpty(v) and (CAMI.PlayerHasAccess(client, "Helix - Manage Vendors", nil) or v[VENDOR_MODE])) then
					items[k] = v
				end
			end

			target.scale = target.scale or 0.5

			client.ixVendorAdv = target

			-- force sync to prevent outdated inventories while buying/selling
			if (character) then
				character:GetInventory():Sync(client, true)
			end

			net.Start("ixVendorAdvOpen")
				net.WriteEntity(target)
				net.WriteUInt(target.money or 0, 16)
				net.WriteTable(items)
				net.WriteFloat(target.scale or 0.5)
			net.Send(client)

			ix.log.Add(client, "vendorUse", target:GetDisplayName())
		end
	end,
	options = {
		"BackTopic",
	}
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "Tell me about yourself.",
	response = "Not a whole lot to know. I came here a few months ago, after the military presence ramped up their presence around here - turns out the swamps are the only place they haven't really cut off around the perimeter of the zone, which means that this is where we stay for now. I worked as a trader back in the days, so thought I might as well put my skills to use here too. Oh, and I have a bunch of friends who can get things. And remove things, like you, if you keep asking.",
	options = {
		"BackTopic",
	}
})

DIALOGUE.addTopic("InterestTopic", {
	statement = "Can you tell me something interesting?",
	response = "Sure. How about you do business with me, or shut the fuck up?",
	options = {
		"BackTopic",
	}
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about something else...",
	response = "All right.",
	options = {
		"TradeTopic",
		"BackgroundTopic",
		"InterestTopic",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you around.",
	response = "Come back soon, STALKER..."
})