ITEM.name = "Canned Chili Beans"
ITEM.model = "models/kek1ch/dev_chili.mdl"
ITEM.hunger = 21
ITEM.description = "A can with something edible inside"
ITEM.longdesc = "Pinto beans, chili peppers, onion & garlic in a zesty tomato sauce."
ITEM.quantity = 1
ITEM.price = 70
ITEM.width = 1
ITEM.height = 1
ITEM.busflag = {"consumables3_1"}
ITEM.sound = "stalkersound/inv_eat_can_open.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()