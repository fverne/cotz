local map = "rp_marsh_cs"

----------
-- Medical
----------

ix.progression.Register("spicylemonItemDelivery_Medical1", {
	name = "Medical Imports 1",
	description = "Spicy Lemon is interested in getting a side project going.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = true,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["spicylemonItemDelivery_Medical1"] = ix.progression.status["spicylemonItemDelivery_Medical1"] or {}
		local dat = ix.progression.status["spicylemonItemDelivery_Medical1"].complexData

		local itemids = self:GetItemIds()

		local str = "Hello, stalker. You may not know it, but I am a chemist by trade; a type of chemist, at any rate. Are you interested in my services? If so, I will need your assistance with getting the tools necessary to get mixing. I am in touch with a laboratory with spare equipment, and they are willing to make an exchange. I require your help.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["meal_tushkano"] = 15,
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

		for item, amt in pairs(finished) do
			ix.progression.status["spicylemonItemDelivery_Medical1"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Medical1"].complexData[item] or 0
			if amt > ix.progression.status["spicylemonItemDelivery_Medical1"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Spicy Lemon'"
				local message = "My laboratory is online and I now offer common breath mints. They are not much, but they are handy for radiation removal in a pinch."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Spicy Lemon'")
			if (npc) then
				npc:AddItemToList("drug_mints", nil, 1, "SELLANDBUY", 1, 4, 1)
			end

			ix.progression.SetCompleted("spicylemonItemDelivery_Medical1", true)
			ix.progression.SetActive("spicylemonItemDelivery_Medical2", true) 

		end
	end
})

ix.progression.Register("spicylemonItemDelivery_Medical2", {
	name = "Medical Imports 2",
	description = "Spicy Lemon wants to expand his business.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["spicylemonItemDelivery_Medical2"] = ix.progression.status["spicylemonItemDelivery_Medical2"] or {}
		local dat = ix.progression.status["spicylemonItemDelivery_Medical2"].complexData

		local itemids = self:GetItemIds()

		local str = "My new laboratory equipment shows great promise, but it is never a bad time to expand business. I have noticed many stalkers sleeping long hours and not getting as much field time as they would like; I would like to remedy this. Are you interested?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["meal_flesh"] = 65,
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

		for item, amt in pairs(finished) do
			ix.progression.status["spicylemonItemDelivery_Medical2"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Medical2"].complexData[item] or 0
			if amt > ix.progression.status["spicylemonItemDelivery_Medical2"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Spicy Lemon'"
				local message = "I now carry caffeine tablets for those stalkers wanting a little extra stamina in their travels. Come and see me."
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
			ix.progression.SetActive("technutItemDelivery_Food", true) 

		end
	end
})


ix.progression.Register("spicylemonItemDelivery_Medical3", {
	name = "Medical Imports 3",
	description = "Spicy Lemon wants to help him help you stay safe.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["spicylemonItemDelivery_Medical3"] = ix.progression.status["spicylemonItemDelivery_Medical3"] or {}
		local dat = ix.progression.status["spicylemonItemDelivery_Medical3"].complexData

		local itemids = self:GetItemIds()

		local str = "Good day, stalker. You may have noticed, but the Swamps are home to a special variety of controller; the Swamp Controller. None of the others here carry the kind of medicines necessary to combat them short of smoking entire packs of cigarettes to clear the mind. As you may imagine, I am not interested in my clients becoming zombies. I am willing to help, but I require certain materials to mix.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["meal_boar"] = 165,
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

		for item, amt in pairs(finished) do
			ix.progression.status["spicylemonItemDelivery_Medical3"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Medical3"].complexData[item] or 0
			if amt > ix.progression.status["spicylemonItemDelivery_Medical3"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Spicy Lemon'"
				local message = "I have begun mixing batches of Modafine; though it is harsh on the system, it is a great anti-psy drug."
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
			ix.progression.SetActive("technutItemDelivery_Vodka", true) 

		end
	end
})


ix.progression.Register("spicylemonItemDelivery_Medical4", {
	name = "Medical Imports 4",
	description = "Spicy Lemon is interested in preventing harm rather than treating it.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["spicylemonItemDelivery_Medical4"] = ix.progression.status["spicylemonItemDelivery_Medical4"] or {}
		local dat = ix.progression.status["spicylemonItemDelivery_Medical4"].complexData

		local itemids = self:GetItemIds()

		local str = "While having Modafine is useful, it is better to avoid harm outright than to treat it. I have received requests for a preventative drug rather than a reactive one, and I am more than happy to serve... provided I am supplied with the appropriate materials.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["meal_cat"] = 190,
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

		for item, amt in pairs(finished) do
			ix.progression.status["spicylemonItemDelivery_Medical4"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Medical4"].complexData[item] or 0
			if amt > ix.progression.status["spicylemonItemDelivery_Medical4"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Spicy Lemon'"
				local message = "I now carry Asenapine tablets. They are useful for lowering the effect of psy fields and Controller attacks."
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
	description = "Spicy Lemon is interested in pain control.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["spicylemonItemDelivery_Medical5"] = ix.progression.status["spicylemonItemDelivery_Medical5"] or {}
		local dat = ix.progression.status["spicylemonItemDelivery_Medical5"].complexData

		local itemids = self:GetItemIds()

		local str = "Do your wounds ache, stalker? I am saddened to hear it; my heart aches to see you all suffering. I believe it will be best for everyone involved if I help tend your wounds, provided I am furnished with the appropriate materials to facilitate the acquisition of supplies...\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["meal_snork"] = 190,
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

		for item, amt in pairs(finished) do
			ix.progression.status["spicylemonItemDelivery_Medical5"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Medical5"].complexData[item] or 0
			if amt > ix.progression.status["spicylemonItemDelivery_Medical5"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Spicy Lemon'"
				local message = "I now carry painkillers; more specifically, Codeine tablets. If you find yourself aching and desire a pick me up, come and see me."
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
			ix.progression.SetActive("technutItemDelivery_Spirits", true) 

		end
	end
})



ix.progression.Register("spicylemonItemDelivery_Medical6", {
	name = "Medical Imports 6",
	description = "Spicy Lemon would like to expand into combat drugs.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["spicylemonItemDelivery_Medical6"] = ix.progression.status["spicylemonItemDelivery_Medical6"] or {}
		local dat = ix.progression.status["spicylemonItemDelivery_Medical6"].complexData

		local itemids = self:GetItemIds()

		local str = "The mutants out there are not getting easier to deal with, stalker. Between them and hostile stalkers, the dangers are many and the options to fight back few. I should like to step in and help provide something I think you might find quite useful. To purchase the mixing materials, however, I am having to reach deep into my own pockets. That is where you come in.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["meal_bloodsucker"] = 190,
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

		for item, amt in pairs(finished) do
			ix.progression.status["spicylemonItemDelivery_Medical6"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Medical6"].complexData[item] or 0
			if amt > ix.progression.status["spicylemonItemDelivery_Medical6"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Spicy Lemon'"
				local message = "I now offer Adrenaline autoinjectors for sale; these handy little pens should get you back in the fight and keep you in it for some time."
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
	description = "Spicy Lemon would like to complete his stock of combat drugs.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["spicylemonItemDelivery_Medical7"] = ix.progression.status["spicylemonItemDelivery_Medical7"] or {}
		local dat = ix.progression.status["spicylemonItemDelivery_Medical7"].complexData

		local itemids = self:GetItemIds()

		local str = "Though Codeine is useful after combat, I am looking to furnish stalkers with something a bit stronger for use during combat. The first thing that comes to mind is morphine sulfate. It is both very powerful and very expensive, but if you are all willing to chip in I will arrange a sale.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["meal_sprig"] = 100,
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

		for item, amt in pairs(finished) do
			ix.progression.status["spicylemonItemDelivery_Medical7"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Medical7"].complexData[item] or 0
			if amt > ix.progression.status["spicylemonItemDelivery_Medical7"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Spicy Lemon'"
				local message = "I now offer Morphine injectors. Please use them responsibly; I would hate to see anyone overdose..."
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
			ix.progression.SetActive("technutItemDelivery_Brew", true) 

		end
	end
})


-------------------
-- Food and Alcohol
-------------------

ix.progression.Register("spicylemonItemDelivery_Food", {
	name = "Food for the poor",
	description = "Spicy Lemon is interested in importing some food.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = true,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["spicylemonItemDelivery_Food"] = ix.progression.status["spicylemonItemDelivery_Food"] or {}
		local dat = ix.progression.status["spicylemonItemDelivery_Food"].complexData

		local itemids = self:GetItemIds()

		local str = "Good day, stalker. You have no doubt encountered mutant meat in your time; most of it is irradiated if not borderline toxic. I have friends outside the Zone who are interested in such samples for research, however, and are willing to exchange purified food and drink for the less pleasant variety we have here. Up to it?\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["drink_energydrink_4"] = 40,
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

		for item, amt in pairs(finished) do
			ix.progression.status["spicylemonItemDelivery_Food"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Food"].complexData[item] or 0
			if amt > ix.progression.status["spicylemonItemDelivery_Food"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Spicy Lemon'"
				local message = "I now offer purified food and drink from outside the Zone."
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
	description = "Spicy Lemon has a discerning eye for new customers...",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["spicylemonItemDelivery_Vodka"] = ix.progression.status["spicylemonItemDelivery_Vodka"] or {}
		local dat = ix.progression.status["spicylemonItemDelivery_Vodka"].complexData

		local itemids = self:GetItemIds()

		local str = "One look at you tells me all I need to know, stalker. You are not interested in beers or store bought alcohol; you are looking for something a bit more discerning. Should you provide me with the resources necessary to start making some trades, I can bring in some fine local vodkas.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["drink_energydrink_5"] = 40,
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

		for item, amt in pairs(finished) do
			ix.progression.status["spicylemonItemDelivery_Vodka"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Vodka"].complexData[item] or 0
			if amt > ix.progression.status["spicylemonItemDelivery_Vodka"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Spicy Lemon'"
				local message = "The first imports of high shelf local vodka have arrived. Come and see the brands for yourselves."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Spicy Lemon'")
			if (npc) then
				npc:AddItemToList("drink_vodka_4", nil, 5, "SELLANDBUY", 5, 1, 5)
				npc:AddItemToList("drink_vodka_5", nil, 1, "SELLANDBUY", 1, 6, 1)
				npc:AddItemToList("drink_vodka_6", nil, 1, "SELLANDBUY", 1, 6, 1)
			end

			ix.progression.SetCompleted("spicylemonItemDelivery_Vodka", true)
			ix.progression.SetActive("spicylemonItemDelivery_Spirits", true) 

		end
	end
})


ix.progression.Register("spicylemonItemDelivery_Spirits", {
	name = "Drinks for the rich",
	description = "Spicy Lemon would like to expand his vodka stocks.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["spicylemonItemDelivery_Spirits"] = ix.progression.status["spicylemonItemDelivery_Spirits"] or {}
		local dat = ix.progression.status["spicylemonItemDelivery_Spirits"].complexData

		local itemids = self:GetItemIds()

		local str = "Not satisfied with local vodka? This is no issue; I completely understand the desire for something a bit more... exotic. I have seen some stalkers carrying foreign imported spirits; expensive, difficult to buy... except I have found just the person to buy them from. They would like some proof of my good intentions, however, so now is the time to give them an appetizer of sorts.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["drink_energydrink_6"] = 40,
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

		for item, amt in pairs(finished) do
			ix.progression.status["spicylemonItemDelivery_Spirits"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Spirits"].complexData[item] or 0
			if amt > ix.progression.status["spicylemonItemDelivery_Spirits"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Spicy Lemon'"
				local message = "Fine international spirits have just arrived from the Cordon. Grab a bottle and kick back with your friends."
				ix.util.HandleChat(name, message)
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = name,
					message = message
				})
			end)

			local npc = ix.progression.GetNPCFromName("'Spicy Lemon'")
			if (npc) then
				npc:AddItemToList("drink_spirit_1", nil, 1, "SELLANDBUY", 1, 6, 1)
				npc:AddItemToList("drink_spirit_2", nil, 1, "SELLANDBUY", 1, 6, 1)
				npc:AddItemToList("drink_spirit_3", nil, 1, "SELLANDBUY", 1, 6, 1)
                npc:AddItemToList("drink_wine", nil, 1, "SELLANDBUY", 1, 6, 1)
			end

			ix.progression.SetCompleted("spicylemonItemDelivery_Spirits", true)
			ix.progression.SetActive("spicylemonItemDelivery_Brew", true) 

		end
	end
})



ix.progression.Register("spicylemonItemDelivery_Brew", {
	name = "Drinks for the smart",
	description = "Spicy Lemon is interested in medicinal brews.",
	keyNpc = "'Spicy Lemon'",
	defaultActive = false,
	progMap = map,
	BuildResponse = function(self, npcname, status)
		ix.progression.status["spicylemonItemDelivery_Brew"] = ix.progression.status["spicylemonItemDelivery_Brew"] or {}
		local dat = ix.progression.status["spicylemonItemDelivery_Brew"].complexData

		local itemids = self:GetItemIds()

		local str = "Hello, stalker. My interest does not lie with chemistry and brewing alone; I like to mix the two crafts from time to time, and I believe it may be time for me to start bringing in my own medicinal teas. The Swamps provide everything we need to make a very special kind of brew.\n\nREQUIRED ITEMS:"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%d %s", amt - tmp, ix.item.list[item].name)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["meal_chimera"] = 50,
			["meal_pseudogiant"] = 50,
			["meal_karlik"] = 50,
			["meal_spider"] = 50,
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

		for item, amt in pairs(finished) do
			ix.progression.status["spicylemonItemDelivery_Brew"].complexData[item] = ix.progression.status["spicylemonItemDelivery_Brew"].complexData[item] or 0
			if amt > ix.progression.status["spicylemonItemDelivery_Brew"].complexData[item] then isdone = false end
		end

		if isdone then

			timer.Simple(60, function()
				local name = "'Spicy Lemon'"
				local message = "Though it has taken some experimentation, I have finished a medicinal brew that I believe will be perfect for the Zone's conditions... although the taste leaves something to be desired."
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