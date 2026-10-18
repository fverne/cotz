ITEM.name = "Boiled Flesh"
ITEM.description = "A meal made from a flesh, cooked in the zone."
ITEM.longdesc = "Strips of Flesh meat boiled until juicy and tender. Should keep your stomach full for a good while, although the taste is nothing special."
ITEM.model = "models/lostsignalproject/items/consumable/meat_flesh.mdl"

ITEM.price = 490
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.025

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_1.png")

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM.message = "eats a bit of their "..ITEM.name.."."

ITEM.blackScreenAction = function(item, player)
	player:AddBuff("debuff_radiation", 10, { amount = 3/20 })
end

function ITEM:PopulateTooltipIndividual(tooltip)
	if !IsValid(self.entity) then
		
		ix.util.PropertyDesc(tooltip, "Mutant Meal", Color(0, 255, 0))
	end
end