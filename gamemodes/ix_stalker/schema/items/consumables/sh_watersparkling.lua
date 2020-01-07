ITEM.name = "Anheuser-Busch drinking water"
ITEM.model = "models/kek1ch/dev_mineral_water.mdl"
ITEM.thirst = 50
ITEM.description = "A small unopened bottle."
ITEM.longdesc = "Sparkling water for thirsty stalkers. It has some exhilarating effect when you're tired."
ITEM.quantity = 3
ITEM.price = 70
ITEM.width = 1
ITEM.height = 2
ITEM.cookable = false
ITEM.sound = "stalkersound/inv_drink_can.mp3"
ITEM.busflag = {"consumables1_1"}
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_staminarestore", 20, { amount = 1 })
	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)
ITEM.weight = 0.1

ITEM:DecideFunction()