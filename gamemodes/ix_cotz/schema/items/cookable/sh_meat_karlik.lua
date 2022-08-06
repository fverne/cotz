ITEM.name = "Karlik Meat"
ITEM.description = "Uncooked meat from a karlik."
ITEM.longdesc = "Meat from a karlik. The meat of this midget-like creature has a bit of a psychoactive effect, and as such is sometimes used recreationally by stalkers."
ITEM.model = "models/lostsignalproject/items/consumable/raw_flesh.mdl"

ITEM.price = 890
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.035
ITEM.BaseWeight = 1.561
ITEM.WeightPerLevel = 0.349

ITEM.meal = "meal_karlik"

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_14.png")

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 15/20 })
	item.player:AddBuff("debuff_psy", 10, {amount = 25/20})
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

function ITEM:PopulateTooltipIndividual(tooltip)
	if !self.entity then
		
		ix.util.PropertyDesc(tooltip, "High Tier Meat", Color(0, 255, 0))
		ix.util.PropertyDesc(tooltip, "Toxic Food", Color(255, 0, 0))
	end
end