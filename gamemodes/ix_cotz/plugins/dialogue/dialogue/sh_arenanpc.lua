DIALOGUE.name = "Arena Master"
DIALOGUE.townContact = "arena-master"

ix.dialogue.AddTradeTopic(
	DIALOGUE,
	"What arena supplies are you trading?",
	"Take a look. Easier to choose before the spectators begin offering their expertise."
)

DIALOGUE.addTopic("GREETING", {
	response = "Welcome. Here for a bout, supplies, or a seat among the people who know exactly what the fighters should have done?",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
		"HealTopic",
		"JoinArena",
		"TutorialTopic",
		"GOODBYE",
		"TradeTopic",
		"AboutWorkTopic",
	},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Something else.",
	response = "Go on. We've time for another question.",
	options = {
		"SpecialtyTopic",
		"InterestZoneLifeTopic",
		"InterestTownRelationsTopic",
		"HealTopic",
		"JoinArena",
		"TutorialTopic",
		"GOODBYE",
		"TradeTopic",
		"AboutWorkTopic",
	}, -- Should be identical to GREETING's options
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "I'll look in another time.",
	response = "Enjoy the afternoon. Come back with an opinion; we're rarely short, but there's always room for another.",
})

DIALOGUE.addTopic("JoinArena", {
	statement = "I'd like to challenge someone to an arena bout.",
	response = "Let's see who's here to challenge.",
	options = {
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if CLIENT then
			local availablePlayers = {}

			for _, v in
				ipairs(ents.FindInSphere(ix.progression.GetNPCFromName("'Arena Master'"):GetPos(), 512))
			do
				if not v:IsPlayer() then
					continue
				end
				if v == client then
					continue
				end
				availablePlayers[#availablePlayers + 1] = v
			end

			if #availablePlayers <= 0 then
				self.response = "Nobody else nearby to challenge just now. You can wait or come back later."
			else
				self.response = "Here are the people nearby. Choose who you'd like to challenge:"

				for _, player in pairs(availablePlayers) do
					self.response = self.response .. "\n    " .. player:GetName()
				end
			end
		end
	end,
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {}

		for _, v in ipairs(ents.FindInSphere(ix.progression.GetNPCFromName("'Arena Master'"):GetPos(), 512)) do
			if not v:IsPlayer() then
				continue
			end
			if v == client then
				continue
			end

			table.insert(
				dynamicOptions,
				{ statement = v:GetName(), topicID = "JoinArena", dyndata = { player = v } }
			)
		end

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		if SERVER then
			local arenaPlugin = ix.plugin.Get("arena")
			if arenaPlugin:CanStartArena("swampsarena") then
				if
					IsValid(dynamicData.player)
					and dynamicData.player:IsPlayer()
					and dynamicData.player:Alive()
				then
					local loadout = {}
					local char = dynamicData.player:GetCharacter()
					local inv = char:GetInventory()

					for _, item in pairs(inv:GetItems()) do
						if item.isWeapon or item.category == "Weapons" and item:GetData("equip", false) then
							table.insert(loadout, item:GetName() or "Unknown Item")
						end
					end

					net.Start("ixArenaChallenge")
					net.WriteString(dynamicData.player:Nick())
					net.WriteString(dynamicData.player:SteamID())
					net.WriteString("swampsarena")
					net.WriteString(dynamicData.player:GetModel())
					net.WriteString(dynamicData.player:getCurrentRankName())
					net.WriteTable(loadout)
					net.Send(client)
				end
			else
				client:Notify("The arena is currently occupied!")
			end
		end

		-- Return the next topicID

		return "BackTopic", dynamicData
	end,
})

DIALOGUE.addTopic("HealTopic", {
	statement = "Can I get treatment here?",
	response = "Let's look at the treatment options and their prices before you decide.",
	IsDynamic = true,
	options = {
		"BackTopic",
	},
	GetDynamicOptions = function(self, client, target)
		return ix.progression.GetTreatmentOptions(client, target)
	end,
	ResolveDynamicOption = function(self, client, target, data)
		return ix.progression.ResolveServiceOffer(client, target, "treatment", data)
	end,
})

DIALOGUE.addTopic("ConfirmHeal", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	IsDynamic = true,
	DynamicPreCallback = function(self, client, target, data)
		ix.progression.ConfirmService(self, client, target, "treatment", data)
	end,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {
			{
				statement = "I can agree to that. Go ahead and heal me.",
				topicID = "ConfirmHeal",
				dyndata = { accepted = true },
			},
			{
				statement = "On second thought...",
				topicID = "ConfirmHeal",
				dyndata = { accepted = false },
			},
		}

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, data)
		if SERVER then
			local accepted = type(data) == "table" and data.accepted == true
			local completed = ix.progression.ExecuteService(client, target, "treatment", accepted)
			if accepted and not completed then
				client:Notify("That service could not be completed. Please request a fresh quote.")
			end
		end

		return "BackTopic"
	end,
})

