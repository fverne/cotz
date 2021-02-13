ITEM.name = "Diet Sausage"
ITEM.description = "A small lump of sausage"
ITEM.longdesc = "For better or worse, this sausage - a mix of chicken and a soy substitute - is often a stalker's breakfast, lunch and dinner in one.\nCan be stored for a long time due to high preservative content."
ITEM.model = "models/lostsignalproject/items/consumable/sausage.mdl"

ITEM.price = 25
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.125
ITEM.flatweight = 0

ITEM.hunger = 8
ITEM.quantity = 2

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
--ITEM.img = ix.util.GetMaterial("vgui/hud/items/food/sausage_1.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()