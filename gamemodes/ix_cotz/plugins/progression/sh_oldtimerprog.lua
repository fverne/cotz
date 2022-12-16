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
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Old Timer'",
					message = "Now available in my shop: Kitchen Knife."
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
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Old Timer'",
					message = "Now available in my shop: Survival Knife."
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
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Old Timer'",
					message = "Now available in my shop: Battered Bayonet."
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
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Old Timer'",
					message = "Now available in my shop: Unlocks Bat, Fireaxe, Fubar, Hatchet, Machete."
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
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Old Timer'",
					message = "Now available in my shop: Cleaning Kit."
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Old Timer'")
			if (npc) then
				npc:AddItemToList("hidestash_cleaningkit", nil, 5, "SELLANDBUY", 5, 1, 5)
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
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Old Timer'",
					message = "Now available in my shop: Shovel."
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Old Timer'")
			if (npc) then
				npc:AddItemToList("hidestash_shovel", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("oldtimerItemDelivery_Hidestash2", true)

		end
	end
})


ix.progression.Register("oldtimerItemDelivery_Nickname", {
	name = "Making a name for yourself",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Old Timer'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["oldtimerItemDelivery_Nickname"] = ix.progression.status["oldtimerItemDelivery_Nickname"] or {}
		local dat = ix.progression.status["oldtimerItemDelivery_Nickname"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Nicknames:\n"

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

		ix.progression.status["oldtimerItemDelivery_Nickname"].complexData = ix.progression.status["oldtimerItemDelivery_Nickname"].complexData or {}
		ix.progression.status["oldtimerItemDelivery_Nickname"].complexData[item] = ix.progression.status["oldtimerItemDelivery_Nickname"].complexData[item] or 0
		ix.progression.status["oldtimerItemDelivery_Nickname"].complexData[item] = ix.progression.status["oldtimerItemDelivery_Nickname"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["oldtimerItemDelivery_Nickname"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["oldtimerItemDelivery_Nickname"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["oldtimerItemDelivery_Nickname"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Old Timer'",
					message = "Stalkers worth their weight can now get a nickname from me."
				})
			end)

			ix.progression.SetCompleted("oldtimerItemDelivery_Nickname", true)

		end
	end
})