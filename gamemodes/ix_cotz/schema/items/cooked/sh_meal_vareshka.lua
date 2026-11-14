ITEM.name = "Vareshka Steak"
ITEM.description = "A meal made from a vareshka, cooked in the zone."
ITEM.longdesc = "Searing has browned the outside without doing much for the tough, chewy centre. Whoever cooked"
	.. " it seems to have favoured getting fed over making a memorable supper."
ITEM.model = "models/lostsignalproject/items/consumable/raw_chimera.mdl"

ITEM.price = 1382.4
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.060

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_2.png")

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM.message = "eats a bit of their "..ITEM.name.."."

ITEM.blackScreenAction = function(item, player)
	player:AddBuff("debuff_radiation", 10, { amount = 18/20 })
end

function ITEM:PopulateTooltipIndividual(tooltip)
	if !IsValid(self.entity) then
		
		ix.util.PropertyDesc(tooltip, "Mutant Meal", Color(0, 255, 0))
	end
end

function ITEM:GetPropertyEffects()
	return {
		{buff = "debuff_radiation", duration = 10, amount = 18/20},
	}
end
