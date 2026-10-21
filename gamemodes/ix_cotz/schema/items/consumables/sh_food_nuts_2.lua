ITEM.name = "Bag of Peanuts"
ITEM.description = "A small bag with nuts inside."
ITEM.longdesc = "This bag holds a nice amount of salted peanuts, good for a pick-me-up during a long trek through hostile territory. Popular with STALKERs, as the low weight and high calories makes it a great choice for sating hunger on the go."
ITEM.model = "models/lostsignalproject/items/consumable/nuts.mdl"

ITEM.price = 65
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.050
ITEM.flatweight = 0.015

ITEM.hunger = 5
ITEM.quantity = 3

ITEM.message = "eats a bit of their "..ITEM.name.."."
ITEM.sound = "stalkersound/inv_food.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/food/nuts_2.png")

ITEM:DecideFunction()

