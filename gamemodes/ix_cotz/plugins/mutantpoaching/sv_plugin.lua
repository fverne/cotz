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
	["models/monsters/chimera3.mdl"] = "chimera", -- replace with firechimera
	["models/gsc/s.t.a.l.k.e.r/monsters/burer.mdl"] = "burer",
	["models/monsters/cat.mdl"] = "cat",
	["models/monsters/karlik.mdl"] = "karlik",
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
		["parts"] = {{"part_bloodsucker", 25}, {"hide_bloodsucker", 2}},
	},
	["flesh"] = {
		["meattype"] = "meat_flesh",
		["parts"] = {{"part_flesh", 75}, {"hide_flesh", 3}},
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
		["parts"] = {{"part_burer_1", 45}, {"part_burer_2", 5}, {"hide_burer", 2}},
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
		["parts"] = {{"part_sprig", 20}, {"hide_sprig", 8}},
	},
	["controller"] = {
		["meattype"] = "meat_controller",
		["parts"] = {{"part_controller_1", 20}, {"part_controller_2", 4}, {"hide_controller", 3}, {"artifact_compass", 1}, },
	},
	["swampcontroller"] = {
		["meattype"] = "meat_controller",
		["parts"] = {{"part_swampcontroller_1", 20}, {"part_swampcontroller_2", 5}, {"hide_swampcontroller", 3}, {"artifact_photo", 1}, },
	},
	["electrocontroller"] = {
		["meattype"] = "meat_controller",
		["parts"] = {{"part_electrocontroller_1", 20}, {"part_electrocontroller_2", 5}, {"hide_electrocontroller", 3}, {"artifact_storm", 1}, },
	},
	["bear"] = {
		["meattype"] = "meat_bear",
		["parts"] = {{"part_bear", 20}, {"hide_bear", 3}},
	},
	["skeleton"] = {
		["meattype"] = "artifact_bonecluster",
		["parts"] = {{"part_skeleton", 40}},
	},
	["pseudogiant"] = {
		["meattype"] = "meat_pseudogiant",
		["parts"] = {{"part_pseudogiant", 20}, {"hide_pseudogiant", 3}},
	},
	["pseudogiantfast"] = {
		["meattype"] = "meat_pseudogiant",
		["parts"] = {{"part_pseudogiant", 25}, {"hide_pseudogiant", 5}},
	},
	["hellhound"] = {
		["meattype"] = "meat_hellhound",
		["parts"] = {{"part_hellhound", 50}},-- {"hide_hellhound", 3}},
	},
	["electrochimera"] = {
		["meattype"] = "meat_chimera",
		["parts"] = {{"part_chimera", 20}, {"artifact_moonlight", 45}, {"artifact_moonlight", 45}, {"artifact_moonlight", 45}, {"artifact_moonlight", 45}, {"hide_chimera", 3}},
	},
	["fastcontroller"] = {
		["meattype"] = "meat_controller",
		["parts"] = {{"part_controller_1", 20}, {"part_controller_2", 4}, {"hide_controller", 3}, {"artifact_moon", 1}, },
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
		["parts"] = {{"part_spider", 20}, {"hide_spider", 8}},
	},

}
ix.poaching.KnifeTime = {
		["tfa_nmrih_combatknife"] =  3,
		["tfa_nmrih_oldknife"] =  3.5,
		["tfa_nmrih_shankknife"] = 4,
		["tfa_nmrih_survivalknife"] = 3,
}

local POACH_DISTANCE = 55
local DEFAULT_POACH_TIME = 5
local activePoaches = {}

local function finishPoach(client, operation)
	if activePoaches[client] ~= operation then return end
	activePoaches[client] = nil
	if IsValid(client) then
		client:SetNetVar("IsPoaching", false)
	end
	if IsValid(operation.npc) then
		operation.npc:SetNetVar("beingSkinned", false)
		operation.npc:StopSound("stalkersound/inv_mutant_loot_animal.ogg")
	end
end

local function ownedKnife(client, knifeID)
	local character = client:GetCharacter()
	if not character then return end
	local knife = character:GetInventory():GetItems()[knifeID]
	if not knife or not knife.isPoachKnife or not knife:GetData("equip", false) then return end

	return knife
end

function PLUGIN:PlayerButtonDown(client, key)
	local operation = activePoaches[client]
	if key ~= KEY_F or not operation then return end
	ix.util.PlayerActionInterrupt(client)
	finishPoach(client, operation)
