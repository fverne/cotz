ITEM.name = "Baltika no 7, 900ml"
ITEM.description = "A can of beer"
ITEM.longdesc = "Baltika No. 7 was launched on the occasion of the Goodwill Games in Saint Petersburg in 1994. This brew is made brewed from selected malt and a mixture of the best hop varieties. The alcohol content of Baltika No. 7 is slightly higher than in classic lager beers, while the hoppy notes are less pronounced. Baltika No. 7 is considered one of the most advanced and innovative brands of the Baltika portfolio."
ITEM.model = "models/weapons4/w_pivo3.mdl"

ITEM.price = 85
ITEM.width = 1
ITEM.height = 2
ITEM.weight = 0.450
ITEM.flatweight = 0.075

ITEM.thirst = 9
ITEM.quantity = 2


ITEM.alcohol = 10

ITEM.addictionLightAlcohol = true

ITEM.sound = "stalkersound/inv_drink_can.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/canbeer_5.png")

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
