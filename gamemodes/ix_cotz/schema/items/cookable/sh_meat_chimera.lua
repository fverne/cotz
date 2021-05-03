ITEM.name = "Chimera Meat"
ITEM.description = "Uncooked meat from a Chimera."
ITEM.longdesc = "A heavy chunk of chimera meat. Since chimeras are considered one of the most dangerous creatures, their meat is highly valued by veteran stalkers who are willing to buy it for fairly high prices. The cook on Skadovsk uses this meat as one of the ingredients of the so called masculine meal, although only few claim that it tastes better than boar meat. Can be sold to the scientists. Furthermore, it provides the best quality animal fat available in the Zone which can be used for the purposes of very effective gun lubrication."
ITEM.model = "models/lostsignalproject/items/consumable/raw_chimera.mdl"

ITEM.price = 1560
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.120
ITEM.BaseWeight = 4.144
ITEM.WeightPerLevel = 1.843

ITEM.meal = "meal_chimera"

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