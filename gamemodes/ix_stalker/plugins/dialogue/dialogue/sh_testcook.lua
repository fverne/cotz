DIALOGUE.name = "Universal Union"

DIALOGUE.addTopic("GREETING", {
	response = "Welcome to the zone!",
	options = {
		"Topic01", 
		"Topic02",
		"Topic03",
		"TradeTopic",
		"RepairItems",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("Topic01", {
	statement = "Who are you?",
	response = "I'm the tech here.",
	options = {
		"Return",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("Topic02", {
	statement = "Can I get something for free?",
	response = "No.",
	options = {
		"Return",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("Topic03", {
	statement = "Why is Helix such a nice framework?",
	response = "It's pretty neat, yeah.",
	options = {
		"Return",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("Return", {
	statement = "Let's talk about something else.",
	response = "What would you like to know?",
	options = {
		"Topic01",
		"Topic02",
		"Topic03",
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
		"Return",
		"GOODBYE"
	}
})


DIALOGUE.addTopic("GOODBYE", {
	statement = "Goodbye.",
	response = "Adios, negr..."
})