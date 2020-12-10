ITEM.name = "Boiled Flesh"
ITEM.description = "A meal made from a flesh, cooked in the zone."
ITEM.longdesc = "Strips of Flesh meat boiled until juicy and tender. Should keep your stomach full for a good while, although the taste is nothing special."
ITEM.model = "models/lostsignalproject/items/consumable/meat_flesh.mdl"

ITEM.price = 390
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.025

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 3/20 })
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)


function ITEM:PopulateTooltipIndividual(tooltip)
	if !IsValid(self.entity) then
		
		ix.util.PropertyDesc(tooltip, "Mutant Meal", Color(0, 255, 0))
	end
end