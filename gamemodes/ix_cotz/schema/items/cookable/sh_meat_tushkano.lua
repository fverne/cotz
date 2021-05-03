ITEM.name = "Tushkano Meat"
ITEM.description = "Uncooked meat from a Tushkano."
ITEM.longdesc = "A small portion of a mutated rodent's body. A cheap and commonly found food that is said to strengthen your heart after being cooked in open fire. Can be sold to the scientists."
ITEM.model = "models/lostsignalproject/items/consumable/raw_tushkano.mdl"

ITEM.price = 35
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.070
ITEM.BaseWeight = 0.423
ITEM.WeightPerLevel = 0.112

ITEM.meal = "meal_tushkano"

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_19.png")

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 9/20 })
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

function ITEM:PopulateTooltipIndividual(tooltip)
	if !self.entity then
		
		ix.util.PropertyDesc(tooltip, "Low Tier Mutant Meat", Color(0, 255, 0))
		ix.util.PropertyDesc(tooltip, "Toxic Food", Color(255, 0, 0))
	end
end