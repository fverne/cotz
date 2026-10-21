ITEM.name = "Sprig Soup"
ITEM.description = "A meal made from a sprig, cooked in the zone."
ITEM.longdesc = "A nice hearthy soup cooked on the leg of a Sprig. Has a vegetable taste that is hard to place your finger on. The soup is filled with chunks of Sprig meat, and will leave you quite satisfied."
ITEM.model = "models/lostsignalproject/items/medical/drink_crow.mdl"

ITEM.price = 730
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.020

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_9.png")

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM.message = "eats a bit of their "..ITEM.name.."."

ITEM.blackScreenAction = function(item, player)
	player:AddBuff("debuff_radiation", 10, { amount = 2/20 })
end

function ITEM:PopulateTooltipIndividual(tooltip)
	if !IsValid(self.entity) then
		
		ix.util.PropertyDesc(tooltip, "Mutant Meal", Color(0, 255, 0))
	end
end