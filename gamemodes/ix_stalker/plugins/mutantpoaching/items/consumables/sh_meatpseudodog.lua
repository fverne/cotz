ITEM.name = "Pseudodog Meat"
ITEM.model = "models/kek1ch/raw_flesh.mdl"
ITEM.hunger = 21
ITEM.description = "Uncooked meat from a Pseudodog."
ITEM.longdesc = "Pseudodog meat is a common dietary component in the Zone. Tasty, with high nutritional value, a popular choice among stalkers. Can be sold to the scientists. Moreover, it can also serve as a source of animal fat for gun lubrication."
ITEM.quantity = 3
ITEM.price = 70
ITEM.width = 1
ITEM.height = 1
ITEM.busflag = {"dev"}
ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 0.5 })
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()

function ITEM:PopulateTooltip(tooltip)
	if !self.entity then
		local descheader = tooltip:AddRow("properties")
		descheader:SetText("\nPROPERTIES:")
		descheader:SizeToContents()

		ix.util.PropertyDesc(tooltip, "Mid Tier Mutant Meat", Color(0, 255, 0))
		ix.util.PropertyDesc(tooltip, "Cookable", Color(0, 255, 0))
		ix.util.PropertyDesc(tooltip, "Toxic Food", Color(255, 0, 0))
	end
end