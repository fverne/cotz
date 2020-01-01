ITEM.name = "Canned Baked Beans"
ITEM.model = "models/kek1ch/dev_beans.mdl"
ITEM.hunger = 22
ITEM.description = "A can with something edible inside"
ITEM.longdesc = "Classic baked beans in deliciously rich tomato sauce; high in fibre, virtually fat free. \nThey also contain no artificial colours, flavours or preservatives, which makes them an ideal snack or accompaniment to any meal."
ITEM.quantity = 3
ITEM.price = 75
ITEM.width = 1
ITEM.height = 1
ITEM.busflag = {"consumables3"}
ITEM.sound = "stalkersound/inv_eat_can_open.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()