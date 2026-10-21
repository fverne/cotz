ITEM.name = "Bread"
ITEM.description = "A loaf of bread"
ITEM.longdesc = "No bakers have ever been identified in the Zone, but this bread is neither contaminated nor radioactive, being fresh and quite edible. \nAt least no complaints have been reported thus far."
ITEM.model = "models/lostsignalproject/items/consumable/bread_spoiled.mdl"

ITEM.price = 15
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.220
ITEM.flatweight = 0

ITEM.hunger = 9
ITEM.quantity = 2

ITEM.message = "eats a bit of their "..ITEM.name.."."
ITEM.sound = "stalkersound/inv_bread1.mp3"
--ITEM.img = ix.util.GetMaterial("vgui/hud/items/food/bread.png")

ITEM:DecideFunction()
