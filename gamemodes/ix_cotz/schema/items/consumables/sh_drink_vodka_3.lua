ITEM.name = "Smirnoff Vodka, 700ml"
ITEM.description = "A bottle with a clear substance inside."
ITEM.longdesc = "Smirnoff Vodka is the largest vodka brand in the world. It is an ultra smooth vodka with a classic taste that has inspired other varieties of vodkas worldwide.\nIt is often mixed with soft drinks and energy drinks, for a strong intoxicating effect."
ITEM.model = "models/weapons4/w_vodka3.mdl"

ITEM.price = 480
ITEM.width = 1
ITEM.height = 2
ITEM.weight = 0.230
ITEM.flatweight = 0.220

ITEM.thirst = -25
ITEM.quantity = 3

ITEM.isDrink = true

ITEM.alcohol = 20

ITEM.addictionStrongAlcohol = true

ITEM.sound = "stalkersound/inv_flask.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/vodka_3.png")

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Strong Alcohol", Color(64, 224, 208))
end

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_radiationremoval", 10, { amount = 0.6 })

	item.player:GetCharacter():SatisfyAddictions("MediumAlcohol")

	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()
