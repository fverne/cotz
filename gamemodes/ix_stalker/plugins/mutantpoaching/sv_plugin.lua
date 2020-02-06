local PLUGIN = PLUGIN

ix.MutantTable = {
	["models/hdmodels/kek1ch/new_izlom_spen.mdl"] = "dogtail",
	["models/hdmodels/kek1ch/new_zombi_spen.mdl"] = "dogtail",
	["models/hdmodels/kek1ch/new_tush_spen.mdl"] = "dogtail",
	["models/hdmodels/kek1ch/new_snork_spen.mdl"] = "dogtail",
	["models/hdmodels/kek1ch/new_psydog_spen.mdl"] = "dogtail",
	["models/hdmodels/kek1ch/new_krovo_spen.mdl"] = "dogtail",
	["models/hdmodels/kek1ch/new_plot_spen.mdl"] = "dogtail",
	["models/hdmodels/kek1ch/new_dog_spen.mdl"] = "dogtail",
	["models/hdmodels/kek1ch/new_boar_spen.mdl"] = "dogtail",
	["models/hdmodels/kek1ch/new_chimer_spen.mdl"] = "dogtail",
}

function PLUGIN:KeyPress(client, key)
	if (client:GetCharacter()) then
		if (client:Alive()) then
			local Hit = client:GetEyeTraceNoCursor()
			local npc = Hit.Entity
			if (key == IN_USE) then
				for k,v in pairs(client:GetCharacter():GetInventory():GetItems()) do
					if v.knifeTier then
						if (npc:IsRagdoll() and MutantTable[npc:GetModel()] and npc:GetPos():Distance( client:GetPos() ) <= 55) then
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
								for i = 1, v.knifeTier do
									ix.item.Spawn(MutantTable[npc:GetModel()], npc:GetPos() + Vector(0, 0, 8) )
								end
							end)
						end
					end
				end
			end
		end
	end
end

