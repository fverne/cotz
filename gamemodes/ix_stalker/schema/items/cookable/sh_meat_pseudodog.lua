ITEM.name = "Pseudodog Meat"
ITEM.description = "Uncooked meat from a Pseudodog."
ITEM.longdesc = "Pseudodog meat is a common dietary component in the Zone. Tasty, with high nutritional value, a popular choice among stalkers. Can be sold to the scientists. Moreover, it can also serve as a source of animal fat for gun lubrication."
ITEM.model = "models/lostsignalproject/items/consumable/raw_pseudodog.mdl"

ITEM.price = 340
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.110
ITEM.BaseWeight = 1.441
ITEM.WeightPerLevel = 0.433

ITEM.meal = "meal_pseudodog"

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_18.png")

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 25/10 })
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

function ITEM:PopulateTooltipIndividual(tooltip)
	if !self.entity then
		
		ix.util.PropertyDesc(tooltip, "Mid Tier Mutant Meat", Color(0, 255, 0))
		ix.util.PropertyDesc(tooltip, "Toxic Food", Color(255, 0, 0))
	end
end