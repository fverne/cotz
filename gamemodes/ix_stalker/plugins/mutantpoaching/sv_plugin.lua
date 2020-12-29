local PLUGIN = PLUGIN

ix.poaching = ix.poaching or {}

ix.poaching.MutantTable = {
	["models/monsters/izlom.mdl"] = "izlom",
	["models/monsters/zombie.mdl"] = "classiczombie",
	["models/monsters/babka.mdl"] = "classiczombie",
	["models/stalkertnb/rodent1.mdl"] = "tushkano",
	["models/monsters/snork2.mdl"] = "snork",
	["models/monsters/psydog.mdl"] = "pseudodog",
	["models/monsters/krovosos.mdl"] = "bloodsucker",
	["models/monsters/plot.mdl"] = "flesh",
	["models/monsters/slep_dog2.mdl"] = "dog",
	["models/monsters/boar.mdl"] = "boar",
	["models/monsters/chimera2.mdl"] = "chimera",
	["models/GSC/S.T.A.L.K.E.R/Monsters/Burer.mdl"] = "burer",
	["models/monsters/cat.mdl"] = "cat",
	["models/maver1k_XVII/Stalker/mutants/karlik.mdl"] = "karlik",
	["models/monsters/zanoza.mdl"] = "sprig",
	["models/monsters/tibet.mdl"] = "swampcontroller"

}

ix.poaching.MutantParts = {
	["dog"] = {
		["meattype"] = "meat_blinddog",
		["parts"] = {{"part_blinddog", 20}, {"hide_blinddog", 3}},
	},
	["izlom"] = {
		["meattype"] = "meat_human",
		["parts"] = {{"part_izlom", 15}, {"hide_izlom", 2}},
	},
	["classiczombie"] = {
		["meattype"] = "meat_human",
		["parts"] = {{"part_zombie_1", 25}, {"part_zombie_2", 5}},
	},
	["tushkano"] = {
		["meattype"] = "meat_tushkano",
		["parts"] = {{"part_tushkano", 45}, {"hide_tushkano", 8}},
	},
	["snork"] = {
		["meattype"] = "meat_human",
		["parts"] = {{"part_snork_1", 35}, {"part_snork_2", 4}},
	},
	["pseudodog"] = {
		["meattype"] = "meat_pseudodog",
		["parts"] = {{"part_pseudodog", 15}, {"hide_pseudodog", 2}},
	},
	["bloodsucker"] = {
		["meattype"] = "meat_bloodsucker",
		["parts"] = {{"part_bloodsucker", 25}, {"hide_bloodsucker", 1}},
	},
	["flesh"] = {
		["meattype"] = "meat_flesh",
		["parts"] = {{"part_flesh", 75}, {"hide_flesh", 1}},
	},
	["boar"] = {
		["meattype"] = "meat_boar",
		["parts"] = {{"part_boar", 75}, {"hide_boar", 5}},
	},
	["chimera"] = {
		["meattype"] = "meat_chimera",
		["parts"] = {{"part_chimera", 90}, {"hide_chimera", 2}},
	},
	["burer"] = {
		["meattype"] = "meat_burer",
		["parts"] = {{"part_burer_1", 45}, {"part_burer_2", 5}, {"hide_chimera", 2}},
	},
	["cat"] = {
		["meattype"] = "meat_cat",
		["parts"] = {{"part_cat", 35}, {"hide_cat", 4}},
	},
	["karlik"] = {
		["meattype"] = "meat_karlik",
		["parts"] = {{"part_karlik_1", 45}, {"part_karlik_2", 5}, {"hide_karlik", 4}},
	},
	["sprig"] = {
		["meattype"] = "meat_sprig",
		["parts"] = {{"part_sprig", 20}, {"hide_sprig", 3}},
	},
	["swampcontroller"] = {
		["meattype"] = "meat_swampcontroller",
		["parts"] = {{"part_swampcontroller", 20}, {"hide_swampcontroller", 3}},
	}
}

function PLUGIN:KeyPress(client, key)			
	local Hit = client:GetEyeTraceNoCursor()
	local npc = Hit.Entity
	local items = client:GetCharacter():GetInventory():GetItems()
	local mutant = ix.poaching.MutantTable[npc:GetModel()]
	local knife = nil

	if client:GetCharacter() and client:Alive() then
		if (key == IN_USE) then
			if (npc:IsRagdoll() and ix.poaching.MutantTable[npc:GetModel()] and npc:GetPos():Distance( client:GetPos() ) <= 55) then
				for _, v in pairs(items) do
					if v:GetData("equip") and v.isPoachKnife then
						knife = ix.item.instances[v.id].id
					end
				end
				
				if (knife != nil) then
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
	netstream.Hook("doPoach", function(client, knife, mutant)
		local char = client:GetCharacter()
		local inv = char:GetInventory()

		if (!inv:HasItem(ix.item.instances[knife].uniqueID)) then
			client:Notify("Stop cheating, and notify developers")
		end

		local mutanttable = ix.poaching.MutantParts[mutant]
		local knifetier = ix.item.instances[knife].knifetier

		local loot = {}

		table.insert(loot, mutanttable["meattype"])
		for _,v in pairs(mutanttable["parts"]) do
			if( math.random(0,100) < v[2] ) then table.insert(loot, v[1]) end
		end

		--Do animation, remove ragdoll and spawn loot
		local Hit = client:GetEyeTraceNoCursor()
		local npc = Hit.Entity
		if npc then
			if (npc:IsRagdoll() and ix.poaching.MutantTable[npc:GetModel()] and npc:GetPos():Distance( client:GetPos() ) <= 55) then
				if npc:GetNetVar("beingSkinned", false) then
					client:Notify("That mutant is being skinned by someone else!")
					return
				end
				client:ForceSequence("cidle_knife", nil, 5)
				npc:SetNetVar("beingSkinned", true)
				npc:EmitSound( "stalkersound/inv_mutant_loot_animal.ogg", 60 )
				ix.util.PlayerPerformBlackScreenAction(client, "Poaching", 5, function(player) 
					local position = client:GetItemDropPos()
					if IsValid(npc) then
						npc:Remove()
						for i = 1, #loot do
							local weight = ix.util.GetMutantMeatWeight(loot[i], knifetier)
							local dat = weight and {["weight"] = weight} or {}

							if (IsValid(client) and client:GetCharacter() and !inv:Add(loot[i], 1, dat)) then
								ix.item.Spawn(loot[i], position, nil, AngleRand(), dat)
								position = position + Vector(0, 0, 5)
								client:Notify("No space in your inventory! Items have been dropped.")
							end
						end
					end
				end)
			end	
		end
	end)
end
