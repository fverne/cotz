DIALOGUE.name = "Cook NPC"

DIALOGUE.addTopic("GREETING", {
	response = "What's up?",
	options = {
		"TradeTopic",
		"BackgroundTopic",
		--"InterestTopic",
		"AboutWorkTopic",
		"GetTask",
		"GOODBYE"
	},
	preCallback = function(self, client, target)
		netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(), {"mutantmeateasy", "mutantkillgroupeasy", "mutantmeatmedium"}, 4)
	end
})

DIALOGUE.addTopic("TradeTopic", {
	statement = "Want to trade?",
	response = "Always - You looking for a good meal?",
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
	response = "Not a whole lot to say - I came here after consolidating with 'Old Timer', as you know him as. We met each other in a city nearby, back in the eighties, under different circumstances than these. I worked at a volunteer at a homeless shelter and... Well maybe the old guy will open up about it at some point. Let's just say we have different reasons for being here. ",
	options = {
		"BackgroundTopic2",
	}
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "Well, what's your reason?",
	response = "Things didn't work out back home. I was led by temptations and my wife didn't take so kindly. But who cares, she was kind of on the big side anyways and didn't want to cook for me. Who would have believed, I had to cook by myself! It's her own fault and was definitely something she had coming. Stupid bitch.",
	options = {
		"BackgroundTopic3",
	}
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "Right... What made you come here, of all places?",
	response = "Well, I heard about the artifacts of course, from good oldie! And I met some crazy people through my volunteer work who are interested in astrology or whatever it's called, they want to pay a big extra for whatever supernatural elements I can get out of here. Apparently they have sources who pay big. I don't care if you believe it, just trust the cash when it flows in, alright?",
	options = {
		"BackgroundTopic4",
	}
})

DIALOGUE.addTopic("BackgroundTopic4", {
	statement = "I'll keep that in mind.",
	response = "You're always welcome to trade here. And remember - I do the best meals in town!",
	options = {
		"BackTopic",
	}
})

DIALOGUE.addTopic("InterestTopic", {
	statement = "Can you tell me something interesting?",
	response = "Not really, no.",
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
				if (CLIENT) then self.response = "Very nice! This is for you, for your efforts." end
			else
				if (CLIENT) then self.response = string.format("Have you finished %s yet?", ix.jobs.getFormattedName(jobs[target:GetDisplayName()])) end
			end
		else
			if (CLIENT) then self.response = "Uhh... I haven't talked to you about any tasks?" end
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
			{statement = "I'll take it", topicID = "ConfirmTask", dyndata = {accepted = true}},
			{statement = "I'll pass", topicID = "ConfirmTask", dyndata = {accepted = false}},
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
	response = "I do, actually. Check this out.",
	options = {
		"BackTopic"
	},
	preCallback = function(self, client, target)
		if client:ixHasJobFromNPC(target:GetDisplayName()) and CLIENT then
			self.response = "You already have a task, which isn't completed yet..."
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


DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about something else...",
	response = "Very nice...",
	options = {
		"TradeTopic",
		"BackgroundTopic",
		--"InterestTopic",
		"AboutWorkTopic",
		"GetTask",
		"GOODBYE"
	},
	preCallback = function(self, client, target)
		netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(), {"mutantmeateasy", "mutantkillgroupeasy", "mutantmeatmedium"}, 4)
	end
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you around.",
	response = "See you soon..."
})

