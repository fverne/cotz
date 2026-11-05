DIALOGUE.name = "Smartass"
DIALOGUE.townContact = "smartass"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"Let's see what you're buying and selling.",
	"Certainly. Show me what interests you before I become distracted by something more difficult."
)

DIALOGUE.addTopic("GREETING", {
	response = "Hello. If you've brought a problem, start before the part where you became absolutely certain what caused it. Much more entertaining that way.",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
		"TradeTopic",
		"BackgroundTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "What sort of work holds your attention?",
	response = "Computers, data, a device doing something its owner swears it never did before. I like the gap between what happened and the account that arrives here. Sometimes there's a good problem in it. Sometimes there's a button nobody wants to admit pressing. Explain what you noticed and what you tried; we might reach the interesting part before I have to become unpleasantly thorough about the second question.",
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
			["anarchist"] = true,
			["authority"] = true,
			["mercenary"] = true,
			-- ["looted"] = true,
			-- ["scavenger"] = true,
			-- ["ecologist"] = true,
			-- ["fanatic"] = true,
		}

		local suitVariants = {}
		for _, v in pairs(ix.item.list) do
			if target.selectedsuitstruct[3] == v.baseSuit and variants[v.suitVariant]
				and ix.townNPCs:CanChangeSuitVariant(client:GetCharacter(), v.uniqueID, target:GetDisplayName()) then
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
			if not ix.townNPCs:CanChangeSuitVariant(
				client:GetCharacter(), dynamicData.suitVariantUID, target:GetDisplayName()
			) then
				return "BackTopic"
			end
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
	statement = "Something else.",
	response = "Go on. You've survived the first answer.",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
		"TradeTopic",
		"BackgroundTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
	preCallback = function(self, client, target) end,
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "I'll leave you to it.",
	response = "Off you go. Remember the interesting part before you rehearse the impressive version.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Wouldn't you rather collect the data yourself?",
	response = "I'd like to see some of the machines before they're reduced to a description beginning 'old computer'. Also like being here when the contents arrive. Sensible division of labour, with the irritating consequence that someone else sees the interesting place. If I go wandering off for field experience, you can explain it to Boss. Give the phrase your full professional confidence. I'd be sorry to miss his expression.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What makes you take a question seriously?",
	response = "A detail the person hasn't already polished into a conclusion. Spool can describe a sound until I almost hear the fault. Then he supplies his theory and we enjoy a perfectly avoidable argument. Mute prefers to show me something and wait. That works too, though it's poor company if I'd prepared a particularly good objection. Tell me what you actually noticed. Curiosity occasionally gets the better of my manners.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "Do people blame anomalies for every broken PDA?",
	response = "Only after exhausting the manufacturer's incompetence and the possibility that I've personally arranged it. Ask when it stopped working and suddenly we're discussing a puddle. Fascinating anomaly, the puddle. Very well documented. Of course something stranger might have happened. I'd love to hear it. That's why I ask what the machine actually did before being appointed expert witness for the dramatic bit. Sometimes the answer's interesting enough that I forget to enjoy the owner's face.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "Does Spool ever get the better of you?",
	response = "He remembers things I've said. Unpleasant habit in a man who spends all day encouraging other people to talk. I'll dismiss a description, he'll repeat the exact noise I asked him about last time, and suddenly I owe the problem another look. He's good at it. There, a compliment. Don't take it over to him; he'll remember the wording and make the rest of my week unbearable.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Have you ever blamed something on an anomaly?",
	response = "I've said 'unexpected behaviour' with considerable confidence. Bought myself enough time to find the setting I'd changed. You may appreciate the honesty while remembering this conversation has no witnesses prepared to support you.",
	options = {"BackTopic"},
})
