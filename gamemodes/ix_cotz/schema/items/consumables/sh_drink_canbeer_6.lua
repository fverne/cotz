ITEM.name = "Heineken, 500ml"
ITEM.description = "A can of beer"
ITEM.longdesc = "Heineken is a full-bodied premium lager with deep golden color, light fruity aroma, a mild bitter taste and a balanced hop aroma leaving a crisp, clean finish for ultimate refreshing taste.\nThe only beer enjoyed in 192 countries. From Argentina to Zambia Heineken is enjoyed in more countries than any other premium beer. Which means it is requested in more languages than any beer on earth. No surprise, really. After all, Heineken's distinctive flavor and unrivaled quality make it lager that stands out everywhere. So whether you find yourself at a fine establishment in New York, New Delhi or Nachingwea, you can enjoy the great taste of an ice cold Heineken."
ITEM.model = "models/weapons4/w_pivo3.mdl"

ITEM.price = 55
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.330
ITEM.flatweight = 0.040

ITEM.thirst = 11
ITEM.quantity = 1


ITEM.alcohol = 10

ITEM.addictionLightAlcohol = true

ITEM.sound = "stalkersound/inv_drink_can.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/canbeer_6.png")

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Light Alcohol", Color(64, 224, 208))
end

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_radiationremoval", 10, { amount = 0.2 })

	item.player:GetCharacter():SatisfyAddictions("CheapAlcohol")

	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()
