ITEM.name = "Moskovskaya"
ITEM.model = "models/kek1ch/dev_kolbasa.mdl"
ITEM.hunger = 23
ITEM.description = "A lump of sausage"
ITEM.longdesc = "Boiled and smoked. The popular Moskovskaya contains pieces of dark meat and fat, milk, cream, flour and starch. \nDelicious when served cold. It can be preserved for 10 to 15 days."
ITEM.quantity = 1
ITEM.price = 95
ITEM.width = 1
ITEM.height = 1
ITEM.busflag = {"consumables2_1"}
ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()