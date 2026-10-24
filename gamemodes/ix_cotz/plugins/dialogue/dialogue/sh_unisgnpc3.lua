DIALOGUE.name = "Smartass NPC"

DIALOGUE.addTopic("GREETING", {
	response = "Hello there.",
	options = {
		"TradeTopic",
		"BackgroundTopic",
		"AboutWorkTopic",
		-- "GetTask",
		"GetTaskByDifficulty",
		"AboutProgression",
		"ChangeSuitVariant",
		"GOODBYE",
	},
	preCallback = function(self, client, target)
		-- netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(), {"repair", "mechanical",
		-- "electronics"}, 4)

		if SERVER then
			if target:GetNetVar("possibleJobs") == nil then
				local possibleJobs = {}
				possibleJobs["easy"] = { "scanRFeasy" }
				possibleJobs["medium"] = { "scanRFmedium" }
				possibleJobs["hard"] = { "scanRFhard" }

				target:SetNetVar("possibleJobs", possibleJobs)
			end
		end
	end,
})

DIALOGUE.addTopic("TradeTopic", {
	statement = "Want to trade?",
	response = "I'm always looking to buy artifacts and mutant parts.",
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

DIALOGUE.addTopic("AboutWorkTopic", {
	statement = "About work...",
	response = "",
	IsDynamic = true,
	options = {
		"BackTopic",
	},
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {}

		if client:ixHasJobFromNPC(target:GetDisplayName()) then
			local jobs = client:GetCharacter():GetJobs()

			-- If it's an item delivery quest
			local itemuid = ix.jobs.isItemJob(jobs[target:GetDisplayName()].identifier)

			if itemuid and not jobs[target:GetDisplayName()].isCompleted then
				dynamicOptions = {
					{
						statement = string.format("Hand over 1 %s", ix.item.list[itemuid].name),
						topicID = "AboutWorkTopic",
						dynamicData = { identifier = itemuid },
					},
				}
			end
		end

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
	end,
	preCallback = function(self, client, target)
		if client:ixHasJobFromNPC(target:GetDisplayName()) then
			local jobs = client:GetCharacter():GetJobs()
			if jobs[target:GetDisplayName()].isCompleted then
				if SERVER then
					ix.dialogue.notifyTaskComplete(
						client,
						ix.jobs.getFormattedName(jobs[target:GetDisplayName()])
					)
					client:ixJobComplete(target:GetDisplayName())
				end
				if CLIENT then
					self.response = "As promised, here's your reward."
				end
			else
				if CLIENT then
					self.response = string.format(
						"What's the status on %s?",
						ix.jobs.getFormattedName(jobs[target:GetDisplayName()])
					)
				end
			end
		else
			if CLIENT then
				self.response = "What are you talking about? We haven't planned anything."
			end
		end
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		netstream.Start("job_deliveritem", target:GetDisplayName())

		-- Return the next topicID

		return "BackTopic"
	end,
	ShouldAdd = function(self, client, target)
		if LocalPlayer():GetCharacter():GetJobs()["'Smartass'"] then
			return true
		end
	end,
})

DIALOGUE.addTopic("ConfirmTask", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	IsDynamic = true,
	DynamicPreCallback = function(self, player, target, dynamicData)
		if dynamicData then
			if CLIENT then
				self.response = dynamicData.description
			else
				target.taskid = dynamicData.identifier
			end
		end
	end,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {
			{ statement = "I'll take it", topicID = "ConfirmTask", dynamicData = { accepted = true } },
			{ statement = "I'll pass", topicID = "ConfirmTask", dynamicData = { accepted = false } },
		}
		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		if SERVER then
			if dynamicData.accepted then
				if not ix.jobs.NPCHasJob(target:GetDisplayName(), target.taskid) then
					client:Notify("Task was taken by somebody else!")
				else
					ix.dialogue.notifyTaskGet(client, ix.jobs.getFormattedNameInactive(target.taskid))

					client:ixJobAdd(target.taskid, target:GetDisplayName())

					ix.jobs.setNPCJobTaken(target:GetDisplayName(), target.taskid)
				end
			end

			target.taskid = nil
		end

		-- Return the next topicID

		return "BackTopic"
	end,
})

DIALOGUE.addTopic("GetTask", {
	statement = "Do you have any work for me?",
	response = "I have a few things I need done, yes.",
	options = {
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if client:ixHasJobFromNPC(target:GetDisplayName()) and CLIENT then
			self.response = "You already have a task, which isn't completed yet."
		end
	end,
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {}

		if not client:ixHasJobFromNPC(target:GetDisplayName()) then
			local jobs = target:GetNetVar("jobs")

			for _, v in pairs(jobs) do
				table.insert(dynamicOptions, {
					statement = ix.jobs.getFormattedNameInactive(v),
					topicID = "GetTask",
					dynamicData = { identifier = v },
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

		return "ConfirmTask",
			{
				description = ix.jobs.getFormattedDescInactive(dynamicData.identifier),
				identifier = dynamicData.identifier,
			}
	end,
	ShouldAdd = function(self, client, target)
		if not LocalPlayer():GetCharacter():GetJobs()["'Smartass'"] then
			return true
		end
	end,
})

-- alternative based on difficulty
DIALOGUE.addTopic("GetTaskByDifficulty", {
	statement = "Do you have any work for me?",
	response = "Yes, what difficulty task are you looking for?.",
	options = {
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if client:ixHasJobFromNPC(target:GetDisplayName()) and CLIENT then
			self.response = "I already gave you some work."
		end
	end,
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {}

		if not client:ixHasJobFromNPC(target:GetDisplayName()) then
			table.insert(dynamicOptions, {
				statement = "A trivial task.",
				topicID = "GetTaskByDifficulty",
				dynamicData = { difficulty = "easy" },
			})
			table.insert(dynamicOptions, {
				statement = "A challenging task.",
				topicID = "GetTaskByDifficulty",
				dynamicData = { difficulty = "medium" },
			})
			table.insert(dynamicOptions, {
				statement = "A hard task.",
				topicID = "GetTaskByDifficulty",
				dynamicData = { difficulty = "hard" },
			})
		end

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption

		return dynamicOptions
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		if SERVER then
			local possibleJobs = target:GetNetVar("possibleJobs")
			local jobCategories = possibleJobs[dynamicData.difficulty]
			local jobid = ix.jobs.getJobFromCategory(jobCategories)

			if not client:ixJobAdd(jobid, target:GetDisplayName()) then
				return "BackTopic", dynamicOptions
			end
			ix.dialogue.notifyTaskGet(client, ix.jobs.getFormattedNameInactive(jobid))
			ix.jobs.setNPCJobTaken(target:GetDisplayName(), jobid)
		end

		-- Return the next topicID

		return "BackTopic", dynamicOptions
	end,
	ShouldAdd = function(self, client, target)
		if not LocalPlayer():GetCharacter():GetJobs()["'Smartass'"] then
			return true
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
					statement = ix.item.list[progitem].name,
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

DIALOGUE.addTopic("AboutProgression", {
	statement = "What do you need help with?",
	response = "I have a few things I need done.",
	options = {
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if CLIENT then
			if #ix.progression.GetActiveProgressions(client:GetCharacter(), "'Smartass'") <= 0 then
				self.response = "Nothing at the moment."
			end
		end
	end,
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {}

		local test = ix.progression.GetActiveProgressions(client:GetCharacter(), "'Smartass'")

		for _, progressionID in
			pairs(ix.progression.GetActiveProgressions(client:GetCharacter(), "'Smartass'"))
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
		return #ix.progression.GetActiveProgressions(client:GetCharacter(), "'Smartass'") > 0
	end,
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "Tell me about yourself.",
	response = "Fuck off.",
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
					dynamicData = { itemuid = v.uniqueID, itemID = v:GetID(), baseSuit = v.baseSuit },
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

			target.selectedsuitstruct = { dynamicData.itemID, dynamicData.itemuid, dynamicData.baseSuit }
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
				dynamicData = { suitVariantUID = v.uniqueID, accepted = true },
			})
		end

		table.insert(dynamicOptions, {
			statement = "Actually, nevermind...",
			topicID = "ChangeSuitVariantP2",
			dynamicData = { accepted = false },
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
	statement = "Let's talk about another topic.",
	response = "Anything else?",
	options = {
		"TradeTopic",
		"BackgroundTopic",
		"AboutWorkTopic",
		-- "GetTask",
		"GetTaskByDifficulty",
		-- "AboutProgression",
		"ChangeSuitVariant",
		"GOODBYE",
	},
	preCallback = function(self, client, target) end,
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "I'll talk to you later.",
	response = "Bye.",
})
