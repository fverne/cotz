ITEM.name = "Nemiroff Honey&Pepper Vodka, 750ml"
ITEM.description = "A bottle with a clear golden yellow substance inside."
ITEM.longdesc = "Nemiroff is a brand with a 150-year history presented in 5 continents. Its production dates back to 1872 in Nemyriv town, Ukraine. This vodka is nice and smooth, spiced with an exciting mixture of honey and hot peppers, giving a real kick when drunk."
ITEM.model = "models/lostsignalproject/items/consumable/vodka_nemiroff.mdl"

ITEM.price = 575
ITEM.width = 1
ITEM.height = 2
ITEM.weight = 0.250
ITEM.flatweight = 0.220

ITEM.thirst = -25
ITEM.quantity = 3

ITEM.isDrink = true

ITEM.alcohol = 20

ITEM.message = "takes a swig of their "..ITEM.name.."."
ITEM.sound = "stalkersound/inv_flask.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/vodka_6.png")

function ITEM:PopulateTooltipIndividual(tooltip)
	ix.util.PropertyDesc(tooltip, "Strong Alcohol", Color(64, 224, 208))
end

ITEM.blackScreenAction = function(item, player)
	player:AddBuff("buff_radiationremoval", 10, { amount = 0.75 })
	player:AddBuff("buff_staminarestore", 50, { amount = 0.5 })
end

ITEM:DecideFunction()
