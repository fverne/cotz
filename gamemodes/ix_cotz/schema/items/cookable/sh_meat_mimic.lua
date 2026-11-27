-- Placeholder item: price, nutrition and weight await balancing.
ITEM.name = "Mimic Meat"
ITEM.description = "Uncooked meat from a Mimic."
ITEM.longdesc = "The cuts are dark and lean, threaded with tough sinew from the long limbs. A sour smell clings to the hands after wrapping them."

ITEM.model = "models/lostsignalproject/items/consumable/raw_pseudodog.mdl"

ITEM.price = 950
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.190
ITEM.BaseWeight = 1.200
ITEM.WeightPerLevel = 0.150

ITEM.meattier = 2
ITEM.meal = "meal_mimic"

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_16.png")
ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM.message = "eats a bit of their " .. ITEM.name .. "."

ITEM.blackScreenAction = function(item, player)
	player:AddBuff("debuff_radiation", 10, {amount = 45 / 20})
end

function ITEM:PopulateTooltipIndividual(tooltip)
	if not self.entity then
		ix.util.PropertyDesc(tooltip, "High Tier Mutant Meat", Color(0, 255, 0))
		ix.util.PropertyDesc(tooltip, "Toxic Food", Color(255, 0, 0))
	end
end

function ITEM:GetPropertyEffects()
	return {buff = "debuff_radiation", duration = 10, amount = 45 / 20}
end
