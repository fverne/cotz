ITEM.name = "Cat Meat"
ITEM.model = "models/kek1ch/raw_flesh.mdl"
ITEM.hunger = 21
ITEM.description = "Uncooked meat from a Cat."
ITEM.longdesc = "The texture of the flesh is very smooth compared to other types of mutant meat. This type of meat is not very popular within the zone, as it is said to make you feel nauseous for a few hours while digesting it."
ITEM.quantity = 1
ITEM.price = 70
ITEM.width = 1
ITEM.height = 1
ITEM.cookable = true
ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 0.5 })
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()

function ITEM:PopulateTooltipIndividual(tooltip)
	if !self.entity then
		
		ix.util.PropertyDesc(tooltip, "Low Tier Mutant Meat", Color(0, 255, 0))
		ix.util.PropertyDesc(tooltip, "Toxic Food", Color(255, 0, 0))
	end
end