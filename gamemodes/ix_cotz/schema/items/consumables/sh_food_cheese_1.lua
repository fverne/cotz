ITEM.name = "Parmesan Cheese"
ITEM.description = "A pack of Parmesan cheese"
ITEM.longdesc = "Long ageing has left a hard texture and a strong, savoury smell. Older stalkers and camp cooks"
	.. " tend to recognise its place at a table before the rest do."
ITEM.model = "models/lostsignalproject/items/consumable/conserva.mdl"
ITEM.material = "models/antlion/antlion_innards"

ITEM.price = 65
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.065
ITEM.flatweight = 0

ITEM.hunger = 8
ITEM.quantity = 2

ITEM.message = "eats a bit of their "..ITEM.name.."."
ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/food/cheese_1.png")

ITEM:DecideFunction()