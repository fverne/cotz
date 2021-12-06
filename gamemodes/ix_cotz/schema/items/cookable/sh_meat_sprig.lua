ITEM.name = "Sprig Meat"
ITEM.description = "Uncooked meat from a Sprig."
ITEM.longdesc = "A small portion of strangely soft wood. Can be cooked and eaten, but has an odd taste. Scientists seem interested in this."
ITEM.model = "models/lostsignalproject/items/consumable/salmon.mdl"

ITEM.price = 300
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.040
ITEM.BaseWeight = 0.376
ITEM.WeightPerLevel = 0.126

ITEM.exRender = true 
ITEM.material = "nickmaps/rostok/trees/trees_bark_a_02"

ITEM.meal = "meal_sprig"

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
