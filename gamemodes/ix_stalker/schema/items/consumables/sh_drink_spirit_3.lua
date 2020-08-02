ITEM.name = "Glenfiddich Whisky, 700ml"
ITEM.description = "A bottle with a clear golden yellow substance inside."
ITEM.longdesc = "Matured for at least 12 years in American and Spanish oak casks, this single malt Scotch whisky possesses Glenfiddich’s signature sweet and fruity essence, this single malt lingers with an aroma of pear and notes of butterscotch, cream and malt, dwelling on the palate with a subtle oak flavour. Glenfiddich 12 Year Old has been crafted to endure a long, smooth and mellow finish, ensuring it is always easily enjoyed."
ITEM.model = "models/lostsignalproject/items/consumable/vodka_putinka.mdl"

ITEM.price = 1
ITEM.width = 1
ITEM.height = 2
ITEM.weight = 0.230
ITEM.flatweight = 0.220

ITEM.thirst = 3
ITEM.quantity = 3

ITEM.sound = "stalkersound/inv_flask.mp3"
ITEM.img = Material("vgui/hud/items/drink/spirit_3.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_radiationremoval", 10, { amount = 0.85 })

	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()

ITEM.weight = 0.850