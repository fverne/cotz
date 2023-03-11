DIALOGUE.name = "Tutorial NPC"

DIALOGUE.addTopic("GREETING", {
	response = "Yes?",
	options = {
		"TradeTopic",
		"TutorialTopic",
		"NicknameTopic",
		"BackgroundTopic",
		"AboutWorkTopic",
		"GetTask",
		"AboutProgression",
		"GOODBYE"
	},
	preCallback = function(self, client, target)
		netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(), {"mutantkilleasy", "mutantkillmedium", "town"}, 4)
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

DIALOGUE.addTopic("NicknameTopic", {
	statement = "I'd like to change my nickname.",
	response = "What would you like your nickname to be?",
	options = {
		"BackTopic",
	},
	preCallback = function(self, client, target)
		if CLIENT then
			Derma_StringRequest(
				"Edit Nickname", 
				"Edit your nickname. Length must be between 4 and 16 characters.",
				"",
				function(text) netstream.Start("ix_requestNicknameChange", text) end,
				function(text) client:Notify("Nickname change cancelled.") end
			)

		end
	end,
	ShouldAdd = function()
		return ix.progression.IsCompleted("oldtimerItemDelivery_Nickname") and LocalPlayer():getReputation() >= 1943
	end
})

DIALOGUE.addTopic("BackgroundTopic", {
	statement = "Tell me about yourself.",
	response = "Well, I've lived in the outskirts of the now exclusion zone for a long time. After the first emission hit, and the area around Chernobyl became restricted, I decided to check out the area myself. And I can tell you, friend, that this area is not for the faint of heart. You're one of the first people I see have seen succesfully sneek past the military patrols.",
	options = {
		"BackgroundTopic2",
	}
})

DIALOGUE.addTopic("BackgroundTopic2", {
	statement = "Military? I didn't know they had the area under lockdown?",
	response = "Well, I would say you're lucky to be here. Usually the military take tourists for a long walk out of here if they find them, but I've heard gunshots coming from their encampments. Not sure if they are bored guarding the exclusion zone, or if they actually take care of intruders like us that way. I suggest just dodging the military entirely if you see any.",
	options = {
		"BackgroundTopic3",
	}
})

DIALOGUE.addTopic("BackgroundTopic3", {
	statement = "Thanks for the advice. Why are you here?",
	response = "Not a lot for me to do back home. I made my living as a hunter, but it's not something you can make a living off anymore. Hit the bottle. Family left me and so I decided to try my adventurelust and check out the rumours around this place. As far as I'm aware, I was the first one to succesfully make it past the military. And not get escorted out. ",
	options = {
		"BackgroundTopic4",
	}
})

DIALOGUE.addTopic("BackgroundTopic4", {
	statement = "Alright. We all have our demons.",
	response = "Some bigger than others. Take care.",
	options = {
		"BackTopic",
	}
})


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
	ShouldAdd = function()
		if (LocalPlayer():GetCharacter():GetJobs()["'Old Timer'"]) then
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
	ShouldAdd = function()
		if (!LocalPlayer():GetCharacter():GetJobs()["'Old Timer'"]) then
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

				if(curcnt < cnt and client:GetCharacter():GetInventory():HasItem(progitem))then
					table.insert(missingitems, progitem)
				end
			end

			for _, progitem in pairs(missingitems) do
				table.insert(dynopts, {statement = "Hand over "..ix.item.list[progitem].name, topicID = "ViewProgression", dyndata = {progid = identifier, itemid = progitem}})
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

DIALOGUE.addTopic("AboutProgression", {
	statement = "What do you need help with?",
	response = "I have a few things I need done.",
	options = {
		"BackTopic"
	},
	preCallback = function(self, client, target)
		if( CLIENT ) then
			if #ix.progression.GetActiveProgressions("'Old Timer'") <= 0 then
				self.response = "Nothing at the moment."
			end

			net.Start("progression_sync")
			net.SendToServer()
		end
	end,
	IsDynamic = true,
	GetDynamicOptions = function(self, client, target)
		local dynopts = {}

		for _, progid in pairs(ix.progression.GetActiveProgressions("'Old Timer'")) do
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
	response = "All right.",
	options = {
		"TradeTopic",
		"TutorialTopic",
		"NicknameTopic",
		"BackgroundTopic",
		"AboutWorkTopic",
		"GetTask",
		"AboutProgression",
		"GOODBYE"
	},
	preCallback = function(self, client, target)
		netstream.Start("job_updatenpcjobs", target, target:GetDisplayName(), {"mutantkilleasy", "mutantkillmedium", "town"}, 4)
	end
})

DIALOGUE.addTopic("GOODBYE", {
	statement = "See you around.",
	response = "Come back soon, stranger..."
})

