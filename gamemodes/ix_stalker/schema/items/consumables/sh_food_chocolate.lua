ITEM.name = "Chocolate"
ITEM.description = "A bar of chocolate"
ITEM.longdesc = "The favorite treat of many stalkers. An excellent remedy for a bad mood."
ITEM.model = "models/lostsignalproject/items/consumable/chocolate.mdl"

ITEM.price = 300
ITEM.width = 2
ITEM.height = 1
ITEM.weight = 0.120
ITEM.flatweight = 0

ITEM.hunger = 5
ITEM.quantity = 1

ITEM.sound = "stalkersound/inv_eat_paperwrap.mp3"
--ITEM.img = ix.util.GetMaterial("vgui/hud/items/food/chocolate.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	--item.player:AddBuff("buff_psyhealthrestore", 10, { amount = 0.5 })

	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()
