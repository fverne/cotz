ITEM.name = "Snork Hand"
ITEM.description = "Uncooked meat from a snork."
ITEM.longdesc = "An uncooked snork hand. Legend has that they bring luck when you eat them, albeit veterans tend to cook them first."
ITEM.model = "models/lostsignalproject/items/consumable/raw_snork.mdl"

ITEM.price = 450
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.120
ITEM.BaseWeight = 0.387
ITEM.WeightPerLevel = 0.129

ITEM.meal = "meal_snork"

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 25/20 })
	item.player:AddBuff("debuff_psy", 10, {amount = 15/20})
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

function ITEM:PopulateTooltipIndividual(tooltip)
	if !self.entity then
		
		ix.util.PropertyDesc(tooltip, "Low Tier Meat", Color(0, 255, 0))
		ix.util.PropertyDesc(tooltip, "Toxic Food", Color(255, 0, 0))
	end
end