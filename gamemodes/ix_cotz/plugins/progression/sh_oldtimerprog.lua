ix.progression.Register("oldtimerItemDelivery_Knife1", {
	name = "Backstabbing 1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Old Timer'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["oldtimerItemDelivery_Knife1"] = ix.progression.status["oldtimerItemDelivery_Knife1"] or {}
		local dat = ix.progression.status["oldtimerItemDelivery_Knife1"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Kitchen Knife:\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_bolt"] = 1,
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
				local message = "Now available in my shop: Kitchen Knife."
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

		end
	end
})

ix.progression.Register("oldtimerItemDelivery_Knife2", {
	name = "Backstabbing 2",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Old Timer'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["oldtimerItemDelivery_Knife2"] = ix.progression.status["oldtimerItemDelivery_Knife2"] or {}
		local dat = ix.progression.status["oldtimerItemDelivery_Knife2"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Survival Knife:\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_bolt"] = 1,
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
				local message = "Now available in my shop: Survival Knife."
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
	description = "## PLACEHOLDER ##",
	keyNpc = "'Old Timer'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["oldtimerItemDelivery_Knife3"] = ix.progression.status["oldtimerItemDelivery_Knife3"] or {}
		local dat = ix.progression.status["oldtimerItemDelivery_Knife3"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Battered Bayonet:\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_bolt"] = 1,
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
				local message = "Now available in my shop: Battered Bayonet."
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
	description = "## PLACEHOLDER ##",
	keyNpc = "'Old Timer'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["oldtimerItemDelivery_Melee"] = ix.progression.status["oldtimerItemDelivery_Melee"] or {}
		local dat = ix.progression.status["oldtimerItemDelivery_Melee"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Bat, Fireaxe, Fubar, Hatchet, Machete:\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_bolt"] = 1,
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
				local message = "Now available in my shop: Unlocks Bat, Fireaxe, Fubar, Hatchet, Machete."
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
	description = "## PLACEHOLDER ##",
	keyNpc = "'Old Timer'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["oldtimerItemDelivery_Hidestash1"] = ix.progression.status["oldtimerItemDelivery_Hidestash1"] or {}
		local dat = ix.progression.status["oldtimerItemDelivery_Hidestash1"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Cleaning Kit:\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_bolt"] = 1,
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
				local message = "Now available in my shop: Cleaning Kit."
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
	description = "## PLACEHOLDER ##",
	keyNpc = "'Old Timer'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["oldtimerItemDelivery_Hidestash2"] = ix.progression.status["oldtimerItemDelivery_Hidestash2"] or {}
		local dat = ix.progression.status["oldtimerItemDelivery_Hidestash2"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Shovel:\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_bolt"] = 1,
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
				local message = "Now available in my shop: Shovel."
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
