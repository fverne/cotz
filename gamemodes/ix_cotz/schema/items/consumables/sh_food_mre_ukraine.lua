ITEM.name = "MRE (Ukrainian)"
ITEM.description = "A Ukrainian pack of rations"
ITEM.longdesc = "This Ukrainian combat ration is based on a previous Russian version, and comprises commercially available cans and dried food items packed together in a sectioned box (resembling a takeout tray) made of very thin green plastic. Contains all that is necessary to provide a healthy adult with all calories and minerals needed during a single day."
ITEM.model = "models/lostsignalproject/items/consumable/ration_ukr.mdl"

ITEM.price = 640
ITEM.width = 2
ITEM.height = 1
ITEM.weight = 0.56
ITEM.flatweight = 0.05

ITEM.hunger = 24
ITEM.quantity = 3

ITEM.sound = "stalkersound/inv_eat_ration1.mp3"
--ITEM.img = ix.util.GetMaterial("vgui/hud/items/food/mre_ukraine.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()
