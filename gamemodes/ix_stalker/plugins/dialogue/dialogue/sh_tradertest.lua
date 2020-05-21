DIALOGUE.name = "Trader Test"

DIALOGUE.addTopic("GREETING", {
	response = "Wassap negr!",
	options = {
		"TradeTopic", 
		"RepairTopic",
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
		"GOODBYE"
	}
})

DIALOGUE.addTopic("RepairTopic", {
	statement = "Can you repair my gear?",
	response = "",
	preCallback = function(self, client, target)
		if (CLIENT) then
			self.response = "Sure, "..client:GetName()..", let me see."
		end
	end,
	options = {
		"BackTopic",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Nevermind.",
	response = "All right.",
	options = {
		"TradeTopic", 
		"RepairTopic",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you!",
	response = "Going so soon?"
})