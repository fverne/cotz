ITEM.name = "Water (Clean), 500ml"
ITEM.description = "A bottle containing water."
ITEM.longdesc = "Cleansed inside the Zone, the contents retain a sour taste despite being free of radiation. The"
	.. " treatment is more concerned with making the next journey possible than with pleasant drinking."
ITEM.model = "models/lostsignalproject/items/consumable/mineral_water.mdl"

ITEM.price = 45
ITEM.width = 1
ITEM.height = 2
ITEM.weight = 0.250
ITEM.flatweight = 0.025

ITEM.thirst = 17
ITEM.quantity = 2

ITEM.message = "takes a swig of their "..ITEM.name.."."
ITEM.sound = "stalkersound/inv_drink_flask.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/bottlewater.png")

ITEM:DecideFunction()