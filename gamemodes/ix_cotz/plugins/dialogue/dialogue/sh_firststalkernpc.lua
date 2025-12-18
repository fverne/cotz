DIALOGUE.name = "Tinker NPC"

-- Template NPC showcasing all currently implemented features
-- Copy&Paste from this file to build new NPCs

-- Progression can be done by calling this:
-- 				ix.progression.AddProgessionValue(progressionIdentifier, amountToIncrement, client:Name())
-- and
--  			ix.progression.GetProgressionValue(progressionIdentifier)
-- to react to progression levels

DIALOGUE.addTopic("GREETING", {
	response = "Hello, I'm the original. The first stalker in the zone. What do you need?",
	options = {
		"TradeTopic", 
		"TutorialTopic",
		"InterestTopic",
		"ChangeSuitVariant",
		"AboutWorkTopic",
		"GetTaskByDifficulty",
		"GOODBYE"
	},
	preCallback = function(self, client, target)
		-- Only needed if NPC offers tasks
		-- 4th argument is the categories to grab tasks from
		-- 5th argument is the amount of tasks to grab
		-- netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(), {"mutantkillgroupeasy"}, 4)

		-- alternative npc task giving by difficulty
		if (SERVER) then
			if target:GetNetVar("possibleJobs") == nil then
				local possibleJobs = {}
				possibleJobs["easy"] = {"item_part_NPC_easy"}
				possibleJobs["medium"] = {"item_part_NPC_medium"}
				possibleJobs["hard"] = {"item_part_NPC_hard"}			
	
				target:SetNetVar("possibleJobs", possibleJobs)
			end
		end
	end
})

DIALOGUE.addTopic("BackTopic", {
	statement = "Let's talk about something else.",
	response = "What would you like to know?",
	options = {
		"TradeTopic", 
		"TutorialTopic",
		"InterestTopic",
		"ChangeSuitVariant",
		"AboutWorkTopic",
		"GetTaskByDifficulty",
		"GOODBYE"
	} --Should be identical to GREETING's options
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you!",
	response = "Take care, STALKER..."
})

----------------------------------------------------------------
----------------------START-TRADER-START------------------------
----------------------------------------------------------------

