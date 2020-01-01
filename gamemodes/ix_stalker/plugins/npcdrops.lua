PLUGIN.name = "NPC Drops"
PLUGIN.author = "some faggot"
PLUGIN.desc = "Makes our npc's drop items"

function PLUGIN:OnNPCKilled(entity, attacker, inflictor)
	local class = entity:GetClass()
//	local zombieitems = {"bread","cannedbeans","cannedchilibeans","cannedcorn","cannedtomato","cannedtuna","cannedtushonka","dietsausage","energydrink","juice","milk","milkold","moonshine","oldmeat","touristsdelight","vodka","waterdirty","cig1","cig2","cig3","bandage"}
--	print(class)
	
	if !attacker:IsPlayer() then
		return
	end

	if class == "npc_mutant_classiczombie" then
/*		if math.random(101) < 15 then -- 15 %
			ix.item.Spawn(table.Random(zombieitems), entity:GetPos() + Vector(0, 0, 8))
		end*/
		if math.random(101) < 25 then -- 15 %
			ix.item.Spawn("zombiehand", entity:GetPos() + Vector(0, 0, 8))
		end
	end
	
	if class == "npc_mutant_boar" then
		if math.random(101) < 25 then -- 15 %
			ix.item.Spawn("boarhoof", entity:GetPos() + Vector(0, 0, 8))
		end
		if math.random(101) < 25 then -- 15 %
			--ix.item.Spawn("meat_boar", entity:GetPos() + Vector(0, 0, 8))
		end
	end
	
	if class == "npc_mutant_dog" then
		if math.random(101) < 25 then -- 15 %
			ix.item.Spawn("dogtail", entity:GetPos() + Vector(0, 0, 8))
		end	
		if math.random(101) < 25 then -- 15 %
			--ix.item.Spawn("meat_dog", entity:GetPos() + Vector(0, 0, 8))
		end
	end
	
	if class == "npc_mutant_flesh" then
		if math.random(101) < 25 then -- 15 %
			ix.item.Spawn("flesheye", entity:GetPos() + Vector(0, 0, 8))
		end
		if math.random(101) < 25 then -- 15 %
		--	ix.item.Spawn("meat_flesh", entity:GetPos() + Vector(0, 0, 8))
		end
	end
	
	if class == "npc_mutant_pseudodog" then
		if math.random(101) < 25 then -- 15 %
			ix.item.Spawn("pseudodogtail", entity:GetPos() + Vector(0, 0, 8))
		end
		if math.random(101) < 25 then -- 15 %
			--ix.item.Spawn("meat_dog", entity:GetPos() + Vector(0, 0, 8))
		end
	end
	
	if class == "npc_mutant_rodent" then
		if math.random(101) < 25 then -- 15 %
			ix.item.Spawn("rodentsear", entity:GetPos() + Vector(0, 0, 8))
		end
		if math.random(101) < 15 then -- 15 %
			--ix.item.Spawn("meat_rodent", entity:GetPos() + Vector(0, 0, 8))
		end
	end
	
	if class == "npc_mutant_snork" then
		if math.random(101) < 25 then -- 15 %
			ix.item.Spawn("snorksfoot", entity:GetPos() + Vector(0, 0, 8))
		end
		if math.random(101) < 25 then -- 15 %
			--ix.item.Spawn("meat_snork", entity:GetPos() + Vector(0, 0, 8))
		end
	end

	if class == "npc_crow" then
		if math.random(101) < 100 then -- 15 %
			ix.item.Spawn("crowbeak", entity:GetPos() + Vector(0, 0, 8))
		end
		if math.random(101) < 25 then -- 15 %
			--ix.item.Spawn("meat_bird", entity:GetPos() + Vector(0, 0, 8))
		end
	end
end

local PLUGIN = PLUGIN
