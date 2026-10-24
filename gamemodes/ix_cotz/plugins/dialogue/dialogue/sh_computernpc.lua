DIALOGUE.name = "Computer NPC"

DIALOGUE.addTopic("GREETING", {
	response = "** The computer beeps as it detects you **",
	options = {
		-- "BackgroundTopic",
		"AboutWorkTopic",
		-- "GetTask",
		"GetTaskByDifficulty",
		"AboutProgression",
		"GOODBYE",
	},
	preCallback = function(self, client, target)
		-- netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(),
		-- {"artifactcollect_computer"}, 2)
		if SERVER then
			if target:GetNetVar("possibleJobs") == nil then
				local possibleJobs = {}
				possibleJobs["any"] = { "artifactcollect_computer" }

				target:SetNetVar("possibleJobs", possibleJobs)
			end
		end

		if CLIENT then
			surface.PlaySound("buttons/button18.wav")
		end
	end,
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "** Query the computer for information **",
	response = "Temp",
	options = {
		"BackgroundTopic2",
	},
	ShouldAdd = function(self, client, target)
		return not ix.progression.IsActive(client:GetCharacter(), "computerDelivery_activateItem")
	end,
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "** Query the computer for more information **",
	response = "Temp",
	options = {
		"BackgroundTopic3",
	},
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "** Query the computer for more information **",
	response = "Temp",
	options = {
		"BackgroundTopic4",
	},
})

DIALOGUE.addTopic("BackgroundTopic4", {
	statement = "** Query the computer for more information **",
	response = "Temp",
	options = {
		"BackTopic",
	},
})

DIALOGUE.addTopic("AboutWorkTopic", {
	statement = "** Query the computer about work **",
	response = "",
	IsDynamic = true,
	options = {
		"BackTopic",
	},
	ShouldAdd = function(self, client, target)
		return not ix.progression.IsActive(client:GetCharacter(), "computerDelivery_activateItem")
	end,
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
					self.response = "** The computer beeps in an accepting manner **."
					surface.PlaySound("buttons/button3.wav") -- OK
				end
			else
				if CLIENT then
					self.response = string.format(
						"A message appears on the screen saying: '%s'",
						ix.jobs.getFormattedName(jobs[target:GetDisplayName()])
					)
					surface.PlaySound("buttons/button18.wav")
				end
			end
		else
			if CLIENT then
				self.response = "** The computer beeps in a dismissive fashion **"
				surface.PlaySound("buttons/button8.wav") -- ERROR
			end
		end
	end,
	ResolveDynamicOption = function(self, client, target, dynamicData)
		netstream.Start("job_deliveritem", target:GetDisplayName())

		-- Return the next topicID

		return "BackTopic"
	end,
	ShouldAdd = function(self, client, target)
		if LocalPlayer():GetCharacter():GetJobs()["'Computer'"] then
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
			{ statement = "** Press 'Y' **", topicID = "ConfirmTask", dynamicData = { accepted = true } },
			{ statement = "** Press 'N' **.", topicID = "ConfirmTask", dynamicData = { accepted = false } },
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
	statement = "** Query the computer for work **",
	response = "** The computer beeps in confirmation **",
	options = {
		"BackTopic",
	},
	ShouldAdd = function(self, client, target)
		return not ix.progression.IsActive(client:GetCharacter(), "computerDelivery_activateItem")
	end,
	preCallback = function(self, client, target)
		if CLIENT then
			if client:ixHasJobFromNPC(target:GetDisplayName()) then
				self.response = "** The computer beeps in error **"
				surface.PlaySound("buttons/button8.wav") -- ERROR
			else
				surface.PlaySound("buttons/button3.wav") -- OK
			end
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
		if not LocalPlayer():GetCharacter():GetJobs()["'Computer'"] then
			return true
		end
	end,
})

DIALOGUE.addTopic("GetTaskByDifficulty", {
	statement = "** Query the computer about work **",
	response = "",
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
				statement = "** Press the 'A' button **",
				topicID = "GetTaskByDifficulty",
				dynamicData = { difficulty = "any" },
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
		if not LocalPlayer():GetCharacter():GetJobs()["'Computer'"] then
			return true
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
					statement = "** Insert " .. ix.item.list[progitem].name .. " **",
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

DIALOGUE.addTopic("AboutProgression", {
	statement = "** Inspect the screen **",
	response = "** The computer shows a list on the screen **",
	options = {
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if CLIENT then
			if #ix.progression.GetActiveProgressions(client:GetCharacter(), "'Computer'") <= 0 then
				self.response = "** The computer shows a blank screen**"
			end
		end
	end,
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynamicOptions = {}

		for _, progressionID in
			pairs(ix.progression.GetActiveProgressions(client:GetCharacter(), "'Computer'"))
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
		return #ix.progression.GetActiveProgressions(client:GetCharacter(), "'Computer'") > 0
	end,
})

DIALOGUE.addTopic("BackTopic", {
	statement = "** Press 'Q' **",
	response = "** The computer beeps in confirmation **",
	options = {
		-- "BackgroundTopic",
		"AboutWorkTopic",
		-- "GetTask",
		"GetTaskByDifficulty",
		"AboutProgression",
		"GOODBYE",
	},
	preCallback = function(self, client, target)
		netstream.Start(
			"job_updatenpcjobs",
			target,
			target:GetDisplayName(),
			{ "artifactcollect_computer" },
			2
		)
		if CLIENT then
			surface.PlaySound("buttons/button18.wav")
		end
	end,
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "** Leave **",
	response = "** The computer whirrs **",
	preCallBack = function(self, client, target)
		if CLIENT then
			surface.PlaySound("buttons/button18.wav")
		end
	end,
})
