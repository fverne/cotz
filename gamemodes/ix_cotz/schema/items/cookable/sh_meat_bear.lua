ITEM.name = "Bear Meat"
ITEM.description = "Uncooked meat from a Bear."
ITEM.longdesc = "The texture of the flesh is very smooth compared to other types of mutant meat. This type of meat is not very popular within the zone, and eating it uncooked is a bad idea, as it will quickly make you nauseous."
ITEM.model = "models/lostsignalproject/items/consumable/raw_pseudodog.mdl"

ITEM.price = 1700
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.070
ITEM.BaseWeight = 2.225
ITEM.WeightPerLevel = 0.428

ITEM.meal = "meal_bear"

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_16.png")

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 32/20 })
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

function ITEM:PopulateTooltipIndividual(tooltip)
	if !self.entity then
		
		ix.util.PropertyDesc(tooltip, "Mid Tier Mutant Meat", Color(0, 255, 0))
		ix.util.PropertyDesc(tooltip, "Toxic Food", Color(255, 0, 0))
	end
end