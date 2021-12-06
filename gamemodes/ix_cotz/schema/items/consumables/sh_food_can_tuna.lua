ITEM.name = "Canned Tuna"
ITEM.description = "A can with something edible inside"
ITEM.longdesc = "A tin can of tuna. Can be used in salads, sandwiches or soups, and it can even be eaten straight out of the can."
ITEM.model =  "models/lostsignalproject/items/consumable/conserva.mdl"

ITEM.price = 45
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.250
ITEM.flatweight = 0.075

ITEM.hunger = 19
ITEM.quantity = 1

ITEM.sound = "stalkersound/inv_eat_can_open.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/food/can_tuna.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()
