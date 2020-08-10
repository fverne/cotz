ITEM.name = "Human Meat"
ITEM.description = "Uncooked meat from a Humanoid creature."
ITEM.longdesc = "Meat from a human. It's very frowned upon to eat by stalkers, even though it originates from creatures that are no longer classified as humans."
ITEM.model = "models/kek1ch/raw_flesh.mdl"

ITEM.price = 70
ITEM.width = 1
ITEM.height = 1

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 0.5 })
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

function ITEM:PopulateTooltipIndividual(tooltip)
	if !self.entity then
		
		ix.util.PropertyDesc(tooltip, "Low Tier Meat", Color(0, 255, 0))
		ix.util.PropertyDesc(tooltip, "Toxic Food", Color(255, 0, 0))
	end
end