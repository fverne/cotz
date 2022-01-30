ITEM.name = "Ochakovo Beer, 2l"
ITEM.description = "A large bottle of beer"
ITEM.longdesc = "Ochakovo Beer is not subject to pasteurization. \nLong-term storage is based on cold filtering technology with the use of fine-meshed polymeric membranes which filter out even the smallest yeast."
ITEM.model = "models/props_junk/garbage_glassbottle001a.mdl"

ITEM.price = 140
ITEM.width = 1
ITEM.height = 3
ITEM.weight = 0.500
ITEM.flatweight = 0.250

ITEM.thirst = 10
ITEM.quantity = 4


ITEM.alcohol = 10

ITEM.addictionLightAlcohol = true

ITEM.sound = "stalkersound/inv_flask.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/bottlebeer_1.png")

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Light Alcohol", Color(64, 224, 208))
end

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_radiationremoval", 10, { amount = 0.15 })

	item.player:GetCharacter():SatisfyAddictions("CheapAlcohol")

	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()
