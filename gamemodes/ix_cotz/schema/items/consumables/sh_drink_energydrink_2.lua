ITEM.name = "Revo Alco Energy, 500ml"
ITEM.description = "An aluminium can with an energy drink inside."
ITEM.longdesc = "Revo is a ukrainian energy drink brand, and this can is one of the variants. Revo Alco Energy is a ready-to-drink cocktail with a refreshing taste, made with vodka, energy drink, and juice. It contains 8.5% alcohol, guarana and damiana extracts, natural juice, and caffeine."
ITEM.model = "models/weapons4/w_energy2.mdl"

ITEM.price = 90
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.250
ITEM.flatweight = 0.050

ITEM.thirst = 8
ITEM.quantity = 2


ITEM.alcohol = 10

ITEM.addictionLightAlcohol = true

ITEM.sound = "stalkersound/inv_drink_can.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/energydrink_2.png")

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Light Alcohol", Color(64, 224, 208))
end

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_staminarestore", 50, { amount = 0.5 })
	item.player:AddBuff("buff_radiationremoval", 10, { amount = 0.15 })

	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()
