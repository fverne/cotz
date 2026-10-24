DIALOGUE.name = "Boss NPC"

DIALOGUE.addTopic("GREETING", {
	response = "Look what the cat dragged in.",
	options = {
		"TradeTopic",
		"RepairItems",
		"BackgroundTopic",
		"AboutWorkTopic",
		-- "GetTask",
		"GetTaskByDifficulty",
		"AboutProgression",
		"GOODBYE",
	},
	preCallback = function(self, client, target)
		-- netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(), {"repair", "mechanical",
		-- "electronics"}, 4)

		if SERVER then
			if target:GetNetVar("possibleJobs") == nil then
				local possibleJobs = {}
				possibleJobs["easy"] = { "dataextracteasy" }
				possibleJobs["medium"] = { "dataextractmedium" }
				possibleJobs["hard"] = { "dataextracthard" }

				target:SetNetVar("possibleJobs", possibleJobs)
			end
		end
	end,
})

DIALOGUE.addTopic("TradeTopic", {
	statement = "Want to trade?",
	response = "Sure.",
	postCallback = function(self, client, target)
		if SERVER then
			local character = client:GetCharacter()

			target.receivers[#target.receivers + 1] = client

			local items = {}

			-- Only send what is needed.
			for k, v in pairs(ix.vendorStock.GetItems(character, target)) do
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
			client.ixVendorAdvEditing = nil

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
						dyndata = { identifier = itemuid },
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
				self.response = "What are you talking about?"
			end
		end
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		netstream.Start("job_deliveritem", target:GetDisplayName())

		-- Return the next topicID

		return "BackTopic"
	end,
	ShouldAdd = function(self, client, target)
		if LocalPlayer():GetCharacter():GetJobs()["'Boss'"] then
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
			{ statement = "I'll take it", topicID = "ConfirmTask", dyndata = { accepted = true } },
			{ statement = "I'll pass", topicID = "ConfirmTask", dyndata = { accepted = false } },
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
					dyndata = { identifier = v },
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
		if not LocalPlayer():GetCharacter():GetJobs()["'Boss'"] then
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
				dyndata = { difficulty = "easy" },
			})
			table.insert(dynamicOptions, {
				statement = "A challenging task.",
				topicID = "GetTaskByDifficulty",
				dyndata = { difficulty = "medium" },
			})
			table.insert(dynamicOptions, {
				statement = "A hard task.",
				topicID = "GetTaskByDifficulty",
				dyndata = { difficulty = "hard" },
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
		if not LocalPlayer():GetCharacter():GetJobs()["'Boss'"] then
			return true
		end
	end,
})

DIALOGUE.addTopic("RepairItems", {
	statement = "Can you fix my items?",
	response = "What would you like me to look at?",
	IsDynamic = true,
	options = {
		"BackTopic",
	},
	-- ShouldAdd = function(self, client, target) return ix.GetProgression("funy") end,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {}

		local items = client:GetCharacter():GetInventory():GetItems()

		for _, v in pairs(items) do
			if v.canRepair then
				if v.isWeapon then
					local percenttorepair = (100 - v:GetData("wear", 100))
					if percenttorepair < 0.5 then
						continue
					end
					local repaircost = math.Round(percenttorepair * v:GetRepairCost())

					table.insert(dynamicOptions, {
						statement = v:GetName()
							.. " ( "
							.. math.Round(v:GetData("wear", 100))
							.. "% Cleanliness ) - "
							.. ix.currency.Get(repaircost),
						topicID = "RepairItems",
						dyndata = {
							itemuid = v.uniqueID,
							itemid = v:GetID(),
							cost = repaircost,
							type = "wear",
						},
					})
				else
					local percenttorepair = (100 - v:GetData("durability", 100))
					if percenttorepair < 0.5 then
						continue
					end
					local repaircost = math.Round(percenttorepair * v:GetRepairCost())

					table.insert(dynamicOptions, {
						statement = v:GetName()
							.. " ( "
							.. math.Round(v:GetData("durability", 100))
							.. "% Durability ) - "
							.. ix.currency.Get(repaircost),
						topicID = "RepairItems",
						dyndata = {
							itemuid = v.uniqueID,
							itemid = v:GetID(),
							cost = repaircost,
							type = "durability",
						},
					})
				end
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
		if not client:GetCharacter():HasMoney(dynamicData.cost) then
			return "NotEnoughMoneyRepair"
		end

		return "ConfirmRepair", dynamicData
	end,
})

DIALOGUE.addTopic("ConfirmRepair", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	IsDynamic = true,
	DynamicPreCallback = function(self, player, target, dynamicData)
		if dynamicData then
			if CLIENT then
				self.response = string.format(
					"Fixing that %s will cost you %s, is that a deal?",
					ix.item.list[dynamicData.itemuid].name,
					ix.currency.Get(dynamicData.cost)
				)
			else
				target.repairstruct = { dynamicData.itemid, dynamicData.cost, dynamicData.type }
			end
		end
	end,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {
			{
				statement = "That's fine, fix it.",
				topicID = "ConfirmRepair",
				dyndata = { accepted = true },
			},
			{
				statement = "On second thought...",
				topicID = "ConfirmRepair",
				dyndata = { accepted = false },
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
			ix.dialogue.notifyMoneyLost(client, target.repairstruct[2])
			client:GetCharacter():TakeMoney(target.repairstruct[2])

			ix.item.instances[target.repairstruct[1]]:SetData(target.repairstruct[3], 100)

			if ix.item.instances[target.repairstruct[1]].class then
				local wep = client:GetWeapon(ix.item.instances[target.repairstruct[1]].class)
				if IsValid(wep) then
					wep:SetWeaponWear(100)
				end
			end
		end
		if SERVER then
			target.repairstruct = nil
		end
		-- Return the next topicID

		return "BackTopic"
	end,
})

DIALOGUE.addTopic("NotEnoughMoneyRepair", {
	statement = "",
	response = "You don't have enough money to repair that.",
	options = {
		"BackTopic",
	},
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
		if definition.requirementSlots then
			local progitems = ix.progression.GetRequirements(client:GetCharacter(), identifier)
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
					dyndata = { progid = identifier, itemid = progitem },
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

				if definition.requirementSlots then
					progressionStatus = ix.progression.GetComplexProgressionValue(
						player:GetCharacter(),
						dynamicData.identifier
					)
				end

				self.response = definition:BuildResponse(
					target:GetDisplayName(),
					progressionStatus,
					player:GetCharacter()
				)
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
			if #ix.progression.GetActiveProgressions(client:GetCharacter(), "'Boss'") <= 0 then
				self.response = "Nothing at the moment."
			end
		end
	end,
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {}

		for _, progressionID in pairs(ix.progression.GetActiveProgressions(client:GetCharacter(), "'Boss'")) do
			table.insert(dynamicOptions, {
				statement = ix.progression.definitions[progressionID].name,
				topicID = "AboutProgression",
				dyndata = { identifier = progressionID },
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
		return #ix.progression.GetActiveProgressions(client:GetCharacter(), "'Boss'") > 0
	end,
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "What are you doing here?",
	response = (
		"Well, since you busted our location I might as well spill "
		.. "the beans. We are part of an international research group "
		.. "who has infiltrated the zone."
	),
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "And what is your mission?",
	response = (
		"Most of the details are classified, but if you help us "
		.. "out, we'll let you know what we know about the zone so "
		.. "far."
	),
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about another topic.",
	response = "Anything else?",
	options = {
		"TradeTopic",
		"RepairItems",
		"BackgroundTopic",
		"AboutWorkTopic",
		-- "GetTask",
		"GetTaskByDifficulty",
		"AboutProgression",
		"GOODBYE",
	},
	preCallback = function(self, client, target) end,
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "I'll talk to you later.",
	response = "Bye.",
})
