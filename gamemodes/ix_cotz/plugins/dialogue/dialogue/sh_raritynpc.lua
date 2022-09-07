DIALOGUE.name = "Rarity NPC"

DIALOGUE.addTopic("GREETING", {
	response = " ** The entity spins in silence. **",
	options = {
		"TradeTopic",
		"SpecialSaleTopic",
		"GOODBYE"
	},
	preCallback = function(self, client, target)
		if SERVER then
			local cooldown = target:GetNetVar("lastSpecialSale", 0)
			if cooldown < os.time() then
				local randomItems = {}
				local randomItemCategories = {
					{itemCategory = "specialsale_raritynpc_smg_1", dialogue = "I like to run and gun, and I'd like something small and fast-shooting.", reqRep = 0},
					{itemCategory = "specialsale_raritynpc_rifle_1", dialogue = "I'm looking weapons that can deal with a bit of everything.", reqRep = 282},
					{itemCategory = "specialsale_raritynpc_longrifle_1", dialogue = "I'm looking for a weapon to kill things from afar.", reqRep = 765},
					{itemCategory = "specialsale_raritynpc_heavy_1", dialogue = "I like to keep shooting until there is nothing left to shoot at.", reqRep = 9338},
					{itemCategory = "specialsale_raritynpc_shotgun_1", dialogue = "I want to fill mutants with pellets of lead.", reqRep = 1943},
					{itemCategory = "specialsale_raritynpc_br_1", dialogue = "I'm looking for better protection against mutants.", reqRep = 50},
					{itemCategory = "specialsale_raritynpc_headgear_1", dialogue = "I'm looking for better headwear.", reqRep = 50},
					{itemCategory = "specialsale_raritynpc_ar_1", dialogue = "I'm the clumsy type, and often stumble into anomalous zones. I'm looking for protection.", reqRep = 4254},
				}

				for k,v in pairs(randomItemCategories) do
					local idat = ix.util.GetRandomItemFromPool(v.itemCategory)
					-- ensure the character has a reputation level high
					if client:getReputation() >= v.reqRep then
						table.insert(randomItems, {idat[1], idat[2], v.dialogue})
					end
				end

				target:SetNetVar("specialSaleItems", randomItems)
				target:SetNetVar("lastSpecialSale", os.time() + ix.config.Get("specialSaleCooldown", 30))
			end
		end
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

DIALOGUE.addTopic("SpecialSaleTopic", {
	statement = "Do you take special orders?",
	response = "...",
	IsDynamic = true,
	options = {
		"BackTopic",
	},
	GetDynamicOptions = function(self, client, target)
		local dynopts = {}
		local randomItems = target:GetNetVar("specialSaleItems")
		
		for k,v in pairs(randomItems) do
			local item = ix.item.list[v[1]]
			local itemdata = ix.item.list[v[2]]
			local dialogue = v[3]
			table.insert(dynopts, {statement = "I'd like to purchase a " ..item.name.. " (Price: " .. item.price.. ")", topicID = "SpecialSaleTopic", dyndata = {itemuid = item.uniqueID, cost = item.price, itemdata = itemdata}})
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
			return "NotEnoughMoneyBuy"
		end

		return "ConfirmSpecialSale", dyndata
	end,
})

DIALOGUE.addTopic("ConfirmSpecialSale", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	IsDynamic = true,
	DynamicPreCallback = function(self, player, target, dyndata)
		if(dyndata) then
			if (CLIENT) then
				self.response = string.format("%s.", dyndata.cost)
			else
				target.specialsalestruct = { dyndata.itemuid, dyndata.cost, dyndata.itemdata }
			end
		end
	end,
	GetDynamicOptions = function(self, client, target)

		local dynopts = {
			{statement = "Uhm, sure, here.", topicID = "ConfirmSpecialSale", dyndata = {accepted = true}},
			{statement = "You're not getting my money.", topicID = "ConfirmSpecialSale", dyndata = {accepted = false}},
		}

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption
		return dynopts
	end,
	ResolveDynamicOption = function(self, client, target, dyndata)
		if( SERVER and dyndata.accepted and client:GetCharacter():GetInventory():Add(target.specialsalestruct[1], 1, target.specialsalestruct[3] or {})) then
			ix.dialogue.notifyItemGet(client, ix.item.list[target.specialsalestruct[1]].name)
			ix.dialogue.notifyMoneyLost(client, target.specialsalestruct[2])
			client:GetCharacter():TakeMoney(target.specialsalestruct[2])
		end
		if(SERVER)then
			target.specialsalestruct = nil
		end
		-- Return the next topicID
		return "BackTopic"
	end,
})

DIALOGUE.addTopic("NotEnoughMoneyBuy", {
	statement = "",
	response = "** The entity ignores you. **",
	options = {
		"BackTopic"
	}
})

DIALOGUE.addTopic("BackTopic", {
	statement = "How about something else.",
	response = "...",
	options = {
		"TradeTopic",
		"SpecialSaleTopic",
		"GOODBYE"
	},
	preCallback = function(self, client, target)
		if SERVER then
			local cooldown = target:GetNetVar("lastSpecialSale", 0)
			if cooldown < os.time() then
				local randomItemCategories = {
					{itemCategory = "specialsale_raritynpc_smg_1", dialogue = "I like to run and gun, and I'd like something small and fast-shooting.", reqRep = 0},
					{itemCategory = "specialsale_raritynpc_rifle_1", dialogue = "I'm looking weapons that can deal with a bit of everything.", reqRep = 282},
					{itemCategory = "specialsale_raritynpc_longrifle_1", dialogue = "I'm looking for a weapon to kill things from afar.", reqRep = 765},
					{itemCategory = "specialsale_raritynpc_heavy_1", dialogue = "I like to keep shooting until there is nothing left to shoot at.", reqRep = 9338},
					{itemCategory = "specialsale_raritynpc_shotgun_1", dialogue = "I want to fill mutants with pellets of lead.", reqRep = 1943},
					{itemCategory = "specialsale_raritynpc_br_1", dialogue = "I'm looking for better protection against mutants.", reqRep = 50},
					{itemCategory = "specialsale_raritynpc_headgear_1", dialogue = "I'm looking for better headwear.", reqRep = 50},
					{itemCategory = "specialsale_raritynpc_ar_1", dialogue = "I'm the clumsy type, and often stumble into anomalous zones. I'm looking for protection.", reqRep = 4254},
				}
				local randomItems = {}

				for k,v in pairs(randomItemCategories) do
					local idat = ix.util.GetRandomItemFromPool(v.itemCategory)
					-- ensure the character has a reputation level high
					if client:getReputation() >= v.reqRep then
						table.insert(randomItems, {idat[1], idat[2], v.dialogue})
					end
				end

			
				target:SetNetVar("specialSaleItems", randomItems)
				target:SetNetVar("lastSpecialSale", os.time() + ix.config.Get("specialSaleCooldown", 30))
			end
		end
	end
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "I'll be going.",
	response = "..."
})

