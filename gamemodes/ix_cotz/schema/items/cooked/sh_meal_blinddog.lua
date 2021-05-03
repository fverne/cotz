ITEM.name = "Dog Chops"
ITEM.description = "A meal made from a dog, cooked in the zone."
ITEM.longdesc = "This meat has been cooked in the zone, and the meat originates from a dog. The meal is not very well-tasting, mostly due to the low fat content of the meat, and the meat not being very tender."
ITEM.model = "models/lostsignalproject/items/consumable/meat_dog.mdl"

ITEM.price = 120
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.040

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 4/20 })
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)


function ITEM:PopulateTooltipIndividual(tooltip)
	if !IsValid(self.entity) then
		
		ix.util.PropertyDesc(tooltip, "Mutant Meal", Color(0, 255, 0))
	end
end