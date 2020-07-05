ITEM.name = "Diet Sausage"
ITEM.model = "models/kek1ch/dev_sausage.mdl"
ITEM.hunger = 24
ITEM.description = "A small lump of sausage"
ITEM.longdesc = "For better or worse, this sausage - a mix of chicken and a soy substitute - is often a stalker's breakfast, lunch and dinner in one. \nCan be stored for a long time due to high preservative content."
ITEM.quantity = 1
ITEM.price = 85
ITEM.width = 1
ITEM.height = 1
ITEM.busflag = {"consumables2"}
ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()

ITEM.weight = 0.380