ITEM.name = "Moonshine, 200ml"
ITEM.description = "An old hip flask."
ITEM.longdesc = "An extremely strong alcohol, made in the zone. Some STALKERs use it as radiation removal in a pinch. It's contained within an old hip flask, which smells of old leather." 
ITEM.model = "models/lostsignalproject/items/consumable/flask3.mdl"

ITEM.price = 160
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.200
ITEM.flatweight = 0.140

ITEM.thirst = -9
ITEM.quantity = 1

ITEM.isDrink = true

ITEM.alcohol = 20

ITEM.message = "takes a swig of their "..ITEM.name.."."
ITEM.sound = "stalkersound/inv_flask.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/moonshine.png")

function ITEM:PopulateTooltipIndividual(tooltip)
	ix.util.PropertyDesc(tooltip, "Strong Alcohol", Color(64, 224, 208))
end

ITEM.blackScreenAction = function(item, player)
	player:AddBuff("debuff_radiation", 10, { amount = 1.15 })
end

ITEM:DecideFunction()
