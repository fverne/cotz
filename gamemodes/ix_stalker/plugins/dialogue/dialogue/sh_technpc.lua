DIALOGUE.name = "Technut"

DIALOGUE.addTopic("GREETING", {
	response = "Hello, buddy!",
	options = {
		"InterestTopic",
		"TradeTopic", 
		"RepairItems",
		"BackgroundTopic",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("TradeTopic", {
	statement = "Want to trade?",
	response = "Absolutely!",
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

DIALOGUE.addTopic("RepairItems", {
	statement = "Can you repair my items?",
	response = "Hoho! Sure! What would you like me to look at?",
	IsDynamic = true,
	options = {
		"BackTopic"
	},
	GetDynamicOptions = function(self, client, target)
		local dynopts = {}

		local items = client:GetCharacter():GetInventory():GetItems()

		for k,v in pairs(items) do
			if v.canRepair then
				if v.isWeapon then
					local percenttorepair = (100 - v:GetData("wear", 100))
					if(percenttorepair < 0.5) then continue end
					local repaircost = math.Round(percenttorepair * v:GetRepairCost())

					table.insert(dynopts, {statement = v:GetName().." ( "..math.Round(v:GetData("wear", 100)).."% Wear ) - "..ix.currency.Get(repaircost), topicID = "RepairItems", dyndata = {itemuid = v.uniqueID , itemid = v:GetID(), cost = repaircost, type="wear"}})
				else
					local percenttorepair = (100 - v:GetData("durability", 100))
					if(percenttorepair < 0.5) then continue end
					local repaircost = math.Round(percenttorepair * v:GetRepairCost())

					table.insert(dynopts, {statement = v:GetName().." ( "..math.Round(v:GetData("durability", 100)).."% Durability ) - "..ix.currency.Get(repaircost), topicID = "RepairItems", dyndata = {itemuid = v.uniqueID , itemid = v:GetID(), cost = repaircost, type="durability"}})
				end
			end
		end
		
		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption
		return dynopts
	end,
	ResolveDynamicOption = function(self, client, target, dyndata)

		-- Return the next topicID
		if( !client:GetCharacter():HasMoney(dyndata.cost)) then
			return "NotEnoughMoneyRepair"
		end
		return "ConfirmRepair", dyndata
	end,
})

DIALOGUE.addTopic("ConfirmRepair", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	IsDynamic = true,
	DynamicPreCallback = function(self, player, target, dyndata)
		if(dyndata) then
			if (CLIENT) then
				self.response = string.format("Jeesh! Repairing that %s will cost you %s, is that a deal?", ix.item.list[dyndata.itemuid].name ,ix.currency.Get(dyndata.cost))
			else
				target.repairstruct = { dyndata.itemid, dyndata.cost, dyndata.type }
			end
		end
	end,
	GetDynamicOptions = function(self, client, target)

		local dynopts = {
			{statement = "That's fine, repair it.", topicID = "ConfirmRepair", dyndata = {accepted = true}},
			{statement = "On second thought...", topicID = "ConfirmRepair", dyndata = {accepted = false}},
		}

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption
		return dynopts
	end,
	ResolveDynamicOption = function(self, client, target, dyndata)
		if( SERVER and dyndata.accepted ) then
			ix.dialogue.notifyMoneyLost(client, target.repairstruct[2])
			client:GetCharacter():TakeMoney(target.repairstruct[2])


			ix.item.instances[target.repairstruct[1]]:SetData(target.repairstruct[3], 100)

			if (ix.item.instances[target.repairstruct[1]].class) then
				local wep = client:GetWeapon(ix.item.instances[target.repairstruct[1]].class)
				if(wep)then
					wep:SetWeaponWear(100)
				end
			end

		end
		if(SERVER)then
			target.repairstruct = nil
		end
		-- Return the next topicID
		return "BackTopic"
	end,
})

DIALOGUE.addTopic("NotEnoughMoneyRepair", {
	statement = "",
	response = "Oh no... You don't have enough money to repair that..",
	options = {
		"BackTopic"
	}
})


local interestingoptions = {"Yeah, the Zone is a dangerous place! But It also houses many scraps.. A man's trash is another mans treasure..",
	"Have you heard about the tech god? Thats me.",
	"Some people say there's a big area called the garbage, that sounds like heaven to me..."
}

DIALOGUE.addTopic("InterestTopic", {
	statement = "Can you tell me something useful?",
	response = table.Random(interestingoptions),
	options = {
		"BackTopic"
	}
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "Tell me about yourself.",
	response = "Hoho! Well, what is there to say? I live here, after... Well, deserting!",
	options = {
		"BackgroundTopic2",
	}
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "Really? Is that so?",
	response = "Yeah, it happened back in 2007, after the first incident we were all cut off, I didn't want to stick any longer so I left.",
	options = {
		"BackgroundTopic3",
	}
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "Sorry to hear that...",
	response = "Dont worry about it. Anything else?",
	options = {
		"BackTopic",
	}
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about another topic.",
	response = "Don't worry about it. Anything else?",
	options = {
		"InterestTopic",
		"TradeTopic", 
		"RepairItems",
		"BackgroundTopic",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "I'll talk to you later.",
	response = "Hey, come back soon!"
})