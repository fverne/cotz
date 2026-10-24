DIALOGUE.name = "Intern NPC"

DIALOGUE.addTopic("GREETING", {
	response = "Hello.",
	options = {
		"TradeTopic",
		"BackgroundTopic",
		"AboutWorkTopic",
		-- "GetTask",
		"GetTaskByDifficulty",
		"AboutProgression",
		"GOODBYE",
	},
	preCallback = function(self, client, target)
		-- netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(), {"electronics",
		-- "information", "dataextract", "artifactcollect_eco"}, 4)
		if SERVER then
			if target:GetNetVar("possibleJobs") == nil then
				local possibleJobs = {}
				possibleJobs["easy"] = { "scanareaeasy" }
				possibleJobs["medium"] = { "scanareamedium" }
				possibleJobs["hard"] = { "scanareahard" }

				target:SetNetVar("possibleJobs", possibleJobs)
			end
		end
	end,
})

DIALOGUE.addTopic("TradeTopic", {
	statement = "Want to trade?",
	response = "Absolutely!",
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

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "Tell me about yourself.",
	response = (
		"I do a longterm internship here, but they make me do all " .. "the counting of equipment..."
	),
	options = {
		"BackgroundTopic2",
	},
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "That sucks. Do you ever go outside?",
	response = "That's classified I'm afraid. But I'm getting tired of this suit.",
	options = {
		"BackgroundTopic3",
	},
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "Alright, thanks.",
	response = "See you later.",
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
					self.response = "Good job. This is from me to you."
				end
			else
				if CLIENT then
					self.response = string.format(
						"Is your contract on %s complete yet?",
						ix.jobs.getFormattedName(jobs[target:GetDisplayName()])
					)
				end
			end
		else
			if CLIENT then
				self.response = "I don't think you are on a contract for me right now."
			end
		end
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		netstream.Start("job_deliveritem", target:GetDisplayName())

		-- Return the next topicID

		return "BackTopic"
	end,
	ShouldAdd = function(self, client, target)
		if LocalPlayer():GetCharacter():GetJobs()["'Intern'"] then
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
			{ statement = "I'll take it.", topicID = "ConfirmTask", dynamicData = { accepted = true } },
			{ statement = "I'll pass.", topicID = "ConfirmTask", dynamicData = { accepted = false } },
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
	response = "I have a few contracts available, yes.",
	options = {
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if client:ixHasJobFromNPC(target:GetDisplayName()) and CLIENT then
			self.response = "You are already on a contract."
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
		if not LocalPlayer():GetCharacter():GetJobs()["'Intern'"] then
			return true
		end
	end,
})

DIALOGUE.addTopic("GetTaskByDifficulty", {
	statement = "Do you have any work for me?",
	response = ("I have a few contracts available, what difficulty task " .. "are you looking for?."),
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
			local jobCategories = table.Random(possibleJobs[dynamicData.difficulty])
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
		if not LocalPlayer():GetCharacter():GetJobs()["'Intern'"] then
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
					statement = "Hand over " .. ix.item.list[progitem].name,
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
	statement = "Do you need help with anything?",
	response = "I'm currently approaching a breakthrough, here's my research focus.",
	options = {
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if CLIENT then
			if #ix.progression.GetActiveProgressions(client:GetCharacter(), "'Intern'") <= 0 then
				self.response = "Nothing at the moment."
			end
		end
	end,
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {}

		for _, progressionID in pairs(ix.progression.GetActiveProgressions(client:GetCharacter(), "'Intern'")) do
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
		return #ix.progression.GetActiveProgressions(client:GetCharacter(), "'Intern'") > 0
	end,
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about something else...",
	response = "Alright, what do you have in mind?",
	options = {
		"TradeTopic",
		"BackgroundTopic",
		"AboutWorkTopic",
		-- "GetTask",
		"GetTaskByDifficulty",
		-- "AboutProgression",
		"GOODBYE",
	},
	preCallback = function(self, client, target) end,
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you around.",
	response = "Take care!",
})
