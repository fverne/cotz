ITEM.name = "Dog Chops"
ITEM.description = "A meal made from a dog, cooked in the zone."
ITEM.longdesc = "The low fat content leaves it dry, with a tough bite and little flavour to recommend it. At a"
	.. " hungry camp, those objections rarely last long."
ITEM.model = "models/lostsignalproject/items/consumable/meat_dog.mdl"

ITEM.price = 420
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.040

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_3.png")

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM.message = "eats a bit of their "..ITEM.name.."."

ITEM.blackScreenAction = function(item, player)
	player:AddBuff("debuff_radiation", 10, { amount = 4/20 })
end

function ITEM:PopulateTooltipIndividual(tooltip)
	if !IsValid(self.entity) then
		
		ix.util.PropertyDesc(tooltip, "Mutant Meal", Color(0, 255, 0))
	end
end