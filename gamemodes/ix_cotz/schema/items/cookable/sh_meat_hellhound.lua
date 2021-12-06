ITEM.name = "Hellhound Meat"
ITEM.description = "Uncooked meat from a Hellhound."
ITEM.longdesc = "This chunk of meat from the mutated type of dog called a Hellhound feels warm to the touch, even though it was killed hours ago. Considered a delicacy among STALKERs used to eating the regular dog meat."
ITEM.model = "models/lostsignalproject/items/consumable/raw_dog.mdl"

ITEM.price = 1680
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.040
ITEM.BaseWeight = 0.688
ITEM.WeightPerLevel = 0.276

ITEM.meal = "meal_hellhound"

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_13.png")

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 16/20 })
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

function ITEM:PopulateTooltipIndividual(tooltip)
	if !self.entity then
		
		ix.util.PropertyDesc(tooltip, "Low Tier Mutant Meat", Color(0, 255, 0))
		ix.util.PropertyDesc(tooltip, "Toxic Food", Color(255, 0, 0))
	end
end