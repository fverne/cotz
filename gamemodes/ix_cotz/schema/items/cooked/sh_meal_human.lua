ITEM.name = "Cooked Human Meat"
ITEM.description = "A meal made from decomposing humans, cooked in the zone."
ITEM.longdesc = "Not even the finest chefs could save this meal. Smells awful, but it would probably fill you up as a last resort."
ITEM.model = "models/lostsignalproject/items/consumable/meat_flesh.mdl"

ITEM.price = 250
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.025

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_3.png")

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM.message = "eats a bit of their "..ITEM.name.."."

ITEM.blackScreenAction = function(item, player)
	player:AddBuff("debuff_radiation", 10, { amount = 7/20 })
	player:AddBuff("debuff_psy", 10, {amount = 15/20})
end

function ITEM:PopulateTooltipIndividual(tooltip)
	if !IsValid(self.entity) then
		
		ix.util.PropertyDesc(tooltip, "Mutant Meal", Color(0, 255, 0))
	end
end