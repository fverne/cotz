ITEM.name = "Pseudogiant Meat"
ITEM.description = "Uncooked meat from a Pseudogiant."
ITEM.longdesc = "A heavy chunk of pseudogiant meat. Since pseudogiants can easily be considered the apex predator of the Zone, their meat is highly valued by veteran stalkers who are willing to buy it for fairly high prices. Can be sold to the scientists."
ITEM.model = "models/lostsignalproject/items/consumable/raw_chimera.mdl"

ITEM.price = 7800
ITEM.width = 2
ITEM.height = 2

ITEM.WeightPerHunger = 0.100
ITEM.BaseWeight = 8.144
ITEM.WeightPerLevel = 2.843

ITEM.meal = "meal_pseudogiant"

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 82/20 })
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

function ITEM:PopulateTooltipIndividual(tooltip)
	if !self.entity then
		
		ix.util.PropertyDesc(tooltip, "High Tier Mutant Meat", Color(0, 255, 0))
		ix.util.PropertyDesc(tooltip, "Toxic Food", Color(255, 0, 0))
	end
end