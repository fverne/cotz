DIALOGUE.name = "Medic NPC"

DIALOGUE.addTopic("GREETING", {
	response = "Welcome!",
	options = {
		"TradeTopic",
		"HealTopic",
		"AboutProgression",
		"GOODBYE",
	},
	preCallback = function(self, client, target)
		-- Only needed if NPC offers tasks
		-- 4th argument is the categories to grab tasks from
		-- 5th argument is the amount of tasks to grab
		-- netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(), {"mutantkillgroupeasy"},
		-- 4)
	end,
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about something else.",
	response = "What would you like to know?",
	options = {
		"TradeTopic",
		"HealTopic",
		"AboutProgression",
		"GOODBYE",
	}, -- Should be identical to GREETING's options
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you!",
	response = "Take care, STALKER...",
})

DIALOGUE.addTopic("TradeTopic", {
	statement = "Want to trade?",
	response = "How can I help?",
	postCallback = function(self, client, target)
		if SERVER then
			local character = client:GetCharacter()

			target.receivers[#target.receivers + 1] = client

			local items = {}
			-- Only send what is needed.
			for k, v in pairs(target.items) do
				if
					not table.IsEmpty(v)
					and (CAMI.PlayerHasAccess(client, "Helix - Manage Vendors", nil) or v[VENDOR_MODE])
				then
					if ix.progression.CanBuyItem(character, target:GetDisplayName(), k) then
						items[k] = v
					end
				end
			end

			target.scale = target.scale or 0.5
			client.ixVendorAdv = target

			-- force sync to prevent outdated inventories while buying/selling
			if character then
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
	},
})

DIALOGUE.addTopic("ViewProgression", {
	statement = "",
	response = "",
	options = {
		"BackTopic",
	},

	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {}

		-- disgusting
		-- local identifier = player:GetCharacter():GetData("curdialogprog")
		local identifier = self.tmp
		self.tmp = nil
		local progressionStatus = ix.progression.GetComplexProgressionValue(client:GetCharacter(), identifier)
		local definition = ix.progression.definitions[identifier]
		if definition.GetItemIds then
			local progitems = definition.GetItemIds()
			local missingitems = {}

			for progitem, cnt in pairs(progitems) do
				local curcnt = 0
				if progressionStatus and progressionStatus[progitem] then
					curcnt = progressionStatus[progitem]
				end

				if curcnt < cnt and client:GetCharacter():GetInventory():HasItem(progitem) then
					table.insert(missingitems, progitem)
				end
			end

			for _, progitem in pairs(missingitems) do
				table.insert(dynamicOptions, {
					statement = "Hand over " .. ix.item.list[progitem].name,
					topicID = "ViewProgression",
					dynamicData = { progressionID = identifier, itemID = progitem },
				})
			end
		end

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		-- Return the next topicID

		return "HandInComplexProgressionItemTopic", dynamicData
	end,

	IsDynamicFollowup = true,
	DynamicPreCallback = function(self, player, target, dynamicData)
		if dynamicData then
			if CLIENT then
				local definition = ix.progression.definitions[dynamicData.identifier]
				local progressionStatus =
					ix.progression.GetLine(player:GetCharacter(), dynamicData.identifier)

				if definition.GetItemIds then
					progressionStatus = ix.progression.GetComplexProgressionValue(
						player:GetCharacter(),
						dynamicData.identifier
					)
				end

				self.response = definition:BuildResponse(target:GetDisplayName(), progressionStatus)
				self.tmp = dynamicData.identifier
			end
		end
	end,
})

DIALOGUE.addTopic("HandInComplexProgressionItemTopic", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	options = { "BackTopic" },
	DynamicPreCallback = function(self, player, target, dynamicData)
		if SERVER and istable(dynamicData) then
			ix.progression.TurnIn(player, target, dynamicData.progid, dynamicData.itemid)
		elseif CLIENT then
			self.response = "Let me check what you have brought."
		end
	end,
})

DIALOGUE.addTopic("AboutProgression", {
	statement = "What do you need help with?",
	response = "I have a few things I need done.",
	options = {
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if CLIENT then
			if #ix.progression.GetActiveProgressions(client:GetCharacter(), "'Jitters'") <= 0 then
				self.response = "Nothing at the moment."
			end
		end
	end,
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {}

		for _, progressionID in
			pairs(ix.progression.GetActiveProgressions(client:GetCharacter(), "'Jitters'"))
		do
			table.insert(dynamicOptions, {
				statement = ix.progression.definitions[progressionID].name,
				topicID = "AboutProgression",
				dynamicData = { identifier = progressionID },
			})
		end

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		-- Return the next topicID

		return "ViewProgression", dynamicData
	end,
	ShouldAdd = function(self, client, target)
		return #ix.progression.GetActiveProgressions(client:GetCharacter(), "'Jitters'") > 0
	end,
})

DIALOGUE.addTopic("HealTopic", {
	statement = "Can you patch me up?",
	response = "What would you like me to look at?",
	IsDynamic = true,
	options = {
		"BackTopic",
	},
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {}
		local pricePerHp = 2
		local pricePerRad = 3
		local pricePerPsy = 4

		local percentPerHp = (100 - client:Health())
		local percentPerRad = (client:getRadiation())
		local percentPerPsy = (100 - client:GetPsyHealth())

		local hpCost = math.Round(percentPerHp * pricePerHp)
		local radCost = math.Round(percentPerRad * pricePerRad)
		local psyCost = math.Round(percentPerPsy * pricePerPsy)

		table.insert(dynamicOptions, {
			statement = "My Physical Health ( " .. client:Health() .. "% ) - " .. ix.currency.Get(hpCost),
			topicID = "HealTopic",
			dynamicData = { cost = hpCost, type = "hp" },
		})
		table.insert(dynamicOptions, {
			statement = "My Radiation Level ( " .. client:getRadiation() .. "% ) - " .. ix.currency.Get(
				radCost
			),
			topicID = "HealTopic",
			dynamicData = { cost = radCost, type = "rad" },
		})
		table.insert(dynamicOptions, {
			statement = "My Mental Health ( " .. client:GetPsyHealth() .. "% ) - " .. ix.currency.Get(
				psyCost
			),
			topicID = "HealTopic",
			dynamicData = { cost = psyCost, type = "psy" },
		})
		table.insert(dynamicOptions, {
			statement = "Everything - " .. ix.currency.Get(hpCost + radCost + psyCost),
			topicID = "HealTopic",
			dynamicData = { cost = hpCost + radCost + psyCost, type = "all" },
		})

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		-- Return the next topicID
		if not client:GetCharacter():HasMoney(dynamicData.cost) then
			return "NotEnoughMoneyHeal"
		end

		return "ConfirmHeal", dynamicData
	end,
})

DIALOGUE.addTopic("ConfirmHeal", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	IsDynamic = true,
	DynamicPreCallback = function(self, player, target, dynamicData)
		if dynamicData then
			if CLIENT then
				self.response =
					string.format("Patching you up will cost you %s.", ix.currency.Get(dynamicData.cost))
			else
				target.healstruct = { dynamicData.cost, dynamicData.type }
			end
		end
	end,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {
			{
				statement = "I can agree to that. Go ahead and heal me.",
				topicID = "ConfirmHeal",
				dynamicData = { accepted = true },
			},
			{
				statement = "On second thought...",
				topicID = "ConfirmHeal",
				dynamicData = { accepted = false },
			},
		}

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		if SERVER and dynamicData.accepted then
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
		if SERVER then
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
		"BackTopic",
	},
})
