ITEM.name = "Cooked Karlik Meat"
ITEM.description = "A meal made from karliks, cooked in the zone."
ITEM.longdesc = "A small stew made from meat of a midget-like karlik. Has a bit of a psychoactive effect."
ITEM.model = "models/lostsignalproject/items/consumable/meat_flesh.mdl"

ITEM.price = 1890
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.015

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_4.png")

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM.message = "eats a bit of their "..ITEM.name.."."

ITEM.blackScreenAction = function(item, player)
	player:AddBuff("debuff_radiation", 10, { amount = 5/20 })
	player:AddBuff("debuff_psy", 10, {amount = 25/20})
end

function ITEM:PopulateTooltipIndividual(tooltip)
	if !IsValid(self.entity) then
		
		ix.util.PropertyDesc(tooltip, "Mutant Meal", Color(0, 255, 0))
	end
end