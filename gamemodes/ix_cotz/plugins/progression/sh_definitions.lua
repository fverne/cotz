--[[
	ix.progression.Register("EcologistResearchMutant", {
		name : Pretty name
		description : Describes the progression
		progressfunctions : table of
			progressfunction {
				OnRun : Function to run when this progress is reached
				RunOnce : Only run this function a single time, ever
			}
		progressthresholds : Table of values denoting how much progress has to be made to get to each level
	})
]]--

hook.Add("ix_OnJobComplete", "OldTimer_oldTimerKillIntro", function(client, npcidentifier, identifier)
	local iscorrecttasktype = false

	local killcategories = {
		["mutantkillgroupeasy"] = true,
		["mutantkillgroupmedium"] = true,
		["mutantkillgrouphard"] = true,
		["mutantkilleasy"] = true,
		["mutantkillmedium"] = true,
		["mutantkillhard"] = true,
	}

	for k, v in pairs(ix.jobs.list[identifier].categories) do
		if killcategories[v] then iscorrecttasktype = true end
	end

	if npcidentifier == "'Old Timer'" and iscorrecttasktype then
		if ix.progression.IsActive("oldTimerKillIntro") then
			ix.progression.AddProgessionValue("oldTimerKillIntro", 1, client:Name())
		end
	end
end)

hook.Add("ix_OnJobComplete", "CookNPC_cookMeatCollect", function(client, npcidentifier, identifier)
	local iscorrecttasktype = false

	local categories = {
		["mutantmeateasy"] = true,
		["mutantmeatmedium"] = true,
		["mutantmeathard"] = true,
	}

	for k, v in pairs(ix.jobs.list[identifier].categories) do
		if categories[v] then iscorrecttasktype = true end
	end

	if npcidentifier == "'Spicy Lemon'" and iscorrecttasktype then
		if ix.progression.IsActive("cookMeatCollect") then
			ix.progression.AddProgessionValue("cookMeatCollect", 1, client:Name())
		end
	end
end)

ix.progression.Register("oldTimerKillIntro", {
	name = "Old Timer Kill Intro",
	description = "Cleaning up the zone",
	keyNpc = "'Old Timer'",
	defaultActive = true,
	BuildResponse = function(self, status)
		-- Find next treshold
		local tresh = 0

		for k,v in ipairs( self.progressthresholds ) do
			if v > status.value then
				tresh = v
				break
			end
		end

		return string.format("I need you to complete mutant kill tasks for me, %d should do.", tresh-status.value)
	end,
	progressfunctions = {
		[1] = {
			OnRun = function()
				ix.progression.SetActive("cookMeatCollect")
				
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Old Timer'",
					message = "Good job, you've lowered the mutant population a bit, and as such we've gained a slight foothold in the zone. I invited my good friend, Spicy Lemon, here. He should be moving into the small hut next to the building I usually stay in."
				})
				
				-- Spawn CookNPC

				ix.util.SpawnAdvDupe2Dupe( "progressiontest1" )
			end,
			RunOnce = false
		},
		[2] = {
			OnRun = function()

				local npc = ix.progression.GetNPCFromName("Sorter")
				if (npc) then
					--Add Old Timer VendorList 2
				end

				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Old Timer'",
					message = "Due to your extraordinary efforts, I have been secured supply lines to import some medical supplies from some leftover army supplies they don't need anymore."
				})

			end,
			RunOnce = false
		},
		[3] = {
			OnRun = function()
				local npc = ix.progression.GetNPCFromName("Sorter")
				if (npc) then
					--Add Old Timer VendorList 3
				end

				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Old Timer'",
					message = "Lovely work everyone, thanks to your lovely work one of my associates have agreed to ship in sporting goods to me, feel free to come check my wares."
				})

				ix.progression.SetActive("oldTimerKillIntro", false)

			end,
			RunOnce = false
		},
	},
	progressthresholds = {
		[1] = 25,
		[2] = 60,
		[3] = 120
	}
})

