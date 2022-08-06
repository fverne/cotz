ITEM.name = "Vareshka Meat"
ITEM.description = "Uncooked meat from a Vareshka."
ITEM.longdesc = "A chunk of vareshka meat. Meat from this hulking ape-like creature is tough and chewy, but it will fill you up, and will be a feast after taking one of them down."
ITEM.model = "models/lostsignalproject/items/consumable/raw_chimera.mdl"

ITEM.price = 1260
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.070
ITEM.BaseWeight = 2.144
ITEM.WeightPerLevel = 0.943

ITEM.meal = "meal_vareshka"

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 62/20 })
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

function ITEM:PopulateTooltipIndividual(tooltip)
	if !self.entity then
		
		ix.util.PropertyDesc(tooltip, "High Tier Mutant Meat", Color(0, 255, 0))
		ix.util.PropertyDesc(tooltip, "Toxic Food", Color(255, 0, 0))
	end
end