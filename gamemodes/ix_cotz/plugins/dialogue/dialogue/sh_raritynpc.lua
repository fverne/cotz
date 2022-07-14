DIALOGUE.name = "Rarity NPC"

DIALOGUE.addTopic("GREETING", {
	response = " ** The entity spins in silence. **",
	options = {
		"TradeTopic",
		-- put specialsale here
		"GOODBYE"
	},
	preCallback = function(self, client, target)
		netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(), {"mutantkillgroupeasy", "mutantkilleasy"}, 4)
	end
})

DIALOGUE.addTopic("TradeTopic", {
	statement = "Uhm, do you have anything I can buy?",
	response = "...",
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



DIALOGUE.addTopic("BackTopic", {
	statement = "I have something else actually",
	response = "...",
	options = {
		"TradeTopic",
		-- put specialsale here
		"GOODBYE"
	},
	preCallback = function(self, client, target)
		netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(), {"mutantkillgroupeasy", "mutantkilleasy"}, 4)
	end
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you around.",
	response = "..."
})