DIALOGUE.addTopic("NotEnoughMoneyHeal", {
	statement = "",
	response = "You haven't enough for that treatment. Leave the purchase for now.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("TutorialTopic", {
	statement = "How do you run the arena?",
	response = "I arrange the bouts and try to get both fighters into the same contest they thought they agreed to. You'd be surprised how much conversation that can take. The spectators need less encouragement. Ask about entering or the rules before you commit; it's an easier discussion while everyone's still standing here.",
	options = {
		"TutorialTopic1",
		"TutorialTopic2",
		-- "TutorialTopic3",
		"BackTopic",
	},
})

DIALOGUE.addTopic("TutorialTopicBack", {
	statement = "Another question about the arena.",
	response = "Certainly. Better to ask now than argue about it afterwards.",
	options = {
		"TutorialTopic1",
		"TutorialTopic2",
		-- "TutorialTopic3",
		"BackTopic",
	},
})

DIALOGUE.addTopic("TutorialTopic1", {
	statement = "How do I arrange a bout?",
	response = "Ask me to challenge someone nearby. You both get to inspect the other's equipment before confirming. Take a proper look; an enthusiastic introduction isn't a description of a loadout. The challenge expires if you leave it too long. You can decide against a match. I'd rather you did it here than spent the first exchange discovering you had entirely different ideas.",
	options = {
		"TutorialTopicBack",
	},
})

