ITEM.name = "Dog Meat"
ITEM.model = "models/kek1ch/meat_flesh.mdl"
ITEM.hunger = 21
ITEM.description = "A bunch of meat"
ITEM.longdesc = "Epic meat from a dead dog. Tastes very well, but needs to be cooked."
ITEM.quantity = 3
ITEM.price = 70
ITEM.width = 1
ITEM.height = 1
ITEM.busflag = {"dev"}
ITEM.sound = "stalkersound/inv_eat_can_open.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()