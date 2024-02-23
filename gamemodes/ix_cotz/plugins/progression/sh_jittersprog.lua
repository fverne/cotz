ix.progression.Register("jittersItemDelivery_medical1", {
	name = "Due Treatment 1",
	description = "Jitters take a good look at you.",
	keyNpc = "'Jitters'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["jittersItemDelivery_medical1"] = ix.progression.status["jittersItemDelivery_medical1"] or {}
		local dat = ix.progression.status["jittersItemDelivery_medical1"].complexData
		local itemids = self:GetItemIds()

		local str = "Hey uhh, It's pretty tough out here, am I right? How about we help each other out.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
            ["drug_cigarette_1"] = 30,
			["drug_cigarette_2"] = 30,
            ["drug_tobacco_2"] = 30,

            ["drug_caffeine"] = 10,
			["drug_painkillers"] = 10,
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

		ix.progression.status["jittersItemDelivery_medical1"].complexData = ix.progression.status["jittersItemDelivery_medical1"].complexData or {}
		ix.progression.status["jittersItemDelivery_medical1"].complexData[item] = ix.progression.status["jittersItemDelivery_medical1"].complexData[item] or 0
		ix.progression.status["jittersItemDelivery_medical1"].complexData[item] = ix.progression.status["jittersItemDelivery_medical1"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["jittersItemDelivery_medical1"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["jittersItemDelivery_medical1"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["jittersItemDelivery_medical1"].complexData[item] = ix.progression.status["jittersItemDelivery_medical1"].complexData[item] or 0
			if amt > ix.progression.status["jittersItemDelivery_medical1"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Jitters'"
				local message = "Jitters here. Thanks for the... uhm... medication. As a reward I have more medical equipment in stock."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Jitters'")
			if (npc) then
				npc:AddItemToList("medic_medkit_1", nil, 10, "SELLANDBUY", 10, 1, 10)
				npc:AddItemToList("medic_medkit_2", nil, 10, "SELLANDBUY", 10, 1, 10)
			end

			ix.progression.SetCompleted("jittersItemDelivery_medical1", true)
            ix.progression.SetActive("jittersItemDelivery_medical2", true)

		end
	end
})


ix.progression.Register("jittersItemDelivery_medical2", {
	name = "Due Treatment 2",
	description = "Jitters take a good look at you.",
	keyNpc = "'Jitters'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["jittersItemDelivery_medical2"] = ix.progression.status["jittersItemDelivery_medical2"] or {}
		local dat = ix.progression.status["jittersItemDelivery_medical2"].complexData
		local itemids = self:GetItemIds()

		local str = "I feel like we are bonding. How about we help each other again?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
            ["drug_cigarette_4"] = 30,
			["drug_cigarette_3"] = 30,
            ["drug_tobacco_2"] = 30,

			["drug_mints"] = 10,
			["drug_morphine"] = 10,
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

		ix.progression.status["jittersItemDelivery_medical2"].complexData = ix.progression.status["jittersItemDelivery_medical2"].complexData or {}
		ix.progression.status["jittersItemDelivery_medical2"].complexData[item] = ix.progression.status["jittersItemDelivery_medical2"].complexData[item] or 0
		ix.progression.status["jittersItemDelivery_medical2"].complexData[item] = ix.progression.status["jittersItemDelivery_medical2"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["jittersItemDelivery_medical2"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["jittersItemDelivery_medical2"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["jittersItemDelivery_medical2"].complexData[item] = ix.progression.status["jittersItemDelivery_medical2"].complexData[item] or 0
			if amt > ix.progression.status["jittersItemDelivery_medical2"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Jitters'"
				local message = "Jitters here. Thanks again for your help. As a reward I have more medical equipment in stock. Come see me again soon!"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Jitters'")
			if (npc) then
                npc:AddItemToList("medic_bandage_2", nil, 10, "SELLANDBUY", 10, 1, 10)
				npc:AddItemToList("medic_medkit_3", nil, 10, "SELLANDBUY", 10, 1, 10)
				-- npc:AddItemToList("medic_medkit_4", nil, 10, "SELLANDBUY", 10, 1, 10)
			end

			ix.progression.SetCompleted("jittersItemDelivery_medical2", true)
            ix.progression.SetActive("jittersItemDelivery_medical3", true)

		end
	end
})


ix.progression.Register("jittersItemDelivery_medical3", {
	name = "Due Treatment 3",
	description = "Jitters take a good look at you.",
	keyNpc = "'Jitters'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["jittersItemDelivery_medical3"] = ix.progression.status["jittersItemDelivery_medical3"] or {}
		local dat = ix.progression.status["jittersItemDelivery_medical3"].complexData
		local itemids = self:GetItemIds()

		local str = "Hello friend! How about we help each other again?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
            ["drug_cigarette_5"] = 30,
			["drug_cigarette_6"] = 30,

			["drug_marijuana"] = 10,
			-- ["drug_cocaine"] = 10,
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

		ix.progression.status["jittersItemDelivery_medical3"].complexData = ix.progression.status["jittersItemDelivery_medical3"].complexData or {}
		ix.progression.status["jittersItemDelivery_medical3"].complexData[item] = ix.progression.status["jittersItemDelivery_medical3"].complexData[item] or 0
		ix.progression.status["jittersItemDelivery_medical3"].complexData[item] = ix.progression.status["jittersItemDelivery_medical3"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["jittersItemDelivery_medical3"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["jittersItemDelivery_medical3"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["jittersItemDelivery_medical3"].complexData[item] = ix.progression.status["jittersItemDelivery_medical3"].complexData[item] or 0
			if amt > ix.progression.status["jittersItemDelivery_medical3"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Jitters'"
				local message = "Jitters here. I have a stock of army syrette kits and new bandages for you."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Jitters'")
			if (npc) then
                npc:AddItemToList("medic_bandage_3", nil, 10, "SELLANDBUY", 10, 1, 10)
				npc:AddItemToList("medic_medkit_4", nil, 10, "SELLANDBUY", 10, 1, 10)
			end

			ix.progression.SetCompleted("jittersItemDelivery_medical3", true)
            ix.progression.SetActive("jittersItemDelivery_medical4", true)

		end
	end
})


ix.progression.Register("jittersItemDelivery_medical4", {
	name = "Due Treatment 4",
	description = "Jitters take a good look at you.",
	keyNpc = "'Jitters'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["jittersItemDelivery_medical4"] = ix.progression.status["jittersItemDelivery_medical4"] or {}
		local dat = ix.progression.status["jittersItemDelivery_medical4"].complexData
		local itemids = self:GetItemIds()

		local str = "Hello friend! How about we help each other again?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
            ["drug_cigar"] = 20,
			["drug_cocaine"] = 10,
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

		ix.progression.status["jittersItemDelivery_medical4"].complexData = ix.progression.status["jittersItemDelivery_medical4"].complexData or {}
		ix.progression.status["jittersItemDelivery_medical4"].complexData[item] = ix.progression.status["jittersItemDelivery_medical4"].complexData[item] or 0
		ix.progression.status["jittersItemDelivery_medical4"].complexData[item] = ix.progression.status["jittersItemDelivery_medical4"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["jittersItemDelivery_medical4"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["jittersItemDelivery_medical4"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["jittersItemDelivery_medical4"].complexData[item] = ix.progression.status["jittersItemDelivery_medical4"].complexData[item] or 0
			if amt > ix.progression.status["jittersItemDelivery_medical4"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Jitters'"
				local message = "Jitters here. I have a stock of scientist stuff. Don't tell them!"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Jitters'")
			if (npc) then
                npc:AddItemToList("medic_medkit_5", nil, 10, "SELLANDBUY", 10, 1, 10)
				npc:AddItemToList("medic_medkit_6", nil, 10, "SELLANDBUY", 10, 1, 10)
			end

			ix.progression.SetCompleted("jittersItemDelivery_medical4", true)

		end
	end
})