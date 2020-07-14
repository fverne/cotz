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

ix.progression.Register("EcologistResearchMutant", {
	name = "Ecologist Research (Mutants)",
	description = "Research progress on mutants - Hand in mutant parts to help the ecologists.",
	progressfunctions = {
		[1] = {
			OnRun = function()
					print("Reached level 1 in Eco Research (Mutants) - Spawn props")
				end,
			RunOnce = false, -- Props are not persisted, so we need to spawn them every time server reloads
			}
		[2] = { 
			OnRun = function()
		  	print("Reached level 2 in Eco Research (Mutants) - Add items to vendor")
			end,
			RunOnce = true, -- Item stock is persisted by vendor, so we dont need to run this every time we load
			}
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
