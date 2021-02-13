ITEM.name = "'Russian' Cheese"
ITEM.description = "A block  of cheese"
ITEM.longdesc = "This massive block of 'Russian Cheese' brand cheese is semi-solid and made from cow's milk. The taste of the cheese is popular and has been for many years. 50% fat content."
ITEM.model = "models/lostsignalproject/items/quest/resistors.mdl"
ITEM.material = "models/antlion/antlion_innards"

ITEM.price = 140
ITEM.width = 2
ITEM.height = 1
ITEM.weight = 0.090
ITEM.flatweight = 0

ITEM.hunger = 7
ITEM.quantity = 5

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/food/cheese_3.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "takes a bite out of their "..item.name..".", false)
end)

ITEM:DecideFunction()