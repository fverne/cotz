ITEM.name = "Wine"
ITEM.model = "models/props_junk/garbage_glassbottle003a.mdl"
ITEM.thirst = 35
ITEM.description = "A bottle with liquid inside."
ITEM.longdesc = "A bottle of wine. Strong alcohol, imported."
ITEM.quantity = 1
ITEM.price = 500
ITEM.width = 1
ITEM.height = 2
ITEM.cookable = false
ITEM.busflag = {"consumables1_1_1"}
ITEM.sound = "stalkersound/inv_flask.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_radiationremoval", 10, { amount = 0.5 })
	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()

ITEM.weight = 1.3