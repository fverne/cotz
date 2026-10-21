ITEM.name = "Braised Bloodsucker"
ITEM.description = "A meal made from a bloodsucker, cooked in the zone."
ITEM.longdesc = "Chunks of Bloodsucker meat, braised for a long time to be as tender as possible. The taste still leaves much to be desired, but the meat is very filling."
ITEM.model = "models/lostsignalproject/items/consumable/meat_bloodsucker.mdl"

ITEM.price = 1800
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.130

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_4.png")

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM.message = "eats a bit of their "..ITEM.name.."."

ITEM.blackScreenAction = function(item, player)
	player:AddBuff("debuff_radiation", 10, { amount = 15/20 })
end

function ITEM:PopulateTooltipIndividual(tooltip)
	if !IsValid(self.entity) then
		
		ix.util.PropertyDesc(tooltip, "Mutant Meal", Color(0, 255, 0))
	end
end