DIALOGUE.addTopic("TutorialTopic2", {
	statement = "What rules should I know before entering?",
	response = "Agree on the contest with your opponent, but these limits apply: the bout ends when one fighter dies, and the three-minute time limit ends an unfinished match in a draw. Equipment is protected from damage caused by the other fighter in the arena. Firing still dirties your weapon. Don't count on the match to clean it for your next expedition. And settle any special understanding before you both confirm; I have heard quite enough inventive recollections afterwards.",
	options = {
		-- "TutorialTopic2_1",
		-- "TutorialTopic2_2",
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
			if v.baseSuit and not v:GetData("equip") then
				local convertcost = math.Round(v.price / 10)
				table.insert(dynamicOptions, {
					statement = v:GetName() .. " - " .. ix.currency.Get(convertcost),
					topicID = "ChangeSuitVariant",
					dyndata = {
						itemuid = v.uniqueID,
						itemid = v:GetID(),
						cost = convertcost,
						baseSuit = v.baseSuit,
					},
				})
			end
		end

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		-- Return the next topicID
		if not client:GetCharacter():HasMoney(dynamicData.cost) then
			return "NotEnoughMoneySuitVariantChange"
		end

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
					(
						"Which suit would you like instead? It will cost you %s. "
						.. "Be sure to remove attachments beforehand."
					),
					ix.currency.Get(dynamicData.cost)
				)
			end

			target.selectedsuitstruct =
				{ dynamicData.itemid, dynamicData.itemuid, dynamicData.cost, dynamicData.baseSuit }
		end
	end,
	GetDynamicOptions = function(self, client, target)
		local variants = {
			["baseline"] = true,
			["anarchist"] = true,
			["authority"] = true,
			["mercenary"] = true,
			["looted"] = true,
			["ecologist"] = true,
			["scavenger"] = true,
			["fanatic"] = true,
		}

		local suitVariants = {}
		for _, v in pairs(ix.item.list) do
			if target.selectedsuitstruct[4] == v.baseSuit and variants[v.suitVariant]
				and ix.townNPCs:CanChangeSuitVariant(client:GetCharacter(), v.uniqueID, target:GetDisplayName()) then
				table.insert(suitVariants, { uniqueID = v.uniqueID, name = v.name })
			end
		end

		local dynamicOptions = {}
		for _, v in pairs(suitVariants) do
			if v.uniqueID == target.selectedsuitstruct[2] then
				continue
			end

			table.insert(dynamicOptions, {
				statement = "["
					.. (v.uniqueID:gsub("^.*_", "")):gsub("^%l", string.upper)
					.. "] "
					.. v.name
					.. " with cost "
					.. ix.currency.Get(target.selectedsuitstruct[3]),
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
			if client:GetCharacter():GetData("carry", 0) >= ix.weight.BaseWeight(client:GetCharacter()) then
				client:Notify("You are extremely overencumbered and can't do that!")

				return "BackTopic"
			end
			local originalSuit = ix.item.instances[target.selectedsuitstruct[1]]
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
			ix.dialogue.notifyMoneyLost(client, ix.currency.Get(target.selectedsuitstruct[3]))
			client:GetCharacter():TakeMoney(target.selectedsuitstruct[3])

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

DIALOGUE.addTopic("SpecialtyTopic", {
	statement = "Can you usually pick the winner?",
	response = "I can usually pick somebody to be wrong about. Quiet fighter, patient feet, looks promising; turns out they're still deciding which way to go. Loud one makes a ridiculous first move, then adapts beautifully. That's the pleasure of watching. If their reputation settled it, we could save everyone the ammunition and let the audience compare stories. Though I suppose the argument would last longer than a bout.",
	options = {"InterestTownFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownFollowup", {
	statement = "What keeps a losing fighter interesting?",
	response = "They try something after the first idea fails. You see the moment they've noticed, then they have to do it with another person interfering. I like that. Afterwards they get a whole audience explaining how obvious the answer was. Handle that without demanding an immediate rematch and they've done something else worth watching. Doesn't stop the spectators talking, unfortunately.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestZoneLifeTopic", {
	statement = "Are the spectators more trouble than the fighters?",
	response = "They've more spare breath. You can be discussing a perfectly decent bout and somebody begins explaining how he'd have handled a bloodsucker. Wonderful creature for an argument: absent, difficult to interview, never complains about the account. I like hearing them, though. You learn who came to watch the fight and who came because the camp was getting quiet. Sometimes the second lot have the better evening.",
	options = {"InterestPersonalFollowup", "BackTopic"},
})

DIALOGUE.addTopic("InterestTownRelationsTopic", {
	statement = "Why does Jitters sound annoyed when your name comes up?",
	response = "He hears the end of a story after the applause has stopped. I hear it while everyone's still enjoying the clever part. We do have different afternoons. He once asked me to finish describing a match while he washed a fighter's blood off his hands. I rather lost my place. No, we aren't enemies. I'd prefer him at a table with a drink and fewer reasons to look at me like that.",
	options = {"BackTopic"},
})

DIALOGUE.addTopic("InterestPersonalFollowup", {
	statement = "Do you ever get tired of the noise?",
	response = "Afterwards, when one spectator is still explaining the first exchange. Everybody else has eaten, the subject has changed twice, and he's moving cups around to show us the footwork. I make a very poor audience when my supper's involved. Apparently this is hypocrisy.",
	options = {"BackTopic"},
})
