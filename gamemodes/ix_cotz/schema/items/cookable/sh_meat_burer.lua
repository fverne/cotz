ITEM.name = "Burer Meat"
ITEM.description = "Uncooked meat from a Burer."
ITEM.longdesc = "Meat from a Burer. Most STALKERs keep away from this meat, but it's extremely filling. Some STALKERs say it deterioates the mind."
ITEM.model = "models/lostsignalproject/items/consumable/raw_flesh.mdl"

ITEM.price = 960
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.070
ITEM.BaseWeight = 0.822
ITEM.WeightPerLevel = 0.186

-- ITEM.meattier = 2
ITEM.meal = "meal_burer"
ITEM.message = "eats a bit of their "..ITEM.name.."."
ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"

ITEM.blackScreenAction = function(item, player)
	player:AddBuff("debuff_radiation", 10, { amount = 48/20 })
	player:AddBuff("debuff_psy", 10, {amount = 20/20})
end

function ITEM:PopulateTooltipIndividual(tooltip)
	if !self.entity then
		
		ix.util.PropertyDesc(tooltip, "Low Tier Meat", Color(0, 255, 0))
		ix.util.PropertyDesc(tooltip, "Toxic Food", Color(255, 0, 0))
	end
end