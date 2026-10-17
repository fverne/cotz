ITEM.name = "Zone-Produced Vodka"
ITEM.description = "A hip flask with a clear substance inside."
ITEM.longdesc = "This hip flask contains zone-produced vodka produced from relatively good ingredients."
ITEM.model = "models/lostsignalproject/items/consumable/flask4.mdl"

ITEM.price = 255
ITEM.width = 1
ITEM.height = 2
ITEM.weight = 0.200
ITEM.flatweight = 0.160

ITEM.thirst = -16
ITEM.quantity = 1

ITEM.isDrink = true

ITEM.alcohol = 20

ITEM.message = "takes a swig of their "..ITEM.name.."."
ITEM.sound = "stalkersound/inv_flask.mp3"
--ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/vodka_2.png")

function ITEM:PopulateTooltipIndividual(tooltip)
	ix.util.PropertyDesc(tooltip, "Strong Alcohol", Color(64, 224, 208))
end

ITEM.blackScreenAction = function(item, player)
	player:AddBuff("buff_radiationremoval", 10, { amount = 1 })
end

ITEM:DecideFunction()