ix.progression.Register("cookMeatCollect", {
	name = "CookNPC Meat Collection",
	description = "Collecting food for the hungry stalkers.",
	keyNpc = "'Spicy Lemon'",
	BuildResponse = function(self, status)
		-- Find next treshold
		local tresh = 0

		for k,v in ipairs( self.progressthresholds ) do
			if v > status.value then
				tresh = v
				break
			end
		end

		return string.format("Just a couple more bundles of meat, %d should be enough.", tresh-status.value)
	end,
	progressfunctions = {
		[1] = {
			OnRun = function()
				-- ??? XD
			end,
			RunOnce = false,
		},
		[2] = { 
			OnRun = function()
		  		ix.progression.SetActive("technutItemDelivery_Main")
			end,
			RunOnce = true,
		},
		[3] = {
			OnRun = function()
		  		-- ??? XD
			end,
			RunOnce = false,
		} -- etc...
	},
	progressthresholds = {
		[1] = 20,
		[2] = 45,
		[3] = 110,
	}
})

ix.progression.Register("technutItemDelivery_Main", {
	name = "Technut Item Collection",
	description = "Collecting important components for Technut.",
	BuildResponse = function(self, status)
		local dat = ix.progression.status["technutItemDelivery_Main"].complexData
		local itemids = {
			["value_wirelesstrans"] = 15,
			["value_wire_heavy"] 	= 30,
			["value_tape_duct"] 	= 10,
			["value_capacitors"] 	= 100,
			["value_sparkplug"] 	= 10,
			["value_carbattery"] 	= 5,
		}

		str = "Alright, here's a list of what I need:\n"

		for item, amt in pairs(itemids) do
			string.format("%s: %d", ix.item.list[item].name, amt - complexData[item])
		end

		return str
	end,
	progressfunctions = {
		[1] = {
			OnRun = function()
				-- ??? XD
			end,
			RunOnce = false,
		},
	},
	progressthresholds = {
		[1] = 1,
	},
	fnAddComplexProgression = function(dat, playername)
		ix.progression.status["technutItemDelivery_Main"].complexData[dat] = ix.progression.status["technutItemDelivery_Main"].complexData[dat]+1
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_Main"].complexData[dat]
	end,
	fnCheckComplexProgression = function()
		local finished = {
			["value_wirelesstrans"] = 15,
			["value_wire_heavy"] 	= 30,
			["value_tape_duct"] 	= 10,
			["value_capacitors"] 	= 100,
			["value_sparkplug"] 	= 10,
			["value_carbattery"] 	= 5,
		}

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_Main"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then
			--Spawn STALKERNETAdmin

			ix.progression.SetActive("technutItemDelivery_Main", false)
		end
	end
})

--[[
ix.progression.Register("TestProgression", {
	name = "Test Progression",
	description = "Progression goal used for testing, talk with Sorter to progress",
	progressfunctions = {
		[1] = {
			OnRun = function()
				print("Reached level 1 in TestProgression - Added Stimpak Mk1")
				local npc = ix.progression.GetNPCFromName("Sorter")
				if (npc) then
					npc:AddItemToList("medic_stimpak_1", nil, 4, "SELLANDBUY", 4, 1, 4)
				end

				ix.util.SpawnAdvDupe2Dupe( "progressiontest1" )
			end,
			RunOnce = false
		},
		[2] = {
			OnRun = function()
				print("Reached level 2 in TestProgression - Added Syringe Mk2")
				local npc = ix.progression.GetNPCFromName("Sorter")
				if (npc) then
					npc:AddItemToList("medic_stimpak_2", nil, 4, "SELLANDBUY", 4, 1, 4)
				end
			end,
			RunOnce = false
		},
		[3] = {
			OnRun = function()
				print("Reached level 3 in TestProgression - Added Syringe Mk3")
				local npc = ix.progression.GetNPCFromName("Sorter")
				if (npc) then
					npc:AddItemToList("medic_stimpak_3", nil, 4, "SELLANDBUY", 4, 1, 4)
				end

				ix.util.SpawnAdvDupe2Dupe( "progressiontest2" )
			end,
			RunOnce = false
		},
	},
	progressthresholds = {
		[1] = 5,
		[2] = 10,
		[3] = 15, -- etc..
	}
})
]]--