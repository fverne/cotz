ITEM.name = "Bloodsucker Meat"
ITEM.description = "Uncooked meat from a Bloodsucker."
ITEM.longdesc = "Bloodsucker meat is stringy and thus not suited for eating. Although bloodsuckers are fearsome beasts, the price of the meat is not very high due to its limited use. Can be sold to the scientists. Moreover, it can also serve as a source of animal fat for gun lubrication."
ITEM.model = "models/lostsignalproject/items/consumable/raw_bloodsucker.mdl"

ITEM.price = 1250
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.190
ITEM.BaseWeight = 1.436
ITEM.WeightPerLevel = 0.184

ITEM.meattier = 2
ITEM.meal = "meal_bloodsucker"

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_15.png")
ITEM.message = "eats a bit of their "..ITEM.name.."."
ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"

ITEM.blackScreenAction = function(item, player)
	player:AddBuff("debuff_radiation", 10, { amount = 45/20 })
end

function ITEM:PopulateTooltipIndividual(tooltip)
	if !self.entity then
		
		ix.util.PropertyDesc(tooltip, "High Tier Mutant Meat", Color(0, 255, 0))
		ix.util.PropertyDesc(tooltip, "Toxic Food", Color(255, 0, 0))
	end
end