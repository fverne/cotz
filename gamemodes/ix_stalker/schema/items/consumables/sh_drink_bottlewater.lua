ITEM.name = "Water (Clean), 500ml"
ITEM.description = "A bottle containing water."
ITEM.longdesc = "A bottle containing water which has been cleansed inside the zone. The result is a radiation-free product, although it still has a sour taste."
ITEM.model = "models/lostsignalproject/items/consumable/mineral_water.mdl"

ITEM.price = 45
ITEM.width = 1
ITEM.height = 2
ITEM.weight = 0.250
ITEM.flatweight = 0.025

ITEM.thirst = 17
ITEM.quantity = 2

ITEM.sound = "stalkersound/inv_drink_flask.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/bottlewater.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()