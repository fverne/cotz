ITEM.name = "Wine, 750ml"
ITEM.description = "A bottle with liquid inside."
ITEM.longdesc = "A bottle of full bodied red wine. The label is almost unreadable, but it seems to be of French origin. Not very popular amoung STALKERs, as they seem to be more into hard spirits and beer, but it can still fetch a decent price if presented to the right people."
ITEM.model = "models/weapons4/w_kona1.mdl"

ITEM.price = 550
ITEM.width = 1
ITEM.height = 2
ITEM.weight = 0.250
ITEM.flatweight = 0.350

ITEM.thirst = -5
ITEM.quantity = 3

ITEM.isDrink = true

ITEM.alcohol = 20

ITEM.message = "takes a swig of their "..ITEM.name.."."
ITEM.sound = "stalkersound/inv_flask.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/wine.png")

function ITEM:PopulateTooltipIndividual(tooltip)
	ix.util.PropertyDesc(tooltip, "Strong Alcohol", Color(64, 224, 208))
end

ITEM.blackScreenAction = function(item, player)
	player:AddBuff("buff_radiationremoval", 10, { amount = 0.25 })
end

ITEM:DecideFunction()
