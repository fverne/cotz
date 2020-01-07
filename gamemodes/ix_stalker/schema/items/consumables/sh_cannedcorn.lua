ITEM.name = "Canned Corn"
ITEM.model = "models/kek1ch/dev_corn.mdl"
ITEM.hunger = 21
ITEM.description = "A can with something edible inside"
ITEM.longdesc = "Canned sweet corn imported from the outside. Can be eaten as it is, but there are some who use it as a soup ingredient."
ITEM.quantity = 3
ITEM.price = 70
ITEM.width = 1
ITEM.height = 1
ITEM.busflag = {"consumables3"}
ITEM.sound = "stalkersound/inv_eat_can_open.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)
ITEM.weight = 0.1

ITEM:DecideFunction()