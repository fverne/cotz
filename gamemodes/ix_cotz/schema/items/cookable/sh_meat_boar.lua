ITEM.name = "Boar Meat"
ITEM.description = "Uncooked meat from a Boar."
ITEM.longdesc = "The most popular meat in the Zone. Nutritious and hardly contaminated. The scientists have enough samples already, which limits its use as a commodity. However, it can also serve as a source of animal fat for gun lubrication."
ITEM.model = "models/lostsignalproject/items/consumable/raw_boar.mdl"

ITEM.price = 140
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.140
ITEM.BaseWeight = 2.028
ITEM.WeightPerLevel = 0.665

ITEM.meal = "meal_boar"

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_12.png")

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 8/20 })
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

function ITEM:PopulateTooltipIndividual(tooltip)
	if !self.entity then
		
		ix.util.PropertyDesc(tooltip, "Low Tier Mutant Meat", Color(0, 255, 0))
		ix.util.PropertyDesc(tooltip, "Toxic Food", Color(255, 0, 0))
	end
end
