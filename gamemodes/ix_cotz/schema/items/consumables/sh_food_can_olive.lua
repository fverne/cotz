ITEM.name = "Can of Olives"
ITEM.description = "A can with something edible inside"
ITEM.longdesc = "Tins of fresh olives are a rare sight in the Zone. A popular and highly tradable item for stalkers, but also spoils quickly once opened."
ITEM.model = "models/lostsignalproject/items/consumable/chili.mdl"

ITEM.price = 55
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.250
ITEM.flatweight = 0.075

ITEM.hunger = 16
ITEM.quantity = 2

ITEM.sound = "stalkersound/inv_eat_can_open.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/food/can_olive.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()