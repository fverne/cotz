ITEM.name = "Grilled Snork Hand"
ITEM.description = "A meal made from the agile snork, cooked in the zone."
ITEM.longdesc = "A grilled snork hand is regarded as a veteran stalker snack. It is not too heavy on calories, but the tendons inside the hand are said to make the stalker more agile and bring you luck, despite it being very hard to eat."
ITEM.model = "models/lostsignalproject/items/consumable/raw_snork.mdl"

ITEM.price = 550
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.090

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 7/20 })
	item.player:AddBuff("debuff_psy", 10, {amount = 15/20})
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)


function ITEM:PopulateTooltipIndividual(tooltip)
	if !IsValid(self.entity) then
		
		ix.util.PropertyDesc(tooltip, "Mutant Meal", Color(0, 255, 0))
	end
end