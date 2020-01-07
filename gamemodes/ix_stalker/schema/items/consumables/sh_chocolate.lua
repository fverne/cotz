ITEM.name = "Chocolate"
ITEM.model = "models/kek1ch/dev_chocolate.mdl"
ITEM.hunger = 9
ITEM.description = "A bar of chocolate"
ITEM.longdesc = "The favorite treat of many stalkers. An excellent remedy for a bad mood."
ITEM.quantity = 3
ITEM.price = 250
ITEM.width = 2
ITEM.height = 1
ITEM.cookable = false
ITEM.busflag = {"consumables2_1_1"}
ITEM.sound = "stalkersound/inv_eat_paperwrap.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)
ITEM.weight = 0.1

ITEM:DecideFunction()