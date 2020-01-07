ITEM.name = "Milk"
ITEM.model = "models/props_junk/garbage_milkcarton002a.mdl"
ITEM.thirst = 40
ITEM.description = "A carton of milk"
ITEM.longdesc = "A carton of fresh milk. Must have been imported."
ITEM.quantity = 3
ITEM.price = 120
ITEM.width = 1
ITEM.height = 2
ITEM.cookable = false
ITEM.sound = "stalkersound/inv_drink_flask_2.mp3"
ITEM.busflag = {"consumables1_1_1"}
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_staminarestore", 10, { amount = 1 })
	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)
ITEM.weight = 0.1

ITEM:DecideFunction()