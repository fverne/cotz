ITEM.name = "Moonshine, 200ml"
ITEM.description = "An old hip flask."
ITEM.longdesc = "An extremely strong alcohol, made in the zone. Some STALKERs use it as radiation removal in a pinch. It's contained within an old hip flask, which smells of old leather." 
ITEM.model = "models/kek1ch/drink_flask.mdl"

ITEM.price = 1
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.200
ITEM.flatweight = 0.140

ITEM.thirst = 3
ITEM.quantity = 1

ITEM.sound = "stalkersound/inv_flask.mp3"
ITEM.img = Material("vgui/hud/items/drink/moonshine.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_radiationremoval", 10, { amount = 1.15 })
	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()

ITEM.weight = 0.6