ITEM.name = "Baileys Irish Cream, 1l"
ITEM.description = "A dark liqour bottle."
ITEM.longdesc = "Baileys Irish Cream is an Irish cream liqueur - an alcoholic beverage flavoured with cream, cocoa, and Irish whiskey. It is very popular with coffee drinkers in the zone, and usually fetches a decent price, as it is not often seen in the zone."
ITEM.model = "models/kek1ch/dev_vodka2.mdl"

ITEM.price = 1
ITEM.width = 1
ITEM.height = 2
ITEM.weight = 0.250
ITEM.flatweight = 0.220

ITEM.thirst = 3
ITEM.quantity = 4

ITEM.sound = "stalkersound/inv_flask.mp3"
ITEM.img = Material("vgui/hud/items/drink/spirit_1.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_radiationremoval", 10, { amount = 0.4 })

	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()

ITEM.weight = 0.850