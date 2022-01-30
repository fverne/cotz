ITEM.name = "Baileys Irish Cream, 1l"
ITEM.description = "A dark liqour bottle."
ITEM.longdesc = "Baileys Irish Cream is an Irish cream liqueur - an alcoholic beverage flavoured with cream, cocoa, and Irish whiskey. It is very popular with coffee drinkers in the zone, and usually fetches a decent price, as it is not often seen in the zone."
ITEM.model = "models/weapons4/w_kona3.mdl"

ITEM.price = 1200
ITEM.width = 1
ITEM.height = 2
ITEM.weight = 0.250
ITEM.flatweight = 0.220

ITEM.thirst = 0
ITEM.quantity = 4

ITEM.isDrink = true

ITEM.alcohol = 20

ITEM.addictionStrongAlcohol = true

ITEM.sound = "stalkersound/inv_flask.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/spirit_1.png")

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Strong Alcohol", Color(64, 224, 208))
end

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_radiationremoval", 10, { amount = 0.4 })

	item.player:GetCharacter():SatisfyAddictions("ExpensiveAlcohol")

	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()
