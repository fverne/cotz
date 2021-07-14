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

hook.Add("ix_OnJobComplete", "OldTimer_Task1Listener", function(client, npcidentifier, identifer)
	if npcidentifier == "'Old Timer'" then
		if ix.progression.GetProgressionValue("TutorialNPCProg1") < 15 then
			ix.progression.AddProgessionValue("TutorialNPCProg1", 1, client:Name())
		end
	end
end)

ix.progression.Register("TutorialNPCProg1", {
	name = "Tutorial NPC Kill Mutants 1",
	description = "First Task",
	progressfunctions = {
		[1] = {
			OnRun = function()
				print("Reached level 1 in TutorialNPCProg1")
				local npc = ix.progression.GetNPCFromName("'Old Timer'")
				if (npc) then
					npc:AddItemToList("medic_stimpak_1", nil, 4, "SELLANDBUY", 4, 1, 4)
				end
				
				ix.chat.Send(nil, "npcpdainternal", message, nil, nil, {
					name = "'Old Timer'",
					message = "Good job, we've completed all 15 tasks and now have gained a slight foothold in the zone. I invited my good friend here, Technut. He should be in the small hut next to us."
				})

				ix.util.SpawnAdvDupe2Dupe( "progressiontest1" )
			end,
			RunOnce = false
		},
		[2] = {
			OnRun = function()
				print("Reached level 2 in TutorialNPCProg1 - Added Syrette Kit ")
				local npc = ix.progression.GetNPCFromName("Sorter")
				if (npc) then
					npc:AddItemToList("medic_medkit_2", nil, 4, "SELLANDBUY", 4, 1, 4)
				end

				ix.chat.Send(nil, "npcpdainternal", message, nil, nil, {
					name = "'Old Timer'",
					message = "Due to our extraoridinary efforts, I have been able to import a syrette kit from some leftover army supplies they don't need anymore."
				})

			end,
			RunOnce = false
		},
	},
	progressthresholds = {
		[1] = 15,
		[2] = 40,
	}
})

ix.progression.Register("EcologistResearchMutant", {
	name = "Ecologist Research (Mutants)",
	description = "Research progress on mutants - Hand in mutant parts to help the ecologists.",
	progressfunctions = {
		[1] = {
			OnRun = function()
					print("Reached level 1 in Eco Research (Mutants) - Spawn props")
				end,
			RunOnce = false, -- Props are not persisted, so we need to spawn them every time server reloads
		},
		[2] = { 
			OnRun = function()
		  	print("Reached level 2 in Eco Research (Mutants) - Add items to vendor")
			end,
			RunOnce = true, -- Item stock is persisted by vendor, so we dont need to run this every time we load
		},
		[3] = {
			OnRun = function()
		  	print("Reached level 3 in Eco Research (Mutants) - Spawn more props")
			end,
			RunOnce = false, -- Props are not persisted, so we need to spawn them every time server reloads
		} -- etc...
	},
	progressthresholds = {
		[1] = 1000,
		[2] = 3000,
		[3] = 9000, -- etc..
	}
})


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