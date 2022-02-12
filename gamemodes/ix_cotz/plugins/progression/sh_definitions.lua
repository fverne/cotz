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
	name = "Cleaning up the Zone",
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

		return string.format("I need you to complete mutant kill tasks for me, %d should do. This will allow us to get better supply lines, and maybe have a friend of mine move in if we clear enough of it.", tresh-status.value)
	end,
	progressfunctions = {
		[1] = {
			OnRun = function()			
				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Old Timer'",
					message = "Good job, you've lowered the mutant population a bit, and as such we've gained a slight foothold in the zone. I invited my good friend, Technut, here. He should be moving into the small hut next to the building I usually stay in."
				})
				
				-- Spawn TechNPC
				local pos = Vector(-6006.653809, -11071.930664, 5026.031250)
				local ang = Angle(0,-177.793,0)
				ix.util.SpawnAdvVendor("technpc", pos, ang)
			end,
			RunOnce = true
		},
		[2] = { -- runs at the same time as [1]
			OnRun = function()
				local npc = ix.progression.GetNPCFromName("'Old Timer'")
				if (npc) then
				end

				ix.util.SpawnAdvDupe2Dupe( "prog_oldtimer_1" )
			end,
			RunOnce = false
		},
		[3] = {
			OnRun = function()

				local npc = ix.progression.GetNPCFromName("'Old Timer'")
				if (npc) then
					npc:AddItemToList("medic_medkit_1", nil, 4, "SELLANDBUY", 4, 1, 4)
					npc:AddItemToList("medic_medkit_2", nil, 4, "SELLANDBUY", 4, 1, 4)
					npc:AddItemToList("medic_bandage_2", nil, 4, "SELLANDBUY", 4, 1, 4)
				end

				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Old Timer'",
					message = "Due to your extraordinary efforts, I have been secured supply lines to import some medical supplies from some leftover army supplies they don't need anymore."
				})

				ix.util.SpawnAdvDupe2Dupe( "prog_oldtimer_2" )
			end,
			RunOnce = false
		},
		[4] = {
			OnRun = function()
				local npc = ix.progression.GetNPCFromName("'Old Timer'")
				if (npc) then
					npc:AddItemToList("medic_medkit_3", nil, 4, "SELLANDBUY", 4, 1, 4)
					npc:AddItemToList("medic_bandage_3", nil, 4, "SELLANDBUY", 4, 1, 4)
				end

				ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
					name = "'Old Timer'",
					message = "Lovely work everyone, thanks to your lovely work one of my associates have agreed to ship in a wider variety of medical supplies, feel free to come check my wares."
				})

				ix.progression.SetActive("oldTimerKillIntro", false)

				ix.util.SpawnAdvDupe2Dupe( "prog_oldtimer_3" )
			end,
			RunOnce = false
		},
	},
	progressthresholds = {
		[1] = 1,
		[2] = 1, -- just for the dupe spawning
		[3] = 2,
		[4] = 3
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
	keyNpc = "'Technut'",
	defaultActive = true,
	BuildResponse = function(self, status)
		local dat = ix.progression.status["technutItemDelivery_Main"].complexData
		local itemids = self:GetItemIds()

		str = "Alright, here's a list of what I need:\n"

		for item, amt in pairs(itemids) do
			local tmp = 0
			if (dat and dat[item]) then tmp = dat[item] end
			str = str..string.format("\n%s: %d", ix.item.list[item].name, amt - tmp)
		end

		return str
	end,
	GetItemIds = function()
		local itemids = {
			["value_wirelesstrans"] = 15,
			["value_wire_heavy"] 	= 30,
			["value_tape_duct"] 	= 10,
			["value_capacitors"] 	= 100,
			["value_sparkplug"] 	= 10,
			["value_carbattery"] 	= 5,
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
		ix.progression.status["technutItemDelivery_Main"].complexData = ix.progression.status["technutItemDelivery_Main"].complexData or {}
		ix.progression.status["technutItemDelivery_Main"].complexData[dat] = ix.progression.status["technutItemDelivery_Main"].complexData[dat] or 0
		ix.progression.status["technutItemDelivery_Main"].complexData[dat] = ix.progression.status["technutItemDelivery_Main"].complexData[dat]+1
	end,
	fnGetComplexProgression = function()
		return ix.progression.status["technutItemDelivery_Main"].complexData
	end,
	fnCheckComplexProgression = function()
		local finished =  ix.progression.definitions["technutItemDelivery_Main"]:GetItemIds()

		local isdone = true

		for item, amt in pairs(ix.progression.status["technutItemDelivery_Main"].complexData) do
			if amt < finished[item] then isdone = false end
		end

		if isdone then
			--Spawn STALKERNETAdmin

			ix.chat.Send(nil, "npcpdainternal", "", nil, nil, {
				name = "'Technut'",
				message = "LUTZ."
			})

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