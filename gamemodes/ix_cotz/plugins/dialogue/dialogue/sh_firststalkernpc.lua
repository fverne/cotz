DIALOGUE.name = "The Original"
DIALOGUE.townContact = "the-original"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"What are you willing to trade?",
	"Let's see. Leave room on the table; I may want a closer look."
)

DIALOGUE.addTopic("GREETING", {
	response = "The Original. Yes, that one. Sit if you're staying for the explanation; otherwise tell me what you need.",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
		"TradeTopic",
		"TutorialTopic",
		"InterestTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"GetTaskByDifficulty",
	},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Go on, then. You've still got my attention.",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
		"TradeTopic",
		"TutorialTopic",
		"InterestTopic",
		"GOODBYE",
		"AboutWorkTopic",
		"GetTaskByDifficulty",
	}, -- Should be identical to GREETING's options
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "I'll hear the rest another time.",
	response = "Come back before you've improved your own version too much. I'd like to hear where it began.",
})

DIALOGUE.addTopic("TutorialTopic", {
	statement = "Can you tell me about the camp and the country around it?",
	response = "Certainly. People occasionally confuse asking me with agreeing to believe me. You can decide about that after I've finished.",
	options = {
		"TutorialTopic1",
		"TutorialTopic2",
		"TutorialTopic3",
		"BackTopic",
	},
})

DIALOGUE.addTopic("TutorialTopicBack", {
	statement = "Another question about the camp.",
	response = "Yes? You've let me get this far; might as well make use of it.",
	options = {
		"TutorialTopic1",
		"TutorialTopic2",
		"TutorialTopic3",
		"BackTopic",
	},
})

DIALOGUE.addTopic("TutorialTopic1", {
	statement = "How did the camp begin?",
	response = "Technut and I helped get it standing. Eastern Haven, we called it, with rather more confidence than the place deserved at the time. You can tell a camp's becoming comfortable when people start complaining that something isn't where they expected it. There was a time we'd have been pleased the thing existed at all. Gasket would give you a long account of how much still needs doing. Ask him after he's eaten.",
	options = {
		"TutorialTopic1_1",
	},
})

DIALOGUE.addTopic("TutorialTopic1_1", {
	statement = "Who should I ask about helping out?",
	response = "Gasket for utility supplies, Technut for workshop salvage, Jitters for the clinic. Lemon has views on everything that might become a meal. I take an interest in specimens. Hear what someone needs before promising your whole pack to them. People come here expecting their first expedition to settle who they are. Usually it settles how much they enjoy walking in wet socks. You can make a useful beginning without impressing every person in camp.",
	options = {
		"TutorialTopicBack",
	},
})

DIALOGUE.addTopic("TutorialTopic2", {
	statement = "What catches new arrivals out?",
	response = "They give the strange things all their attention. See an anomaly, spend ten minutes staring, then walk off without looking where they've decided to put their foot. Or hear a mutant and forget which way they came. I've had my share of foolish moments. Mine have the advantage of becoming stories told by me. Give yourself time to look around before somebody else's excitement decides what you're doing next.",
	options = {
		"TutorialTopic2_1",
		"TutorialTopic2_2",
		"TutorialTopicBack",
	},
})

DIALOGUE.addTopic("TutorialTopic2_1", {
	statement = "What is worth knowing before approaching anomalies?",
	response = "Get a good look at the approach before going closer. I've seen an animal lifted where I expected it to run. Whether you like my explanation of that hardly matters; it made me reconsider where I stood. A stalker with an artifact to sell may describe the return more cheerfully than the collection. Ask what they actually saw. And ask about the particular artifact before deciding to carry it. Egghead can happily spend an afternoon on that question.",
	options = {
		"TutorialTopic2_2",
		"TutorialTopicBack",
	},
})

DIALOGUE.addTopic("TutorialTopic2_2", {
	statement = "How do you judge the mutants out there?",
	response = "I'd like to see where one was, how it moved, what it was doing before the shooting began. Most accounts arrive in the opposite order. Old Timer can discuss hunting; Spoor in Garbage will happily keep you talking about tracks. I examine what people bring back. We disagree often enough to keep supper interesting. Listen to the details that made somebody hesitate. They're usually more useful than the size of the thing in the final telling.",
	options = {
		"TutorialTopic2_1",
		"TutorialTopicBack",
	},
})

