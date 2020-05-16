ITEM.name = "Chunk of Rotten Meat"
ITEM.model = "models/kek1ch/raw_flesh.mdl"
ITEM.hunger = 11
ITEM.description = "A small clump of organic mass."
ITEM.longdesc = "You can't tell the origin of this meat, but there's mold on parts of it."
ITEM.quantity = 1
ITEM.price = 40
ITEM.width = 1
ITEM.height = 1
ITEM.busflag = {"consumables"}
ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 1 })
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()