ITEM.name = "Water"
ITEM.model = "models/kek1ch/dev_mineral_water.mdl"
ITEM.thirst = 45
ITEM.description = "A bottle containing water."
ITEM.longdesc = "A bottle containing water which has been cleansed inside the zone. The result is a radiation-free product, albeit it still has a sour taste."
ITEM.quantity = 3
ITEM.price = 70
ITEM.width = 1
ITEM.height = 1
ITEM.cookable = false
ITEM.sound = "stalkersound/inv_drink_flask.mp3"
ITEM.busflag = {"consumables1"}
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()