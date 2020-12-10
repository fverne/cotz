ITEM.name = "Cat Strips"
ITEM.description = "A meal made from a cat, cooked in the zone."
ITEM.longdesc = "Thin cuts of Cat meat, cut across the grain to make the meat as tender as possible, although it's still quite tough and chewy."
ITEM.model = "models/lostsignalproject/items/consumable/food_chimera.mdl"

ITEM.price = 340
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.055

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 6/20 })
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)


function ITEM:PopulateTooltipIndividual(tooltip)
	if !IsValid(self.entity) then
		
		ix.util.PropertyDesc(tooltip, "Mutant Meal", Color(0, 255, 0))
	end
end