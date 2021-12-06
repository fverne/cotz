ITEM.name = "Moskovskaya Sausage"
ITEM.description = "A lump of sausage"
ITEM.longdesc = "A traditional Russian sausage similar to the Polish kielbasa, this Eastern European sausage is also known as Maskoska. This sausage is made in the Ukraine following the classic Eastern European recipe, pork and beef lightly smoked, with a bit of garlic and other spices. Ready to eat, just bite off a piece."
ITEM.model = "models/lostsignalproject/items/consumable/sausage2.mdl"

ITEM.price = 40
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.125
ITEM.flatweight = 0

ITEM.hunger = 11
ITEM.quantity = 2

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "takes a bite out of their "..item.name..".", false)
end)

ITEM:DecideFunction()