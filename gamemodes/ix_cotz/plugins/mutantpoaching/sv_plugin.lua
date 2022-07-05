local PLUGIN = PLUGIN

ix.poaching = ix.poaching or {}

ix.poaching.MutantTable = {
	["models/monsters/izlom.mdl"] = "izlom",
	["models/monsters/zombie.mdl"] = "classiczombie",
	["models/monsters/babka.mdl"] = "classiczombie",
	["models/stalkertnb/rodent1.mdl"] = "tushkano",
	["models/monsters/snork2.mdl"] = "snork",
	["models/monsters/psydog2.mdl"] = "pseudodog",
	["models/monsters/psydog.mdl"] = "psydog",
	["models/monsters/krovosos.mdl"] = "bloodsucker",
	["models/monsters/plot.mdl"] = "flesh",
	["models/monsters/slep_dog2.mdl"] = "dog",
	["models/monsters/slep_dog.mdl"] = "hellhound",
	["models/monsters/boar.mdl"] = "boar",
	["models/monsters/chimera2.mdl"] = "chimera",
	["models/monsters/chimera.mdl"] = "electrochimera",
	["models/GSC/S.T.A.L.K.E.R/Monsters/Burer.mdl"] = "burer",
	["models/monsters/cat.mdl"] = "cat",
	["models/maver1k_XVII/Stalker/mutants/karlik.mdl"] = "karlik",
	["models/monsters/zanoza.mdl"] = "sprig",
	["models/monsters/controler.mdl"] = "controller",
	["models/monsters/tibet.mdl"] = "swampcontroller",
	["models/monsters/controler_big.mdl"] = "electrocontroller",
	["models/monsters/controler_fast.mdl"] = "fastcontroller",
	["models/monsters/bear.mdl"] = "bear",
	["models/monsters/skelet.mdl"] = "skeleton",
	["models/monsters/gigant3.mdl"] = "pseudogiant",
	["models/monsters/gigant.mdl"] = "pseudogiantfast",
	["models/monsters/tark.mdl"] = "tark",
	["models/monsters/vareshka.mdl"] = "vareshka",
	["models/darkmessiah/spider_regular.mdl"] = "spider",
}

ix.poaching.MutantParts = {
	["dog"] = {
		["meattype"] = "meat_blinddog",
		["parts"] = {{"part_blinddog", 20}, {"hide_blinddog", 3}},
	},
	["izlom"] = {
		["meattype"] = "meat_human",
		["parts"] = {{"part_izlom", 15}}, -- {"hide_izlom", 2}},
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
		["meattype"] = "meat_snork",
		["parts"] = {{"part_snork_1", 35}, {"part_snork_2", 4}},
	},
	["pseudodog"] = {
		["meattype"] = "meat_pseudodog",
		["parts"] = {{"part_pseudodog", 15}, {"hide_pseudodog", 2}},
	},
	["psydog"] = {
		["meattype"] = "meat_pseudodog",
		["parts"] = {{"part_pseudodog", 35}, {"part_psydog", 4}, {"hide_pseudodog", 5}},
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
		["parts"] = {{"part_sprig", 20}, {"hide_sprig", 2}},
	},
	["controller"] = {
		["meattype"] = "meat_controller",
		["parts"] = {{"part_controller", 20}, {"hide_controller", 3}},
	},
	["swampcontroller"] = {
		["meattype"] = "meat_swampcontroller",
		["parts"] = {{"part_swampcontroller", 20}, {"hide_swampcontroller", 3}},
	},
	["electrocontroller"] = {
		["meattype"] = "meat_controller",
		["parts"] = {{"part_electrocontroller", 20}, {"hide_controller", 3}},
	},
	["bear"] = {
		["meattype"] = "meat_bear",
		["parts"] = {{"part_bear", 20}, {"hide_bear", 3}},
	},
	["skeleton"] = {
		["meattype"] = "meat_skeleton",
		["parts"] = {{"part_skeleton", 20}, {"hide_skeleton", 3}},
	},
	["pseudogiant"] = {
		["meattype"] = "meat_pseudogiant",
		["parts"] = {{"part_pseudogiant", 20}, {"hide_pseudogiant", 3}},
	},
	["pseudogiantfast"] = {
		["meattype"] = "meat_pseudogiantfast",
		["parts"] = {{"part_pseudogiantfast", 20}, {"hide_pseudogiantfast", 3}},
	},
	["hellhound"] = {
		["meattype"] = "meat_hellhound",
		["parts"] = {{"part_hellhound", 20}, {"hide_hellhound", 3}},
	},
	["electrochimera"] = {
		["meattype"] = "meat_electrochimera",
		["parts"] = {{"part_electrochimera", 20}, {"hide_electrochimera", 3}},
	},
	["fastcontroller"] = {
		["meattype"] = "meat_fastcontroller",
		["parts"] = {{"part_fastcontroller", 20}, {"hide_fastcontroller", 3}},
	},
	["tark"] = {
		["meattype"] = "meat_tark",
		["parts"] = {{"part_tark", 20}, {"hide_tark", 3}},
	},
	["vareshka"] = {
		["meattype"] = "meat_vareshka",
		["parts"] = {{"part_vareshka", 20}, {"hide_vareshka", 3}},
	},
	["spider"] = {
		["meattype"] = "meat_spider",
		["parts"] = {{"part_spider", 20}, {"hide_spider", 3}},
	},

}

