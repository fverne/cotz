ITEM.name = "Dog Meat"
ITEM.model = "models/kek1ch/raw_flesh.mdl"
ITEM.hunger = 21
ITEM.description = "Uncooked meat from a Dog."
ITEM.longdesc = "Meat of mutated dogs is used as a cheap alternative to the more popular boar meat. The scientists have enough samples already, which limits its use as a commodity. However, it can also serve as a source of animal fat for gun lubrication."
ITEM.quantity = 1
ITEM.price = 70
ITEM.width = 1
ITEM.height = 1
ITEM.cookable = true
ITEM.meal = "meatdogmeal"
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