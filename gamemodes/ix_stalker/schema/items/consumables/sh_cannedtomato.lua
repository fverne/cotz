ITEM.name = "Canned Tomatoes"
ITEM.model = "models/kek1ch/dev_tomato.mdl"
ITEM.hunger = 22
ITEM.description = "A can with something edible inside"
ITEM.longdesc = "Canned, sliced and diced tomatoes are imported to the Zone on a regular basis. \nThe best before date on the bottom suggests they're still fresh."
ITEM.quantity = 1
ITEM.price = 80
ITEM.width = 1
ITEM.height = 1
ITEM.busflag = {"consumables3_1"}
ITEM.sound = "stalkersound/inv_eat_can_open.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()

ITEM.weight = 0.560