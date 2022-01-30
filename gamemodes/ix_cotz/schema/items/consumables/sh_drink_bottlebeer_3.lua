ITEM.name = "Baltika no.3, 850ml"
ITEM.description = "A bottle of beer"
ITEM.longdesc = "A foamy, golden brew with a delicate flavour of hops and first-class malt. \nThe Baltika invested in a large reconstruction that made the Baltika brewery the most advanced in Russia."
ITEM.model = "models/props_junk/GlassBottle01a.mdl"

ITEM.price = 60
ITEM.width = 1
ITEM.height = 2
ITEM.weight = 0.150
ITEM.flatweight = 0.425

ITEM.thirst = 8
ITEM.quantity = 2


ITEM.alcohol = 10

ITEM.addictionLightAlcohol = true

ITEM.sound = "stalkersound/inv_flask.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/bottlebeer_3.png")

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Light Alcohol", Color(64, 224, 208))
end

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_radiationremoval", 10, { amount = 0.1 })

	item.player:GetCharacter():SatisfyAddictions("CheapAlcohol")

	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()
