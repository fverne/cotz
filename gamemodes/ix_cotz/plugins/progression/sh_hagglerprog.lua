ix.progression.Register("hagglerItemDelivery_1", {
	name = "Kitting Up 1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_1"] = ix.progression.status["hagglerItemDelivery_1"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_1"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Fort-12, M1911, Browning Hi-Power :\n"

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

		ix.progression.status["hagglerItemDelivery_1"].complexData = ix.progression.status["hagglerItemDelivery_1"].complexData or {}
		ix.progression.status["hagglerItemDelivery_1"].complexData[item] = ix.progression.status["hagglerItemDelivery_1"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_1"].complexData[item] = ix.progression.status["hagglerItemDelivery_1"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_1"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_1"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_1"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: Fort-12, M1911, Browning Hi-Power."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("fort12", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("m1911", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("brhp", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_1", true)
			ix.progression.SetActive("hagglerItemDelivery_11", true) 
			ix.progression.SetActive("hagglerItemDelivery_12", true) 

		end
	end
})

ix.progression.Register("hagglerItemDelivery_11", {
	name = "Kitting Up 1.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_11"] = ix.progression.status["hagglerItemDelivery_11"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_11"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks LA-X 410 Short, Sten :\n"

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

		ix.progression.status["hagglerItemDelivery_11"].complexData = ix.progression.status["hagglerItemDelivery_11"].complexData or {}
		ix.progression.status["hagglerItemDelivery_11"].complexData[item] = ix.progression.status["hagglerItemDelivery_11"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_11"].complexData[item] = ix.progression.status["hagglerItemDelivery_11"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_11"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_11"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_11"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: LA-X 410 Short, Sten."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("lax410s", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("sten", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_11", true)
			ix.progression.SetActive("hagglerItemDelivery_111", true) 
			ix.progression.SetActive("hagglerItemDelivery_112", true) 

		end
	end
})

ix.progression.Register("hagglerItemDelivery_111", {
	name = "Kitting Up 1.1.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_111"] = ix.progression.status["hagglerItemDelivery_111"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_111"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks LA-X 410 :\n"

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

		ix.progression.status["hagglerItemDelivery_111"].complexData = ix.progression.status["hagglerItemDelivery_111"].complexData or {}
		ix.progression.status["hagglerItemDelivery_111"].complexData[item] = ix.progression.status["hagglerItemDelivery_111"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_111"].complexData[item] = ix.progression.status["hagglerItemDelivery_111"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_111"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_111"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_111"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: LA-X 410."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("lax410", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_111", true)
			ix.progression.SetActive("hagglerItemDelivery_1111", true) 

		end
	end
})

ix.progression.Register("hagglerItemDelivery_1111", {
	name = "Kitting Up 1.1.1.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_1111"] = ix.progression.status["hagglerItemDelivery_1111"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_1111"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks S&W Model 29 :\n"

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

		ix.progression.status["hagglerItemDelivery_1111"].complexData = ix.progression.status["hagglerItemDelivery_1111"].complexData or {}
		ix.progression.status["hagglerItemDelivery_1111"].complexData[item] = ix.progression.status["hagglerItemDelivery_1111"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_1111"].complexData[item] = ix.progression.status["hagglerItemDelivery_1111"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_1111"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_1111"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_1111"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: S&W Model 29."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("swmodel29", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_1111", true)

		end
	end
})


ix.progression.Register("hagglerItemDelivery_112", {
	name = "Kitting Up 1.1.2",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_112"] = ix.progression.status["hagglerItemDelivery_112"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_112"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Sterling :\n"

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

		ix.progression.status["hagglerItemDelivery_112"].complexData = ix.progression.status["hagglerItemDelivery_112"].complexData or {}
		ix.progression.status["hagglerItemDelivery_112"].complexData[item] = ix.progression.status["hagglerItemDelivery_112"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_112"].complexData[item] = ix.progression.status["hagglerItemDelivery_112"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_112"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_112"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_112"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: Sterling."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("sterling", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_112", true)
		end
	end
})

