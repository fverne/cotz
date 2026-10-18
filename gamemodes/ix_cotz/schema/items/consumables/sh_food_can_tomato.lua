ITEM.name = "Can of Tomatoes"
ITEM.description = "A can with something edible inside"
ITEM.longdesc = "Canned, sliced and diced tomatoes are imported to the Zone on a regular basis.\nThe best before date on the bottom suggests they're still fresh."
ITEM.model = "models/lostsignalproject/items/consumable/tomato.mdl"

ITEM.price = 35
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.250
ITEM.flatweight = 0.075

ITEM.hunger = 12
ITEM.quantity = 2

ITEM.message = "eats a bit of their "..ITEM.name.."."
ITEM.sound = "stalkersound/inv_eat_can_open.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/food/can_tomato.png")

ITEM:DecideFunction()