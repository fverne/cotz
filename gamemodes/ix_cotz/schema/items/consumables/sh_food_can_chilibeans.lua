ITEM.name = "Can of Chili Beans"
ITEM.description = "A can with something edible inside"
ITEM.longdesc = "Pinto beans, chili peppers, onion & garlic in a zesty tomato sauce."
ITEM.model = "models/lostsignalproject/items/consumable/chili.mdl"

ITEM.price = 25
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.250
ITEM.flatweight = 0.075

ITEM.hunger = 15
ITEM.quantity = 2

ITEM.message = "eats a bit of their "..ITEM.name.."."
ITEM.sound = "stalkersound/inv_eat_can_open.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/food/can_chilibeans.png")

ITEM:DecideFunction()