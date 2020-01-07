ITEM.name = "Jaguar Energy drink"
ITEM.model = "models/kek1ch/dev_drink_stalker.mdl"
ITEM.thirst = 30
ITEM.description = "An aluminium can with energy drink inside."
ITEM.longdesc = "This energy drink is one of the best on the market, and provides long-lasting energy for stalkers who need to stay clear-headed, and light-footed for a while."
ITEM.quantity = 2
ITEM.price = 250
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Consumables"
ITEM.busflag = {"medical1_1"}
ITEM.cookable = false
ITEM.sound = "stalkersound/inv_drink_can.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_staminarestore", 150, { amount = 1 })
	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)
ITEM.weight = 0.1

ITEM:DecideFunction()