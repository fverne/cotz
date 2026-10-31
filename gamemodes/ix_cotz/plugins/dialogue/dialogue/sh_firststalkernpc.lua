DIALOGUE.name = "The Original"
DIALOGUE.townContact = "the-original"

ix.dialogue.AddTradeTopic(DIALOGUE, "Want to trade?", "Yes!")

DIALOGUE.addTopic("GREETING", {
	response = "Hello, I'm the original. The first stalker in the zone. What do you need?",
	options = {
		"TradeTopic",
		"ChangeSuitVariant",
		"TutorialTopic",
		"InterestTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about something else.",
	response = "What would you like to know?",
	options = {
		"TradeTopic",
		"ChangeSuitVariant",
		"TutorialTopic",
		"InterestTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"TownProgression",
		"GetTaskByDifficulty",
	}, -- Should be identical to GREETING's options
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you!",
	response = "Take care, STALKER...",
})

DIALOGUE.addTopic("TutorialTopic", {
	statement = "I have a few questions, I just arrived here.",
	response = "What do you want to know?",
	options = {
		"TutorialTopic1",
		"TutorialTopic2",
		"TutorialTopic3",
		"BackTopic",
	},
})

DIALOGUE.addTopic("TutorialTopicBack", {
	statement = "Alright, let me ask you something else.",
	response = "Sure.",
	options = {
		"TutorialTopic1",
		"TutorialTopic2",
		"TutorialTopic3",
		"BackTopic",
	},
})

DIALOGUE.addTopic("TutorialTopic1", {
	statement = "What is this place?",
	response = (
		"This is an area near the Chernobyl exclusion zone. More "
		.. "specifically, we're in the great swamps. Until recently, "
		.. "this area was completely abandoned, but me and another "
		.. "local, 'Technut', set up camp here in this shithole. We "
		.. "call it our 'Eastern Haven'. We could definitely use some "
		.. "help getting this place in proper shape."
	),
	options = {
		"TutorialTopic1_1",
	},
})

DIALOGUE.addTopic("TutorialTopic1_1", {
	statement = "How can I help out?",
	response = (
		"If we work together, I'm sure we will get this place in "
		.. "proper shape in no time. Go talk to the other inhabitants, "
		.. "and see if they need anything. You'll be properly rewarded. "
		.. "Both personally by the inhabitant, but as we keep helping "
		.. "each other out, it will unlock more opportunities for us "
		.. "to do, and more people will move here, each with their "
		.. "own agendas. You should ask around to see what people need "
		.. "help with. Both us oldies, but also the younger opportunity "
		.. "seekers like yourself."
	),
	options = {
		"TutorialTopicBack",
	},
})

DIALOGUE.addTopic("TutorialTopic2", {
	statement = "How dangerous is this place?",
	response = (
		"There are two types of people here. The careful people, "
		.. "and the dead people. As you can imagine, a place like this "
		.. "where the laws of science do not apply as anywhere in the "
		.. "world, can be quite unforgiving and dangerous. The dangers "
		.. "are manyfold, but the biggest of your troubles will be "
		.. "the mutants, and the anomalies."
	),
	options = {
		"TutorialTopic2_1",
		"TutorialTopic2_2",
		"TutorialTopicBack",
	},
})

DIALOGUE.addTopic("TutorialTopic2_1", {
	statement = "Tell me about the anomalies.",
	response = (
		"The anomalies are a work of a merciless god. I've seen "
		.. "animals being torn apart by sheer gravity, and those are "
		.. "the lucky ones. Luckily, most are static, so if you watch "
		.. "your step and don't fall into one, you should be alright. "
		.. "It should be noted that sometimes, the merciless god seems "
		.. "to be merciful, and he releases a part of scientific wonder "
		.. "near them. They are artifacts that mostly are not dangerous "
		.. "to the wielder, sometimes with benefits, but always worth "
		.. "a lot to the scientific community outside the zone, and "
		.. "hence worth quite a lot on the black market."
	),
	options = {
		"TutorialTopic2_2",
		"TutorialTopicBack",
	},
})

DIALOGUE.addTopic("TutorialTopic2_2", {
	statement = "Tell me about the mutants.",
	response = (
		"After the first couple of emissions, many of the animals "
		.. "here died, but those that survived had a worse fate. They "
		.. "all turned into dangerous, aggressive, mutated versions "
		.. "of their former selves, and are no longer good for anything "
		.. "but having to be put down, as they will all try to take "
		.. "you down, regardless of your intentions. Due to the mutations, "
		.. "many of the mutants bodyparts have special properties that "
		.. "are valuable to scientists. I suggest poaching the mutants "
		.. "whenever possible, and sell off the dead parts."
	),
	options = {
		"TutorialTopic2_1",
		"TutorialTopicBack",
	},
})

DIALOGUE.addTopic("TutorialTopic3", {
	statement = "What gear do you recommend I get my hands on?",
	response = (
		"The most neccessary things are a geiger counter, some medical "
		.. "items, and something to defend yourself with. Always carry "
		.. "those three with you. Also, keep your weapons in good condition "
		.. "always if you want them to shoot straight, and remember, "
		.. "we don't have access to many spare parts here, so firearms "
		.. "will not be maintainable forever. 'Technut' can help you "
		.. "out."
	),
	options = {
		"TutorialTopicBack",
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
			["looted"] = true,
			["scavenger"] = true,
			-- ["ecologist"] = true,
			-- ["fanatic"] = true,
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

DIALOGUE.addTopic("InterestTopic", {
	statement = "Can you tell me something interesting?",
	response = "",
	options = {
		"InterestMoreTopic",
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if CLIENT then
			local tbl = {
				(
					"The Zone is a dangerous place. Anomalies are everywhere, "
					.. "and all the mutants here are out to get you, I swear."
				),
				(
					"Did you know people stash their stuff everywhere? If you "
					.. "have a keen eye, you can find some interesting things."
				),
				(
					"We STALKERS, as we call ourselves, are incredibly creative. "
					.. "I don't think any other place in the world has our level "
					.. "of craftiness and ability to survive even the harshest "
					.. "conditions. Who would have thought of using cutlery as "
					.. "makeshift digging tools, for instance?"
				),
				(
					"I've heard rumours of creatures out there, who can mess "
					.. "you up. Not in the sense that they gnaw and tear you apart, "
					.. "but that they send even the strongest willed men into the "
					.. "deepest hole - if they can make it away. I'm not going "
					.. "out there..."
				),
				(
					"The mutants in here are, to nobodys surprise, very irradiated. "
					.. "If you ever do plan to eat them, I suggest cooking them "
					.. "first, as it takes away a lot of their radiation."
				),
				(
					"I'm still having trouble believing this place is not more "
					.. "well known, but I assume it's because everyone in the surrounding "
					.. "areas are being told not to say a word, and the military "
					.. "are not too keen on rulebreakers around here."
				),
				(
					"If you ever encounter something that shakes you up, I suggest "
					.. "smoking a couple of cigarettes. They calm the mind, and "
					.. "help you think clearer."
				),
			}

			self.response = table.Random(tbl)
		end
	end,
})

DIALOGUE.addTopic("InterestMoreTopic", {
	statement = "Very nice, more?",
	response = "",
	options = {
		"InterestMoreTopic",
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if CLIENT then
			local tbl = {
				(
					"The Zone is a dangerous place. Anomalies are everywhere, "
					.. "and all the mutants here are out to get you, I swear."
				),
				(
					"Did you know people stash their stuff everywhere? If you "
					.. "have a keen eye, you can find some interesting things."
				),
				(
					"We STALKERS, as we call ourselves, are incredibly creative. "
					.. "I don't think any other place in the world has our level "
					.. "of craftiness and ability to survive even the harshest "
					.. "conditions. Who would have thought of using cutlery as "
					.. "makeshift digging tools, for instance?"
				),
				(
					"I've heard rumours of creatures out there, who can mess "
					.. "you up. Not in the sense that they gnaw and tear you apart, "
					.. "but that they send even the strongest willed men into the "
					.. "deepest hole - if they can make it away. I'm not going "
					.. "out there..."
				),
				(
					"The mutants in here are, to nobodys surprise, very irradiated. "
					.. "If you ever do plan to eat them, I suggest cooking them "
					.. "first, as it takes away a lot of their radiation."
				),
				(
					"I'm still having trouble believing this place is not more "
					.. "well known, but I assume it's because everyone in the surrounding "
					.. "areas are being told not to say a word, and the military "
					.. "are not too keen on rulebreakers around here."
				),
				(
					"If you ever encounter something that shakes you up, I suggest "
					.. "smoking a couple of cigarettes. They calm the mind, and "
					.. "help you think clearer."
				),
			}

			self.response = table.Random(tbl)
		end
	end,
})
