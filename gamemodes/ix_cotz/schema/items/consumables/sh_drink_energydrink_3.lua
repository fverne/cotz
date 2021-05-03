ITEM.name = "Redline Extreme, 240ml"
ITEM.description = "A small plastic bottle with an energy drink inside."
ITEM.longdesc = "Redline Xtreme is one of the most powerful and fast-acting, ready-to-drink energy products on the market. Redline Xtreme is a unique blend that will boost energy and intensity for whatever your day has in store.\nYou won’t get a sugar-induced energy crash, nor will you suffer the harsh comedowns so prevalent with other, overly caffeinated products. That’s because Redline Xtreme’s ingredients work with, instead of against, your body’s natural energy-producing mechanisms. If you’re looking for a big-time energy boost that lets you be productive and focused, Redline Xtreme is the perfect drink."
ITEM.model = "models/lostsignalproject/items/medical/booster.mdl"

ITEM.price = 240
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.240
ITEM.flatweight = 0.020

ITEM.thirst = 2
ITEM.quantity = 1

ITEM.sound = "stalkersound/inv_drink_can.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/energydrink_3.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_staminarestore", 80, { amount = 3 })
	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()