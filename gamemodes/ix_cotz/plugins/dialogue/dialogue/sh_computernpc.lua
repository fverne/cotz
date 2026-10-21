DIALOGUE.name = "Computer NPC"

DIALOGUE.addTopic("GREETING", {
	response = "** The computer beeps as it detects you **",
	options = {
		-- "BackgroundTopic",
		"AboutWorkTopic",
		-- "GetTask",
		"GetTaskByDifficulty",
		"AboutProgression",
		"GOODBYE"
	},
	preCallback = function(self, client, target)
		-- netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(), {"artifactcollect_computer"}, 2)
		if (SERVER) then
			if target:GetNetVar("possibleJobs") == nil then
				local possibleJobs = {}
				possibleJobs["any"] = {"artifactcollect_computer"}		
	
				target:SetNetVar("possibleJobs", possibleJobs)
			end
		end
		
		if(CLIENT)then
			surface.PlaySound("buttons/button18.wav")
		end
	end
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
	}
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "** Query the computer for more information **",
	response = "Temp",
	options = {
		"BackgroundTopic4",
	}
})

DIALOGUE.addTopic("BackgroundTopic4", {
	statement = "** Query the computer for more information **",
	response = "Temp",
	options = {
		"BackTopic",
	}
})

DIALOGUE.addTopic("AboutWorkTopic", {
	statement = "** Query the computer about work **",
	response = "",
	IsDynamic = true,
	options = {
		"BackTopic"
	},
	ShouldAdd = function(self, client, target)
		return not ix.progression.IsActive(client:GetCharacter(), "computerDelivery_activateItem")
	end,
	GetDynamicOptions = function(self, client, target)
		local dynopts = {}

		if(client:ixHasJobFromNPC(target:GetDisplayName())) then
			local jobs = client:GetCharacter():GetJobs()

			-- If it's an item delivery quest
			local itemuid = ix.jobs.isItemJob(jobs[target:GetDisplayName()].identifier)

			if itemuid and not jobs[target:GetDisplayName()].isCompleted then
				dynopts = {
					{statement = string.format("Hand over 1 %s", ix.item.list[itemuid].name), topicID = "AboutWorkTopic", dyndata = {identifier = itemuid}},
				}
			end
		end

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption
		return dynopts
	end,
	preCallback = function(self, client, target)
		if client:ixHasJobFromNPC(target:GetDisplayName()) then
			local jobs = client:GetCharacter():GetJobs()
			if (jobs[target:GetDisplayName()].isCompleted) then
				if (SERVER) then 
					ix.dialogue.notifyTaskComplete(client, ix.jobs.getFormattedName(jobs[target:GetDisplayName()]))
					client:ixJobComplete(target:GetDisplayName()) 
				end
				if (CLIENT) then 
					self.response = "** The computer beeps in an accepting manner **." 
					surface.PlaySound("buttons/button3.wav") -- OK
				end
			else
				if (CLIENT) then 
					self.response = string.format("A message appears on the screen saying: '%s'", ix.jobs.getFormattedName(jobs[target:GetDisplayName()])) 
					surface.PlaySound("buttons/button18.wav")
				end
			end
		else
			if (CLIENT) then 
				self.response = "** The computer beeps in a dismissive fashion **" 
				surface.PlaySound("buttons/button8.wav") -- ERROR
			end
		end

	end,
	ResolveDynamicOption = function(self, client, target, dyndata)
		netstream.Start("job_deliveritem", target:GetDisplayName())

		-- Return the next topicID
		return "BackTopic"
	end,
	ShouldAdd = function(self, client, target)
		if (LocalPlayer():GetCharacter():GetJobs()["'Computer'"]) then
			return true
		end
	end,
})

DIALOGUE.addTopic("ConfirmTask", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	IsDynamic = true,
	DynamicPreCallback = function(self, player, target, dyndata)
		if(dyndata) then
			if (CLIENT) then
				self.response = dyndata.description
			else
				target.taskid = dyndata.identifier
			end
		end
	end,
	GetDynamicOptions = function(self, client, target)
		local dynopts = {
			{statement = "** Press 'Y' **", topicID = "ConfirmTask", dyndata = {accepted = true}},
			{statement = "** Press 'N' **.", topicID = "ConfirmTask", dyndata = {accepted = false}},
		}
		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption
		return dynopts
	end,
	ResolveDynamicOption = function(self, client, target, dyndata)
		if (SERVER) then
			if (dyndata.accepted) then
				if (!ix.jobs.NPCHasJob(target:GetDisplayName(), target.taskid)) then
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
		"BackTopic"
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
		local dynopts = {}

		if not client:ixHasJobFromNPC(target:GetDisplayName()) then
			local jobs = target:GetNetVar("jobs")

			for k,v in pairs(jobs) do
				table.insert(dynopts, {statement = ix.jobs.getFormattedNameInactive(v), topicID = "GetTask", dyndata = {identifier = v}})
			end
		end
		
		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption
		return dynopts
	end,
	ResolveDynamicOption = function(self, client, target, dyndata)

		-- Return the next topicID
		return "ConfirmTask", {description = ix.jobs.getFormattedDescInactive(dyndata.identifier), identifier = dyndata.identifier}
	end,
	ShouldAdd = function(self, client, target)
		if (!LocalPlayer():GetCharacter():GetJobs()["'Computer'"]) then
			return true
		end
	end,
})

