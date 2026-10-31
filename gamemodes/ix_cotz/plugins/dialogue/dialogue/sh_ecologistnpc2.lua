DIALOGUE.name = "Beanstalk"
DIALOGUE.townContact = "beanstalk"

ix.dialogue.AddTradeTopic(DIALOGUE, "Want to trade?", "Keep it down!")

DIALOGUE.addTopic("GREETING", {
	response = "Hello.",
	options = {
		"TradeTopic",
		"ChangeSuitVariant",
		"BackgroundTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "What is this place?",
	response = "Classified. But since you are acting nice, you get to stay.",
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "Alright, I'll behave.",
	response = "Good dog. Remember we have the military on hotline.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("ChangeSuitVariant", {
	statement = "Can you exchange my suit to another variant?",
	response = "Which suit would you like to exchange?",
	IsDynamic = true,
	options = {
		"BackTopic",
	},
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {}
		local items = client:GetCharacter():GetInventory():GetItems()

		for _, v in pairs(items) do
			if v.baseSuit then
				table.insert(dynamicOptions, {
					statement = v:GetName(),
					topicID = "ChangeSuitVariant",
					dyndata = { itemuid = v.uniqueID, itemid = v:GetID(), baseSuit = v.baseSuit },
				})
			end
		end

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		-- Return the next topicID

		return "ChangeSuitVariantP2", dynamicData
	end,
})

DIALOGUE.addTopic("ChangeSuitVariantP2", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	IsDynamic = true,
	DynamicPreCallback = function(self, player, target, dynamicData)
		if dynamicData then
			if CLIENT then
				self.response = string.format(
					("Which suit would you like instead? Be sure to remove attachments " .. "beforehand.")
				)
			end

			target.selectedsuitstruct = { dynamicData.itemid, dynamicData.itemuid, dynamicData.baseSuit }
		end
	end,
	GetDynamicOptions = function(self, client, target)
		local variants = {
			["baseline"] = true,
			-- ["anarchist"] = true,
			-- ["authority"] = true,
			-- ["mercenary"] = true,
			-- ["looted"] = true,
			-- ["scavenger"] = true,
			["ecologist"] = true,
			["fanatic"] = true,
		}

		local suitVariants = {}
		for _, v in pairs(ix.item.list) do
			if target.selectedsuitstruct[3] == v.baseSuit and variants[v.suitVariant] then
				table.insert(suitVariants, {
					uniqueID = v.uniqueID,
					name = v.name,
					price = v.price / 10,
					suitVariant = v.suitVariant,
				})
			end
		end

		local dynamicOptions = {}
		for _, v in pairs(suitVariants) do
			if v.uniqueID == target.selectedsuitstruct[2] then
				continue
			end

			table.insert(dynamicOptions, {
				statement = "["
					.. v.suitVariant:gsub("^%l", string.upper)
					.. "] "
					.. v.name
					.. " with cost "
					.. ix.currency.Get(math.Round(v.price)),
				topicID = "ChangeSuitVariantP2",
				dyndata = { suitVariantUID = v.uniqueID, accepted = true },
			})
		end

		table.insert(dynamicOptions, {
			statement = "Actually, nevermind...",
			topicID = "ChangeSuitVariantP2",
			dyndata = { accepted = false },
		})

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		if SERVER and dynamicData.accepted then
			local finalPrice = math.Round(ix.item.list[dynamicData.suitVariantUID].price / 10)
			if not client:GetCharacter():HasMoney(finalPrice) then
				client:Notify("You don't have enough money!")

				return "BackTopic"
			end

			if client:GetCharacter():GetData("carry", 0) >= ix.weight.BaseWeight(client:GetCharacter()) then
				client:Notify("You are extremely overencumbered and can't do that!")

				return "BackTopic"
			end

			local originalSuit = ix.item.instances[target.selectedsuitstruct[1]]

			-- Check if the item exists
			if originalSuit == nil then
				client:Notify("Something went wrong! Try again.")

				return "BackTopic"
			end
			-- Check if the item is in player inventory
			if originalSuit.invID ~= client:GetCharacter():GetInventory():GetID() then
				client:Notify("Something went very wrong! Try again.")

				return "BackTopic"
			end

			-- Check if the item is valid for exchange
			if
				not (
					originalSuit.baseSuit ~= nil
					and ix.item.list[dynamicData.suitVariantUID].baseSuit == originalSuit.baseSuit
				)
			then
				client:Notify("Something went extremely wrong!")

				return "BackTopic"
			end

			if
				not table.IsEmpty(
					originalSuit:GetData("attachments", originalSuit.miscSlots)["exteriorSlots"]
				)
				or not table.IsEmpty(
					originalSuit:GetData("attachments", originalSuit.miscSlots)["interiorSlots"]
				)
				or not table.IsEmpty(
					originalSuit:GetData("attachments", originalSuit.miscSlots)["extraSlots"]
				)
			then
				client:Notify("Can't exchange suit with installed attachments!")

				return "BackTopic"
			end

			if originalSuit:GetData("equip") then
				if hook.Run("CanPlayerUnequipItem", client, originalSuit) == false then
					client:Notify("Couldn't unequip the suit, try again!")

					return "BackTopic"
				end

				if originalSuit.RemoveOutfit then
					originalSuit:RemoveOutfit(client)
				elseif originalSuit.RemovePart then
					originalSuit:RemovePart(client)
				else
					client:Notify("Code is not coding, notify the developer!")

					return "BackTopic"
				end

				client:RecalculateResistances()
				client:ReevaluateOverlay()
				originalSuit:OnUnequipped()
			end

			ix.dialogue.notifyMoneyLost(client, ix.currency.Get(finalPrice))
			client:GetCharacter():TakeMoney(finalPrice)

			originalSuit:Remove()
			client:GetCharacter():SetData("carry", ix.weight.CalculateWeight(client:GetCharacter()))
			client:GetCharacter():GetInventory():Add(dynamicData.suitVariantUID)
		end
		-- Return the next topicID

		return "BackTopic"
	end,
})

DIALOGUE.addTopic("NotEnoughMoneySuitVariantChange", {
	statement = "",
	response = "Not enough money for that.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about something else...",
	response = "Hmm? Spill the beans.",
	options = {
		"TradeTopic",
		"ChangeSuitVariant",
		"BackgroundTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
	preCallback = function(self, client, target) end,
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you around.",
	response = "See you soon.",
})
