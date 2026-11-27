-- Placeholder item: price, nutrition and weight await balancing.
ITEM.name = "Poltergeist Meat"
ITEM.description = "Uncooked meat from a poltergeist."
ITEM.longdesc = "The flesh is soft, pale and oddly sparse, as though the creature had little use for muscle. It looks no stranger on the cutting board than other mutant meat, which is not much reassurance."

ITEM.model = "models/lostsignalproject/items/consumable/raw_flesh.mdl"

ITEM.price = 1000
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.200
ITEM.BaseWeight = 1.000
ITEM.WeightPerLevel = 0.120

ITEM.meattier = 2
ITEM.meal = "meal_poltergeist"

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_11.png")
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