DIALOGUE.addTopic("GetTaskByDifficulty", {
	statement = "** Query the computer about work **",
	response = "",
	options = {
		"BackTopic"
	},
	preCallback = function(self, client, target)
		if client:ixHasJobFromNPC(target:GetDisplayName()) and CLIENT then
			self.response = "I already gave you some work."
		end
	end,
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynopts = {}
		
		if not client:ixHasJobFromNPC(target:GetDisplayName()) then
			table.insert(dynopts, {statement = "** Press the 'A' button **", topicID = "GetTaskByDifficulty", dyndata = {difficulty = "any"}})
		end
		
		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption
		return dynopts
	end,
	ResolveDynamicOption = function(self, client, target, dyndata)
		if (SERVER) then
			local possibleJobs = target:GetNetVar("possibleJobs")
			local jobCategories = table.Random(possibleJobs[dyndata.difficulty])
			local jobid = ix.jobs.getJobFromCategory(jobCategories)

			if !client:ixJobAdd(jobid, target:GetDisplayName()) then
				return "BackTopic", dynopts
			end
			ix.dialogue.notifyTaskGet(client, ix.jobs.getFormattedNameInactive(jobid))
			ix.jobs.setNPCJobTaken(target:GetDisplayName(), jobid)
		end		

		-- Return the next topicID
		return "BackTopic", dynopts
	end,
	ShouldAdd = function(self, client, target)
		if (!LocalPlayer():GetCharacter():GetJobs()["'Computer'"]) then
			return true
		end
	end,
})

DIALOGUE.addTopic("ViewProgression", {
	statement = "",
	response = "",
	options = {
		"BackTopic"
	},

	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynopts = {}

		local identifier 	= self.tmp
		self.tmp = nil
		local progstatus 	= ix.progression.GetComplexProgressionValue(client:GetCharacter(), identifier)
		local progdef 		= ix.progression.definitions[identifier]
		if(progdef.GetItemIds)then
			local progitems 	= progdef.GetItemIds()
			local missingitems  = {}

			for progitem,cnt in pairs(progitems) do
				local curcnt = 0
				if(progstatus and progstatus[progitem]) then curcnt = progstatus[progitem] end

				if(curcnt < cnt and client:GetCharacter():GetInventory():HasItem(progitem))then
					table.insert(missingitems, progitem)
				end
			end

			for _, progitem in pairs(missingitems) do
				table.insert(dynopts, {statement = "** Insert "..ix.item.list[progitem].name.." **", topicID = "ViewProgression", dyndata = {progid = identifier, itemid = progitem}})
			end
		end

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption
		return dynopts
	end,
	ResolveDynamicOption = function(self, client, target, dyndata)

		-- Return the next topicID
		return "HandInComplexProgressionItemTopic", dyndata
	end,

	IsDynamicFollowup = true,
	DynamicPreCallback = function(self, player, target, dyndata)
		if (dyndata) then
			if(CLIENT)then
				local progdef 		= ix.progression.definitions[dyndata.identifier]
				local progstatus 	= ix.progression.GetLine(player:GetCharacter(), dyndata.identifier)

				if progdef.GetItemIds then
					progstatus = ix.progression.GetComplexProgressionValue(player:GetCharacter(), dyndata.identifier)
				end

				self.response = progdef:BuildResponse(target:GetDisplayName(), progstatus)
				self.tmp = dyndata.identifier
			end
		end
	end,
})

DIALOGUE.addTopic("HandInComplexProgressionItemTopic", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	options = {"BackTopic"},
	DynamicPreCallback = function(self, player, target, dyndata)
		if (SERVER and istable(dyndata)) then
			ix.progression.TurnIn(player, target, dyndata.progid, dyndata.itemid)
		elseif (CLIENT) then
			self.response = "Let me check what you have brought."
		end
	end,
})

DIALOGUE.addTopic("AboutProgression", {
	statement = "** Inspect the screen **",
	response = "** The computer shows a list on the screen **",
	options = {
		"BackTopic"
	},
	preCallback = function(self, client, target)
		if( CLIENT ) then
			if #ix.progression.GetActiveProgressions(client:GetCharacter(), "'Computer'") <= 0 then
				self.response = "** The computer shows a blank screen**"
			end
		end
	end,
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynopts = {}

		for _, progid in pairs(ix.progression.GetActiveProgressions(client:GetCharacter(), "'Computer'")) do
			table.insert(dynopts, {statement = ix.progression.definitions[progid].name, topicID = "AboutProgression", dyndata = {identifier = progid}})
		end

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption
		return dynopts
	end,
	ResolveDynamicOption = function(self, client, target, dyndata)

		-- Return the next topicID
		return "ViewProgression", dyndata
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
		"GOODBYE"
	},
	preCallback = function(self, client, target)
		netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(), {"artifactcollect_computer"}, 2)
		if CLIENT then
			surface.PlaySound("buttons/button18.wav")
		end
	end
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "** Leave **",
	response = "** The computer whirrs **",
	preCallBack = function(self, client, target)
		if CLIENT then
			surface.PlaySound("buttons/button18.wav")
		end
	end
})

