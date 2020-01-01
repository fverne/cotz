ITEM.name = "Milk (old)"
ITEM.model = "models/props_junk/garbage_milkcarton002a.mdl"
ITEM.thirst = 40
ITEM.description = "A carton of milk"
ITEM.longdesc = "A carton of old milk. It seems to have passed the expiration date."
ITEM.quantity = 3
ITEM.price = 40
ITEM.width = 1
ITEM.height = 2
ITEM.cookable = false
ITEM.sound = "stalkersound/inv_drink_beak.mp3"
ITEM.busflag = {"consumables"}
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 0.5 })
	item.player:AddBuff("buff_staminarestore", 5, { amount = 1 })
	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()