ix.progression.Register("hagglerItemDelivery_12", {
	name = "Kitting Up 1.2",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_12"] = ix.progression.status["hagglerItemDelivery_12"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_12"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks TOZ-66 :\n"

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

		ix.progression.status["hagglerItemDelivery_12"].complexData = ix.progression.status["hagglerItemDelivery_12"].complexData or {}
		ix.progression.status["hagglerItemDelivery_12"].complexData[item] = ix.progression.status["hagglerItemDelivery_12"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_12"].complexData[item] = ix.progression.status["hagglerItemDelivery_12"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_12"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_12"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_12"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: TOZ-66."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("toz66", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_12", true)
			ix.progression.SetActive("hagglerItemDelivery_121", true)
			ix.progression.SetActive("hagglerItemDelivery_1221", true)
		end
	end
})

ix.progression.Register("hagglerItemDelivery_121", {
	name = "Kitting Up 1.2.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_121"] = ix.progression.status["hagglerItemDelivery_121"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_121"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks SKS, Ruger Mini-14 :\n"

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

		ix.progression.status["hagglerItemDelivery_121"].complexData = ix.progression.status["hagglerItemDelivery_121"].complexData or {}
		ix.progression.status["hagglerItemDelivery_121"].complexData[item] = ix.progression.status["hagglerItemDelivery_121"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_121"].complexData[item] = ix.progression.status["hagglerItemDelivery_121"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_121"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_121"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_121"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: SKS, Ruger Mini-14."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("sks", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("rugermini14", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_121", true)
			ix.progression.SetActive("hagglerItemDelivery_1211", true)
		end
	end
})

ix.progression.Register("hagglerItemDelivery_1211", {
	name = "Kitting Up 1.2.1.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_1211"] = ix.progression.status["hagglerItemDelivery_1211"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_1211"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Saiga Semi :\n"

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

		ix.progression.status["hagglerItemDelivery_1211"].complexData = ix.progression.status["hagglerItemDelivery_1211"].complexData or {}
		ix.progression.status["hagglerItemDelivery_1211"].complexData[item] = ix.progression.status["hagglerItemDelivery_1211"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_1211"].complexData[item] = ix.progression.status["hagglerItemDelivery_1211"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_1211"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_1211"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_1211"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: Saiga Semi."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("saigasemi", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_1211", true)
			ix.progression.SetActive("hagglerItemDelivery_12111", true)
		end
	end
})

ix.progression.Register("hagglerItemDelivery_12111", {
	name = "Kitting Up 1.2.1.1.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_12111"] = ix.progression.status["hagglerItemDelivery_12111"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_12111"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Marlin 1894C .357 Magnum :\n"

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

		ix.progression.status["hagglerItemDelivery_12111"].complexData = ix.progression.status["hagglerItemDelivery_12111"].complexData or {}
		ix.progression.status["hagglerItemDelivery_12111"].complexData[item] = ix.progression.status["hagglerItemDelivery_12111"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_12111"].complexData[item] = ix.progression.status["hagglerItemDelivery_12111"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_12111"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_12111"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_12111"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: Marlin 1894C .357 Magnum."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("w9422357", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("357magnum", nil, 15, "SELLANDBUY", 15, 1, 15)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_12111", true)
			ix.progression.SetActive("hagglerItemDelivery_121111", true)
		end
	end
})

ix.progression.Register("hagglerItemDelivery_121111", {
	name = "Kitting Up 1.2.1.1.1.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_121111"] = ix.progression.status["hagglerItemDelivery_121111"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_121111"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks G2 Contender (.500 Magnum), .500 Magnum :\n"

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

		ix.progression.status["hagglerItemDelivery_121111"].complexData = ix.progression.status["hagglerItemDelivery_121111"].complexData or {}
		ix.progression.status["hagglerItemDelivery_121111"].complexData[item] = ix.progression.status["hagglerItemDelivery_121111"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_121111"].complexData[item] = ix.progression.status["hagglerItemDelivery_121111"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_121111"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_121111"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_121111"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: G2 Contender (.500 Magnum), .500 Magnum."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("g2500mag", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("500magnum", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_121111", true)
		end
	end
})

ix.progression.Register("hagglerItemDelivery_122", {
	name = "Kitting Up 1.2.2",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_122"] = ix.progression.status["hagglerItemDelivery_122"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_122"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Kiparis, KP31 :\n"

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

		ix.progression.status["hagglerItemDelivery_122"].complexData = ix.progression.status["hagglerItemDelivery_122"].complexData or {}
		ix.progression.status["hagglerItemDelivery_122"].complexData[item] = ix.progression.status["hagglerItemDelivery_122"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_122"].complexData[item] = ix.progression.status["hagglerItemDelivery_122"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_122"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_122"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_122"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: Kiparis, KP31."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("kiparis", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("kp31", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_122", true)
			ix.progression.SetActive("hagglerItemDelivery_1221", true)
		end
	end
})