end

function PLUGIN:KeyPress(client, key)
	local operation = activePoaches[client]
	if operation then
		ix.util.PlayerActionInterrupt(client)
		finishPoach(client, operation)

		return
	end
	if key ~= IN_USE or not client:Alive() or not client:GetCharacter() then return end
	local npc = client:GetEyeTraceNoCursor().Entity
	if not IsValid(npc) or not npc:IsRagdoll() then return end
	local mutant = ix.poaching.MutantTable[npc:GetModel()]
	if not mutant or npc:GetPos():Distance(client:GetPos()) > POACH_DISTANCE then return end
	for _, knife in pairs(client:GetCharacter():GetInventory():GetItems()) do
		if knife.isPoachKnife and knife:GetData("equip", false) then
			self:OpenPoachMenu(client, mutant, knife:GetID())

			return
		end
	end
	client:Notify("You need an equipped knife to poach mutants.")
end

local function givePoachingLoot(client, inventory, mutant, knifeTier)
	local parts = ix.poaching.MutantParts[mutant]
	local loot = {parts.meattype}
	for _, part in ipairs(parts.parts) do
		if math.random(0, 100) < part[2] then
			loot[#loot + 1] = part[1]
		end
	end
	local position = client:GetItemDropPos()
	for _, uniqueID in ipairs(loot) do
		local data = {
			weight = ix.util.GetMutantMeatWeight(uniqueID, knifeTier),
			tier = knifeTier,
		}
		if not inventory:Add(uniqueID, 1, data) then
			ix.item.Spawn(uniqueID, position, function(_, entity) entity.bTemporary = true end, AngleRand(), data)
			position = position + Vector(0, 0, 5)
			client:Notify("No space in your inventory! Items have been dropped.")
		end
	end
	ix.weight.Update(client:GetCharacter())
end

function PLUGIN:OpenPoachMenu(client, mutant, knifeID)
	if activePoaches[client] or not client:Alive() then return end
	local knife = ownedKnife(client, knifeID)
	if not knife or not ix.poaching.MutantParts[mutant] then return end
	if ix.poaching.GetSharpness(knife) <= 0 then
		client:Notify("Your knife is dull. Use a sharpening stone before poaching.")

		return
	end
	local weapon = client:GetActiveWeapon()
	if IsValid(weapon) and weapon:GetClass():find("cw_") and weapon:isReloading() then
		client:Notify("You can not poach while you are reloading a weapon!")

		return
	end
	local npc = client:GetEyeTraceNoCursor().Entity
	if not IsValid(npc) or not npc:IsRagdoll() then return end
	if ix.poaching.MutantTable[npc:GetModel()] ~= mutant then return end
	if npc:GetPos():Distance(client:GetPos()) > POACH_DISTANCE then return end
	if npc:GetNetVar("beingSkinned", false) then
		client:Notify("That mutant is being skinned by someone else!")

		return
	end
	local character = client:GetCharacter()
	local operation = {npc = npc, character = character, knife = knife}
	local poachingTime = ix.poaching.KnifeTime[knife.class] or DEFAULT_POACH_TIME
	activePoaches[client] = operation
	npc:SetNetVar("beingSkinned", true)
	npc:EmitSound("stalkersound/inv_mutant_loot_animal.ogg", 60)
	client:SetNetVar("IsPoaching", true)

	ix.util.PlayerPerformBlackScreenAction(client, "Poaching", poachingTime, function(player)
		if activePoaches[player] ~= operation then return end
		local wasPoaching = player:GetNetVar("IsPoaching", false)
		finishPoach(player, operation)
		if not wasPoaching or not player:Alive() or player:GetCharacter() ~= character then return end
		if ownedKnife(player, knifeID) ~= knife or ix.poaching.GetSharpness(knife) <= 0 then return end
		if not IsValid(npc) or ix.poaching.MutantTable[npc:GetModel()] ~= mutant then return end
		if npc:GetPos():Distance(player:GetPos()) > POACH_DISTANCE then return end
		local knifeTier = ix.poaching.GetKnifeTier(knife)
		ix.poaching.WearKnife(knife)
		npc:Remove()
		givePoachingLoot(player, character:GetInventory(), mutant, knifeTier)
	end)

	-- The shared action helper skips its callback when another system interrupts it.
	timer.Simple(poachingTime + 0.1, function()
		finishPoach(client, operation)
	end)
end
