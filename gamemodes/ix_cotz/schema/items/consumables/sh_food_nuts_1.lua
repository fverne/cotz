ITEM.name = "Bag of Mixed Nuts"
ITEM.description = "A small bag with nuts inside."
ITEM.longdesc = "This bag includes several different nutritious nuts, good for eating on the go in the zone. A favourite among stalkers on patrols, or if they just need a quick snack."
ITEM.model = "models/lostsignalproject/items/consumable/nuts.mdl"

ITEM.price = 50
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.040
ITEM.flatweight = 0.015

ITEM.hunger = 4
ITEM.quantity = 3

ITEM.message = "eats a bit of their "..ITEM.name.."."
ITEM.sound = "stalkersound/inv_food.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/food/nuts_1.png")

ITEM:DecideFunction()

