ITEM.name = "Cooked Controller Meat"
ITEM.description = "A meal made from controllers, cooked in the zone."
ITEM.longdesc = "A small stew made from meat of a Controller. Even cooked, the meat still carries powerful psychic energies."
ITEM.model = "models/lostsignalproject/items/consumable/meat_flesh.mdl"

ITEM.price = 2300
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.020

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_9.png")

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM.message = "eats a bit of their "..ITEM.name.."."

ITEM.blackScreenAction = function(item, player)
	player:AddBuff("debuff_radiation", 10, { amount = 5/20 })
	player:AddBuff("debuff_psy", 10, {amount = 35/20})
end

function ITEM:PopulateTooltipIndividual(tooltip)
	if !IsValid(self.entity) then
		
		ix.util.PropertyDesc(tooltip, "Mutant Meal", Color(0, 255, 0))
	end
end