ix.progression.Register("hagglerItemDelivery_1221", {
	name = "Kitting Up 1.2.2.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_1221"] = ix.progression.status["hagglerItemDelivery_1221"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_1221"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Mac-11 :\n"

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

		ix.progression.status["hagglerItemDelivery_1221"].complexData = ix.progression.status["hagglerItemDelivery_1221"].complexData or {}
		ix.progression.status["hagglerItemDelivery_1221"].complexData[item] = ix.progression.status["hagglerItemDelivery_1221"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_1221"].complexData[item] = ix.progression.status["hagglerItemDelivery_1221"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_1221"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_1221"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_1221"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: Mac-11."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("mac11", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_1221", true)
			ix.progression.SetActive("hagglerItemDelivery_12211", true)
		end
	end
})

ix.progression.Register("hagglerItemDelivery_12211", {
	name = "Kitting Up 1.2.2.1.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_12211"] = ix.progression.status["hagglerItemDelivery_12211"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_12211"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Colt Chicago :\n"

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

		ix.progression.status["hagglerItemDelivery_12211"].complexData = ix.progression.status["hagglerItemDelivery_12211"].complexData or {}
		ix.progression.status["hagglerItemDelivery_12211"].complexData[item] = ix.progression.status["hagglerItemDelivery_12211"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_12211"].complexData[item] = ix.progression.status["hagglerItemDelivery_12211"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_12211"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_12211"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_12211"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: Colt Chicago."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("m1911chic", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_12211", true)
		end
	end
})

ix.progression.Register("hagglerItemDelivery_2", {
	name = "Kitting Up 2",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_2"] = ix.progression.status["hagglerItemDelivery_2"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_2"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks TOZ-34 :\n"

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

		ix.progression.status["hagglerItemDelivery_2"].complexData = ix.progression.status["hagglerItemDelivery_2"].complexData or {}
		ix.progression.status["hagglerItemDelivery_2"].complexData[item] = ix.progression.status["hagglerItemDelivery_2"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_2"].complexData[item] = ix.progression.status["hagglerItemDelivery_2"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_2"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_2"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_2"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: TOZ-34."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("toz34", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_2", true)
			ix.progression.SetActive("hagglerItemDelivery_21", true) 
			ix.progression.SetActive("hagglerItemDelivery_22", true) 

		end
	end
})

ix.progression.Register("hagglerItemDelivery_21", {
	name = "Kitting Up 2.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_21"] = ix.progression.status["hagglerItemDelivery_21"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_21"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks SAKO 85 (5.56 NATO) :\n"

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

		ix.progression.status["hagglerItemDelivery_21"].complexData = ix.progression.status["hagglerItemDelivery_21"].complexData or {}
		ix.progression.status["hagglerItemDelivery_21"].complexData[item] = ix.progression.status["hagglerItemDelivery_21"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_21"].complexData[item] = ix.progression.status["hagglerItemDelivery_21"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_21"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_21"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_21"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: SAKO 85 (5.56 NATO)."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("sako85nato", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_21", true)
			ix.progression.SetActive("hagglerItemDelivery_211", true) 
			ix.progression.SetActive("hagglerItemDelivery_212", true) 

		end
	end
})

ix.progression.Register("hagglerItemDelivery_211", {
	name = "Kitting Up 2.1.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_211"] = ix.progression.status["hagglerItemDelivery_211"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_211"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Mauser C96 Carbine :\n"

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

		ix.progression.status["hagglerItemDelivery_211"].complexData = ix.progression.status["hagglerItemDelivery_211"].complexData or {}
		ix.progression.status["hagglerItemDelivery_211"].complexData[item] = ix.progression.status["hagglerItemDelivery_211"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_211"].complexData[item] = ix.progression.status["hagglerItemDelivery_211"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_211"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_211"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_211"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: Mauser C96 Carbine."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("c96carbine", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_211", true)
			ix.progression.SetActive("hagglerItemDelivery_2111", true) 
		end
	end
})

