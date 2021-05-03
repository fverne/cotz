ITEM.name = "Bloodsucker Meat"
ITEM.description = "Uncooked meat from a Bloodsucker."
ITEM.longdesc = "Bloodsucker meat is stringy and thus not suited for eating. Although bloodsuckers are fearsome beasts, the price of the meat is not very high due to its limited use. Can be sold to the scientists. Moreover, it can also serve as a source of animal fat for gun lubrication."
ITEM.model = "models/lostsignalproject/items/consumable/raw_bloodsucker.mdl"

ITEM.price = 1250
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.190
ITEM.BaseWeight = 3.436
ITEM.WeightPerLevel = 1.284

ITEM.meal = "meal_bloodsucker"

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_15.png")

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 45/20 })
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

function ITEM:PopulateTooltipIndividual(tooltip)
	if !self.entity then
		
		ix.util.PropertyDesc(tooltip, "High Tier Mutant Meat", Color(0, 255, 0))
		ix.util.PropertyDesc(tooltip, "Toxic Food", Color(255, 0, 0))
	end
end