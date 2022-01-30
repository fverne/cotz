ITEM.name = "Utenos Porteris, 500ml"
ITEM.description = "A can of beer"
ITEM.longdesc = "Utenos Porteris is a Lithuanian beer that is among the beers, best valued by the critics and representatives of the Baltijos Porteris style. Distinguished by its dark mahogany colour with slightly spongy head, this beer has a rich and well-balanced caramel aroma. Brewed from the best quality materials, this beer reveals a “rounded” sweetish, rich taste. The caramel malt in the beer pleasantly overshadows the usual grain of commonly known porter."
ITEM.model = "models/weapons4/w_pivo3.mdl"

ITEM.price = 45
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.500
ITEM.flatweight = 0.075

ITEM.thirst = 13
ITEM.quantity = 1


ITEM.alcohol = 10

ITEM.addictionLightAlcohol = true

ITEM.sound = "stalkersound/inv_drink_can.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/canbeer_4.png")

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Light Alcohol", Color(64, 224, 208))
end

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_radiationremoval", 10, { amount = 0.3 })

	item.player:GetCharacter():SatisfyAddictions("CheapAlcohol")

	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()
