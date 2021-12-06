ITEM.name = "Anheuser-Busch sparkling water, 330ml"
ITEM.description = "A small, white can bottle."
ITEM.longdesc = "Sparkling water for thirsty stalkers. It has some exhilarating effect when you're tired."
ITEM.model = "models/lostsignalproject/items/consumable/drink_water.mdl"

ITEM.price = 70
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.330
ITEM.flatweight = 0.025

ITEM.thirst = 14
ITEM.quantity = 1

ITEM.sound = "stalkersound/inv_drink_can.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/canwater.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	--item.player:AddBuff("buff_psyhealthrestore", 10, { amount = 0.25 })
	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()