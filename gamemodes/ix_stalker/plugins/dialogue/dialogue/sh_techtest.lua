DIALOGUE.name = "Trader Test"

DIALOGUE.addTopic("GREETING", {
	response = "Hmm?",
	options = {
		"InterestTopic",
		"TradeTopic", 
		"RepairItems",
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

DIALOGUE.addTopic("RepairItems", {
	statement = "Can you repair my items?",
	response = "What would you like me to look at?",
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
				self.response = string.format("Repairing that %s will cost you %s, is that a deal?", ix.item.list[dyndata.itemuid].name ,ix.currency.Get(dyndata.cost))
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
	response = "You don't have enough money to repair that..",
	options = {
		"BackTopic"
	}
})

DIALOGUE.addTopic("InterestTopic", {
	statement = "Can you tell me something useful?",
	response = "Sneed.",
	options = {
		"BackTopic"
	}
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about another topic.",
	response = "All right.",
	options = {
		"InterestTopic",
		"TradeTopic", 
		"RepairItems",
		"GOODBYE"
	}
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you!",
	response = "Come back soon, STALKER..."
})