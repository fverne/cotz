local PLUGIN = PLUGIN

ix.MutantTable = {
	["models/hdmodels/kek1ch/new_izlom_spen.mdl"] = "dogtail",
	["models/hdmodels/kek1ch/new_zombi_spen.mdl"] = "dogtail",
	["models/hdmodels/kek1ch/new_tush_spen.mdl"] = "dogtail",
	["models/hdmodels/kek1ch/new_snork_spen.mdl"] = "dogtail",
	["models/hdmodels/kek1ch/new_psydog_spen.mdl"] = "dogtail",
	["models/hdmodels/kek1ch/new_krovo_spen.mdl"] = "dogtail",
	["models/hdmodels/kek1ch/new_plot_spen.mdl"] = "dogtail",
	["models/hdmodels/kek1ch/new_dog_spen.mdl"] = "dog",
	["models/hdmodels/kek1ch/new_boar_spen.mdl"] = "dogtail",
	["models/hdmodels/kek1ch/new_chimer_spen.mdl"] = "dogtail",
}

ix.MutantParts = {
	["dog"] = {
		["meat"] = {["meattickets"] = 8, ["parttickets"] = 1},
		["mix"] = {["meattickets"] = 8, ["parttickets"] = 2},
		["part"] = {["meattickets"] = 8, ["parttickets"] = 4},
		["meattype"] = "meatdog",
		["parttype"] = "dogtail",
	},
	["zombie"] = {
		["meat"] = "makarov",
		["mix"] = "9x18",
		["part"] = "cig1",
	}
}

function PLUGIN:OpenPoachMenu(mutant, knife)

	netstream.Start(client, "mutantPoachOpen", client, mutant, knife)
end

if SERVER then
	netstream.Hook("doPoach", function(client, poachoption, knife, mutant)
		for k, v in pairs(ix.MutantParts) do
			if k == mutant then
				for k2, v2 in pairs(v) do
					if k2 == poachoption then
						local totaltickets = 0
						local meattickets = 0
						local parttickets = 0
						local lootamount = math.random(1,3)
						local loot = {}

						-- gets all the tickets in the mutantpart table based on poachoption
						meattickets = meattickets + v2.meattickets
						parttickets = parttickets + v2.parttickets

						-- gets the ticket additions from the knife used
						meattickets = meattickets + ix.item.list[knife].meattickets 
						parttickets = parttickets + ix.item.list[knife].parttickets

						-- making sure value isnt below zero for each parttype 
						meattickets = math.max(0, meattickets)
						parttickets = math.max(0, parttickets)

						--getting the total amount of parts
						totaltickets = totaltickets + meattickets + parttickets

						print("meattickets:", meattickets)
						print("parttickets:", parttickets)

						-- create table of the loot that should spawn, based on the tickets
						for i = 1, lootamount do
							local ticketdecider = math.random(1, totaltickets)
							if ticketdecider <= meattickets then
								loot[i] = v.meattype
							else
								loot[i] = v.parttype
							end
						end

						PrintTable(loot)

						--Do animation, remove ragdoll and spawn loot
						local Hit = client:GetEyeTraceNoCursor()
						local npc = Hit.Entity
						if npc then
							if (npc:IsRagdoll() and ix.MutantTable[npc:GetModel()] and npc:GetPos():Distance( client:GetPos() ) <= 55) then
								client:SetAction("Poaching", 5)
								client:Freeze(true) 
								client:ForceSequence("Cidle All")
								npc:EmitSound( "interface/inv_mutant_loot_animal.ogg", 60, 100 )
								client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 ) 
								timer.Simple(1, function() 
									client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 ) 
								end)
								timer.Simple(4, function() 
									client:Freeze(false)
									if IsValid(npc) then
										npc:Remove()
										for i = 1, lootamount do
											ix.item.Spawn(loot[i], npc:GetPos() + Vector(0, 0, i * 8) )
										end
									end
								end)
							end	
						end
					end
				end
			end
		end
			
	end)
end