ITEM.name = "Baltika no.3"
ITEM.model = "models/props_junk/GlassBottle01a.mdl"
ITEM.thirst = 27
ITEM.description = "A bottle of beer"
ITEM.longdesc = "A foamy, golden brew with a delicate flavour of hops and first-class malt. \nThe Baltika invested in a large reconstruction that made the Baltika brewery the most advanced in Russia."
ITEM.quantity = 3
ITEM.price = 350
ITEM.width = 1
ITEM.height = 2
ITEM.cookable = false
ITEM.sound = "stalkersound/inv_flask.mp3"
ITEM.busflag = {"consumables1_1_1"}
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_radiationremoval", 10, { amount = 0.5 })
	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()