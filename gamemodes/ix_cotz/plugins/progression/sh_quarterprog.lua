ix.progression.Register("quartermasterItemDelivery_1", {
	name = "Gearing Up 1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Quartermaster'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_1"] = ix.progression.status["quartermasterItemDelivery_1"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_1"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks MP5 :\n"

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

		ix.progression.status["quartermasterItemDelivery_1"].complexData = ix.progression.status["quartermasterItemDelivery_1"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_1"].complexData[item] = ix.progression.status["quartermasterItemDelivery_1"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_1"].complexData[item] = ix.progression.status["quartermasterItemDelivery_1"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_1"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_1"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["quartermasterItemDelivery_1"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Now available in my shop: MP5."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("mp5", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_1", true)
			ix.progression.SetActive("quartermasterItemDelivery_11", true) 
			ix.progression.SetActive("quartermasterItemDelivery_12", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_11", {
	name = "Gearing Up 1.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_11"] = ix.progression.status["quartermasterItemDelivery_11"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_11"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Mateba Unica, AK-74, L85 :\n"

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

		ix.progression.status["quartermasterItemDelivery_11"].complexData = ix.progression.status["quartermasterItemDelivery_11"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_11"].complexData[item] = ix.progression.status["quartermasterItemDelivery_11"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_11"].complexData[item] = ix.progression.status["quartermasterItemDelivery_11"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_11"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_11"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["quartermasterItemDelivery_11"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Now available in my shop: Mateba Unica, AK-74, L85."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("mateba", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("ak74", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("l85", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_11", true)
			ix.progression.SetActive("quartermasterItemDelivery_111", true) 
			ix.progression.SetActive("quartermasterItemDelivery_112", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_111", {
	name = "Gearing Up 1.1.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_111"] = ix.progression.status["quartermasterItemDelivery_111"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_111"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Henry Lever Action X Model .44, G36c :\n"

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

		ix.progression.status["quartermasterItemDelivery_111"].complexData = ix.progression.status["quartermasterItemDelivery_111"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_111"].complexData[item] = ix.progression.status["quartermasterItemDelivery_111"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_111"].complexData[item] = ix.progression.status["quartermasterItemDelivery_111"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_111"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_111"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["quartermasterItemDelivery_111"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Now available in my shop: Henry Lever Action X Model .44, G36c."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("lax44", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("g36c", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_111", true)
			ix.progression.SetActive("quartermasterItemDelivery_1111", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_1111", {
	name = "Gearing Up 1.1.1.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_1111"] = ix.progression.status["quartermasterItemDelivery_1111"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_1111"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks SG552 :\n"

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

		ix.progression.status["quartermasterItemDelivery_1111"].complexData = ix.progression.status["quartermasterItemDelivery_1111"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_1111"].complexData[item] = ix.progression.status["quartermasterItemDelivery_1111"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_1111"].complexData[item] = ix.progression.status["quartermasterItemDelivery_1111"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_1111"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_1111"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["quartermasterItemDelivery_1111"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Now available in my shop: SG552."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("sg552", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_1111", true)

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_112", {
	name = "Gearing Up 1.1.2",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_112"] = ix.progression.status["quartermasterItemDelivery_112"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_112"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks AEK-971, AN94k :\n"

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

		ix.progression.status["quartermasterItemDelivery_112"].complexData = ix.progression.status["quartermasterItemDelivery_112"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_112"].complexData[item] = ix.progression.status["quartermasterItemDelivery_112"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_112"].complexData[item] = ix.progression.status["quartermasterItemDelivery_112"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_112"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_112"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["quartermasterItemDelivery_112"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Now available in my shop: AEK-971, AN94k."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("aek971", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("an94k", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_112", true)
			ix.progression.SetActive("quartermasterItemDelivery_1121", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_1121", {
	name = "Gearing Up 1.1.2.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_1121"] = ix.progression.status["quartermasterItemDelivery_1121"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_1121"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks SAKO RK 95 :\n"

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

		ix.progression.status["quartermasterItemDelivery_1121"].complexData = ix.progression.status["quartermasterItemDelivery_1121"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_1121"].complexData[item] = ix.progression.status["quartermasterItemDelivery_1121"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_1121"].complexData[item] = ix.progression.status["quartermasterItemDelivery_1121"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_1121"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_1121"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["quartermasterItemDelivery_1121"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Now available in my shop: SAKO RK 95."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("rk95", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_1121", true)
			ix.progression.SetActive("quartermasterItemDelivery_11211", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_11211", {
	name = "Gearing Up 1.1.2.1.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_11211"] = ix.progression.status["quartermasterItemDelivery_11211"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_11211"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks AK-12 :\n"

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

		ix.progression.status["quartermasterItemDelivery_11211"].complexData = ix.progression.status["quartermasterItemDelivery_11211"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_11211"].complexData[item] = ix.progression.status["quartermasterItemDelivery_11211"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_11211"].complexData[item] = ix.progression.status["quartermasterItemDelivery_11211"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_11211"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_11211"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["quartermasterItemDelivery_11211"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Now available in my shop: AK-12."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("ak12", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_11211", true)
		end
	end
})

ix.progression.Register("quartermasterItemDelivery_12", {
	name = "Gearing Up 1.2",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_12"] = ix.progression.status["quartermasterItemDelivery_12"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_12"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks M3 Super 90, FN FiveseveN :\n"

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

		ix.progression.status["quartermasterItemDelivery_12"].complexData = ix.progression.status["quartermasterItemDelivery_12"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_12"].complexData[item] = ix.progression.status["quartermasterItemDelivery_12"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_12"].complexData[item] = ix.progression.status["quartermasterItemDelivery_12"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_12"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_12"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["quartermasterItemDelivery_12"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Now available in my shop: M3 Super 90, FN FiveseveN."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("m3super90", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("fiveseven", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_12", true)
			ix.progression.SetActive("quartermasterItemDelivery_121", true) 
			ix.progression.SetActive("quartermasterItemDelivery_122", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_121", {
	name = "Gearing Up 1.2.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_121"] = ix.progression.status["quartermasterItemDelivery_121"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_121"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks FN P90, UMP-45 :\n"

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

		ix.progression.status["quartermasterItemDelivery_121"].complexData = ix.progression.status["quartermasterItemDelivery_121"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_121"].complexData[item] = ix.progression.status["quartermasterItemDelivery_121"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_121"].complexData[item] = ix.progression.status["quartermasterItemDelivery_121"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_121"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_121"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["quartermasterItemDelivery_121"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Now available in my shop: FN P90, UMP-45."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("p90", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("ump45", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_121", true)
		end
	end
})

ix.progression.Register("quartermasterItemDelivery_122", {
	name = "Gearing Up 1.2.2",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_122"] = ix.progression.status["quartermasterItemDelivery_122"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_122"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks LR 300 :\n"

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

		ix.progression.status["quartermasterItemDelivery_122"].complexData = ix.progression.status["quartermasterItemDelivery_122"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_122"].complexData[item] = ix.progression.status["quartermasterItemDelivery_122"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_122"].complexData[item] = ix.progression.status["quartermasterItemDelivery_122"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_122"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_122"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["quartermasterItemDelivery_122"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Now available in my shop: LR 300."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("lr300", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_122", true)
			ix.progression.SetActive("quartermasterItemDelivery_1221", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_1221", {
	name = "Gearing Up 1.2.2.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_1221"] = ix.progression.status["quartermasterItemDelivery_1221"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_1221"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks M16A4 :\n"

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

		ix.progression.status["quartermasterItemDelivery_1221"].complexData = ix.progression.status["quartermasterItemDelivery_1221"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_1221"].complexData[item] = ix.progression.status["quartermasterItemDelivery_1221"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_1221"].complexData[item] = ix.progression.status["quartermasterItemDelivery_1221"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_1221"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_1221"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["quartermasterItemDelivery_1221"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Now available in my shop: M16A4."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("m16a4", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_1221", true)
			ix.progression.SetActive("quartermasterItemDelivery_12211", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_12211", {
	name = "Gearing Up 1.2.2.1.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_12211"] = ix.progression.status["quartermasterItemDelivery_12211"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_12211"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks FN FAL :\n"

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

		ix.progression.status["quartermasterItemDelivery_12211"].complexData = ix.progression.status["quartermasterItemDelivery_12211"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_12211"].complexData[item] = ix.progression.status["quartermasterItemDelivery_12211"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_12211"].complexData[item] = ix.progression.status["quartermasterItemDelivery_12211"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_12211"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_12211"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["quartermasterItemDelivery_12211"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Now available in my shop: FN FAL."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("fnfal", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_12211", true)
		end
	end
})

ix.progression.Register("quartermasterItemDelivery_2", {
	name = "Gearing Up 2",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Quartermaster'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_2"] = ix.progression.status["quartermasterItemDelivery_2"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_2"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks S&W R8 :\n"

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

		ix.progression.status["quartermasterItemDelivery_2"].complexData = ix.progression.status["quartermasterItemDelivery_2"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_2"].complexData[item] = ix.progression.status["quartermasterItemDelivery_2"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_2"].complexData[item] = ix.progression.status["quartermasterItemDelivery_2"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_2"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_2"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["quartermasterItemDelivery_2"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Now available in my shop: S&W R8."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("swr8", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_2", true)
			ix.progression.SetActive("quartermasterItemDelivery_21", true) 
			ix.progression.SetActive("quartermasterItemDelivery_22", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_21", {
	name = "Gearing Up 2.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_21"] = ix.progression.status["quartermasterItemDelivery_21"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_21"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Taurus Raging Bull, MP9a1 :\n"

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

		ix.progression.status["quartermasterItemDelivery_21"].complexData = ix.progression.status["quartermasterItemDelivery_21"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_21"].complexData[item] = ix.progression.status["quartermasterItemDelivery_21"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_21"].complexData[item] = ix.progression.status["quartermasterItemDelivery_21"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_21"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_21"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["quartermasterItemDelivery_21"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Now available in my shop: Taurus Raging Bull, MP9a1."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("taurusragingbull", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("mp9a1", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_21", true)
			ix.progression.SetActive("quartermasterItemDelivery_211", true) 
			ix.progression.SetActive("quartermasterItemDelivery_212", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_211", {
	name = "Gearing Up 2.1.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_211"] = ix.progression.status["quartermasterItemDelivery_211"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_211"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks IMI Uzi, PP-19-01 'Vityaz' :\n"

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

		ix.progression.status["quartermasterItemDelivery_211"].complexData = ix.progression.status["quartermasterItemDelivery_211"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_211"].complexData[item] = ix.progression.status["quartermasterItemDelivery_211"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_211"].complexData[item] = ix.progression.status["quartermasterItemDelivery_211"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_211"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_211"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["quartermasterItemDelivery_211"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Now available in my shop: IMI Uzi, PP-19-01 'Vityaz'."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("uzi", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("pp1901vityaz", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_211", true)
		end
	end
})

ix.progression.Register("quartermasterItemDelivery_212", {
	name = "Gearing Up 2.1.2",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_212"] = ix.progression.status["quartermasterItemDelivery_212"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_212"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks FAMAS :\n"

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

		ix.progression.status["quartermasterItemDelivery_212"].complexData = ix.progression.status["quartermasterItemDelivery_212"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_212"].complexData[item] = ix.progression.status["quartermasterItemDelivery_212"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_212"].complexData[item] = ix.progression.status["quartermasterItemDelivery_212"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_212"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_212"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["quartermasterItemDelivery_212"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Now available in my shop: FAMAS."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("famas", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_212", true)
			ix.progression.SetActive("quartermasterItemDelivery_2121", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_2121", {
	name = "Gearing Up 2.1.2.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_2121"] = ix.progression.status["quartermasterItemDelivery_2121"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_2121"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Steyr AUG :\n"

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

		ix.progression.status["quartermasterItemDelivery_2121"].complexData = ix.progression.status["quartermasterItemDelivery_2121"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_2121"].complexData[item] = ix.progression.status["quartermasterItemDelivery_2121"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_2121"].complexData[item] = ix.progression.status["quartermasterItemDelivery_2121"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_2121"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_2121"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["quartermasterItemDelivery_2121"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Now available in my shop: Steyr AUG."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("aug", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_2121", true)
		end
	end
})

ix.progression.Register("quartermasterItemDelivery_22", {
	name = "Gearing Up 2.2",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_22"] = ix.progression.status["quartermasterItemDelivery_22"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_22"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Remington 870AE, MR96 :\n"

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

		ix.progression.status["quartermasterItemDelivery_22"].complexData = ix.progression.status["quartermasterItemDelivery_22"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_22"].complexData[item] = ix.progression.status["quartermasterItemDelivery_22"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_22"].complexData[item] = ix.progression.status["quartermasterItemDelivery_22"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_22"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_22"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["quartermasterItemDelivery_22"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Now available in my shop: Remington 870AE, MR96."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("rem870", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("mr96", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_22", true)
			ix.progression.SetActive("quartermasterItemDelivery_221", true) 
			ix.progression.SetActive("quartermasterItemDelivery_222", true) 

		end
	end
})

ix.progression.Register("quartermasterItemDelivery_221", {
	name = "Gearing Up 2.2.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_221"] = ix.progression.status["quartermasterItemDelivery_221"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_221"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Baikal MP-153 :\n"

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

		ix.progression.status["quartermasterItemDelivery_221"].complexData = ix.progression.status["quartermasterItemDelivery_221"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_221"].complexData[item] = ix.progression.status["quartermasterItemDelivery_221"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_221"].complexData[item] = ix.progression.status["quartermasterItemDelivery_221"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_221"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_221"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["quartermasterItemDelivery_221"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Now available in my shop: Baikal MP-153."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("mp153", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_221", true)
		end
	end
})

ix.progression.Register("quartermasterItemDelivery_222", {
	name = "Gearing Up 2.2.2",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_222"] = ix.progression.status["quartermasterItemDelivery_222"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_222"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks SV-98 :\n"

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

		ix.progression.status["quartermasterItemDelivery_222"].complexData = ix.progression.status["quartermasterItemDelivery_222"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_222"].complexData[item] = ix.progression.status["quartermasterItemDelivery_222"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_222"].complexData[item] = ix.progression.status["quartermasterItemDelivery_222"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_222"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_222"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["quartermasterItemDelivery_222"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Now available in my shop: SV-98."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("sv98", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_222", true)
			ix.progression.SetActive("quartermasterItemDelivery_2221", true) 
		end
	end
})

ix.progression.Register("quartermasterItemDelivery_2221", {
	name = "Gearing Up 2.2.2.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Quartermaster'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["quartermasterItemDelivery_2221"] = ix.progression.status["quartermasterItemDelivery_2221"] or {}
		local dat = ix.progression.status["quartermasterItemDelivery_2221"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks SVD :\n"

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

		ix.progression.status["quartermasterItemDelivery_2221"].complexData = ix.progression.status["quartermasterItemDelivery_2221"].complexData or {}
		ix.progression.status["quartermasterItemDelivery_2221"].complexData[item] = ix.progression.status["quartermasterItemDelivery_2221"].complexData[item] or 0
		ix.progression.status["quartermasterItemDelivery_2221"].complexData[item] = ix.progression.status["quartermasterItemDelivery_2221"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["quartermasterItemDelivery_2221"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["quartermasterItemDelivery_2221"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["quartermasterItemDelivery_2221"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Quartermaster'"
				local message = "Now available in my shop: SVD."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Quartermaster'")
			if (npc) then
				npc:AddItemToList("svd", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("quartermasterItemDelivery_2221", true)
		end
	end
})

