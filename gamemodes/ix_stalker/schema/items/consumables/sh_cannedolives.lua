ITEM.name = "Canned Olives"
ITEM.model = "models/kek1ch/dev_tomato.mdl"
ITEM.hunger = 20
ITEM.description = "A can with something edible inside"
ITEM.longdesc = "Tins of fresh olives are a rare sight in the Zone. A popular and highly tradable item for stalkers, but also spoils quickly once opened."
ITEM.quantity = 1
ITEM.price = 60
ITEM.width = 1
ITEM.height = 1
ITEM.busflag = {"consumables3_1"}
ITEM.sound = "stalkersound/inv_eat_can_open.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()

ITEM.weight = 0.550