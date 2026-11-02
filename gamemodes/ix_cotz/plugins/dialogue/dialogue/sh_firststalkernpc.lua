DIALOGUE.name = "The Original"
DIALOGUE.townContact = "the-original"

ix.dialogue.AddTradeTopic(DIALOGUE, "Want to trade?", "Yes!")

DIALOGUE.addTopic("GREETING", {
	response = (
		"You found me. They call me the Original. First stalker in the Zone, if you're asking. What can "
		.. "I do for you?"
	),
	options = {
		"SpecialtyTopic",
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
	response = "What else did you want to discuss?",
	options = {
		"SpecialtyTopic",
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
	response = "Come back with a question worth arguing about.",
})

DIALOGUE.addTopic("TutorialTopic", {
	statement = "Can you explain a few things about the camp?",
	response = "I can. Whether you believe the explanation seems to be a separate question these days. Go on, ask.",
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
	statement = "How did this camp get started?",
	response = (
		"Technut and I helped get the place standing when it was considerably less inviting. Eastern Haven, "
		.. "we called it. You can judge how much of that was optimism. A camp begins looking established once "
		.. "enough people forget the work of starting it. Then somebody asks where the spare tools are and you "
		.. "discover how much establishing remains. Talk to the people doing the ordinary jobs. They'll give "
		.. "you a different account of the place from the people admiring it."
	),
	options = {
		"TutorialTopic1_1",
	},
})

DIALOGUE.addTopic("TutorialTopic1_1", {
	statement = "Who should I speak to about helping?",
	response = (
		"Ask what people actually need. Gasket wants utility supplies, Technut handles workshop salvage, "
		.. "Jitters looks after the clinic. Lemon will explain his requirements whether you ask or not. I "
		.. "collect specimens and other things worth examining. Read a request before promising to fill it. A "
		.. "successful first trip doesn't have to impress everyone in camp."
	),
	options = {
		"TutorialTopicBack",
	},
})

DIALOGUE.addTopic("TutorialTopic2", {
	statement = "What should I be most careful about?",
	response = (
		"The thing you've decided is ordinary. People stare at the impossible and walk straight past a "
		.. "warning they recognise. Mutants, anomalies, exposure, a bad return route - there are plenty of ways "
		.. "to make a short journey longer than you intended. I can tell you what I've seen. Don't turn that "
		.. "into permission to stop looking for yourself."
	),
	options = {
		"TutorialTopic2_1",
		"TutorialTopic2_2",
		"TutorialTopicBack",
	},
})

DIALOGUE.addTopic("TutorialTopic2_1", {
	statement = "What should I know about anomalies?",
	response = (
		"Keep your distance until you understand the approach, and don't trust a quiet-looking patch because "
		.. "it looks like one you crossed yesterday. I've watched an animal get lifted where I expected to see "
		.. "it run. That persuaded me more effectively than any explanation since. Artifacts bring people close "
		.. "to fields; sometimes they're valuable enough to make the risk sound smaller in the telling. Ask "
		.. "about the particular object before assuming it is harmless to carry. Egghead enjoys that sort of "
		.. "question."
	),
	options = {
		"TutorialTopic2_2",
		"TutorialTopicBack",
	},
})

DIALOGUE.addTopic("TutorialTopic2_2", {
	statement = "What should I know about the mutants?",
	response = (
		"Watch what they're doing before you decide what they are about to do. A frightened account tends to "
		.. "put every animal in the same bad temper. That won't help you judge the one in front of you. Old "
		.. "Timer has hunting work, and Spoor in Garbage cares about what the ground can tell him. I examine "
		.. "the parts that come back. There's useful work in that, provided you survive collecting them and "
		.. "don't ruin them in your pack."
	),
	options = {
		"TutorialTopic2_1",
		"TutorialTopicBack",
	},
})

DIALOGUE.addTopic("TutorialTopic3", {
	statement = "What should I carry before going out?",
	response = (
		"Water, food, medical supplies you know how to use, and something you can rely on to defend "
		.. "yourself. A working Geiger counter is worth making room for. Check the condition of the equipment "
		.. "before leaving; discovering a fault at the wrong end of a walk is an expensive way to become "
		.. "familiar with it. Technut can discuss repairs. And leave space for the thing you went to collect. "
		.. "People overlook that until they're standing over a case deciding which of their own belongings "
		.. "became optional."
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
			if target.selectedsuitstruct[3] == v.baseSuit and variants[v.suitVariant]
				and ix.townNPCs:CanChangeSuitVariant(client:GetCharacter(), v.uniqueID) then
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
			if not ix.townNPCs:CanChangeSuitVariant(client:GetCharacter(), dynamicData.suitVariantUID) then
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

DIALOGUE.addTopic("InterestTopic", {
	statement = "Have you got a story to pass the time?",
	response = "",
	options = {
		"InterestMoreTopic",
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if CLIENT then
			local tbl = {
				(
					"Technut once tried to explain a fault using the sound it made. By the time he finished, three "
					.. "people were offering diagnoses and nobody knew which machine he meant. I listened to the whole "
					.. "performance. Free entertainment was less common than spare parts that week."
				),
				(
					"People ask whether I kept a record when I first came here. I did. Then I used a page to keep "
					.. "something dry and another to start a fire. Carbon looks at me as if I've personally misplaced a "
					.. "century. I tell him the fire was very good. He never enjoys that part."
				),
				(
					"A fellow asked me the safest way to travel with a heavy pack. I said to put some of it down. He "
					.. "explained why every object was necessary, then asked the question again. We were both "
					.. "disappointed by the conversation."
				),
				(
					"I've heard descriptions of animals I wouldn't care to meet. Some from people who saw them, some "
					.. "from people who improved the account at every table. Ask where the teller was standing. A "
					.. "surprising number of the best stories were witnessed from a chair in camp."
				),
				(
					"Lemon tells me he can judge a person's appetite at a glance. I asked why he always makes enough "
					.. "for another person. He explained stock management for so long I had time to finish the bowl. An "
					.. "excellent cook. Could use a little practice at leaving a question unanswered."
				),
				(
					"Spoor will spend half an evening asking what an animal was eating. I ask whether he wants the "
					.. "rest of the story. He says that's the part he's asking for. We do eventually have a useful "
					.. "conversation, provided neither of us objects to doing it in the wrong order."
				),
				(
					"I like a person who can say they don't remember. Gives you somewhere sensible to begin asking. "
					.. "Of course, when I say it, people look delighted. You'd think I'd just handed them a rare "
					.. "artifact instead of admitting where I put down a pair of gloves."
				),
			}

			self.response = table.Random(tbl)
		end
	end,
})

DIALOGUE.addTopic("InterestMoreTopic", {
	statement = "What else do you remember?",
	response = "",
	options = {
		"InterestMoreTopic",
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if CLIENT then
			local tbl = {
				(
					"Technut once tried to explain a fault using the sound it made. By the time he finished, three "
					.. "people were offering diagnoses and nobody knew which machine he meant. I listened to the whole "
					.. "performance. Free entertainment was less common than spare parts that week."
				),
				(
					"People ask whether I kept a record when I first came here. I did. Then I used a page to keep "
					.. "something dry and another to start a fire. Carbon looks at me as if I've personally misplaced a "
					.. "century. I tell him the fire was very good. He never enjoys that part."
				),
				(
					"A fellow asked me the safest way to travel with a heavy pack. I said to put some of it down. He "
					.. "explained why every object was necessary, then asked the question again. We were both "
					.. "disappointed by the conversation."
				),
				(
					"I've heard descriptions of animals I wouldn't care to meet. Some from people who saw them, some "
					.. "from people who improved the account at every table. Ask where the teller was standing. A "
					.. "surprising number of the best stories were witnessed from a chair in camp."
				),
				(
					"Lemon tells me he can judge a person's appetite at a glance. I asked why he always makes enough "
					.. "for another person. He explained stock management for so long I had time to finish the bowl. An "
					.. "excellent cook. Could use a little practice at leaving a question unanswered."
				),
				(
					"Spoor will spend half an evening asking what an animal was eating. I ask whether he wants the "
					.. "rest of the story. He says that's the part he's asking for. We do eventually have a useful "
					.. "conversation, provided neither of us objects to doing it in the wrong order."
				),
				(
					"I like a person who can say they don't remember. Gives you somewhere sensible to begin asking. "
					.. "Of course, when I say it, people look delighted. You'd think I'd just handed them a rare "
					.. "artifact instead of admitting where I put down a pair of gloves."
				),
			}

			self.response = table.Random(tbl)
		end
	end,
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Does everyone believe you were first?",
	response = (
		"Believing isn't their favourite pastime. Arguing is. Carbon wants dates, Spoor wants tracks, Old "
		.. "Timer remembers an entirely different conversation. Keeps them occupied. I don't mind a question "
		.. "with something behind it. A man once told me he didn't believe an animal could move the way I "
		.. "described, then asked which way he'd be safest walking. I answered the second question. You'd have "
		.. "enjoyed his face."
	),
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "Would you admit remembering something wrong?",
	response = (
		"Show me. Don't wave a folder and expect the cover to settle it. We'll read the thing. I might have "
		.. "put a name in the wrong place, or kept two bad nights as one. That happens. It doesn't mean the "
		.. "person who wrote the report saw everything either. Bring both accounts to the table and we'll make "
		.. "an evening of it. I reserve the right to complain."
	),
	options = {"BackTopic"},
})
