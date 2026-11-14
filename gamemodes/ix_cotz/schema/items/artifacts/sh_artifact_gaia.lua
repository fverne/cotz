ITEM.name = "Gaia"
ITEM.model ="models/lostsignalproject/items/artefacts/bat.mdl"
ITEM.description = "A glowing blue orb encased in a wing-like shroud."
ITEM.longdesc = "This artifact is also called 'Heart of the Planet' by some, 'Seed from the Tree of Life' by others, given its ability to seemingly speed up biological growth in a small area around it.\nIt's not a very practical artifact for STALKERs, however it's very sought after by the outside world. How it manages to accelerate the growths of living beings is still a mystery, however, it might explain some of the extreme mutations and evolutions of some of the fauna in the exclusion zone."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 29437.5
ITEM.flag = "A"
ITEM.rarity = 7
ITEM.baseweight = 1.800
ITEM.varweight  = 0.300

ITEM.JumpPower = 400

ITEM.exRender = true

ITEM.functions.use = {
	name = "Meditate",
 	icon = "icon16/stalker/heal.png",
    sound = "physics/metal/chain_impact_soft2.wav",
    OnRun = function(item)
        if item.player:Health() < item.player:GetMaxHealth() then
        	item.player:AddBuff("buff_meditation", -1, { min = 1, max = 5 })
        end
        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and item.invID == item.player:GetCharacter():GetInventory():GetID()
    end
}

function ITEM:GetPropertyEffects()
	return {
		{buff = "buff_meditation", duration = -1, min = 1, max = 5},
	}
end
