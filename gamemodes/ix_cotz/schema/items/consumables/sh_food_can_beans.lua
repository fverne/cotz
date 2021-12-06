ITEM.name = "Can of Baked Beans"
ITEM.description = "A can with something edible inside"
ITEM.longdesc = "Classic baked beans in deliciously rich tomato sauce; high in fibre, virtually fat free.\nThey also contain no artificial colours, flavours or preservatives, which makes them an ideal snack or accompaniment to any meal."
ITEM.model = "models/lostsignalproject/items/consumable/beans.mdl"

ITEM.price = 20
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.250
ITEM.flatweight = 0.075

ITEM.hunger = 14
ITEM.quantity = 2

ITEM.sound = "stalkersound/inv_eat_can_open.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/food/can_beans.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()