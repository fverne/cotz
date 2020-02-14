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
		["tier1"] = {"flesheye", "dogtail", "skinningknife"},
		["tier2"] = "dogtail",
		["tier3"] = {"flesheye", "dogtail", "skinningknife"},
	},
	["zombie"] = {
		["tier1"] = "makarov",
		["tier2"] = "9x18",
		["tier3"] = "cig1",
	}
}

function PLUGIN:GetLoot(mutant, knife)
	for k, v in pairs(ix.MutantParts) do
		if k == mutant then
			for k2, v2 in pairs(v) do
				if k2 == ix.item.list[knife].knifeTier then
					netstream.Start(client, "mutantPoachOpen", client, mutant, v2, knife)
				end
			end	
		end
	end
end


/*
if (npc:IsRagdoll() and ix.MutantTable[npc:GetModel()] and npc:GetPos():Distance( client:GetPos() ) <= 55) then
	client:SetAction("Poaching", 5)
	client:Freeze(true) 
	client:ForceSequence("Cidle All")
	npc:EmitSound( "interface/inv_mutant_loot_animal.ogg", 60, 100 )
	client:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 3 ) 
	timer.Simple(1,function() 
		client:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 3 ) 
	end)
	timer.Simple(5, function() 
		client:Freeze(false)
		if IsValid(npc) then
			npc:Remove()
		end
		for i = 1, item.knifeTier do
			ix.item.Spawn(ix.MutantTable[npc:GetModel()], npc:GetPos() + Vector(0, 0, 8) )
		end
	end)
end