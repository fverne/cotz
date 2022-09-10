DIALOGUE.name = "Ecologist NPC"

DIALOGUE.addTopic("GREETING", {
	response = "Hello.",
	options = {
		"TradeTopic",
		"BackgroundTopic",
		"AboutWorkTopic",
		"GetTask",
		"AboutProgression",
		"GOODBYE"
	},
	preCallback = function(self, client, target)
		netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(), {"electronics", "information", "dataextract", "artifactcollect_eco"}, 4)
	end
})

DIALOGUE.addTopic("TradeTopic", {
	statement = "Want to trade?",
	response = "Keep it down!",
	postCallback = function(self, client, target)
		if (SERVER) then
			local character = client:GetCharacter()

			target.receivers[#target.receivers + 1] = client

			local items = {}

			-- Only send what is needed.
			for k, v in pairs(target.items) do
				if (!table.IsEmpty(v) and (CAMI.PlayerHasAccess(client, "Helix - Manage Vendors", nil) or v[VENDOR_MODE])) then
					items[k] = v
				end
			end

			target.scale = target.scale or 0.5

			client.ixVendorAdv = target

			-- force sync to prevent outdated inventories while buying/selling
			if (character) then
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
	}
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "Tell me about yourself.",
	response = "Sure. Overly intelligent, physics and nanotechnology PhD student from Kiev, got tired of the older professors stealing all my hard-earned work.",
	options = {
		"BackgroundTopic2",
	}
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "Yeah? But how did you end up here then?",
	response = "They told me I was entitled, and after complaining to the university dean, they evicted me to this hellhole, to 'gather my own research'. And guess what - they don't even fund me!",
	options = {
		"BackgroundTopic3",
	}
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "How do you make a living if you don't get any funding?",
	response = "I guess they do fund me, in terms of rations, but they are so tasteless. Hey, listen, here's a deal. If you want to buy some shitty supplies from kiev, let me know. I want to fuck the professors over as much as possible.",
	options = {
		"BackgroundTopic4",
	}
})

DIALOGUE.addTopic("BackgroundTopic4", {
	statement = "Thanks I guess, won't they be mad if they know?",
	response = "Hypothetically, they would, but who would tell them? If I hear anything, I'll have 'Quartermaster' evict you into an anomaly. Take care!",
	options = {
		"BackTopic",
	}
})


DIALOGUE.addTopic("AboutWorkTopic", {
	statement = "About work...",
	response = "",
	IsDynamic = true,
	options = {
		"BackTopic"
	},
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
				if (CLIENT) then self.response = "Good job. This is from me to you." end
			else
				if (CLIENT) then self.response = string.format("Is your contract on %s complete yet?", ix.jobs.getFormattedName(jobs[target:GetDisplayName()])) end
			end
		else
			if (CLIENT) then self.response = "I don't think you are on a contract for me right now." end
		end

	end,
	ResolveDynamicOption = function(self, client, target, dyndata)
		netstream.Start("job_deliveritem", target:GetDisplayName())

		-- Return the next topicID
		return "BackTopic"
	end,



	--
} )

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
			{statement = "I'll take it.", topicID = "ConfirmTask", dyndata = {accepted = true}},
			{statement = "I'll pass.", topicID = "ConfirmTask", dyndata = {accepted = false}},
		}
		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption
		return dynopts
	end,
	ResolveDynamicOption = function(self, client, target, dyndata)
		if( SERVER and dyndata.accepted ) then
			ix.dialogue.notifyTaskGet(client, ix.jobs.getFormattedNameInactive(target.taskid))

			client:ixJobAdd(target.taskid, target:GetDisplayName())

			ix.jobs.setNPCJobTaken(target:GetDisplayName(), target.taskid)
		end
		if(SERVER)then
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
		"BackTopic"
	},
	preCallback = function(self, client, target)
		if client:ixHasJobFromNPC(target:GetDisplayName()) and CLIENT then
			self.response = "You are already on a contract."
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
})

DIALOGUE.addTopic("ViewProgression", {
	statement = "",
	response = "",
	options = {
		"BackTopic"
	},
	IsDynamicFollowup = true,
	DynamicPreCallback = function(self, player, target, dyndata)
		if (dyndata and CLIENT) then
			local progstatus 	= ix.progression.status[dyndata.identifier]
			local progdef 		= ix.progression.definitions[dyndata.identifier]
			self.response = progdef.BuildResponse(progdef, progstatus)
		end
	end,
})


DIALOGUE.addTopic("AboutProgression", {
	statement = "What do you need help with?",
	response = "I'm currently approaching a breakthrough, here's my research focus.",
	options = {
		"BackTopic"
	},
	preCallback = function(self, client, target)
		if( CLIENT ) then
			if #ix.progression.GetActiveProgressions("'Egghead'") <= 0 then
				self.response = "Nothing at the moment."
			end

			net.Start("progression_sync")
			net.SendToServer()
		end
	end,
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynopts = {}

		for _, progid in pairs(ix.progression.GetActiveProgressions("'Egghead'")) do
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
})


DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about something else...",
	response = "What else is there to talk about?",
	options = {
		"TradeTopic",
		"BackgroundTopic",
		"AboutWorkTopic",
		"GetTask",
		"AboutProgression",
		"GOODBYE"
	},
	preCallback = function(self, client, target)
		netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(), {"electronics", "information", "dataextract", "artifactcollect_eco"}, 4)
	end
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you around.",
	response = "Don't trip into an anomaly!"
})

