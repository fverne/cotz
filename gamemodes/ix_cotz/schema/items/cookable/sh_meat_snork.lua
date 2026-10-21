ITEM.name = "Snork Hand"
ITEM.description = "Uncooked meat from a snork."
ITEM.longdesc = "An uncooked snork hand. Legend has that they bring luck when you eat them, albeit veterans tend to cook them first."
ITEM.model = "models/lostsignalproject/items/consumable/raw_snork.mdl"

ITEM.price = 1250
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.120
ITEM.BaseWeight = 0.287
ITEM.WeightPerLevel = 0.129

ITEM.meal = "meal_snork"

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM.message = "eats a bit of their "..ITEM.name.."."

ITEM.blackScreenAction = function(item, player)
	player:AddBuff("debuff_radiation", 10, { amount = 25/20 })
	player:AddBuff("debuff_psy", 10, {amount = 15/20})
end

function ITEM:PopulateTooltipIndividual(tooltip)
	if !self.entity then
		
		ix.util.PropertyDesc(tooltip, "Low Tier Meat", Color(0, 255, 0))
		ix.util.PropertyDesc(tooltip, "Toxic Food", Color(255, 0, 0))
	end
end