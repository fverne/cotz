ITEM.name = "Can of Sweet Corn"
ITEM.description = "A can with something edible inside"
ITEM.longdesc = "Canned sweet corn imported from the outside. Can be eaten as it is, but there are some who use it as a soup ingredient."
ITEM.model = "models/lostsignalproject/items/consumable/corn.mdl"

ITEM.price = 15
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.250
ITEM.flatweight = 0.075

ITEM.hunger = 13
ITEM.quantity = 2

ITEM.message = "eats a bit of their "..ITEM.name.."."
ITEM.sound = "stalkersound/inv_eat_can_open.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/food/can_corn.png")

ITEM:DecideFunction()