function PLUGIN:PlayerButtonDown(client,key)
    local Hit = client:GetEyeTraceNoCursor()
    local npc = Hit.Entity
    if (client:GetNetVar("IsPoaching") == true && key == 16 ) then
       ix.util.PlayerActionInterrupt(client)
       npc:SetNetVar("beingSkinned",false)

    end
end

function PLUGIN:KeyPress(client, key)

    if (client:GetNetVar("IsPoaching") == true ) then
       ix.util.PlayerActionInterrupt(client)

    end

	local Hit = client:GetEyeTraceNoCursor()
	local npc = Hit.Entity
	local items = client:GetCharacter():GetInventory():GetItems()
	local mutant
	if npc then
		mutant = ix.poaching.MutantTable[npc:GetModel()]
	end
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
        local weapon = client:GetActiveWeapon()

        if (weapon and weapon:IsValid()) then
            local class = weapon:GetClass()

            if class:find("cw_") then
                if weapon:isReloading() then return client:Notify("You can not poach while you are reloading a weapon!") end
            end
        end

        local char = client:GetCharacter()
        local inv = char:GetInventory()

        if (not inv:HasItem(ix.item.instances[knife].uniqueID)) then
            client:Notify("Stop cheating, and notify developers")
        end

        local mutanttable = ix.poaching.MutantParts[mutant]
        local knifetier = ix.item.instances[knife].knifetier
        local loot = {}
        table.insert(loot, mutanttable["meattype"])

        for _, v in pairs(mutanttable["parts"]) do
            if (math.random(0, 100) < v[2]) then
                table.insert(loot, v[1])
            end
        end

        --Do animation, remove ragdoll and spawn loot
        local Hit = client:GetEyeTraceNoCursor()
        local npc = Hit.Entity

        if npc then
            if (npc:IsRagdoll() and ix.poaching.MutantTable[npc:GetModel()] and npc:GetPos():Distance(client:GetPos()) <= 55) then
                if npc:GetNetVar("beingSkinned", false) then
                    client:Notify("That mutant is being skinned by someone else!")

                    return
                end

                --client:ForceSequence("cidle_knife", nil, 5)
                npc:SetNetVar("beingSkinned", true)
                npc:EmitSound("stalkersound/inv_mutant_loot_animal.ogg", 60)
                client:SetNetVar("IsPoaching", true)

                ix.util.PlayerPerformBlackScreenAction(client, "Poaching (Press F to Cancel)", 5, function(player)
                    if not player:GetNetVar("IsPoaching") then
                        npc:SetNetVar("beingSkinned", false)
                        npc:StopSound("stalkersound/inv_mutant_loot_animal.ogg")

                        return
                    end

                    local position = client:GetItemDropPos()

                    if IsValid(npc) then
                        npc:Remove()

                        for _, v in pairs(loot) do
                            local weight = ix.util.GetMutantMeatWeight(v, knifetier)
                            local dat = {}

                            if (weight) then
                                dat = {
                                    ["weight"] = weight,
                                    ["tier"] = knifetier
                                }
                            end

                            if (IsValid(client) and client:GetCharacter() and not inv:Add(v, 1, dat)) then
                                ix.item.Spawn(v, position, nil, AngleRand(), dat)
                                position = position + Vector(0, 0, 5)
                                client:Notify("No space in your inventory! Items have been dropped.")
                            end
                        end

                        player:SetNetVar("IsPoaching", false)
                    end
                end)
            end
        end
    end)
end
