ITEM.name = "Controller Meat"
ITEM.description = "Uncooked meat from a Controller."
ITEM.longdesc = "Meat from a controller. Incredibly dangerous to eat raw, as the latent psychic powers in the flesh will still affect the mind of the consumer."
ITEM.model = "models/lostsignalproject/items/consumable/raw_flesh.mdl"

ITEM.price = 1890
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.030
ITEM.BaseWeight = 2.761
ITEM.WeightPerLevel = 0.449

ITEM.meal = "meal_controller"

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_14.png")

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 25/20 })
	item.player:AddBuff("debuff_psy", 10, {amount = 45/20})
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

function ITEM:PopulateTooltipIndividual(tooltip)
	if !self.entity then
		
		ix.util.PropertyDesc(tooltip, "High Tier Meat", Color(0, 255, 0))
		ix.util.PropertyDesc(tooltip, "Toxic Food", Color(255, 0, 0))
	end
end