ITEM.name = "Boar Chops"
ITEM.description = "A meal made from a boar, cooked in the zone."
ITEM.longdesc = "A nicely seared pork chop from a wild boar. A little more gamey than the stuff you'd find outside the zone, but still pretty tasty."
ITEM.model = "models/lostsignalproject/items/consumable/meat_boar.mdl"

ITEM.price = 320
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.090

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 2/20 })
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)


function ITEM:PopulateTooltipIndividual(tooltip)
	if !IsValid(self.entity) then
		
		ix.util.PropertyDesc(tooltip, "Mutant Meal", Color(0, 255, 0))
	end
end