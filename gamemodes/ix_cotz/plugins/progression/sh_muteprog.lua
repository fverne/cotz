ix.progression.Register("muteItemDelivery_Binoc1", {
	name = "Looking ahead 1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Mute'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["muteItemDelivery_Binoc1"] = ix.progression.status["muteItemDelivery_Binoc1"] or {}
		local dat = ix.progression.status["muteItemDelivery_Binoc1"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Binoculars_2:\n"

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

		ix.progression.status["muteItemDelivery_Binoc1"].complexData = ix.progression.status["muteItemDelivery_Binoc1"].complexData or {}
		ix.progression.status["muteItemDelivery_Binoc1"].complexData[item] = ix.progression.status["muteItemDelivery_Binoc1"].complexData[item] or 0
		ix.progression.status["muteItemDelivery_Binoc1"].complexData[item] = ix.progression.status["muteItemDelivery_Binoc1"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["muteItemDelivery_Binoc1"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["muteItemDelivery_Binoc1"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["muteItemDelivery_Binoc1"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Mute'"
				local message = "Now available in my shop: Binoculars_2."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Mute'")
			if (npc) then
				npc:AddItemToList("binoculars_2", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("muteItemDelivery_Binoc1", true)
			ix.progression.SetActive("muteItemDelivery_Binoc2", true) 

		end
	end
})

ix.progression.Register("muteItemDelivery_Binoc2", {
	name = "Looking ahead 2",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Mute'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["muteItemDelivery_Binoc2"] = ix.progression.status["muteItemDelivery_Binoc2"] or {}
		local dat = ix.progression.status["muteItemDelivery_Binoc2"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Binoculars_1:\n"

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

		ix.progression.status["muteItemDelivery_Binoc2"].complexData = ix.progression.status["muteItemDelivery_Binoc2"].complexData or {}
		ix.progression.status["muteItemDelivery_Binoc2"].complexData[item] = ix.progression.status["muteItemDelivery_Binoc2"].complexData[item] or 0
		ix.progression.status["muteItemDelivery_Binoc2"].complexData[item] = ix.progression.status["muteItemDelivery_Binoc2"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["muteItemDelivery_Binoc2"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["muteItemDelivery_Binoc2"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["muteItemDelivery_Binoc2"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Mute'"
				local message = "Now available in my shop: Binoculars_1."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Mute'")
			if (npc) then
				npc:AddItemToList("binoculars_1", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("muteItemDelivery_Binoc2", true)
			ix.progression.SetActive("muteItemDelivery_Binoc3", true) 

		end
	end
})


ix.progression.Register("muteItemDelivery_Binoc3", {
	name = "Looking ahead 3",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Mute'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["muteItemDelivery_Binoc3"] = ix.progression.status["muteItemDelivery_Binoc3"] or {}
		local dat = ix.progression.status["muteItemDelivery_Binoc3"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Binoculars_4:\n"

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

		ix.progression.status["muteItemDelivery_Binoc3"].complexData = ix.progression.status["muteItemDelivery_Binoc3"].complexData or {}
		ix.progression.status["muteItemDelivery_Binoc3"].complexData[item] = ix.progression.status["muteItemDelivery_Binoc3"].complexData[item] or 0
		ix.progression.status["muteItemDelivery_Binoc3"].complexData[item] = ix.progression.status["muteItemDelivery_Binoc3"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["muteItemDelivery_Binoc3"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["muteItemDelivery_Binoc3"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["muteItemDelivery_Binoc3"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Mute'"
				local message = "Now available in my shop: Binoculars_4."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Mute'")
			if (npc) then
				npc:AddItemToList("binoculars_4", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("muteItemDelivery_Binoc3", true)
			ix.progression.SetActive("muteItemDelivery_Binoc4", true) 

		end
	end
})



ix.progression.Register("muteItemDelivery_Binoc4", {
	name = "Looking ahead 4",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Mute'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["muteItemDelivery_Binoc4"] = ix.progression.status["muteItemDelivery_Binoc4"] or {}
		local dat = ix.progression.status["muteItemDelivery_Binoc4"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Binoculars_3:\n"

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

		ix.progression.status["muteItemDelivery_Binoc4"].complexData = ix.progression.status["muteItemDelivery_Binoc4"].complexData or {}
		ix.progression.status["muteItemDelivery_Binoc4"].complexData[item] = ix.progression.status["muteItemDelivery_Binoc4"].complexData[item] or 0
		ix.progression.status["muteItemDelivery_Binoc4"].complexData[item] = ix.progression.status["muteItemDelivery_Binoc4"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["muteItemDelivery_Binoc4"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["muteItemDelivery_Binoc4"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["muteItemDelivery_Binoc4"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Mute'"
				local message = "Now available in my shop: Binoculars_3."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Mute'")
			if (npc) then
				npc:AddItemToList("binoculars_3", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("muteItemDelivery_Binoc4", true)

		end
	end
})




ix.progression.Register("muteItemDelivery_Anomaly", {
	name = "Anomaly Detector",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Mute'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["muteItemDelivery_Anomaly"] = ix.progression.status["muteItemDelivery_Anomaly"] or {}
		local dat = ix.progression.status["muteItemDelivery_Anomaly"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Anomaly Detector:\n"

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

		ix.progression.status["muteItemDelivery_Anomaly"].complexData = ix.progression.status["muteItemDelivery_Anomaly"].complexData or {}
		ix.progression.status["muteItemDelivery_Anomaly"].complexData[item] = ix.progression.status["muteItemDelivery_Anomaly"].complexData[item] or 0
		ix.progression.status["muteItemDelivery_Anomaly"].complexData[item] = ix.progression.status["muteItemDelivery_Anomaly"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["muteItemDelivery_Anomaly"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["muteItemDelivery_Anomaly"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["muteItemDelivery_Anomaly"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Mute'"
				local message = "Now available in my shop: Anomaly Detector."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Mute'")
			if (npc) then
				npc:AddItemToList("anomalydecector", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("muteItemDelivery_Anomaly", true)

		end
	end
})




ix.progression.Register("muteItemDelivery_Broadcast", {
	name = "Keeping tabs",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Mute'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["muteItemDelivery_Broadcast"] = ix.progression.status["muteItemDelivery_Broadcast"] or {}
		local dat = ix.progression.status["muteItemDelivery_Broadcast"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Mutant pda broadcasts:\n"

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

		ix.progression.status["muteItemDelivery_Broadcast"].complexData = ix.progression.status["muteItemDelivery_Broadcast"].complexData or {}
		ix.progression.status["muteItemDelivery_Broadcast"].complexData[item] = ix.progression.status["muteItemDelivery_Broadcast"].complexData[item] or 0
		ix.progression.status["muteItemDelivery_Broadcast"].complexData[item] = ix.progression.status["muteItemDelivery_Broadcast"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["muteItemDelivery_Broadcast"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["muteItemDelivery_Broadcast"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["muteItemDelivery_Broadcast"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Mute'"
				local message = "Now available: Mutant PDA Broadcasts."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			-- local npc = ix.progression.GetNPCFromName("'Mute'")
			-- if (npc) then
			-- 	npc:AddItemToList("anomalydecector", nil, 5, "SELLANDBUY", 5, 1, 5)
			-- end

			ix.progression.SetCompleted("muteItemDelivery_Broadcast", true)

		end
	end
})

