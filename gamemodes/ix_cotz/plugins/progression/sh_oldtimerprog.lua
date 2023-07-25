ix.progression.Register("oldtimerItemDelivery_Knife1", {
	name = "Backstabbing 1",
	description = "Prove your worth as a small game hunter to Old Timer.",
	keyNpc = "'Old Timer'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["oldtimerItemDelivery_Knife1"] = ix.progression.status["oldtimerItemDelivery_Knife1"] or {}
		local dat = ix.progression.status["oldtimerItemDelivery_Knife1"].complexData
		local itemids = self:GetItemIds()

		local str = "You are still new to the Zone, stalker. You may have been out on a few trips, but you are still completely unprepared for what it can and will throw at you. If you are interested in proving your worth as a hunter, then get out there and show me what you can do with little more than a piece of rebar and your instincts.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["hide_blinddog"] = 10,
			["hide_flesh"] = 10,
			["hide_tushkano"] = 10,
			["part_zombie_1"] = 40,
			["part_swampcontroller_2"] = 5,
		}	

		return itemids
	end,
	progressfunctions = {
		[1] = {
			OnRun = function()
				
			end,
			RunOnce = false,
		},
	},
	progressthresholds = {
		[1] = 1,
	},
	fnAddComplexProgression = function(dat, playername)
		local item = dat[1]
		local amt = dat[2]

		ix.progression.status["oldtimerItemDelivery_Knife1"].complexData = ix.progression.status["oldtimerItemDelivery_Knife1"].complexData or {}
		ix.progression.status["oldtimerItemDelivery_Knife1"].complexData[item] = ix.progression.status["oldtimerItemDelivery_Knife1"].complexData[item] or 0
		ix.progression.status["oldtimerItemDelivery_Knife1"].complexData[item] = ix.progression.status["oldtimerItemDelivery_Knife1"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["oldtimerItemDelivery_Knife1"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["oldtimerItemDelivery_Knife1"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["oldtimerItemDelivery_Knife1"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Old Timer'"
				local message = "You all seem ready for tougher game. I now have proper knives available for purchase."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Old Timer'")
			if (npc) then
				npc:AddItemToList("knife2", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("oldtimerItemDelivery_Knife1", true)
			ix.progression.SetActive("oldtimerItemDelivery_Knife2", true) 
			ix.progression.SetActive("oldtimerItemDelivery_Hidestash1", true) 

		end
	end
})

ix.progression.Register("oldtimerItemDelivery_Knife2", {
	name = "Backstabbing 2",
	description = "Prove your worth as a big game hunter to Old Timer.",
	keyNpc = "'Old Timer'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["oldtimerItemDelivery_Knife2"] = ix.progression.status["oldtimerItemDelivery_Knife2"] or {}
		local dat = ix.progression.status["oldtimerItemDelivery_Knife2"].complexData
		local itemids = self:GetItemIds()

		local str = "You may have seen some of the game the Zone has to offer, but have you taken on a chimera? A pseudogiant? Multiple of them at once? i have a test for you and other would be hunters. Enter the Zone and bring me back proof that you have been to hell and back again.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["hide_spider"] = 5,
			["hide_controller"] = 5,
			["hide_vareshka"] = 5,
			["part_controller_2"] = 10,
		}	

		return itemids
	end,
	progressfunctions = {
		[1] = {
			OnRun = function()
				
			end,
			RunOnce = false,
		},
	},
	progressthresholds = {
		[1] = 1,
	},
	fnAddComplexProgression = function(dat, playername)
		local item = dat[1]
		local amt = dat[2]

		ix.progression.status["oldtimerItemDelivery_Knife2"].complexData = ix.progression.status["oldtimerItemDelivery_Knife2"].complexData or {}
		ix.progression.status["oldtimerItemDelivery_Knife2"].complexData[item] = ix.progression.status["oldtimerItemDelivery_Knife2"].complexData[item] or 0
		ix.progression.status["oldtimerItemDelivery_Knife2"].complexData[item] = ix.progression.status["oldtimerItemDelivery_Knife2"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["oldtimerItemDelivery_Knife2"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["oldtimerItemDelivery_Knife2"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["oldtimerItemDelivery_Knife2"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Old Timer'"
				local message = "You are ready. To those passionate hunters among you, I now offer my best knives for sale."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Old Timer'")
			if (npc) then
				npc:AddItemToList("knife3", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("oldtimerItemDelivery_Knife2", true)
			ix.progression.SetActive("oldtimerItemDelivery_Knife3", true) 

		end
	end
})

ix.progression.Register("oldtimerItemDelivery_Knife3", {
	name = "Backstabbing 3",
	description = "Prove your worth as a knife fighter to Old Timer.",
	keyNpc = "'Old Timer'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["oldtimerItemDelivery_Knife3"] = ix.progression.status["oldtimerItemDelivery_Knife3"] or {}
		local dat = ix.progression.status["oldtimerItemDelivery_Knife3"].complexData
		local itemids = self:GetItemIds()

		local str = "You and yours are seasoned fighters; I can see it in your eyes. The way you carry yourselves, the way you walk... the cues are obvious to those well-versed enough to look for them. If you are searching for a blade better suited to combat than hunting, you must prove yourself worthy of bearing your steel. Show me what you are capable of.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["hide_pseudogiant"] = 4,
			["hide_chimera"] = 4,
			["hide_karlik"] = 4,
			["part_electrocontroller_2"] = 10,
			["part_karlik_2"] = 10,
		}	

		return itemids
	end,
	progressfunctions = {
		[1] = {
			OnRun = function()
				
			end,
			RunOnce = false,
		},
	},
	progressthresholds = {
		[1] = 1,
	},
	fnAddComplexProgression = function(dat, playername)
		local item = dat[1]
		local amt = dat[2]

		ix.progression.status["oldtimerItemDelivery_Knife3"].complexData = ix.progression.status["oldtimerItemDelivery_Knife3"].complexData or {}
		ix.progression.status["oldtimerItemDelivery_Knife3"].complexData[item] = ix.progression.status["oldtimerItemDelivery_Knife3"].complexData[item] or 0
		ix.progression.status["oldtimerItemDelivery_Knife3"].complexData[item] = ix.progression.status["oldtimerItemDelivery_Knife3"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["oldtimerItemDelivery_Knife3"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["oldtimerItemDelivery_Knife3"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["oldtimerItemDelivery_Knife3"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Old Timer'"
				local message = "There are true knife fighters among you. I now offer bayonets more suited to combat than hunting to those fond of the dance of blades."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Old Timer'")
			if (npc) then
				npc:AddItemToList("knife4", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("oldtimerItemDelivery_Knife3", true)

		end
	end
})


ix.progression.Register("oldtimerItemDelivery_Melee", {
	name = "Clubbing",
	description = "Prove your worth as a warrior to Old Timer.",
	keyNpc = "'Old Timer'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["oldtimerItemDelivery_Melee"] = ix.progression.status["oldtimerItemDelivery_Melee"] or {}
		local dat = ix.progression.status["oldtimerItemDelivery_Melee"].complexData
		local itemids = self:GetItemIds()

		local str = "Do you carry a melee weapon with you, stalker? They are both economic solutions for poorer stalkers and useful kit to those who are able to dance in and out of battle with the claws of mutants. A well aimed blow with such weapons can instantly kill some threats. Take to the field of battle, stalker, and prove your worth.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_bolt"] = 2,
		}	

		return itemids
	end,
	progressfunctions = {
		[1] = {
			OnRun = function()
				
			end,
			RunOnce = false,
		},
	},
	progressthresholds = {
		[1] = 1,
	},
	fnAddComplexProgression = function(dat, playername)
		local item = dat[1]
		local amt = dat[2]

		ix.progression.status["oldtimerItemDelivery_Melee"].complexData = ix.progression.status["oldtimerItemDelivery_Melee"].complexData or {}
		ix.progression.status["oldtimerItemDelivery_Melee"].complexData[item] = ix.progression.status["oldtimerItemDelivery_Melee"].complexData[item] or 0
		ix.progression.status["oldtimerItemDelivery_Melee"].complexData[item] = ix.progression.status["oldtimerItemDelivery_Melee"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["oldtimerItemDelivery_Melee"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["oldtimerItemDelivery_Melee"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["oldtimerItemDelivery_Melee"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Old Timer'"
				local message = "Though the middle ages are long behind us, I see within you all a warrior's spirit. I now carry new melee weapons that are a cut above what you previously had."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Old Timer'")
			if (npc) then
				npc:AddItemToList("bat", nil, 5, "SELLANDBUY", 5, 1, 5)
                npc:AddItemToList("fireaxe", nil, 5, "SELLANDBUY", 5, 1, 5)
                npc:AddItemToList("fubar", nil, 5, "SELLANDBUY", 5, 1, 5)
                npc:AddItemToList("hatchet", nil, 5, "SELLANDBUY", 5, 1, 5)
                npc:AddItemToList("machete", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("oldtimerItemDelivery_Melee", true)

		end
	end
})


ix.progression.Register("oldtimerItemDelivery_Hidestash1", {
	name = "Hiding Secrets 1",
	description = "Prove your worth as a seeker to Old Timer",
	keyNpc = "'Old Timer'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["oldtimerItemDelivery_Hidestash1"] = ix.progression.status["oldtimerItemDelivery_Hidestash1"] or {}
		local dat = ix.progression.status["oldtimerItemDelivery_Hidestash1"].complexData
		local itemids = self:GetItemIds()

		local str = "Have you found some of the hidden secrets of the Zone, stalker? Not all of them are figuratively buried; some stashes are literally hidden underground. If you are interested in moving on from digging in the dirt with spoons, you must first demonstrate mastery.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_bolt"] = 15,
		}	

		return itemids
	end,
	progressfunctions = {
		[1] = {
			OnRun = function()
				
			end,
			RunOnce = false,
		},
	},
	progressthresholds = {
		[1] = 1,
	},
	fnAddComplexProgression = function(dat, playername)
		local item = dat[1]
		local amt = dat[2]

		ix.progression.status["oldtimerItemDelivery_Hidestash1"].complexData = ix.progression.status["oldtimerItemDelivery_Hidestash1"].complexData or {}
		ix.progression.status["oldtimerItemDelivery_Hidestash1"].complexData[item] = ix.progression.status["oldtimerItemDelivery_Hidestash1"].complexData[item] or 0
		ix.progression.status["oldtimerItemDelivery_Hidestash1"].complexData[item] = ix.progression.status["oldtimerItemDelivery_Hidestash1"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["oldtimerItemDelivery_Hidestash1"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["oldtimerItemDelivery_Hidestash1"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["oldtimerItemDelivery_Hidestash1"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Old Timer'"
				local message = "I see in you the eyes of seekers and hands stained with dirt from a long dig, yet the rewards speak for themselves. I now offer sturdier tools for digging."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Old Timer'")
			if (npc) then
				npc:AddItemToList("hidestasher_cleaningkit", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("oldtimerItemDelivery_Hidestash1", true)
			ix.progression.SetActive("oldtimerItemDelivery_Hidestash2", true) 

		end
	end
})


ix.progression.Register("oldtimerItemDelivery_Hidestash2", {
	name = "Hiding Secrets 2",
	description = "Prove your worth as a treasure hunter to Old Timer.",
	keyNpc = "'Old Timer'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["oldtimerItemDelivery_Hidestash2"] = ix.progression.status["oldtimerItemDelivery_Hidestash2"] or {}
		local dat = ix.progression.status["oldtimerItemDelivery_Hidestash2"].complexData
		local itemids = self:GetItemIds()

		local str = "Have you grown tired of using small hand tools in your searches, stalker? Before man mastered gunpowder and the rifle, he mastered the sword with the riddle of steel, and before the sword came the stone. You must become a master with the stone before you may pick up the sword. Show me your skill.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_bolt"] = 50,
		}	

		return itemids
	end,
	progressfunctions = {
		[1] = {
			OnRun = function()
				
			end,
			RunOnce = false,
		},
	},
	progressthresholds = {
		[1] = 1,
	},
	fnAddComplexProgression = function(dat, playername)
		local item = dat[1]
		local amt = dat[2]

		ix.progression.status["oldtimerItemDelivery_Hidestash2"].complexData = ix.progression.status["oldtimerItemDelivery_Hidestash2"].complexData or {}
		ix.progression.status["oldtimerItemDelivery_Hidestash2"].complexData[item] = ix.progression.status["oldtimerItemDelivery_Hidestash2"].complexData[item] or 0
		ix.progression.status["oldtimerItemDelivery_Hidestash2"].complexData[item] = ix.progression.status["oldtimerItemDelivery_Hidestash2"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["oldtimerItemDelivery_Hidestash2"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["oldtimerItemDelivery_Hidestash2"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["oldtimerItemDelivery_Hidestash2"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Old Timer'"
				local message = "You are ready to move on from smaller tools. For those of you who are proud excavators, I now offer entrenching tools."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Old Timer'")
			if (npc) then
				npc:AddItemToList("hidestasher_shovel", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("oldtimerItemDelivery_Hidestash2", true)

		end
	end
})