ix.progression.Register("hagglerItemDelivery_2111", {
	name = "Kitting Up 2.1.1.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_2111"] = ix.progression.status["hagglerItemDelivery_2111"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_2111"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks PPSh :\n"

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

		ix.progression.status["hagglerItemDelivery_2111"].complexData = ix.progression.status["hagglerItemDelivery_2111"].complexData or {}
		ix.progression.status["hagglerItemDelivery_2111"].complexData[item] = ix.progression.status["hagglerItemDelivery_2111"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_2111"].complexData[item] = ix.progression.status["hagglerItemDelivery_2111"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_2111"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_2111"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_2111"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: PPSh."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("ppsh", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_2111", true)

		end
	end
})

ix.progression.Register("hagglerItemDelivery_212", {
	name = "Kitting Up 2.1.2",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_212"] = ix.progression.status["hagglerItemDelivery_212"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_212"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks TOZ-194 :\n"

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

		ix.progression.status["hagglerItemDelivery_212"].complexData = ix.progression.status["hagglerItemDelivery_212"].complexData or {}
		ix.progression.status["hagglerItemDelivery_212"].complexData[item] = ix.progression.status["hagglerItemDelivery_212"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_212"].complexData[item] = ix.progression.status["hagglerItemDelivery_212"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_212"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_212"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_212"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: TOZ-194."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("toz194", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_212", true)
			ix.progression.SetActive("hagglerItemDelivery_2121", true) 
		end
	end
})

ix.progression.Register("hagglerItemDelivery_2121", {
	name = "Kitting Up 2.1.2.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_2121"] = ix.progression.status["hagglerItemDelivery_2121"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_2121"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks M1887 :\n"

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

		ix.progression.status["hagglerItemDelivery_2121"].complexData = ix.progression.status["hagglerItemDelivery_2121"].complexData or {}
		ix.progression.status["hagglerItemDelivery_2121"].complexData[item] = ix.progression.status["hagglerItemDelivery_2121"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_2121"].complexData[item] = ix.progression.status["hagglerItemDelivery_2121"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_2121"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_2121"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_2121"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: M1887."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("m1887", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_2121", true)
			ix.progression.SetActive("hagglerItemDelivery_21211", true) 
		end
	end
})

ix.progression.Register("hagglerItemDelivery_21211", {
	name = "Kitting Up 2.1.2.1.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_21211"] = ix.progression.status["hagglerItemDelivery_21211"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_21211"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Ithaca 37 :\n"

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

		ix.progression.status["hagglerItemDelivery_21211"].complexData = ix.progression.status["hagglerItemDelivery_21211"].complexData or {}
		ix.progression.status["hagglerItemDelivery_21211"].complexData[item] = ix.progression.status["hagglerItemDelivery_21211"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_21211"].complexData[item] = ix.progression.status["hagglerItemDelivery_21211"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_21211"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_21211"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_21211"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: Ithaca 37."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("ithaca37", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_21211", true)
		end
	end
})

ix.progression.Register("hagglerItemDelivery_22", {
	name = "Kitting Up 2.2",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_22"] = ix.progression.status["hagglerItemDelivery_22"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_22"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Saiga Semi (5.45x39mm), MP34 :\n"

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

		ix.progression.status["hagglerItemDelivery_22"].complexData = ix.progression.status["hagglerItemDelivery_22"].complexData or {}
		ix.progression.status["hagglerItemDelivery_22"].complexData[item] = ix.progression.status["hagglerItemDelivery_22"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_22"].complexData[item] = ix.progression.status["hagglerItemDelivery_22"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_22"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_22"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_22"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: Saiga Semi (5.45x39mm), MP34."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("saigasemi545", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("mp34", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_22", true)
			ix.progression.SetActive("hagglerItemDelivery_221", true) 
			ix.progression.SetActive("hagglerItemDelivery_222", true) 

		end
	end
})

ix.progression.Register("hagglerItemDelivery_221", {
	name = "Kitting Up 2.2.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_221"] = ix.progression.status["hagglerItemDelivery_221"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_221"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks SAKO 85, Winchester 1895 :\n"

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

		ix.progression.status["hagglerItemDelivery_221"].complexData = ix.progression.status["hagglerItemDelivery_221"].complexData or {}
		ix.progression.status["hagglerItemDelivery_221"].complexData[item] = ix.progression.status["hagglerItemDelivery_221"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_221"].complexData[item] = ix.progression.status["hagglerItemDelivery_221"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_221"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_221"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_221"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: SAKO 85, Winchester 1895."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("sako85", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("w1895", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_221", true)
			ix.progression.SetActive("hagglerItemDelivery_2211", true) 
		end
	end
})

