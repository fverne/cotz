ix.progression.Register("bossItemDelivery_1", {
	name = "Cleaning Inventory 1",
	description = "Help Boss amass parts.",
	keyNpc = "'Boss'",
	defaultActive = false,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["bossItemDelivery_1"] = ix.progression.status["bossItemDelivery_1"] or {}
		local dat = ix.progression.status["bossItemDelivery_1"].complexData

		local itemids = self:GetItemIds()

		local str = "I have a ton of stockpile sitting here collecting dust in the research station. I'm willing to sell some to you if you help me out. First off the bat is a mercenary suit.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["part_boar"] = 15,
			["part_blinddog"] = 15,
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

		ix.progression.status["bossItemDelivery_1"].complexData = ix.progression.status["bossItemDelivery_1"].complexData or {}
		ix.progression.status["bossItemDelivery_1"].complexData[item] = ix.progression.status["bossItemDelivery_1"].complexData[item] or 0
		ix.progression.status["bossItemDelivery_1"].complexData[item] = ix.progression.status["bossItemDelivery_1"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["bossItemDelivery_1"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["bossItemDelivery_1"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["bossItemDelivery_1"].complexData[item] = ix.progression.status["bossItemDelivery_1"].complexData[item] or 0
			if amt > ix.progression.status["bossItemDelivery_1"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(15, function()
				local name = "'Boss'"
				local message = "IO7a's now available for purchase."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Boss'")
			if (npc) then
				npc:AddItemToList("suit_io7a", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("bossItemDelivery_1", true)
			ix.progression.SetActive("bossItemDelivery_2", true) 

		end
	end
})


ix.progression.Register("bossItemDelivery_2", {
	name = "Cleaning Inventory 2",
	description = "Help Boss amass parts.",
	keyNpc = "'Boss'",
	defaultActive = false,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["bossItemDelivery_2"] = ix.progression.status["bossItemDelivery_2"] or {}
		local dat = ix.progression.status["bossItemDelivery_2"].complexData

		local itemids = self:GetItemIds()

		local str = "I have more suits in my stockpile. Next up is a lightweight Universal Protection Suit.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["part_cat"] = 20,
			["part_flesh"] = 20,
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

		ix.progression.status["bossItemDelivery_2"].complexData = ix.progression.status["bossItemDelivery_2"].complexData or {}
		ix.progression.status["bossItemDelivery_2"].complexData[item] = ix.progression.status["bossItemDelivery_2"].complexData[item] or 0
		ix.progression.status["bossItemDelivery_2"].complexData[item] = ix.progression.status["bossItemDelivery_2"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["bossItemDelivery_2"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["bossItemDelivery_2"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["bossItemDelivery_2"].complexData[item] = ix.progression.status["bossItemDelivery_2"].complexData[item] or 0
			if amt > ix.progression.status["bossItemDelivery_2"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(15, function()
				local name = "'Boss'"
				local message = "PS5M's now available for purchase."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Boss'")
			if (npc) then
				npc:AddItemToList("suit_ps5m", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("bossItemDelivery_2", true)
			ix.progression.SetActive("bossItemDelivery_3", true) 

		end
	end
})



ix.progression.Register("bossItemDelivery_3", {
	name = "Cleaning Inventory 3",
	description = "Help Boss amass parts.",
	keyNpc = "'Boss'",
	defaultActive = false,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["bossItemDelivery_3"] = ix.progression.status["bossItemDelivery_3"] or {}
		local dat = ix.progression.status["bossItemDelivery_3"].complexData

		local itemids = self:GetItemIds()

		local str = "I have more suits in my stockpile. Next up is the military standard issue Berill-5M.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["part_snork_2"] = 20,
			["part_zombie_2"] = 20,
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

		ix.progression.status["bossItemDelivery_3"].complexData = ix.progression.status["bossItemDelivery_3"].complexData or {}
		ix.progression.status["bossItemDelivery_3"].complexData[item] = ix.progression.status["bossItemDelivery_3"].complexData[item] or 0
		ix.progression.status["bossItemDelivery_3"].complexData[item] = ix.progression.status["bossItemDelivery_3"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["bossItemDelivery_3"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["bossItemDelivery_3"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["bossItemDelivery_3"].complexData[item] = ix.progression.status["bossItemDelivery_3"].complexData[item] or 0
			if amt > ix.progression.status["bossItemDelivery_3"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(15, function()
				local name = "'Boss'"
				local message = "Berill-5M's now available for purchase."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Boss'")
			if (npc) then
				npc:AddItemToList("suit_berill", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("bossItemDelivery_3", true)
			ix.progression.SetActive("bossItemDelivery_4", true) 

		end
	end
})


ix.progression.Register("bossItemDelivery_4", {
	name = "Cleaning Inventory 4",
	description = "Help Boss amass parts.",
	keyNpc = "'Boss'",
	defaultActive = false,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["bossItemDelivery_4"] = ix.progression.status["bossItemDelivery_4"] or {}
		local dat = ix.progression.status["bossItemDelivery_4"].complexData

		local itemids = self:GetItemIds()

		local str = "I have more suits in my stockpile. Next up is the prototype Skat10.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["part_tark"] = 25,
			["part_sprig"] = 25,
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

		ix.progression.status["bossItemDelivery_4"].complexData = ix.progression.status["bossItemDelivery_4"].complexData or {}
		ix.progression.status["bossItemDelivery_4"].complexData[item] = ix.progression.status["bossItemDelivery_4"].complexData[item] or 0
		ix.progression.status["bossItemDelivery_4"].complexData[item] = ix.progression.status["bossItemDelivery_4"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["bossItemDelivery_4"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["bossItemDelivery_4"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["bossItemDelivery_4"].complexData[item] = ix.progression.status["bossItemDelivery_4"].complexData[item] or 0
			if amt > ix.progression.status["bossItemDelivery_4"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(15, function()
				local name = "'Boss'"
				local message = "Skat-10 Armoured Suits are now available for purchase."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Boss'")
			if (npc) then
				npc:AddItemToList("suit_skat10", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("bossItemDelivery_4", true)
			ix.progression.SetActive("bossItemDelivery_5", true) 

		end
	end
})




ix.progression.Register("bossItemDelivery_5", {
	name = "Cleaning Inventory 5",
	description = "Help Boss amass parts.",
	keyNpc = "'Boss'",
	defaultActive = false,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["bossItemDelivery_5"] = ix.progression.status["bossItemDelivery_5"] or {}
		local dat = ix.progression.status["bossItemDelivery_5"].complexData

		local itemids = self:GetItemIds()

		local str = "I have more suits in my stockpile. Next up is the exclusive Skat9.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["part_controller_1"] = 30,
			["part_chimera"] = 30,
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

		ix.progression.status["bossItemDelivery_5"].complexData = ix.progression.status["bossItemDelivery_5"].complexData or {}
		ix.progression.status["bossItemDelivery_5"].complexData[item] = ix.progression.status["bossItemDelivery_5"].complexData[item] or 0
		ix.progression.status["bossItemDelivery_5"].complexData[item] = ix.progression.status["bossItemDelivery_5"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["bossItemDelivery_5"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["bossItemDelivery_5"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["bossItemDelivery_5"].complexData[item] = ix.progression.status["bossItemDelivery_5"].complexData[item] or 0
			if amt > ix.progression.status["bossItemDelivery_5"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(15, function()
				local name = "'Boss'"
				local message = "Skat-9 Armoured Suits are now available for purchase."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Boss'")
			if (npc) then
				npc:AddItemToList("suit_skat9", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("bossItemDelivery_5", true)
			ix.progression.SetActive("bossItemDelivery_6", true) 

		end
	end
})



ix.progression.Register("bossItemDelivery_6", {
	name = "Cleaning Inventory 6",
	description = "Help Boss amass parts.",
	keyNpc = "'Boss'",
	defaultActive = false,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["bossItemDelivery_6"] = ix.progression.status["bossItemDelivery_6"] or {}
		local dat = ix.progression.status["bossItemDelivery_6"].complexData

		local itemids = self:GetItemIds()

		local str = "I have more suits in my stockpile. Next up is the Radsuit.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["part_controller_2"] = 30,
			["part_pseudogiant"] = 30,
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

		ix.progression.status["bossItemDelivery_6"].complexData = ix.progression.status["bossItemDelivery_6"].complexData or {}
		ix.progression.status["bossItemDelivery_6"].complexData[item] = ix.progression.status["bossItemDelivery_6"].complexData[item] or 0
		ix.progression.status["bossItemDelivery_6"].complexData[item] = ix.progression.status["bossItemDelivery_6"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["bossItemDelivery_6"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["bossItemDelivery_6"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["bossItemDelivery_6"].complexData[item] = ix.progression.status["bossItemDelivery_6"].complexData[item] or 0
			if amt > ix.progression.status["bossItemDelivery_6"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(15, function()
				local name = "'Boss'"
				local message = "Radsuits are now available for purchase."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Boss'")
			if (npc) then
				npc:AddItemToList("suit_radsuit", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("headwear_rad", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("bossItemDelivery_6", true)
			ix.progression.SetActive("bossItemDelivery_7", true) 

		end
	end
})




ix.progression.Register("bossItemDelivery_7", {
	name = "Cleaning Inventory 7",
	description = "Help Boss amass parts.",
	keyNpc = "'Boss'",
	defaultActive = false,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["bossItemDelivery_7"] = ix.progression.status["bossItemDelivery_7"] or {}
		local dat = ix.progression.status["bossItemDelivery_7"].complexData

		local itemids = self:GetItemIds()

		local str = "I have one last suit in my repository - the exoskeleton. \n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["part_electrocontroller_1"] = 35,
			["part_hellhound"] = 35,
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

		ix.progression.status["bossItemDelivery_7"].complexData = ix.progression.status["bossItemDelivery_7"].complexData or {}
		ix.progression.status["bossItemDelivery_7"].complexData[item] = ix.progression.status["bossItemDelivery_7"].complexData[item] or 0
		ix.progression.status["bossItemDelivery_7"].complexData[item] = ix.progression.status["bossItemDelivery_7"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["bossItemDelivery_7"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["bossItemDelivery_7"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(finished) do
			ix.progression.status["bossItemDelivery_7"].complexData[item] = ix.progression.status["bossItemDelivery_7"].complexData[item] or 0
			if amt > ix.progression.status["bossItemDelivery_7"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(15, function()
				local name = "'Boss'"
				local message = "Exoskeletons and protoype Spartan helmets are now available for purchase."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Boss'")
			if (npc) then
				npc:AddItemToList("suit_exoskeleton", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("headwear_spartan", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("gear_exoskeletonframe", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("bossItemDelivery_7", true)
			-- ix.progression.SetActive("bossItemDelivery_8", true) 

		end
	end
})