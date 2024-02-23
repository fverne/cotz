DIALOGUE.name = "Medic NPC"

DIALOGUE.addTopic("GREETING", {
	response = "Welcome!",
	options = {
        "TradeTopic", 
		"HealTopic",
		"AboutProgression",
		"GOODBYE"
	},
	preCallback = function(self, client, target)
		-- Only needed if NPC offers tasks
		-- 4th argument is the categories to grab tasks from
		-- 5th argument is the amount of tasks to grab
		-- netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(), {"mutantkillgroupeasy"}, 4)
	end
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about something else.",
	response = "What would you like to know?",
	options = {
		"TradeTopic", 
		"HealTopic",
		"AboutProgression",
		"GOODBYE"
	} --Should be identical to GREETING's options
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you!",
	response = "Take care, STALKER..."
})

----------------------------------------------------------------
----------------------START-TRADER-START------------------------
----------------------------------------------------------------

DIALOGUE.addTopic("TradeTopic", {
	statement = "Want to trade?",
	response = "How can I help?",
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

----------------------------------------------------------------
------------------------END-TRADER-END--------------------------
----------------------------------------------------------------


DIALOGUE.addTopic("ViewProgression", {
	statement = "",
	response = "",
	options = {
		"BackTopic"
	},

	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynopts = {}

		--disgusting
		--local identifier = player:GetCharacter():GetData("curdialogprog")
		local identifier 	= self.tmp
		self.tmp = nil
		local progstatus 	= ix.progression.GetComplexProgressionValue(identifier)
		local progdef 		= ix.progression.definitions[identifier]
		if(progdef.fnAddComplexProgression)then
			local progitems 	= progdef.GetItemIds()
			local missingitems  = {}

			for progitem,cnt in pairs(progitems) do
				local curcnt = 0
				if(progstatus and progstatus[progitem]) then curcnt = progstatus[progitem] end

				if(curcnt < cnt and client:GetCharacter():GetInventory():HasItem(progitem))then
					table.insert(missingitems, progitem)
				end
			end

			for _, progitem in pairs(missingitems) do
				table.insert(dynopts, {statement = "Hand over "..ix.item.list[progitem].name, topicID = "ViewProgression", dyndata = {progid = identifier, itemid = progitem}})
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
		return "HandInComplexProgressionItemTopic", dyndata
	end,

	IsDynamicFollowup = true,
	DynamicPreCallback = function(self, player, target, dyndata)
		if (dyndata) then
			if(CLIENT)then
				local progstatus 	= ix.progression.status[dyndata.identifier]
				local progdef 		= ix.progression.definitions[dyndata.identifier]

				self.response = progdef.BuildResponse(progdef, progstatus)
				self.tmp = dyndata.identifier
			end
		end
	end,
})

DIALOGUE.addTopic("HandInComplexProgressionItemTopic", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	options = {
		"BackTopic"
	},
	DynamicPreCallback = function(self, player, target, dyndata)
		if (dyndata) then
			if(CLIENT)then
				self.response = string.format("Do you have %s?", ix.item.list[dyndata.itemid].name)
			else
				if ix.progression.IsActive(dyndata.progid) then
					
					local item = player:GetCharacter():GetInventory():HasItem(dyndata.itemid)

					local dat = ix.progression.status[dyndata.progid].complexData
					dat = dat or {}
					local amtcur = dat[dyndata.itemid] or 0

					local reqitems = ix.progression.GetComplexProgressionReqs(dyndata.progid)
					local amtreq = reqitems[dyndata.itemid]

					local amtneed = amtreq - amtcur

					if(item)then
						local amtavailable = item:GetData("quantity", item.quantity or 1)
						local amtfinal = amtavailable >= amtneed and amtneed or amtavailable

						item:SetData("quantity", item:GetData("quantity",0) - amtfinal)
						
						if(item:GetData("quantity", 0) < 1)then
							item:Remove()
						end

						--Adds reward
						repReward, monReward = ix.util.GetValueFromProgressionTurnin(item, amtfinal)
						player:addReputation(repReward)
						ix.dialogue.notifyReputationReceive(player, repReward)
						player:GetCharacter():GiveMoney(monReward)
						ix.dialogue.notifyMoneyReceive(player, monReward)

						ix.progression.AddComplexProgressionValue(dyndata.progid, {dyndata.itemid, amtfinal}, player:Name())
					end
				end
			end	
		end
	end,
} )

DIALOGUE.addTopic("AboutProgression", {
	statement = "What do you need help with?",
	response = "I have a few things I need done.",
	options = {
		"BackTopic"
	},
	preCallback = function(self, client, target)
		if( CLIENT ) then
			if #ix.progression.GetActiveProgressions("'Jitters'") <= 0 then
				self.response = "Nothing at the moment."
			end

			net.Start("progression_sync")
			net.SendToServer()
		end
	end,
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynopts = {}

		for _, progid in pairs(ix.progression.GetActiveProgressions("'Jitters'")) do
			table.insert(dynopts, {statement = ix.progression.definitions[progid].name, topicID = "AboutProgression", dyndata = {identifier = progid}})
		end

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption
		return dynopts
	end,
	ResolveDynamicOption = function(self, client, target, dyndata)

		-- Return the next topicID
		return "ViewProgression", dyndata
	end,
})


----------------------------------------------------------------
-----------------------START-HEAL-START-------------------------
----------------------------------------------------------------

DIALOGUE.addTopic("HealTopic", {
	statement = "Can you patch me up?",
	response = "What would you like me to look at?",
	IsDynamic = true,
	options = {
		"BackTopic"
	},
	GetDynamicOptions = function(self, client, target)
		local dynopts = {}
        local pricePerHp = 2
        local pricePerRad = 3
        local pricePerPsy = 4

        local percentPerHp = (100 - client:Health())
        local percentPerRad = (client:getRadiation())
        local percentPerPsy = (100 - client:GetPsyHealth())

        local hpCost = math.Round(percentPerHp * pricePerHp)
        local radCost = math.Round(percentPerRad * pricePerRad)
        local psyCost = math.Round(percentPerPsy * pricePerPsy)

        table.insert(dynopts, {statement = "My Physical Health ( "..client:Health().."% ) - "..ix.currency.Get(hpCost), topicID = "HealTopic", dyndata = {cost = hpCost, type="hp"}})
        table.insert(dynopts, {statement = "My Radiation Level ( "..client:getRadiation().."% ) - "..ix.currency.Get(radCost), topicID = "HealTopic", dyndata = {cost = radCost, type="rad"}})
        table.insert(dynopts, {statement = "My Mental Health ( "..client:GetPsyHealth().."% ) - "..ix.currency.Get(psyCost), topicID = "HealTopic", dyndata = {cost = psyCost, type="psy"}})
        table.insert(dynopts, {statement = "Everything - "..ix.currency.Get(hpCost + radCost + psyCost), topicID = "HealTopic", dyndata = {cost = hpCost + radCost + psyCost, type="all"}})

		return dynopts
	end,
	ResolveDynamicOption = function(self, client, target, dyndata)

		-- Return the next topicID
		if( !client:GetCharacter():HasMoney(dyndata.cost)) then
			return "NotEnoughMoneyHeal"
		end
		return "ConfirmHeal", dyndata
	end,
})

DIALOGUE.addTopic("ConfirmHeal", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	IsDynamic = true,
	DynamicPreCallback = function(self, player, target, dyndata)
		if(dyndata) then
			if (CLIENT) then
				self.response = string.format("Patching you up will cost you %s.", ix.currency.Get(dyndata.cost))
			else
				target.healstruct = { dyndata.cost, dyndata.type }
			end
		end
	end,
	GetDynamicOptions = function(self, client, target)

		local dynopts = {
			{statement = "I can agree to that. Go ahead and heal me.", topicID = "ConfirmHeal", dyndata = {accepted = true}},
			{statement = "On second thought...", topicID = "ConfirmHeal", dyndata = {accepted = false}},
		}

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption
		return dynopts
	end,
	ResolveDynamicOption = function(self, client, target, dyndata)
		if( SERVER and dyndata.accepted ) then
			ix.dialogue.notifyMoneyLost(client, target.healstruct[1])
			client:GetCharacter():TakeMoney(target.healstruct[1])

            if target.healstruct[2] == "hp" then
                client:SetHealth(100)
            elseif target.healstruct[2] == "rad" then
                client:setRadiation(0)
            elseif target.healstruct[2] == "psy" then
                client:SetPsyHealth(100)
            elseif target.healstruct[2] == "all" then
                client:SetHealth(100)
                client:setRadiation(0)
                client:SetPsyHealth(100)
            end

		end
		if(SERVER)then
			target.healstruct = nil
		end
		-- Return the next topicID
		return "BackTopic"
	end,
})

DIALOGUE.addTopic("NotEnoughMoneyHeal", {
	statement = "",
	response = "Not enough money for that.",
	options = {
		"BackTopic"
	}
})

----------------------------------------------------------------
-------------------------END-HEAL-END---------------------------
----------------------------------------------------------------
