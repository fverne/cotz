ITEM.name = "Parmesan Cheese"
ITEM.description = "A pack of Parmesan cheese"
ITEM.longdesc = "A hard block of parmesan cheese, well aged. Popular with older STALKERs and cooks in the zone."
ITEM.model = "models/lostsignalproject/items/consumable/conserva.mdl"
ITEM.material = "models/antlion/antlion_innards"

ITEM.price = 65
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.065
ITEM.flatweight = 0

ITEM.hunger = 8
ITEM.quantity = 2

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/food/cheese_1.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "takes a bite out of their "..item.name..".", false)
end)

ITEM:DecideFunction()