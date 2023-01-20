----------
-- Medical
----------

ix.progression.Register("spicylemonItemDelivery_Medical1", {
	name = "Medical Imports 1",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Spicy Lemon'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["spicylemonItemDelivery_Medical1"] = ix.progression.status["spicylemonItemDelivery_Medical1"] or {}
		local dat = ix.progression.status["spicylemonItemDelivery_Medical1"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Mints:\n"

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

		ix.progression.status["spicylemonItemDelivery_Medical1"].complexData = ix.progression.status["spicylemonItemDelivery_Medical1"].complexData or {}
		ix.progression.status["spicylemonItemDelivery_Medical1"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Medical1"].complexData[item] or 0
		ix.progression.status["spicylemonItemDelivery_Medical1"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Medical1"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["spicylemonItemDelivery_Medical1"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["spicylemonItemDelivery_Medical1"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["spicylemonItemDelivery_Medical1"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Spicy Lemon'"
				local message = "Now available in my shop: Mints."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Spicy Lemon'")
			if (npc) then
				npc:AddItemToList("drug_mints", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("spicylemonItemDelivery_Medical1", true)
			ix.progression.SetActive("spicylemonItemDelivery_Medical2", true) 

		end
	end
})

ix.progression.Register("spicylemonItemDelivery_Medical2", {
	name = "Medical Imports 2",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["spicylemonItemDelivery_Medical2"] = ix.progression.status["spicylemonItemDelivery_Medical2"] or {}
		local dat = ix.progression.status["spicylemonItemDelivery_Medical2"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Caffeine:\n"

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

		ix.progression.status["spicylemonItemDelivery_Medical2"].complexData = ix.progression.status["spicylemonItemDelivery_Medical2"].complexData or {}
		ix.progression.status["spicylemonItemDelivery_Medical2"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Medical2"].complexData[item] or 0
		ix.progression.status["spicylemonItemDelivery_Medical2"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Medical2"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["spicylemonItemDelivery_Medical2"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["spicylemonItemDelivery_Medical2"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["spicylemonItemDelivery_Medical2"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Spicy Lemon'"
				local message = "Now available in my shop: Caffeine."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Spicy Lemon'")
			if (npc) then
				npc:AddItemToList("drug_caffeine", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("spicylemonItemDelivery_Medical2", true)
			ix.progression.SetActive("spicylemonItemDelivery_Medical3", true) 

		end
	end
})


ix.progression.Register("spicylemonItemDelivery_Medical3", {
	name = "Medical Imports 3",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["spicylemonItemDelivery_Medical3"] = ix.progression.status["spicylemonItemDelivery_Medical3"] or {}
		local dat = ix.progression.status["spicylemonItemDelivery_Medical3"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Modafine Tablets:\n"

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

		ix.progression.status["spicylemonItemDelivery_Medical3"].complexData = ix.progression.status["spicylemonItemDelivery_Medical3"].complexData or {}
		ix.progression.status["spicylemonItemDelivery_Medical3"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Medical3"].complexData[item] or 0
		ix.progression.status["spicylemonItemDelivery_Medical3"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Medical3"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["spicylemonItemDelivery_Medical3"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["spicylemonItemDelivery_Medical3"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["spicylemonItemDelivery_Medical3"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Spicy Lemon'"
				local message = "Now available in my shop: Modafine Tablets."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Spicy Lemon'")
			if (npc) then
				npc:AddItemToList("medic_psyheal_1", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("spicylemonItemDelivery_Medical3", true)
			ix.progression.SetActive("spicylemonItemDelivery_Medical4", true) 

		end
	end
})


ix.progression.Register("spicylemonItemDelivery_Medical4", {
	name = "Medical Imports 4",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["spicylemonItemDelivery_Medical4"] = ix.progression.status["spicylemonItemDelivery_Medical4"] or {}
		local dat = ix.progression.status["spicylemonItemDelivery_Medical4"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Asenapine Tablets:\n"

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

		ix.progression.status["spicylemonItemDelivery_Medical4"].complexData = ix.progression.status["spicylemonItemDelivery_Medical4"].complexData or {}
		ix.progression.status["spicylemonItemDelivery_Medical4"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Medical4"].complexData[item] or 0
		ix.progression.status["spicylemonItemDelivery_Medical4"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Medical4"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["spicylemonItemDelivery_Medical4"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["spicylemonItemDelivery_Medical4"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["spicylemonItemDelivery_Medical4"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Spicy Lemon'"
				local message = "Now available in my shop: Asenapine Tablets."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Spicy Lemon'")
			if (npc) then
				npc:AddItemToList("medic_antipsychotic_1", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("spicylemonItemDelivery_Medical4", true)
			ix.progression.SetActive("spicylemonItemDelivery_Medical5", true) 

		end
	end
})



ix.progression.Register("spicylemonItemDelivery_Medical5", {
	name = "Medical Imports 5",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["spicylemonItemDelivery_Medical5"] = ix.progression.status["spicylemonItemDelivery_Medical5"] or {}
		local dat = ix.progression.status["spicylemonItemDelivery_Medical5"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Codeine Tablets:\n"

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

		ix.progression.status["spicylemonItemDelivery_Medical5"].complexData = ix.progression.status["spicylemonItemDelivery_Medical5"].complexData or {}
		ix.progression.status["spicylemonItemDelivery_Medical5"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Medical5"].complexData[item] or 0
		ix.progression.status["spicylemonItemDelivery_Medical5"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Medical5"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["spicylemonItemDelivery_Medical5"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["spicylemonItemDelivery_Medical5"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["spicylemonItemDelivery_Medical5"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Spicy Lemon'"
				local message = "Now available in my shop: Codeine Tablets."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Spicy Lemon'")
			if (npc) then
				npc:AddItemToList("drug_painkillers", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("spicylemonItemDelivery_Medical5", true)
			ix.progression.SetActive("spicylemonItemDelivery_Medical6", true) 

		end
	end
})



ix.progression.Register("spicylemonItemDelivery_Medical6", {
	name = "Medical Imports 6",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["spicylemonItemDelivery_Medical6"] = ix.progression.status["spicylemonItemDelivery_Medical6"] or {}
		local dat = ix.progression.status["spicylemonItemDelivery_Medical6"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Adrenaline Injector:\n"

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

		ix.progression.status["spicylemonItemDelivery_Medical6"].complexData = ix.progression.status["spicylemonItemDelivery_Medical6"].complexData or {}
		ix.progression.status["spicylemonItemDelivery_Medical6"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Medical6"].complexData[item] or 0
		ix.progression.status["spicylemonItemDelivery_Medical6"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Medical6"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["spicylemonItemDelivery_Medical6"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["spicylemonItemDelivery_Medical6"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["spicylemonItemDelivery_Medical6"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Spicy Lemon'"
				local message = "Now available in my shop: Adrenaline Injector."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Spicy Lemon'")
			if (npc) then
				npc:AddItemToList("drug_adrenaline", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("spicylemonItemDelivery_Medical6", true)
			ix.progression.SetActive("spicylemonItemDelivery_Medical7", true) 

		end
	end
})


ix.progression.Register("spicylemonItemDelivery_Medical7", {
	name = "Medical Imports 7",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	BuildResponse = function(self, status)
		ix.progression.status["spicylemonItemDelivery_Medical7"] = ix.progression.status["spicylemonItemDelivery_Medical7"] or {}
		local dat = ix.progression.status["spicylemonItemDelivery_Medical7"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Morphine Injector:\n"

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

		ix.progression.status["spicylemonItemDelivery_Medical7"].complexData = ix.progression.status["spicylemonItemDelivery_Medical7"].complexData or {}
		ix.progression.status["spicylemonItemDelivery_Medical7"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Medical7"].complexData[item] or 0
		ix.progression.status["spicylemonItemDelivery_Medical7"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Medical7"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["spicylemonItemDelivery_Medical7"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["spicylemonItemDelivery_Medical7"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["spicylemonItemDelivery_Medical7"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Spicy Lemon'"
				local message = "Now available in my shop: Morphine Injector."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Spicy Lemon'")
			if (npc) then
				npc:AddItemToList("drug_morphine", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("spicylemonItemDelivery_Medical7", true)

		end
	end
})


-------------------
-- Food and Alcohol
-------------------

ix.progression.Register("spicylemonItemDelivery_Food", {
	name = "Food for the poor",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Spicy Lemon'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["spicylemonItemDelivery_Food"] = ix.progression.status["spicylemonItemDelivery_Food"] or {}
		local dat = ix.progression.status["spicylemonItemDelivery_Food"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks Basic food and drinks:\n"

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

		ix.progression.status["spicylemonItemDelivery_Food"].complexData = ix.progression.status["spicylemonItemDelivery_Food"].complexData or {}
		ix.progression.status["spicylemonItemDelivery_Food"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Food"].complexData[item] or 0
		ix.progression.status["spicylemonItemDelivery_Food"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Food"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["spicylemonItemDelivery_Food"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["spicylemonItemDelivery_Food"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["spicylemonItemDelivery_Food"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Spicy Lemon'"
				local message = "Now available in my shop: Basic food and drinks."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Spicy Lemon'")
			if (npc) then
				npc:AddItemToList("drink_bottlebeer_6", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("drink_canwater", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("drink_energydrink_4", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("drink_energydrink_2", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("food_cheese_2", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("food_nuts_2", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("food_can_tomato", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("food_can_tushonka", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("spicylemonItemDelivery_Food", true)
			ix.progression.SetActive("spicylemonItemDelivery_Vodka", true) 

		end
	end
})


ix.progression.Register("spicylemonItemDelivery_Vodka", {
	name = "Drinks for the poor",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Spicy Lemon'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["spicylemonItemDelivery_Vodka"] = ix.progression.status["spicylemonItemDelivery_Vodka"] or {}
		local dat = ix.progression.status["spicylemonItemDelivery_Vodka"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks a variety of vodka brands:\n"

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

		ix.progression.status["spicylemonItemDelivery_Vodka"].complexData = ix.progression.status["spicylemonItemDelivery_Vodka"].complexData or {}
		ix.progression.status["spicylemonItemDelivery_Vodka"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Vodka"].complexData[item] or 0
		ix.progression.status["spicylemonItemDelivery_Vodka"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Vodka"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["spicylemonItemDelivery_Vodka"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["spicylemonItemDelivery_Vodka"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["spicylemonItemDelivery_Vodka"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Spicy Lemon'"
				local message = "Now available in my shop: a variety of vodka brands."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Spicy Lemon'")
			if (npc) then
				npc:AddItemToList("drink_vodka_4", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("drink_vodka_5", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("drink_vodka_6", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("spicylemonItemDelivery_Vodka", true)
			ix.progression.SetActive("spicylemonItemDelivery_Spirits", true) 

		end
	end
})


ix.progression.Register("spicylemonItemDelivery_Spirits", {
	name = "Drinks for the rich",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Spicy Lemon'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["spicylemonItemDelivery_Spirits"] = ix.progression.status["spicylemonItemDelivery_Spirits"] or {}
		local dat = ix.progression.status["spicylemonItemDelivery_Spirits"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks a variety of spirits:\n"

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

		ix.progression.status["spicylemonItemDelivery_Spirits"].complexData = ix.progression.status["spicylemonItemDelivery_Spirits"].complexData or {}
		ix.progression.status["spicylemonItemDelivery_Spirits"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Spirits"].complexData[item] or 0
		ix.progression.status["spicylemonItemDelivery_Spirits"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Spirits"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["spicylemonItemDelivery_Spirits"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["spicylemonItemDelivery_Spirits"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["spicylemonItemDelivery_Spirits"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Spicy Lemon'"
				local message = "Now available in my shop: a variety of spirits."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Spicy Lemon'")
			if (npc) then
				npc:AddItemToList("drink_spirit_1", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("drink_spirit_2", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("drink_spirit_3", nil, 5, "SELLANDBUY", 5, 1, 5)
                npc:AddItemToList("drink_wine", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("spicylemonItemDelivery_Spirits", true)
			ix.progression.SetActive("spicylemonItemDelivery_Brew", true) 

		end
	end
})



ix.progression.Register("spicylemonItemDelivery_Brew", {
	name = "Drinks for the smart",
	description = "## PLACEHOLDER ##",
	keyNpc = "'Spicy Lemon'",
	defaultActive = true,
	BuildResponse = function(self, status)
		ix.progression.status["spicylemonItemDelivery_Brew"] = ix.progression.status["spicylemonItemDelivery_Brew"] or {}
		local dat = ix.progression.status["spicylemonItemDelivery_Brew"].complexData
		local itemids = self:GetItemIds()

		local str = "## PLACEHOLDER ## - Unlocks a swamp brew:\n"

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

		ix.progression.status["spicylemonItemDelivery_Brew"].complexData = ix.progression.status["spicylemonItemDelivery_Brew"].complexData or {}
		ix.progression.status["spicylemonItemDelivery_Brew"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Brew"].complexData[item] or 0
		ix.progression.status["spicylemonItemDelivery_Brew"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Brew"].complexData[item]+amt
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["spicylemonItemDelivery_Brew"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["spicylemonItemDelivery_Brew"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["spicylemonItemDelivery_Brew"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Spicy Lemon'"
				local message = "Now available in my shop: swamp brew."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Spicy Lemon'")
			if (npc) then
				npc:AddItemToList("miscaid_swampbrew", nil, 5, "SELLANDBUY", 5, 1, 5)
			end

			ix.progression.SetCompleted("spicylemonItemDelivery_Brew", true)

		end
	end
})