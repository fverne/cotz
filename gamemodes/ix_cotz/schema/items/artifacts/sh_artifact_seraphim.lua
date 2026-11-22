ITEM.name = "Seraphim"
ITEM.model ="models/lostsignalproject/items/artefacts/serofim.mdl"
ITEM.description = "A glowing blue orb encased in a wing-like shroud."
ITEM.longdesc = "This artifact is also called 'Heart of the Planet' by some, 'Seed from the Tree of Life' by others, given its ability to seemingly speed up biological growth in a small area around it.\nIt's not a very practical artifact for STALKERs, however it's very sought after by the outside world. How it manages to accelerate the growths of living beings is still a mystery, however, it might explain some of the extreme mutations and evolutions of some of the fauna in the exclusion zone."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 39500
ITEM.flag = "A"
ITEM.rarity = 7
ITEM.baseweight = 1.200
ITEM.varweight  = 0.300
ITEM.restoreduration = 300
ITEM.meditationRadius = 400

ITEM.JumpPower = 400

ITEM.exRender = true

ITEM.functions.use = {
	name = "Meditate",
 	icon = "icon16/stalker_grey/heal.png",
    sound = "physics/metal/chain_impact_soft2.wav",
    OnRun = function(item)
        item.player:AddBuff("buff_meditation", item.restoreduration, { min = 1, max = 3, dur = item.restoreduration, aoe = item.meditationRadius, aoeMult = 1, healthNoStop = true, damageNoStop = true })
        return false
    end,
    OnCanRun = function(item)
        return !IsValid(item.entity) and item.invID == item.player:GetCharacter():GetInventory():GetID()
    end
}

function ITEM:GetPropertyEffects()
	return {
		{buff = "buff_meditation", duration = self.restoreduration, min = 1, max = 3},
	}
end

function ITEM:GetIndividualProperties()
	return {
		{id = "meditationRadius", text = "Area of effect: "
			.. ix.itemProperties.Format("distance", self.meditationRadius)},
	}
end
