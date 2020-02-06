ITEM.name = "Skinning Knife (Tier 1)"
ITEM.description = "A knife for mutant poaching."
ITEM.model = "models/kek1ch/notes_letter_1.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.price = 500
ITEM.flag = "A"
ITEM.value = ITEM.price*0.5
ITEM.knifeTier = 3

ITEM.functions.SkinTarget = {
	name = "Skin Mutant",
	tip = "equipTip",
	icon = "icon16/stalker/equip.png",
	OnRun = function(item)
		local client = item.player
		if (client:GetCharacter()) then
			if (client:Alive()) then
				local Hit = client:GetEyeTraceNoCursor()
				local npc = Hit.Entity
				if item.knifeTier then
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
				end
			end
		end

		return false
	end,
	OnCanRun = function(item)
		return !IsValid(item.entity)
	end
}