ix.progression.Register("hagglerItemDelivery_2211", {
	name = "Kitting Up 2.2.1.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_2211"] = ix.progression.status["hagglerItemDelivery_2211"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_2211"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Mosin Nagant :\n"

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

		ix.progression.status["hagglerItemDelivery_2211"].complexData = ix.progression.status["hagglerItemDelivery_2211"].complexData or {}
		ix.progression.status["hagglerItemDelivery_2211"].complexData[item] = ix.progression.status["hagglerItemDelivery_2211"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_2211"].complexData[item] = ix.progression.status["hagglerItemDelivery_2211"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_2211"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_2211"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_2211"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: Mosin Nagant."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("mosinnagant", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_2211", true)
			ix.progression.SetActive("hagglerItemDelivery_22111", true) 
		end
	end
})

ix.progression.Register("hagglerItemDelivery_22111", {
	name = "Kitting Up 2.2.1.1.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_22111"] = ix.progression.status["hagglerItemDelivery_22111"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_22111"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks SVT40 :\n"

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

		ix.progression.status["hagglerItemDelivery_22111"].complexData = ix.progression.status["hagglerItemDelivery_22111"].complexData or {}
		ix.progression.status["hagglerItemDelivery_22111"].complexData[item] = ix.progression.status["hagglerItemDelivery_22111"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_22111"].complexData[item] = ix.progression.status["hagglerItemDelivery_22111"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_22111"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_22111"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_22111"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: SVT40."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("svt40", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_22111", true)
		end
	end
})

ix.progression.Register("hagglerItemDelivery_222", {
	name = "Kitting Up 2.2.2",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_222"] = ix.progression.status["hagglerItemDelivery_222"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_222"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks MP40 :\n"

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

		ix.progression.status["hagglerItemDelivery_222"].complexData = ix.progression.status["hagglerItemDelivery_222"].complexData or {}
		ix.progression.status["hagglerItemDelivery_222"].complexData[item] = ix.progression.status["hagglerItemDelivery_222"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_222"].complexData[item] = ix.progression.status["hagglerItemDelivery_222"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_222"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_222"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_222"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: MP40."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("mp40", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_222", true)
			ix.progression.SetActive("hagglerItemDelivery_2221", true) 
		end
	end
})

ix.progression.Register("hagglerItemDelivery_2221", {
	name = "Kitting Up 2.2.2.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_2221"] = ix.progression.status["hagglerItemDelivery_2221"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_2221"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks AKS-74u :\n"

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

		ix.progression.status["hagglerItemDelivery_2221"].complexData = ix.progression.status["hagglerItemDelivery_2221"].complexData or {}
		ix.progression.status["hagglerItemDelivery_2221"].complexData[item] = ix.progression.status["hagglerItemDelivery_2221"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_2221"].complexData[item] = ix.progression.status["hagglerItemDelivery_2221"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_2221"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_2221"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_2221"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: AKS-74u."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("aks74u", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_2221", true)
			ix.progression.SetActive("hagglerItemDelivery_22211", true) 
		end
	end
})

ix.progression.Register("hagglerItemDelivery_22211", {
	name = "Kitting Up 2.2.2.1.1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Haggler'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["hagglerItemDelivery_22211"] = ix.progression.status["hagglerItemDelivery_22211"] or {}
		local dat = ix.progression.status["hagglerItemDelivery_22211"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks AKM :\n"

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

		ix.progression.status["hagglerItemDelivery_22211"].complexData = ix.progression.status["hagglerItemDelivery_22211"].complexData or {}
		ix.progression.status["hagglerItemDelivery_22211"].complexData[item] = ix.progression.status["hagglerItemDelivery_22211"].complexData[item] or 0
		ix.progression.status["hagglerItemDelivery_22211"].complexData[item] = ix.progression.status["hagglerItemDelivery_22211"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["hagglerItemDelivery_22211"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["hagglerItemDelivery_22211"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["hagglerItemDelivery_22211"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Haggler'"
				local message = "Now available in my shop: AKM."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Haggler'")
			if (npc) then
				npc:AddItemToList("akm", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("hagglerItemDelivery_22211", true)
			ix.progression.SetActive("hagglerItemDelivery_222111", true) 
		end
	end
})