DIALOGUE.addTopic("TradeTopic", {
	statement = "Want to trade?",
	response = "Yes!",
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

----------------------------------------------------------------
------------------------END-TRADER-END--------------------------
----------------------------------------------------------------

-- Tutorial start
DIALOGUE.addTopic("TutorialTopic", {
	statement = "I have a few questions, I just arrived here.",
	response = "What do you want to know?",
	options = {
		"TutorialTopic1",
		"TutorialTopic2",
		"TutorialTopic3",
		"BackTopic",
	}
})

DIALOGUE.addTopic("TutorialTopicBack", {
	statement = "Alright, let me ask you something else.",
	response = "Sure.",
	options = {
		"TutorialTopic1",
		"TutorialTopic2",
		"TutorialTopic3",
		"BackTopic",
	}
})

DIALOGUE.addTopic("TutorialTopic1", {
	statement = "What is this place?",
	response = "This is an area near the Chernobyl exclusion zone. More specifically, we're in the great swamps. Until recently, this area was completely abandoned, but me and another local, 'Technut', set up camp here in this shithole. We call it our 'Eastern Haven'. We could definitely use some help getting this place in proper shape.",
	options = {
		"TutorialTopic1_1",
	}
})

DIALOGUE.addTopic("TutorialTopic1_1", {
	statement = "How can I help out?",
	response = "If we work together, I'm sure we will get this place in proper shape in no time. Go talk to the other inhabitants, and see if they need anything. You'll be properly rewarded. Both personally by the inhabitant, but as we keep helping each other out, it will unlock more opportunities for us to do, and more people will move here, each with their own agendas. You should ask around to see what people need help with. Both us oldies, but also the younger opportunity seekers like yourself.",
	options = {
		"TutorialTopicBack",
	}
})

DIALOGUE.addTopic("TutorialTopic2", {
	statement = "How dangerous is this place?",
	response = "There are two types of people here. The careful people, and the dead people. As you can imagine, a place like this where the laws of science do not apply as anywhere in the world, can be quite unforgiving and dangerous. The dangers are manyfold, but the biggest of your troubles will be the mutants, and the anomalies.",
	options = {
		"TutorialTopic2_1",
		"TutorialTopic2_2",
		"TutorialTopicBack",
	}
})

DIALOGUE.addTopic("TutorialTopic2_1", {
	statement = "Tell me about the anomalies.",
	response = "The anomalies are a work of a merciless god. I've seen animals being torn apart by sheer gravity, and those are the lucky ones. Luckily, most are static, so if you watch your step and don't fall into one, you should be alright. It should be noted that sometimes, the merciless god seems to be merciful, and he releases a part of scientific wonder near them. They are artifacts that mostly are not dangerous to the wielder, sometimes with benefits, but always worth a lot to the scientific community outside the zone, and hence worth quite a lot on the black market.",
	options = {
		"TutorialTopic2_2",
		"TutorialTopicBack",
	}
})

DIALOGUE.addTopic("TutorialTopic2_2", {
	statement = "Tell me about the mutants.",
	response = "After the first couple of emissions, many of the animals here died, but those that survived had a worse fate. They all turned into dangerous, aggressive, mutated versions of their former selves, and are no longer good for anything but having to be put down, as they will all try to take you down, regardless of your intentions. Due to the mutations, many of the mutants bodyparts have special properties that are valuable to scientists. I suggest poaching the mutants whenever possible, and sell off the dead parts.",
	options = {
		"TutorialTopic2_1",
		"TutorialTopicBack",
	}
})

DIALOGUE.addTopic("TutorialTopic3", {
	statement = "What gear do you recommend I get my hands on?",
	response = "The most neccessary things are a geiger counter, some medical items, and something to defend yourself with. Always carry those three with you. Also, keep your weapons in good condition always if you want them to shoot straight, and remember, we don't have access to many spare parts here, so firearms will not be maintainable forever. 'Technut' can help you out.",
	options = {
		"TutorialTopicBack",
	}
})

-- Tutorial end

----------------------------------------------------------------
--------------------START-TASKGIVER-START-----------------------
----------------------------------------------------------------

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
		
		return dynopts
	end,
	ResolveDynamicOption = function(self, client, target, dyndata)

		-- Return the next topicID
		return "ConfirmTask", {description = ix.jobs.getFormattedDescInactive(dyndata.identifier), identifier = dyndata.identifier}
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
			{statement = "I'll take it", topicID = "ConfirmTask", dyndata = {accepted = true}},
			{statement = "I'll pass", topicID = "ConfirmTask", dyndata = {accepted = false}},
		}
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

-- alternative based on difficulty
DIALOGUE.addTopic("GetTaskByDifficulty", {
	statement = "Do you have any work for me?",
	response = "Yes, what difficulty task are you looking for?.",
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
			table.insert(dynopts, {statement = "A trivial task.", topicID = "GetTaskByDifficulty", dyndata = {difficulty = "easy"}})
			table.insert(dynopts, {statement = "A challenging task.", topicID = "GetTaskByDifficulty", dyndata = {difficulty = "medium"}})
			table.insert(dynopts, {statement = "A hard task.", topicID = "GetTaskByDifficulty", dyndata = {difficulty = "hard"}})
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
			local jobCategories = possibleJobs[dyndata.difficulty]
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
	ShouldAdd = function()
		if (!LocalPlayer():GetCharacter():GetJobs()["'The Original'"]) then
			return true
		end
	end,
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

			-- If it's an item delivery quest, let the player hand in an item
			local itemuid = ix.jobs.isItemJob(jobs[target:GetDisplayName()].identifier)

			if itemuid and not jobs[target:GetDisplayName()].isCompleted then
				dynopts = {
					{statement = string.format("Hand over 1 %s", ix.item.list[itemuid].name), topicID = "AboutWorkTopic", dyndata = {identifier = itemuid}},
				}
			end
		end

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
	ShouldAdd = function()
		if (LocalPlayer():GetCharacter():GetJobs()["'The Original'"]) then
			return true
		end
	end,
} )


----------------------------------------------------------------
---------------------END--TASKGIVER--END------------------------
----------------------------------------------------------------


----------------------------------------------------------------
--------------------START-SUITCHANGE-START----------------------
----------------------------------------------------------------

DIALOGUE.addTopic("ChangeSuitVariant", {
	statement = "Can you exchange my suit to another variant?",
	response = "Which suit would you like to exchange?",
	IsDynamic = true,
	options = {
		"BackTopic"
	},
	GetDynamicOptions = function(self, client, target)
		local dynopts = {}
		local items = client:GetCharacter():GetInventory():GetItems()

		for k,v in pairs(items) do
			if v.baseSuit and !v:GetData("equip") then
				local convertcost = math.Round(v.price / 10)
				table.insert(dynopts, {statement = v:GetName().." - "..ix.currency.Get(convertcost), topicID = "ChangeSuitVariant", dyndata = {itemuid = v.uniqueID, itemid = v:GetID(), cost = convertcost, baseSuit = v.baseSuit}})
			end
		end
		
		return dynopts
	end,
	ResolveDynamicOption = function(self, client, target, dyndata)

		-- Return the next topicID
		if( !client:GetCharacter():HasMoney(dyndata.cost)) then
			return "NotEnoughMoneySuitVariantChange"
		end
		return "ChangeSuitVariantP2", dyndata
	end,
})

DIALOGUE.addTopic("ChangeSuitVariantP2", {
	statement = "",
	response = "",
	IsDynamicFollowup = true,
	IsDynamic = true,
	DynamicPreCallback = function(self, player, target, dyndata)
		if(dyndata) then
			if (CLIENT) then
				self.response = string.format("Which suit would you like instead? It will cost you %s. Be sure to remove attachments beforehand.", ix.currency.Get(dyndata.cost))
			end

			target.selectedsuitstruct = { dyndata.itemid, dyndata.itemuid, dyndata.cost, dyndata.baseSuit }
		end
	end,
	GetDynamicOptions = function(self, client, target)
		local variants = {
			["baseline"] = true,
			-- ["anarchist"] = true,
			-- ["authority"] = true,
			-- ["mercenary"] = true,
			["looted"] = true,
			["scavenger"] = true,
			-- ["ecologist"] = true,
			-- ["fanatic"] = true,
		}

		local suitVariants = {}
		for _, v in pairs(ix.item.list) do
			if target.selectedsuitstruct[4] == v.baseSuit and variants[v.suitVariant] then
				table.insert(suitVariants, {uniqueID = v.uniqueID, name = v.name})
			end
		end

		local dynopts = {}
		for _, v in pairs(suitVariants) do
			if v.uniqueID == target.selectedsuitstruct[2] then
				continue
			end

			table.insert(dynopts, {statement = "["..(v.uniqueID:gsub("^.*_","")):gsub("^%l", string.upper).."] "..v.name.." with cost "..ix.currency.Get(target.selectedsuitstruct[3]), topicID = "ChangeSuitVariantP2", dyndata = {suitVariantUID = v.uniqueID, accepted = true}})
		end

		table.insert(dynopts, {statement = "Actually, nevermind...", topicID = "ChangeSuitVariantP2", dyndata = {accepted = false}})

		-- Return table of options
		-- statement : String shown to player
		-- topicID : should be identical to addTopic id
		-- dyndata : arbitrary table that will be passed to ResolveDynamicOption
		return dynopts
	end,
	ResolveDynamicOption = function(self, client, target, dyndata)
		if( SERVER and dyndata.accepted ) then
			if (client:GetCharacter():GetData("carry", 0) >= ix.weight.BaseWeight(client:GetCharacter())) then
				client:Notify("You are extremely overencumbered and can't do that!")
				return "BackTopic"
			end
			local originalSuit = ix.item.instances[target.selectedsuitstruct[1]]
			if !table.IsEmpty((originalSuit:GetData("attachments", originalSuit.miscSlots)["exteriorSlots"])) or 
			!table.IsEmpty((originalSuit:GetData("attachments", originalSuit.miscSlots)["interiorSlots"])) or 
			!table.IsEmpty((originalSuit:GetData("attachments", originalSuit.miscSlots)["extraSlots"])) then
				client:Notify("Can't exchange suit with installed attachments!")
				return "BackTopic"
			end
			ix.dialogue.notifyMoneyLost(client, ix.currency.Get(target.selectedsuitstruct[3]))
			client:GetCharacter():TakeMoney(target.selectedsuitstruct[3])

			originalSuit:Remove()
			client:GetCharacter():SetData("carry", ix.weight.CalculateWeight(client:GetCharacter()))
			client:GetCharacter():GetInventory():Add(dyndata.suitVariantUID)
		end
		-- Return the next topicID
		return "BackTopic"
	end,
})

DIALOGUE.addTopic("NotEnoughMoneySuitVariantChange", {
	statement = "",
	response = "Not enough money for that.",
	options = {
		"BackTopic"
	}
})

----------------------------------------------------------------
----------------------END-SUITCHANGE-END------------------------
----------------------------------------------------------------

----------------------------------------------------------------
---------------------START-INTEREST-START-----------------------
----------------------------------------------------------------

DIALOGUE.addTopic("InterestTopic", {
    statement = "Can you tell me something interesting?",
    response = "",
    options = {
    	"InterestMoreTopic",
        "BackTopic"
    },
    preCallback = function(self, client, target)
        if (CLIENT) then
            local tbl = {	"The Zone is a dangerous place. Anomalies are everywhere, and all the mutants here are out to get you, I swear.",
							"Did you know people stash their stuff everywhere? If you have a keen eye, you can find some interesting things.",
							"We STALKERS, as we call ourselves, are incredibly creative. I don't think any other place in the world has our level of craftiness and ability to survive even the harshest conditions. Who would have thought of using cutlery as makeshift digging tools, for instance?",
							"I've heard rumours of creatures out there, who can mess you up. Not in the sense that they gnaw and tear you apart, but that they send even the strongest willed men into the deepest hole - if they can make it away. I'm not going out there...",
							"The mutants in here are, to nobodys surprise, very irradiated. If you ever do plan to eat them, I suggest cooking them first, as it takes away a lot of their radiation.",
							"I'm still having trouble believing this place is not more well known, but I assume it's because everyone in the surrounding areas are being told not to say a word, and the military are not too keen on rulebreakers around here.",
							"If you ever encounter something that shakes you up, I suggest smoking a couple of cigarettes. They calm the mind, and help you think clearer."}

            self.response = table.Random(tbl)
        end
    end,
} )

DIALOGUE.addTopic("InterestMoreTopic", {
    statement = "Very nice, more?",
    response = "",
    options = {
    	"InterestMoreTopic",
        "BackTopic"
    },
    preCallback = function(self, client, target)
        if (CLIENT) then
          	local tbl = {	"The Zone is a dangerous place. Anomalies are everywhere, and all the mutants here are out to get you, I swear.",
							"Did you know people stash their stuff everywhere? If you have a keen eye, you can find some interesting things.",
							"We STALKERS, as we call ourselves, are incredibly creative. I don't think any other place in the world has our level of craftiness and ability to survive even the harshest conditions. Who would have thought of using cutlery as makeshift digging tools, for instance?",
							"I've heard rumours of creatures out there, who can mess you up. Not in the sense that they gnaw and tear you apart, but that they send even the strongest willed men into the deepest hole - if they can make it away. I'm not going out there...",
							"The mutants in here are, to nobodys surprise, very irradiated. If you ever do plan to eat them, I suggest cooking them first, as it takes away a lot of their radiation.",
							"I'm still having trouble believing this place is not more well known, but I assume it's because everyone in the surrounding areas are being told not to say a word, and the military are not too keen on rulebreakers around here.",
							"If you ever encounter something that shakes you up, I suggest smoking a couple of cigarettes. They calm the mind, and help you think clearer."}

            self.response = table.Random(tbl)
        end
    end,
} )

----------------------------------------------------------------
-----------------------END-INTEREST-END-------------------------
----------------------------------------------------------------