ITEM.name = "Cossacks Vodka, 700ml"
ITEM.description = "A bottle with a clear substance inside."
ITEM.longdesc = "Made by GSC. Goes down easy and lowers the effects of radiation. Should be enjoyed in moderation."
ITEM.model = "models/lostsignalproject/items/consumable/vodka.mdl"

ITEM.price = 350
ITEM.width = 1
ITEM.height = 2
ITEM.weight = 0.230
ITEM.flatweight = 0.220

ITEM.thirst = -12
ITEM.quantity = 3

ITEM.isDrink = true

ITEM.alcohol = 20

ITEM.message = "takes a swig of their "..ITEM.name.."."
ITEM.sound = "stalkersound/inv_flask.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/vodka_1.png")

function ITEM:PopulateTooltipIndividual(tooltip)
	ix.util.PropertyDesc(tooltip, "Strong Alcohol", Color(64, 224, 208))
end

ITEM.blackScreenAction = function(item, player)
	player:AddBuff("buff_radiationremoval", 10, { amount = 0.55 })
end

ITEM:DecideFunction()
