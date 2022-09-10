DIALOGUE.name = "Trader Test"

DIALOGUE.addTopic("GREETING", {
	response = "What is it?",
	options = {
		"TradeTopic",
		"SpecialSaleTopic",
		"BackgroundTopic",
		"InterestTopic",
		"AboutWorkTopic",
		"GetTask",
		"GOODBYE"
	},
	preCallback = function(self, client, target)
		-- Tasks
		netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(), {"information", "riches"}, 2)

		-- Special Sale
		if SERVER then
			local cooldown = target:GetNetVar("lastSpecialSale", 0)
			if cooldown < os.time() then
				local randomItems = {}
				local randomItemCategories = {
					{itemCategory = "specialsale_owlnpc_smg_1", dialogue = "I like to run and gun, and I'd like something small and fast-shooting.", reqRep = 0},
					{itemCategory = "specialsale_owlnpc_rifle_1", dialogue = "I'm looking weapons that can deal with a bit of everything.", reqRep = 282},
					{itemCategory = "specialsale_owlnpc_longrifle_1", dialogue = "I'm looking for a weapon to kill things from afar.", reqRep = 765},
					{itemCategory = "specialsale_owlnpc_heavy_1", dialogue = "I like to keep shooting until there is nothing left to shoot at.", reqRep = 9338},
					{itemCategory = "specialsale_owlnpc_shotgun_1", dialogue = "I want to fill mutants with pellets of lead.", reqRep = 1943},
					{itemCategory = "specialsale_owlnpc_br_1", dialogue = "I'm looking for better protection against mutants.", reqRep = 50},
					{itemCategory = "specialsale_owlnpc_headgear_1", dialogue = "I'm looking for better headwear.", reqRep = 50},
					{itemCategory = "specialsale_owlnpc_ar_1", dialogue = "I'm the clumsy type, and often stumble into anomalous zones. I'm looking for protection.", reqRep = 4254},
				}

				for k,v in pairs(randomItemCategories) do
					local idat = ix.util.GetRandomItemFromPool(v.itemCategory)
					-- ensure the character has a reputation level high enough
					if client:getReputation() >= v.reqRep then
						table.insert(randomItems, {idat[1], idat[2], v.dialogue})
					end
				end

				target:SetNetVar("specialSaleItems", randomItems)
				target:SetNetVar("lastSpecialSale", os.time() + ix.config.Get("specialSaleCooldown", 30))
			end
		end
	end
})

