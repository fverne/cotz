local PLUGIN = PLUGIN

ix.MutantTable = {
	["models/stalker/new_izlom_spen.mdl"] = "izlom",
	["models/stalkertnb/zombie1.mdl"] = "classiczombie",
	["models/stalkertnb/rodent1.mdl"] = "tushkano",
	["models/stalkertnb/snork1.mdl"] = "snork",
	["models/jerry/mutants/stalker_anomaly_pseudodog.mdl"] = "pseudodog",
	["models/stalkertnb/bloodsucker1.mdl"] = "bloodsucker",
	["models/jerry/mutants/stalker_anomaly_flesh.mdl"] = "flesh",
	["models/stalkertnb/dog1.mdl"] = "dog",
	["models/stalkertnb/boar1.mdl"] = "boar",
	["models/stalkertnb/chimera1.mdl"] = "chimera",
	["models/GSC/S.T.A.L.K.E.R/Monsters/Burer.mdl"] = "burer",
	["models/jerry/mutants/stalker_anomaly_ca1.mdl"] = "cat",
	["models/maver1k_XVII/Stalker/mutants/karlik.mdl"] = "karlik",

}

ix.MutantParts = {
	["dog"] = {
		["meat"] = {["meattickets"] = 8, ["parttickets"] = 1},
		["mix"] = {["meattickets"] = 8, ["parttickets"] = 2},
		["part"] = {["meattickets"] = 8, ["parttickets"] = 4},
		["meattype"] = "meatdog",
		["parttype"] = "dogtail",
	},
	["izlom"] = {
		["meat"] = {["meattickets"] = 8, ["parttickets"] = 1},
		["mix"] = {["meattickets"] = 8, ["parttickets"] = 2},
		["part"] = {["meattickets"] = 8, ["parttickets"] = 4},
		["meattype"] = "meathuman",
		["parttype"] = "izlomhand",
	},
	["classiczombie"] = {
		["meat"] = {["meattickets"] = 8, ["parttickets"] = 1},
		["mix"] = {["meattickets"] = 8, ["parttickets"] = 2},
		["part"] = {["meattickets"] = 8, ["parttickets"] = 4},
		["meattype"] = "meathuman",
		["parttype"] = "zombiehand",
	},
	["tushkano"] = {
		["meat"] = {["meattickets"] = 8, ["parttickets"] = 1},
		["mix"] = {["meattickets"] = 8, ["parttickets"] = 2},
		["part"] = {["meattickets"] = 8, ["parttickets"] = 4},
		["meattype"] = "meattushkano",
		["parttype"] = "rodentsear",
	},
	["snork"] = {
		["meat"] = {["meattickets"] = 8, ["parttickets"] = 1},
		["mix"] = {["meattickets"] = 8, ["parttickets"] = 2},
		["part"] = {["meattickets"] = 8, ["parttickets"] = 4},
		["meattype"] = "meathuman",
		["parttype"] = "snorksfoot",
	},
	["pseudodog"] = {
		["meat"] = {["meattickets"] = 8, ["parttickets"] = 1},
		["mix"] = {["meattickets"] = 8, ["parttickets"] = 2},
		["part"] = {["meattickets"] = 8, ["parttickets"] = 4},
		["meattype"] = "meatpseudodog",
		["parttype"] = "pseudodogtail",
	},
	["bloodsucker"] = {
		["meat"] = {["meattickets"] = 8, ["parttickets"] = 1},
		["mix"] = {["meattickets"] = 8, ["parttickets"] = 2},
		["part"] = {["meattickets"] = 8, ["parttickets"] = 4},
		["meattype"] = "meatbloodsucker",
		["parttype"] = "bloodsuckerjaw",
	},
	["flesh"] = {
		["meat"] = {["meattickets"] = 8, ["parttickets"] = 1},
		["mix"] = {["meattickets"] = 8, ["parttickets"] = 2},
		["part"] = {["meattickets"] = 8, ["parttickets"] = 4},
		["meattype"] = "meatflesh",
		["parttype"] = "flesheye",
	},
	["boar"] = {
		["meat"] = {["meattickets"] = 8, ["parttickets"] = 1},
		["mix"] = {["meattickets"] = 8, ["parttickets"] = 2},
		["part"] = {["meattickets"] = 8, ["parttickets"] = 4},
		["meattype"] = "meatboar",
		["parttype"] = "boarhoof",
	},
	["chimera"] = {
		["meat"] = {["meattickets"] = 8, ["parttickets"] = 1},
		["mix"] = {["meattickets"] = 8, ["parttickets"] = 2},
		["part"] = {["meattickets"] = 8, ["parttickets"] = 4},
		["meattype"] = "meatchimera",
		["parttype"] = "chimerasclaw",
	},
	["burer"] = {
		["meat"] = {["meattickets"] = 8, ["parttickets"] = 1},
		["mix"] = {["meattickets"] = 8, ["parttickets"] = 2},
		["part"] = {["meattickets"] = 8, ["parttickets"] = 4},
		["meattype"] = "meathuman",
		["parttype"] = "burerbrain",
	},
	["cat"] = {
		["meat"] = {["meattickets"] = 8, ["parttickets"] = 1},
		["mix"] = {["meattickets"] = 8, ["parttickets"] = 2},
		["part"] = {["meattickets"] = 8, ["parttickets"] = 4},
		["meattype"] = "meatcat",
		["parttype"] = "cattail",
	},
	["karlik"] = {
		["meat"] = {["meattickets"] = 8, ["parttickets"] = 1},
		["mix"] = {["meattickets"] = 8, ["parttickets"] = 2},
		["part"] = {["meattickets"] = 8, ["parttickets"] = 4},
		["meattype"] = "meathuman",
		["parttype"] = "medkit",
	},
}

