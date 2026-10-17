ITEM.name = "Lvivske 1715, 500ml"
ITEM.description = "A can of beer"
ITEM.longdesc = "Lvivske 1715 is a light beer of flawless quality that is based on tercentenary traditions and even more ancient secrets of Lviv brewers. The secrets of ancient recipe were passed by word of mouth, from father to son. Light hop beverage with pure malt aroma and inimitable taste is a true discovery for all who are devoted to classics and ancient traditions."
ITEM.model = "models/lostsignalproject/items/consumable/drink_water.mdl"

ITEM.price = 35
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.500
ITEM.flatweight = 0.075

ITEM.thirst = 10
ITEM.quantity = 1

ITEM.alcohol = 10

ITEM.message = "cracks open and drinks their "..ITEM.name.."."
ITEM.sound = "stalkersound/inv_drink_can.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/canbeer_3.png")

function ITEM:PopulateTooltipIndividual(tooltip)
	ix.util.PropertyDesc(tooltip, "Light Alcohol", Color(64, 224, 208))
end

ITEM.blackScreenAction = function(item, player)
	player:AddBuff("buff_radiationremoval", 10, { amount = 0.2 })
end

ITEM:DecideFunction()
