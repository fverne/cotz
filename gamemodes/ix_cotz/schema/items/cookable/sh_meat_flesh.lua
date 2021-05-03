ITEM.name = "Flesh Meat"
ITEM.description = "Uncooked meat from a Flesh."
ITEM.longdesc = "A popular choice in the Zone, flesh meat has a good taste and high nutritional value. The scientists have enough samples already, which limits its use as a commodity. However, it can also serve as a source of animal fat for gun lubrication."
ITEM.model = "models/lostsignalproject/items/consumable/raw_flesh.mdl"

ITEM.price = 180
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.040
ITEM.BaseWeight = 0.843
ITEM.WeightPerLevel = 0.363

ITEM.meal = "meal_flesh"

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_11.png")

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 18/20 })
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

function ITEM:PopulateTooltipIndividual(tooltip)
	if !self.entity then
		
		ix.util.PropertyDesc(tooltip, "Low Tier Mutant Meat", Color(0, 255, 0))
		ix.util.PropertyDesc(tooltip, "Toxic Food", Color(255, 0, 0))
	end
end