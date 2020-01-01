ITEM.name = "Orange Juice"
ITEM.model = "models/kek1ch/item_sok.mdl"
ITEM.thirst = 35
ITEM.description = "A carton of juice."
ITEM.longdesc = "A carton of multi-fruit juice. It's briefly refreshing."
ITEM.quantity = 3
ITEM.price = 80
ITEM.width = 1
ITEM.height = 2
ITEM.cookable = false
ITEM.sound = "stalkersound/inv_drink_flask_2.mp3"
ITEM.busflag = {"consumables1_1"}
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_staminarestore", 20, { amount = 0.5 })
	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()