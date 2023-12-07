ix.progression.Register("eggheadItemDelivery_Detector1", {
	name = "Detecting Anomalous Materials Part 1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Egghead'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["eggheadItemDelivery_Detector1"] = ix.progression.status["eggheadItemDelivery_Detector1"] or {}
		local dat = ix.progression.status["eggheadItemDelivery_Detector1"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Echo Detector:\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_bolt"] = 20,
			["artifact_bonecluster"] = 20,
			["artifact_mementomori"] = 20,
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

		ix.progression.status["eggheadItemDelivery_Detector1"].complexData = ix.progression.status["eggheadItemDelivery_Detector1"].complexData or {}
		ix.progression.status["eggheadItemDelivery_Detector1"].complexData[item] = ix.progression.status["eggheadItemDelivery_Detector1"].complexData[item] or 0
		ix.progression.status["eggheadItemDelivery_Detector1"].complexData[item] = ix.progression.status["eggheadItemDelivery_Detector1"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["eggheadItemDelivery_Detector1"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["eggheadItemDelivery_Detector1"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["eggheadItemDelivery_Detector1"].finished) do
			ix.progression.status["eggheadItemDelivery_Detector1"].complexData[item] = ix.progression.status["eggheadItemDelivery_Detector1"].complexData[item] or 0
			if amt > ix.progression.status["eggheadItemDelivery_Detector1"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Egghead'"
				local message = "I've had a breakthrough! It is now possible to detect anomalous substances, come by and pick up a detector!"
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Egghead'")
			if (npc) then
				npc:AddItemToList("detectorecho", nil, 10, "SELLANDBUY", 10, 1, 10)
			end


			ix.progression.SetCompleted("eggheadItemDelivery_Detector1", true)

			ix.progression.SetActive("eggheadItemDelivery_Detector2", true) 
			ix.progression.SetActive("eggheadItemDelivery_Suit1", true) 
			ix.progression.SetActive("eggheadItemDelivery_Aid1", true) 
		end
	end
})

ix.progression.Register("eggheadItemDelivery_Detector2", {
	name = "Detecting Anomalous Materials Part 2",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Egghead'",
	BuildResponse = function(self, status)
		ix.progression.status["eggheadItemDelivery_Detector2"] = ix.progression.status["eggheadItemDelivery_Detector2"] or {}
		local dat = ix.progression.status["eggheadItemDelivery_Detector2"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Bear Detector:\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_crystal"] = 10,
			["artifact_mamasbeads"] = 10,
			["artifact_capacitor"] = 5,
			["artifact_panacea"] = 5,
			["artifact_moonlight"] = 2,
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

		ix.progression.status["eggheadItemDelivery_Detector2"].complexData = ix.progression.status["eggheadItemDelivery_Detector2"].complexData or {}
		ix.progression.status["eggheadItemDelivery_Detector2"].complexData[item] = ix.progression.status["eggheadItemDelivery_Detector2"].complexData[item] or 0
		ix.progression.status["eggheadItemDelivery_Detector2"].complexData[item] = ix.progression.status["eggheadItemDelivery_Detector2"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["eggheadItemDelivery_Detector2"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["eggheadItemDelivery_Detector2"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["eggheadItemDelivery_Detector2"].finished) do
			ix.progression.status["eggheadItemDelivery_Detector2"].complexData[item] = ix.progression.status["eggheadItemDelivery_Detector2"].complexData[item] or 0
			if amt > ix.progression.status["eggheadItemDelivery_Detector2"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Egghead'"
				local message = "Thanks to your dilligence, I was able to improve on the design of the detectors, allowing one to more accurately pinpoint the location. Oh, and the new detectors are of course for sale."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Egghead'")
			if (npc) then
				npc:AddItemToList("detectorbear", nil, 10, "SELLANDBUY", 10, 1, 10)
			end


			ix.progression.SetCompleted("eggheadItemDelivery_Detector2", true)

			ix.progression.SetActive("eggheadItemDelivery_Detector3", true) 
		end
	end
})

ix.progression.Register("eggheadItemDelivery_Detector3", {
	name = "Detecting Anomalous Materials Part 3",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Egghead'",
	BuildResponse = function(self, status)
		ix.progression.status["eggheadItemDelivery_Detector3"] = ix.progression.status["eggheadItemDelivery_Detector3"] or {}
		local dat = ix.progression.status["eggheadItemDelivery_Detector3"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Veles Detector:\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["artifact_gmamasbeads"] = 8,
			["artifact_galaxy"] = 5,
			["artifact_arachno"] = 5,
			["artifact_halo"] = 5,
			["artifact_gaia"] = 3,
			["artifact_midas"] = 1,
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

		ix.progression.status["eggheadItemDelivery_Detector3"].complexData = ix.progression.status["eggheadItemDelivery_Detector3"].complexData or {}
		ix.progression.status["eggheadItemDelivery_Detector3"].complexData[item] = ix.progression.status["eggheadItemDelivery_Detector3"].complexData[item] or 0
		ix.progression.status["eggheadItemDelivery_Detector3"].complexData[item] = ix.progression.status["eggheadItemDelivery_Detector3"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["eggheadItemDelivery_Detector3"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["eggheadItemDelivery_Detector3"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["eggheadItemDelivery_Detector3"].finished) do
			ix.progression.status["eggheadItemDelivery_Detector3"].complexData[item] = ix.progression.status["eggheadItemDelivery_Detector3"].complexData[item] or 0
			if amt > ix.progression.status["eggheadItemDelivery_Detector3"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Egghead'"
				local message = "I was able to improve on the design of the detectors, allowing one to more precisely pinpoint the location."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Egghead'")
			if (npc) then
				npc:AddItemToList("detectorveles", nil, 10, "SELLANDBUY", 10, 1, 10)
			end

			ix.progression.SetCompleted("eggheadItemDelivery_Detector3", true)
		end
	end
})

ix.progression.Register("eggheadItemDelivery_Suit1", {
	name = "Anomalous Protection Part 1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Egghead'",
	BuildResponse = function(self, status)
		ix.progression.status["eggheadItemDelivery_Suit1"] = ix.progression.status["eggheadItemDelivery_Suit1"] or {}
		local dat = ix.progression.status["eggheadItemDelivery_Suit1"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks SSP99:\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["hide_pseudodog"] = 5,
			["hide_cat"] = 10,
			["hide_blinddog"] = 10,
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

		ix.progression.status["eggheadItemDelivery_Suit1"].complexData = ix.progression.status["eggheadItemDelivery_Suit1"].complexData or {}
		ix.progression.status["eggheadItemDelivery_Suit1"].complexData[item] = ix.progression.status["eggheadItemDelivery_Suit1"].complexData[item] or 0
		ix.progression.status["eggheadItemDelivery_Suit1"].complexData[item] = ix.progression.status["eggheadItemDelivery_Suit1"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["eggheadItemDelivery_Suit1"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["eggheadItemDelivery_Suit1"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["eggheadItemDelivery_Suit1"].finished) do
			ix.progression.status["eggheadItemDelivery_Suit1"].complexData[item] = ix.progression.status["eggheadItemDelivery_Suit1"].complexData[item] or 0
			if amt > ix.progression.status["eggheadItemDelivery_Suit1"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Egghead'"
				local message = "## PLACEHOLDER ## - SSP99 unlocked."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Egghead'")
			if (npc) then
				npc:AddItemToList("ssp99", nil, 10, "SELLANDBUY", 10, 1, 10)
			end

			ix.progression.SetCompleted("eggheadItemDelivery_Suit1", true)

			ix.progression.SetActive("eggheadItemDelivery_Suit2", true) 
		end
	end
})

ix.progression.Register("eggheadItemDelivery_Suit2", {
	name = "Anomalous Protection Part 2",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Egghead'",
	BuildResponse = function(self, status)
		ix.progression.status["eggheadItemDelivery_Suit2"] = ix.progression.status["eggheadItemDelivery_Suit2"] or {}
		local dat = ix.progression.status["eggheadItemDelivery_Suit2"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks SSP99m:\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["hide_bloodsucker"] = 5,
			["hide_vareshka"] = 5,
			["hide_chimera"] = 5,
			["hide_controller"] = 5,
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

		ix.progression.status["eggheadItemDelivery_Suit2"].complexData = ix.progression.status["eggheadItemDelivery_Suit2"].complexData or {}
		ix.progression.status["eggheadItemDelivery_Suit2"].complexData[item] = ix.progression.status["eggheadItemDelivery_Suit2"].complexData[item] or 0
		ix.progression.status["eggheadItemDelivery_Suit2"].complexData[item] = ix.progression.status["eggheadItemDelivery_Suit2"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["eggheadItemDelivery_Suit2"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["eggheadItemDelivery_Suit2"]:GetItemIds()

		local isdone = true
		
		for item, amt in pairs(ix.progression.status["eggheadItemDelivery_Suit2"].finished) do
			ix.progression.status["eggheadItemDelivery_Suit2"].complexData[item] = ix.progression.status["eggheadItemDelivery_Suit2"].complexData[item] or 0
			if amt > ix.progression.status["eggheadItemDelivery_Suit2"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Egghead'"
				local message = "## PLACEHOLDER ## - SSP99m unlocked."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Egghead'")
			if (npc) then
				npc:AddItemToList("ssp99m", nil, 10, "SELLANDBUY", 10, 1, 10)
			end

			ix.progression.SetCompleted("eggheadItemDelivery_Suit2", true)

			ix.progression.SetActive("eggheadItemDelivery_Suit3", true) 
		end
	end
})

ix.progression.Register("eggheadItemDelivery_Suit3", {
	name = "Anomalous Protection Part 3",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Egghead'",
	BuildResponse = function(self, status)
		ix.progression.status["eggheadItemDelivery_Suit3"] = ix.progression.status["eggheadItemDelivery_Suit3"] or {}
		local dat = ix.progression.status["eggheadItemDelivery_Suit3"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks SEVA:\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["hide_pseudogiant"] = 5,
			["hide_electrocontroller"] = 5,
			["hide_karlik"] = 10,
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

		ix.progression.status["eggheadItemDelivery_Suit3"].complexData = ix.progression.status["eggheadItemDelivery_Suit3"].complexData or {}
		ix.progression.status["eggheadItemDelivery_Suit3"].complexData[item] = ix.progression.status["eggheadItemDelivery_Suit3"].complexData[item] or 0
		ix.progression.status["eggheadItemDelivery_Suit3"].complexData[item] = ix.progression.status["eggheadItemDelivery_Suit3"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["eggheadItemDelivery_Suit3"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["eggheadItemDelivery_Suit3"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["eggheadItemDelivery_Suit3"].finished) do
			ix.progression.status["eggheadItemDelivery_Suit3"].complexData[item] = ix.progression.status["eggheadItemDelivery_Suit3"].complexData[item] or 0
			if amt > ix.progression.status["eggheadItemDelivery_Suit3"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Egghead'"
				local message = "## PLACEHOLDER ## - SEVA unlocked."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Egghead'")
			if (npc) then
				npc:AddItemToList("seva", nil, 10, "SELLANDBUY", 10, 1, 10)
			end

			ix.progression.SetCompleted("eggheadItemDelivery_Suit3", true)
		end
	end
})

ix.progression.Register("eggheadItemDelivery_Aid1", {
	name = "Scientific Aid Part 1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Egghead'",
	BuildResponse = function(self, status)
		ix.progression.status["eggheadItemDelivery_Aid1"] = ix.progression.status["eggheadItemDelivery_Aid1"] or {}
		local dat = ix.progression.status["eggheadItemDelivery_Aid1"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Stimpak MkI, Antiradiation Drugs, Psyheal Drugs:\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["part_swampcontroller_2"] = 10,
			["part_tark"] = 15,
			["part_sprig"] = 15,
			["part_spider"] = 20,
			["part_snork_2"] = 20,
			["part_cat"] = 20,
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

		ix.progression.status["eggheadItemDelivery_Aid1"].complexData = ix.progression.status["eggheadItemDelivery_Aid1"].complexData or {}
		ix.progression.status["eggheadItemDelivery_Aid1"].complexData[item] = ix.progression.status["eggheadItemDelivery_Aid1"].complexData[item] or 0
		ix.progression.status["eggheadItemDelivery_Aid1"].complexData[item] = ix.progression.status["eggheadItemDelivery_Aid1"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["eggheadItemDelivery_Aid1"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["eggheadItemDelivery_Aid1"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["eggheadItemDelivery_Aid1"].finished) do
			ix.progression.status["eggheadItemDelivery_Aid1"].complexData[item] = ix.progression.status["eggheadItemDelivery_Aid1"].complexData[item] or 0
			if amt > ix.progression.status["eggheadItemDelivery_Aid1"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Egghead'"
				local message = "## PLACEHOLDER ## - Stimpak MkI, Antiradiation Drugs, Psyheal Drugs unlocked."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Egghead'")
			if (npc) then
				npc:AddItemToList("medic_stimpak_1", nil, 10, "SELLANDBUY", 10, 1, 10)
				npc:AddItemToList("medic_antirad_2", nil, 10, "SELLANDBUY", 10, 1, 10)
				npc:AddItemToList("medic_psyheal_2", nil, 10, "SELLANDBUY", 10, 1, 10)
			end

			ix.progression.SetCompleted("eggheadItemDelivery_Aid1", true)

			ix.progression.SetActive("eggheadItemDelivery_Aid2", true) 
		end
	end
})

ix.progression.Register("eggheadItemDelivery_Aid2", {
	name = "Scientific Aid Part 2",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Egghead'",
	BuildResponse = function(self, status)
		ix.progression.status["eggheadItemDelivery_Aid2"] = ix.progression.status["eggheadItemDelivery_Aid2"] or {}
		local dat = ix.progression.status["eggheadItemDelivery_Aid2"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Stimpak MkII, Psyblock Drugs:\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["part_controller_2"] = 15,
			["part_vareshka"] = 20,
			["part_skeleton"] = 20,
			["part_karlik_2"] = 20,
			["part_burer_2"] = 20,
			["part_pseudodog"] = 40,
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

		ix.progression.status["eggheadItemDelivery_Aid2"].complexData = ix.progression.status["eggheadItemDelivery_Aid2"].complexData or {}
		ix.progression.status["eggheadItemDelivery_Aid2"].complexData[item] = ix.progression.status["eggheadItemDelivery_Aid2"].complexData[item] or 0
		ix.progression.status["eggheadItemDelivery_Aid2"].complexData[item] = ix.progression.status["eggheadItemDelivery_Aid2"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["eggheadItemDelivery_Aid2"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["eggheadItemDelivery_Aid2"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["eggheadItemDelivery_Aid2"].finished) do
			ix.progression.status["eggheadItemDelivery_Aid2"].complexData[item] = ix.progression.status["eggheadItemDelivery_Aid2"].complexData[item] or 0
			if amt > ix.progression.status["eggheadItemDelivery_Aid2"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Egghead'"
				local message = "## PLACEHOLDER ## - Stimpak MkII, Psyblock Drugs unlocked."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Egghead'")
			if (npc) then
				npc:AddItemToList("medic_stimpak_2", nil, 10, "SELLANDBUY", 10, 1, 10)
				npc:AddItemToList("medic_antipsychotic_2", nil, 10, "SELLANDBUY", 10, 1, 10)
			end

			ix.progression.SetCompleted("eggheadItemDelivery_Aid2", true)

			ix.progression.SetActive("eggheadItemDelivery_Aid3", true) 
		end
	end
})

ix.progression.Register("eggheadItemDelivery_Aid3", {
	name = "Scientific Aid Part 3",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Egghead'",
	BuildResponse = function(self, status)
		ix.progression.status["eggheadItemDelivery_Aid3"] = ix.progression.status["eggheadItemDelivery_Aid3"] or {}
		local dat = ix.progression.status["eggheadItemDelivery_Aid3"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Stimpak MkIII, Psyblock Drugs:\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["part_pseudogiant"] = 20,
			["part_electrocontroller_2"] = 15,
			["part_chimera"] = 40,
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

		ix.progression.status["eggheadItemDelivery_Aid3"].complexData = ix.progression.status["eggheadItemDelivery_Aid3"].complexData or {}
		ix.progression.status["eggheadItemDelivery_Aid3"].complexData[item] = ix.progression.status["eggheadItemDelivery_Aid3"].complexData[item] or 0
		ix.progression.status["eggheadItemDelivery_Aid3"].complexData[item] = ix.progression.status["eggheadItemDelivery_Aid3"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["eggheadItemDelivery_Aid3"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["eggheadItemDelivery_Aid3"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["eggheadItemDelivery_Aid3"].finished) do
			ix.progression.status["eggheadItemDelivery_Aid3"].complexData[item] = ix.progression.status["eggheadItemDelivery_Aid3"].complexData[item] or 0
			if amt > ix.progression.status["eggheadItemDelivery_Aid3"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Egghead'"
				local message = "## PLACEHOLDER ## - Stimpak MkIII, Psyblock Drugs unlocked."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Egghead'")
			if (npc) then
				npc:AddItemToList("medic_stimpak_3", nil, 10, "SELLANDBUY", 10, 1, 10)
				npc:AddItemToList("medic_antipsychotic_3", nil, 10, "SELLANDBUY", 10, 1, 10)
			end

			ix.progression.SetCompleted("eggheadItemDelivery_Aid3", true)
		end
	end
})