DIALOGUE.name = "Beanstalk"
DIALOGUE.townContact = "beanstalk"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"Can I look through your supplies?",
	"Certainly. Keep the samples separate while we look at what can be exchanged."
)

DIALOGUE.addTopic("GREETING", {
	response = "Hello. Leave the containers shut, please. I've just finished sorting them and would rather begin this conversation in a good mood.",
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
	statement = "What interests you about the conditions here?",
	response = "How difficult they make an apparently simple comparison. You return to a place, take another reading, and begin working out what else changed between the two visits. Sometimes a stalker mentions an ordinary detail at the end of a story and I have to ask them to go back. I enjoy that moment. Less enjoyable when they've thrown away the first notes because the second set looked neater. I can tolerate untidy paper remarkably well.",
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "How do you decide whether a strange reading matters?",
	response = "Keep the original, check the conditions, compare it with a control. Then ask what you expected to see. That last question is uncomfortable. I've had a perfectly ordinary clerical mistake survive far too long because its explanation was interesting. If somebody disagrees, I want the awkward observation left in the account. We can argue over it. Difficult to argue usefully with a discrepancy someone has carefully erased.",
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
	response = "Yes? We can leave that question open for now.",
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
	statement = "I'll leave you to the research.",
	response = "Good journey. If you remember something you couldn't quite describe, don't feel you need a better explanation before mentioning it.",
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Do the field workers frustrate you?",
	response = "Sometimes. Sometimes I'm the frustrating part of their day. Vesper can describe why an arrangement that looked sensible here became awkward beside an anomaly field. I need to hear that before I start defending it. Not always successful. She's learned to wait while I finish explaining the difficulty she's just told me about. I'd prefer you didn't repeat how much she enjoys that interval.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What makes those arguments worth having?",
	response = "We eventually discuss the same trip. She tells me what she could actually observe; I explain which uncertainty still bothers me. Sometimes the work needs changing. Sometimes we simply have to qualify the result. I owe that conversation to somebody who went out there. Besides, I'd rather hear her describe the inconvenient part than spend the evening discovering I'd asked the wrong question again.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "Is there anything you enjoy watching outside the research?",
	response = "The birds, when I have a chance. No, that isn't a coded answer about sampling. I couldn't identify every one before coming here, and I certainly won't pretend to now. A stalker described a bird he'd seen near an anomaly and expected me to explain why it was there. I wanted to know what it sounded like. We had a rather pleasant conversation once he stopped expecting a finding at the end of it.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "Can you and Egghead talk without arguing?",
	response = "Certainly. We can spend several minutes agreeing that the coffee is dreadful. Then he remembers an artifact somebody showed him, and I ask one question too many. I enjoy his enthusiasm. It can make a thoroughly irritating day interesting again. I would enjoy it even more if he noticed when I'd put my coat on to leave. Apparently that's an excellent moment to describe another possibility.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Do you write those observations down too?",
	response = "A few. I keep them apart from the readings. Sometimes the note is only a sound I couldn't place, which looks rather foolish in my handwriting. I like finding it later. Reminds me I was standing somewhere, instead of spending the whole day correcting a table.",
	options = {"BackTopic"},
})
