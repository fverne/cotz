ITEM.name = "Pseudodog Stew"
ITEM.description = "A meal made from a pseudodog, cooked in the zone."
ITEM.longdesc = "A thick stew made primarily from Pseudodog meat. Surprisingly tasty, if you take into consideration where the meat comes from."
ITEM.model = "models/lostsignalproject/items/consumable/meat_pseudodog.mdl"

ITEM.price = 455
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.055

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 5/20 })
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)


function ITEM:PopulateTooltipIndividual(tooltip)
	if !IsValid(self.entity) then
		
		ix.util.PropertyDesc(tooltip, "Mutant Meal", Color(0, 255, 0))
	end
end