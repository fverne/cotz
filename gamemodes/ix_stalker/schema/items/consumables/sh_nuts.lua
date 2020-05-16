ITEM.name = "Assorted Nuts"
ITEM.model = "models/kek1ch/dev_nuts.mdl"
ITEM.hunger = 12
ITEM.description = "A small bag with nuts inside."
ITEM.longdesc = "This bag includes several different nutritious nuts, good for eating on the go in the zone. A favourite among stalkers on patrols, or if they just need a quick snack."
ITEM.quantity = 1
ITEM.price = 320
ITEM.width = 1
ITEM.height = 1
ITEM.busflag = {"consumables2_1"}
ITEM.sound = "stalkersound/inv_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()