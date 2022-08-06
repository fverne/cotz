ITEM.name = "Cooked Karlik Meat"
ITEM.description = "A meal made from karliks, cooked in the zone."
ITEM.longdesc = "A small stew made from meat of a Controller. Even cooked, the meat still carries powerful psychic energies."
ITEM.model = "models/lostsignalproject/items/consumable/meat_flesh.mdl"

ITEM.price = 2100
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.020

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 5/20 })
	item.player:AddBuff("debuff_psy", 10, {amount = 35/20})
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)


function ITEM:PopulateTooltipIndividual(tooltip)
	if !IsValid(self.entity) then
		
		ix.util.PropertyDesc(tooltip, "Mutant Meal", Color(0, 255, 0))
	end
end