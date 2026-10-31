DIALOGUE.name = "Arena Master"
DIALOGUE.townContact = "arena-master"

ix.dialogue.AddTradeTopic(DIALOGUE, "Want to trade?", "Sure, I have some arena supplies.")

DIALOGUE.addTopic("GREETING", {
	response = "Greetings, I am the arena master.",
	options = {
		"HealTopic",
		"JoinArena",
		"TutorialTopic",
		"GOODBYE",
		"TradeTopic",
		"AboutWorkTopic",
		"TownProgression",
	},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about something else.",
	response = "What would you like to know?",
	options = {
		"HealTopic",
		"JoinArena",
		"TutorialTopic",
		"GOODBYE",
		"TradeTopic",
		"AboutWorkTopic",
		"TownProgression",
	}, -- Should be identical to GREETING's options
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you!",
	response = "Take care, STALKER...",
})

DIALOGUE.addTopic("JoinArena", {
	statement = "I would like to join the arena.",
	response = "Sure.",
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
				self.response = "No players to challenge."
			else
				self.response = "Players:"

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
	statement = "Can you patch me up?",
	response = "I can restore your health, so you can get ready for the arena.",
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
	response = "Not enough money for that.",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("TutorialTopic", {
	statement = "What do you do?",
	response = "Well, I'm the arena master. I facilitate fights.",
	options = {
		"TutorialTopic1",
		"TutorialTopic2",
		-- "TutorialTopic3",
		"BackTopic",
	},
})

DIALOGUE.addTopic("TutorialTopicBack", {
	statement = "Alright, let me ask you something else.",
	response = "Hmm?",
	options = {
		"TutorialTopic1",
		"TutorialTopic2",
		-- "TutorialTopic3",
		"BackTopic",
	},
})

DIALOGUE.addTopic("TutorialTopic1", {
	statement = "How do I fight someone?",
	response = (
		"You can challenge anyone near us, and you both have to "
		.. "confirm the fight after inspecting their gear. If you wait "
		.. "too long, I assume you chicken out and the challenge is "
		.. "no longer valid."
	),
	options = {
		"TutorialTopicBack",
	},
})

DIALOGUE.addTopic("TutorialTopic2", {
	statement = "What are the rules?",
	response = (
		"Well, its up to you to decide it. I just facilitate the "
		.. "fights. But there are some basic rules. \n\n - The fight "
		.. "ends when someone dies. \n - You have three minutes before "
		.. "the match ends in a draw. \n - I will make sure your stuff "
		.. "doesn't take damage if you are shot at in the arena. Your "
		.. "guns, however, still get dirty from the shooting you are "
		.. "doing."
	),
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
			if target.selectedsuitstruct[4] == v.baseSuit and variants[v.suitVariant] then
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
