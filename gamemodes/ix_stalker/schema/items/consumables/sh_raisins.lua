ITEM.name = "Raisins"
ITEM.model = "models/kek1ch/dev_raisins.mdl"
ITEM.hunger = 11
ITEM.description = "A small bag containing raisins."
ITEM.longdesc = "A small bag with raisins inside. They seem hard and dry, but edible regardless. Useful when you are on the go and need a quick snack."
ITEM.quantity = 4
ITEM.price = 260
ITEM.width = 1
ITEM.height = 1
ITEM.busflag = {"consumables2_1"}
ITEM.sound = "stalkersound/inv_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()