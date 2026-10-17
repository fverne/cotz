ITEM.name = "Burer Stew"
ITEM.description = "A meal made from a burer, cooked in the zone."
ITEM.longdesc = "A watery stew made from Burer meat. Eating this while thinking of the fact that there's one less Burer in the zone gives most STALKERs a peace of mind."
ITEM.model = "models/lostsignalproject/items/consumable/meat_pseudodog.mdl"

ITEM.price = 1420
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.035

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_6.png")

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM.message = "eats a bit of their "..ITEM.name.."."

ITEM.blackScreenAction = function(item, player)
	player:AddBuff("debuff_radiation", 10, { amount = 5/20 })
	player:AddBuff("buff_psyheal", 10, { amount = 10/20 })
end

function ITEM:PopulateTooltipIndividual(tooltip)
	if !IsValid(self.entity) then
		
		ix.util.PropertyDesc(tooltip, "Mutant Meal", Color(0, 255, 0))
	end
end