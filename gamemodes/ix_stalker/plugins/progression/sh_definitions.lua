--[[
	ix.progression.Register("EcologistResearchMutant", {
		name = "Ecologist Research (Mutants)",
		description = "Research progress on mutants - Hand in mutant parts to help the ecologists.",
		progressfunctions = {
			[1] = function()
				print("Reached level 1 in Eco Research (Mutants) - Spawn props")
			end,
			[2] = function()
		  	print("Reached level 2 in Eco Research (Mutants) - Add items to vendor")
			end, -- etc...
		}
	})
]]--

ix.progression.Register("EcologistResearchMutant", {
	name = "Ecologist Research (Mutants)",
	description = "Research progress on mutants - Hand in mutant parts to help the ecologists.",
	progressfunctions = {
		[1] = function()
			print("Reached level 1 in Eco Research (Mutants) - Spawn props")
			end,
		[2] = function()
		  print("Reached level 2 in Eco Research (Mutants) - Add items to vendor")
		end,
		[3] = function()
		  print("Reached level 3 in Eco Research (Mutants) - Spawn more props")
		end,  -- etc...
	},
	progressneeded = {
		[1] = 1000,
		[2] = 3000,
		[3] = 9000, -- etc..
	}
})
