ITEM.name = "Cossacks Vodka"
ITEM.model = "models/kek1ch/dev_vodka2.mdl"
ITEM.thirst = 34
ITEM.description = "A bottle with a clear substance inside."
ITEM.longdesc = "Made by GSC. Goes down easy and lowers the effects of radiation. Should be enjoyed in moderation."
ITEM.quantity = 1
ITEM.price = 250
ITEM.width = 1
ITEM.height = 2
ITEM.cookable = false
ITEM.sound = "stalkersound/inv_flask.mp3"
ITEM.busflag = {"consumables1"}
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_radiationremoval", 10, { amount = 1 })
	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()