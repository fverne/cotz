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
		end, -- etc...
	}
})
