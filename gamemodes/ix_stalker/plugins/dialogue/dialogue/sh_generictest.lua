DIALOGUE.name = "Generic Test"

DIALOGUE.addTopic("GREETING", {
	response = "Hey man.",
	options = {
		"InterestTopic",
		"TradeTopic", 
		"QuestTopic",
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

DIALOGUE.addTopic("InterestTopic", {
	statement = "Can you tell me something useful?",
	response = "",
	preCallback = function(self, client, target)
		if (CLIENT) then
			self.response = "You can find secret stashes around the zone, hidden by other stalkers. Anyone can dig them up, the person who hid it is most likely not here to recover it anyways..."
		end
	end,
	options = {
		"BackTopic"
	}
})

DIALOGUE.addTopic("QuestTopic", {
	statement = "Got anything you need done? I'll do it for a fee.",
	response = "",
	preCallback = function(self, client, target)
		if (CLIENT) then
			self.response = "Yes, actually, yesterday when I was out hunting for artifacts, I lost a valuable possession - my dead fathers canteen. Bloody cat mutants, they can really sneak up on you without making a sound. I lept at me from behind, and even though I managed to blast it with my shotgun before it killed me, it still somehow ripped my canteen clean off my belt. I didn't notice before I came back here, but no way I'm going out there any time soon. Can you find it for me? I'll give some vodka in return, as well as 500 Rubles."
		end
	end,
	options = {
		"QuestAccept",
		"BackTopic"
	}
})

DIALOGUE.addTopic("QuestAccept", {
	statement = "I'll find your canteen.",
	response = "",
	preCallback = function(self, client, target)
		if (CLIENT) then
			self.response = "Wow really? Thanks a lot man!"
		end
	end,
	options = {
		"BackTopic"
	}
})

DIALOGUE.addTopic("BackTopic", {
	statement = "I want to talk about something else.",
	response = "All right.",
	options = {
		"TradeTopic", 
		"InterestTopic", 
		"QuestTopic",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you!",
	response = "Going so soon?"
})