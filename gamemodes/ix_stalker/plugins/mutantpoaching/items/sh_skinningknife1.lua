ITEM.name = "Skinning Knife (Tier 1)"
ITEM.description = "A knife for mutant poaching."
ITEM.model = "models/weapons/ws kabar/w_knife_t.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.price = 500
ITEM.flag = "A"
ITEM.value = ITEM.price*0.5
ITEM.meattickets = 2
ITEM.parttickets = 5

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
				if (npc:IsRagdoll() and ix.MutantTable[npc:GetModel()] and npc:GetPos():Distance( client:GetPos() ) <= 55) then
					local knife = item.uniqueID
					local mutant = ix.MutantTable[npc:GetModel()]

					ix.plugin.list["mutantpoaching"]:OpenPoachMenu(mutant, knife)
				end
			end
		end

		return false
	end,
	OnCanRun = function(item)
		return !IsValid(item.entity)
	end
}