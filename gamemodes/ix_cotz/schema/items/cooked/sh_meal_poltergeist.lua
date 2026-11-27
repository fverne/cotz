-- Placeholder item: nutrition awaits balancing. Price stays at 144% of the raw meat.
ITEM.name = "Stewed Poltergeist"
ITEM.description = "A meal made from poltergeist meat, cooked in the zone."
ITEM.longdesc = "Slow stewing turns the soft flesh tender and leaves a thin grey broth around it. The first mouthful tends to be small and taken while watching the pot for any sign of movement."

ITEM.model = "models/lostsignalproject/items/consumable/meat_flesh.mdl"

ITEM.price = 1440
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.140

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_3.png")
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