function PLUGIN:KeyPress(client, key)
	if (client:GetCharacter()) then
		if (client:Alive()) then
			local Hit = client:GetEyeTraceNoCursor()
			local npc = Hit.Entity
			if (key == IN_USE) then
				if (npc:IsRagdoll() and ix.MutantTable[npc:GetModel()] and npc:GetPos():Distance( client:GetPos() ) <= 55) then
					local knife = client:GetCharacter():GetInventory():GetItems()
					local mutant = ix.MutantTable[npc:GetModel()]
					for _, v in pairs(knife) do
						if v:GetData("equip") and v.isPoachKnife then
							knife = ix.item.instances[v.id].id
						end
					end
					
					ix.plugin.list["mutantpoaching"]:OpenPoachMenu(client, mutant, knife)
				end
			end
		end
	end
end

function PLUGIN:OpenPoachMenu(client, mutant, knife)

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

						-- adds extra loot from the knife used
						lootamount = lootamount + ix.item.instances[knife].lootbonus

						-- gets all the tickets in the mutantpart table based on poachoption
						meattickets = meattickets + v2.meattickets
						parttickets = parttickets + v2.parttickets

						-- gets the ticket additions from the knife used
						meattickets = meattickets + ix.item.instances[knife].meattickets 
						parttickets = parttickets + ix.item.instances[knife].parttickets

						-- making sure value isnt below zero for each parttype 
						meattickets = math.max(0, meattickets)
						parttickets = math.max(0, parttickets)

						--getting the total amount of parts
						totaltickets = totaltickets + meattickets + parttickets

						--print("meattickets:", meattickets)
						--print("parttickets:", parttickets)

						-- create table of the loot that should spawn, based on the tickets
						for i = 1, lootamount do
							local ticketdecider = math.random(1, totaltickets)
							if ticketdecider <= meattickets then
								loot[i] = v.meattype
							else
								loot[i] = v.parttype
							end
						end

						--PrintTable(loot)

						--Do animation, remove ragdoll and spawn loot
						local Hit = client:GetEyeTraceNoCursor()
						local npc = Hit.Entity
						if npc then
							if (npc:IsRagdoll() and ix.MutantTable[npc:GetModel()] and npc:GetPos():Distance( client:GetPos() ) <= 55) then
								client:SetAction("Poaching", 5)
								client:Freeze(true) 
								client:ForceSequence("Cidle All")
								npc:EmitSound( "stalkersound/inv_mutant_loot_animal.ogg", 60, 100 )
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