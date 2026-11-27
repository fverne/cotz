-- Placeholder item: nutrition awaits balancing. Price stays at 144% of the raw meat.
ITEM.name = "Roasted Mimic"
ITEM.description = "A meal made from Mimic meat, cooked in the zone."
ITEM.longdesc = "Long roasting softens the lean cuts and chars the sinew at their edges. It eats like tough game bird, if the cook is feeling generous with the comparison."

ITEM.model = "models/lostsignalproject/items/consumable/meat_pseudodog.mdl"

ITEM.price = 1368
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.130

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_5.png")
ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM.message = "eats a bit of their " .. ITEM.name .. "."

ITEM.blackScreenAction = function(item, player)
	player:AddBuff("debuff_radiation", 10, {amount = 15 / 20})
end

function ITEM:PopulateTooltipIndividual(tooltip)
	if not IsValid(self.entity) then
		ix.util.PropertyDesc(tooltip, "Mutant Meal", Color(0, 255, 0))
	end
end

function ITEM:GetPropertyEffects()
	return {{buff = "debuff_radiation", duration = 10, amount = 15 / 20}}
end
