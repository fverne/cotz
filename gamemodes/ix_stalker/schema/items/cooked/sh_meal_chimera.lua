ITEM.name = "Chimera Steak"
ITEM.description = "A meal made from a chimera, cooked in the zone."
ITEM.longdesc = "A seared roast cut from a Chimera. It is pretty tender, with just a slight off taste. If you close your eyes while eating, you can almost convince yourself you're eating a nice cut of beef."
ITEM.model = "models/lostsignalproject/items/consumable/raw_chimera.mdl"

ITEM.price = 3360
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.080

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 18/20 })
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)


function ITEM:PopulateTooltipIndividual(tooltip)
	if !IsValid(self.entity) then
		
		ix.util.PropertyDesc(tooltip, "Mutant Meal", Color(0, 255, 0))
	end
end