DIALOGUE.addTopic("TradeTopic", {
	statement = "Want to trade?",
	response = "Yes",
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


DIALOGUE.addTopic("SpecialSaleTopic", {
	statement = "Do you take special orders?",
	response = "Yes. Here's what I can get you.",
	IsDynamic = true,
	options = {
		"BackTopic",
	},
	GetDynamicOptions = function(self, client, target)
		local dynopts = {}
		local randomItems = target:GetNetVar("specialSaleItems")
		
		for k,v in pairs(randomItems) do
			local item = ix.item.list[v[1]]
			local itemdata = ix.item.list[v[2]]
			local dialogue = v[3]
			table.insert(dynopts, {statement = dialogue.. " (Price: " .. item.price*3.00 .. ")", topicID = "SpecialSaleTopic", dyndata = {itemuid = item.uniqueID, cost = item.price*3.00, itemdata = itemdata}})
		end

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption
		return dynopts
	end,
	ResolveDynamicOption = function(self, client, target, dyndata)
		-- Return the next topicID
		if( !client:GetCharacter():HasMoney(dyndata.cost)) then
			return "NotEnoughMoneyBuy"
		end

		return "ConfirmSpecialSale", dyndata
	end,
})


DIALOGUE.addTopic("ConfirmSpecialSale", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	IsDynamic = true,
	DynamicPreCallback = function(self, player, target, dyndata)
		if(dyndata) then
			if (CLIENT) then
				self.response = string.format("That order will cost you %s.", dyndata.cost)
			else
				target.specialsalestruct = { dyndata.itemuid, dyndata.cost, dyndata.itemdata }
			end
		end
	end,
	GetDynamicOptions = function(self, client, target)

		local dynopts = {
			{statement = "Sure, here.", topicID = "ConfirmSpecialSale", dyndata = {accepted = true}},
			{statement = "That's too expensive for me.", topicID = "ConfirmSpecialSale", dyndata = {accepted = false}},
		}

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption
		return dynopts
	end,
	ResolveDynamicOption = function(self, client, target, dyndata)
		if( SERVER and dyndata.accepted and client:GetCharacter():GetInventory():Add(target.specialsalestruct[1], 1, target.specialsalestruct[3] or {})) then
			ix.dialogue.notifyItemGet(client, ix.item.list[target.specialsalestruct[1]].name)
			ix.dialogue.notifyMoneyLost(client, target.specialsalestruct[2])
			client:GetCharacter():TakeMoney(target.specialsalestruct[2])
		end
		if(SERVER)then
			target.specialsalestruct = nil
		end
		-- Return the next topicID
		return "BackTopic"
	end,
})

DIALOGUE.addTopic("NotEnoughMoneyBuy", {
	statement = "",
	response = "Come back once you're serious and can pay the cash.",
	options = {
		"BackTopic"
	}
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "Tell me about yourself.",
	response = "Not a whole lot to know. I came here a few months ago, after the military presence ramped up their presence around here - turns out the swamps are the only place they haven't really cut off around the perimeter of the zone, which means that this is where we stay for now. I worked as a trader back in the days, so thought I might as well put my skills to use here too. Oh, and I have a bunch of friends who can get things. And remove things, like you, if you keep asking.",
	options = {
		"BackTopic",
	}
})

DIALOGUE.addTopic("InterestTopic", {
	statement = "Can you tell me something interesting?",
	response = "Sure. How about you do business with me, or shut the fuck up?",
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
				if (CLIENT) then self.response = "Great work on the job, here's your reward." end
			else
				if (CLIENT) then self.response = string.format("Have you finished %s yet?", ix.jobs.getFormattedName(jobs[target:GetDisplayName()])) end
			end
		else
			if (CLIENT) then self.response = "You're not working for me right now." end
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
	response = "Yes, have a look.",
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

DIALOGUE.addTopic("ProgressionTestTopic", {
	statement = "Progression?",
	response = "ok)",
	postCallback = function(self, client, target)
		if (SERVER) then
			ix.progression.AddProgessionValue("TestProgression", 1, client:Name())
		end
	end,
	options = {
		"BackTopic",
	}
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about something else...",
	response = "All right.",
	options = {
		"TradeTopic",
		"SpecialSaleTopic",
		"BackgroundTopic",
		"InterestTopic",
		"AboutWorkTopic",
		"GetTask",
		"GOODBYE"
	},
	preCallback = function(self, client, target)
		-- Tasks
		netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(), {"information", "riches"}, 2)

		-- Special Sale
		if SERVER then
			local cooldown = target:GetNetVar("lastSpecialSale", 0)
			if cooldown < os.time() then
				local randomItems = {}
				local randomItemCategories = {
					{itemCategory = "specialsale_owlnpc_smg_1", dialogue = "I like to run and gun, and I'd like something small and fast-shooting.", reqRep = 0},
					{itemCategory = "specialsale_owlnpc_rifle_1", dialogue = "I'm looking weapons that can deal with a bit of everything.", reqRep = 282},
					{itemCategory = "specialsale_owlnpc_longrifle_1", dialogue = "I'm looking for a weapon to kill things from afar.", reqRep = 765},
					{itemCategory = "specialsale_owlnpc_heavy_1", dialogue = "I like to keep shooting until there is nothing left to shoot at.", reqRep = 9338},
					{itemCategory = "specialsale_owlnpc_shotgun_1", dialogue = "I want to fill mutants with pellets of lead.", reqRep = 1943},
					{itemCategory = "specialsale_owlnpc_br_1", dialogue = "I'm looking for better protection against mutants.", reqRep = 50},
					{itemCategory = "specialsale_owlnpc_headgear_1", dialogue = "I'm looking for better headwear.", reqRep = 50},
					{itemCategory = "specialsale_owlnpc_ar_1", dialogue = "I'm the clumsy type, and often stumble into anomalous zones. I'm looking for protection.", reqRep = 4254},
				}

				for k,v in pairs(randomItemCategories) do
					local idat = ix.util.GetRandomItemFromPool(v.itemCategory)
					-- ensure the character has a reputation level high
					if client:getReputation() >= v.reqRep then
						table.insert(randomItems, {idat[1], idat[2], v.dialogue})
					end
				end

				target:SetNetVar("specialSaleItems", randomItems)
				target:SetNetVar("lastSpecialSale", os.time() + ix.config.Get("specialSaleCooldown", 30))
			end
		end
	end
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you around.",
	response = "Come back soon, STALKER..."
})

