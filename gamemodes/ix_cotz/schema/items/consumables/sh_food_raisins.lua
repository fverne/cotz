ITEM.name = "Raisins"
ITEM.description = "A small bag containing raisins."
ITEM.longdesc = "A small bag with raisins inside. They seem hard and dry, but edible regardless. Useful when you are on the go and need a quick snack."
ITEM.model = "models/lostsignalproject/items/consumable/raisins.mdl"

ITEM.price = 125
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.070
ITEM.flatweight = 0

ITEM.hunger = 9
ITEM.quantity = 2

ITEM.sound = "stalkersound/inv_food.mp3"
--ITEM.img = ix.util.GetMaterial("vgui/hud/items/food/raisins.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()