DIALOGUE.addTopic("TutorialTopic3", {
	statement = "What should I pack for a first trip?",
	response = "Food, water, medical supplies you understand, and a means of defending yourself that you've checked before leaving. Make room for a working Geiger counter. Technut can look at equipment that needs attention. Then leave some space in the pack. Saw a man spend ages choosing which belongings to abandon beside a find once. His companion ate while waiting. Sensible preparation from at least one member of the expedition.",
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
				"Technut tried to imitate a fault he'd heard in a piece of equipment. Excellent performance. By the time he reached the grinding noise, three people were explaining what it must be and nobody knew which machine he meant. I let them argue. Had spent the morning hearing about a mutant hunt; made a pleasant change to have the noises supplied by somebody sitting safely beside his supper.",
				"Carbon asked why I hadn't kept better records of my first journeys. I had kept them. Then I needed a dry bit of paper for a fire and became interested in the practical value of a page. He looked at me as though I'd burnt the answer to everything. Good fire. Warmed my hands, dried a cuff. He's allowed to regret the notes; I reserve some affection for the evening they improved.",
				"Met a fellow who wanted advice on travelling with a heavy pack. Suggested putting some of it down. He began explaining the importance of every scrap, including something from a wreck he couldn't identify. I became quite interested in seeing it. He'd packed it at the bottom. We had a long, inconvenient look, and afterwards he was much less attached to it. Difficult to persuade a man of anything while the object stays an idea in his bag.",
				"Heard two accounts of the same mutant over supper. By the second, I was beginning to feel sorry for the men who'd faced it. Then the first teller asked where the second had been standing. 'Here,' he said, pointing at his chair. Good listener, poor witness. We let him finish anyway. He'd remembered the part about the lost boot better than the man who'd lost it.",
				"Lemon objected to a fellow describing his cooking as adequate after an expedition. Thought we'd be there all night. Then the fellow asked for more, and suddenly adequate became evidence of a poor vocabulary rather than poor judgement. I enjoyed the meal and the explanation. Lemon could feed a camp on the energy he spends making sure the compliment arrives in the proper form.",
				"Spoor wanted to know what a mutant had been eating. I wanted to describe the noise it made. We each considered the other an obstacle to a useful account. Eventually he asked whether the noise came before or after it stopped feeding, which let us both become interested. Pleasant evening after that. I can endure a question if somebody has actually listened long enough to think of it.",
				"Told a man I couldn't remember where I'd put my gloves. Looked delighted, as though he'd caught the first stalker admitting the whole Zone was somebody else's idea. We searched the place together. Found them where I'd been drying my coat. He remembered the exact words of my admission; I remembered who'd helped find the gloves. Told him he could include that part when he took the story round camp.",
			}

			self.response = table.Random(tbl)
		end
	end,
})

DIALOGUE.addTopic("InterestMoreTopic", {
	statement = "What else comes to mind?",
	response = "",
	options = {
		"InterestMoreTopic",
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if CLIENT then
			local tbl = {
				"Technut tried to imitate a fault he'd heard in a piece of equipment. Excellent performance. By the time he reached the grinding noise, three people were explaining what it must be and nobody knew which machine he meant. I let them argue. Had spent the morning hearing about a mutant hunt; made a pleasant change to have the noises supplied by somebody sitting safely beside his supper.",
				"Carbon asked why I hadn't kept better records of my first journeys. I had kept them. Then I needed a dry bit of paper for a fire and became interested in the practical value of a page. He looked at me as though I'd burnt the answer to everything. Good fire. Warmed my hands, dried a cuff. He's allowed to regret the notes; I reserve some affection for the evening they improved.",
				"Met a fellow who wanted advice on travelling with a heavy pack. Suggested putting some of it down. He began explaining the importance of every scrap, including something from a wreck he couldn't identify. I became quite interested in seeing it. He'd packed it at the bottom. We had a long, inconvenient look, and afterwards he was much less attached to it. Difficult to persuade a man of anything while the object stays an idea in his bag.",
				"Heard two accounts of the same mutant over supper. By the second, I was beginning to feel sorry for the men who'd faced it. Then the first teller asked where the second had been standing. 'Here,' he said, pointing at his chair. Good listener, poor witness. We let him finish anyway. He'd remembered the part about the lost boot better than the man who'd lost it.",
				"Lemon objected to a fellow describing his cooking as adequate after an expedition. Thought we'd be there all night. Then the fellow asked for more, and suddenly adequate became evidence of a poor vocabulary rather than poor judgement. I enjoyed the meal and the explanation. Lemon could feed a camp on the energy he spends making sure the compliment arrives in the proper form.",
				"Spoor wanted to know what a mutant had been eating. I wanted to describe the noise it made. We each considered the other an obstacle to a useful account. Eventually he asked whether the noise came before or after it stopped feeding, which let us both become interested. Pleasant evening after that. I can endure a question if somebody has actually listened long enough to think of it.",
				"Told a man I couldn't remember where I'd put my gloves. Looked delighted, as though he'd caught the first stalker admitting the whole Zone was somebody else's idea. We searched the place together. Found them where I'd been drying my coat. He remembered the exact words of my admission; I remembered who'd helped find the gloves. Told him he could include that part when he took the story round camp.",
			}

			self.response = table.Random(tbl)
		end
	end,
})

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "What do you say to people who doubt you were first?",
	response = "Depends whether they've asked a question or arrived with the answer. Carbon brings dates. Spoor wants to know where I stood. Old Timer begins by disagreeing and eventually remembers something worth hearing. I can make an evening of any of those. A fellow once dismissed my account of a mutant, then asked which way he'd be safest walking. I answered the second question. He stayed for the rest of the story.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What would make you reconsider an account?",
	response = "Something we can look at together. A page, a place, a detail I hadn't noticed. I won't promise to enjoy being corrected. Nor will I accept a folder's cover as evidence for everything inside. Sometimes I've mixed two nights together. Sometimes the writer wasn't where they claimed to be. We can keep both possibilities on the table while we talk. Carbon brings enough paper for that.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "Do you get tired of telling the same stories?",
	response = "I get tired of the same interruptions. A man hears 'mutant' and immediately wants its size. I was describing the night we spent arguing over whose coat had fallen in the mud. Good coat. Much more important to us at the time than whatever made the noise outside. You let me finish and there might be something in the story you haven't heard. Even I notice a different part when the company changes.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "Why keep talking to Carbon if he doubts you?",
	response = "Because he comes back with another question. Most people decide whether they believe you and consider the evening finished. Carbon wants to know why I mentioned a stove before I mentioned the building. I hadn't thought about the stove for years. Now we're arguing over where it stood. Annoying man. Listens properly. Those qualities occur together more often than you'd expect.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Was there actually a mutant outside?",
	response = "Heard something. Nobody volunteered to go and establish its credentials. By morning everyone remembered a different noise, and one man remembered being asleep throughout. He told the most alarming version later. I should have charged him for the coat.",
	options = {"BackTopic"},
})
