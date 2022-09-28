DIALOGUE.name = "Bodyguard NPC"

DIALOGUE.addTopic("GREETING", {
	response = "Yes?",
	options = {
		"TradeTopic", 
		"BackgroundTopic",
		"AboutWorkTopic",
		"GetTask",
		"AboutProgression",
		"GOODBYE"
	},
	preCallback = function(self, client, target)
		netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(), {"repair", "mechanical", "electronics"}, 4)
	end
})

DIALOGUE.addTopic("TradeTopic", {
	statement = "Want to trade?",
	response = "I have some spare equipment laying around, yes.",
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
				if (CLIENT) then self.response = "As promised, here's your reward." end
			else
				if (CLIENT) then self.response = string.format("What's the status on %s?", ix.jobs.getFormattedName(jobs[target:GetDisplayName()])) end
			end
		else
			if (CLIENT) then self.response = "What are you talking about? We haven't planned anything." end
		end

	end,
	ResolveDynamicOption = function(self, client, target, dyndata)
		netstream.Start("job_deliveritem", target:GetDisplayName())

		-- Return the next topicID
		return "BackTopic"
	end,
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
	response = "I have a few things I need done, yes.",
	options = {
		"BackTopic"
	},
	preCallback = function(self, client, target)
		if client:ixHasJobFromNPC(target:GetDisplayName()) and CLIENT then
			self.response = "You already have a task, which isn't completed yet."
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

DIALOGUE.addTopic("HandInComplexProgressionItemTopic", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	options = {
		"BackTopic"
	},
	DynamicPreCallback = function(self, player, target, dyndata)
		if (dyndata) then
			if(CLIENT)then
				self.response = string.format("Nice work, this %s will help our cause.", ix.item.list[dyndata.itemid].name)
			else
				if ix.progression.IsActive(dyndata.progid) then
					
					local item = player:GetCharacter():GetInventory():HasItem(dyndata.itemid)

					local dat = ix.progression.status[dyndata.progid].complexData
					dat = dat or {}
					local amtcur = dat[dyndata.itemid] or 0

					local reqitems = ix.progression.GetComplexProgressionReqs(dyndata.progid)
					local amtreq = reqitems[dyndata.itemid]

					local amtneed = amtreq - amtcur

					if(item)then
						local amtavailable = item:GetData("quantity", 1)
						local amtfinal = amtavailable >= amtneed and amtneed or amtavailable

						item:SetData("quantity", item:GetData("quantity",0) - amtfinal)
						
						if(item:GetData("quantity", 0) < 1)then
							item:Remove()
						end

						--Adds reward
						repReward, monReward = ix.util.GetValueFromProgressionTurnin(item, amtfinal)
						player:addReputation(repReward)
						ix.dialogue.notifyReputationReceive(player, repReward)
						player:GetCharacter():GiveMoney(monReward)
						ix.dialogue.notifyMoneyReceive(player, monReward)

						ix.progression.AddComplexProgressionValue(dyndata.progid, {dyndata.itemid, amtfinal}, player:Name())
					end
				end
			end	
		end
	end,
} )

DIALOGUE.addTopic("ViewProgression", {
	statement = "",
	response = "",
	options = {
		"BackTopic"
	},

	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynopts = {}

		--disgusting
		--local identifier = player:GetCharacter():GetData("curdialogprog")
		local identifier 	= self.tmp
		self.tmp = nil
		local progstatus 	= ix.progression.GetComplexProgressionValue(identifier)
		local progdef 		= ix.progression.definitions[identifier]
		if(progdef.fnAddComplexProgression)then
			local progitems 	= progdef.GetItemIds()
			local missingitems  = {}

			for progitem,cnt in pairs(progitems) do
				local curcnt = 0
				if(progstatus and progstatus[progitem]) then curcnt = progstatus[progitem] end

				if(curcnt < cnt)then
					table.insert(missingitems, progitem)
				end
			end

			for _, progitem in pairs(missingitems) do
				table.insert(dynopts, {statement = ix.item.list[progitem].name, topicID = "ViewProgression", dyndata = {progid = identifier, itemid = progitem}})
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
				local progstatus 	= ix.progression.status[dyndata.identifier]
				local progdef 		= ix.progression.definitions[dyndata.identifier]

				self.response = progdef.BuildResponse(progdef, progstatus)
				self.tmp = dyndata.identifier
			end
		end
	end,
})


DIALOGUE.addTopic("AboutProgression", {
	statement = "What do you need help with?",
	response = "I have a few things I need done.",
	options = {
		"BackTopic"
	},
	preCallback = function(self, client, target)
		if( CLIENT ) then
			if #ix.progression.GetActiveProgressions("'Bodyguard'") <= 0 then
				self.response = "Nothing at the moment."
			end

			net.Start("progression_sync")
			net.SendToServer()
		end
	end,
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynopts = {}

		local test = ix.progression.GetActiveProgressions("'Bodyguard'")

		PrintTable(test)

		for _, progid in pairs(ix.progression.GetActiveProgressions("'Bodyguard'")) do
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

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "Tell me about yourself.",
	response = "No.",
	options = {
		"BackTopic",
	}
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about another topic.",
	response = "Anything else?",
	options = {
		"TradeTopic", 
		"BackgroundTopic",
		"AboutWorkTopic",
		"GetTask",
		"AboutProgression",
		"GOODBYE"
	},
	preCallback = function(self, client, target)
		netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(), {"repair", "mechanical", "electronics"}, 4)
	end
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "I'll talk to you later.",
	response = "Bye."
})