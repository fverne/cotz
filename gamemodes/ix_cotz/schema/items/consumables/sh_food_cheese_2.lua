ITEM.name = "Seliskaya Cheese"
ITEM.description = "A block  of cheese"
ITEM.longdesc = "A Ukrainian produced Swiss style cheese. This semi-hard cheese is easy to eat. It is ripened for 90 days, and it has a rich sweet-spicy taste and a specific pronounced cheese smell."
ITEM.model = "models/lostsignalproject/items/consumable/conserva.mdl"
ITEM.material = "models/antlion/antlion_innards"

ITEM.price = 80
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.065
ITEM.flatweight = 0

ITEM.hunger = 6
ITEM.quantity = 4

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/food/cheese_2.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "takes a bite out of their "..item.name..".", false)
end)

ITEM:DecideFunction()