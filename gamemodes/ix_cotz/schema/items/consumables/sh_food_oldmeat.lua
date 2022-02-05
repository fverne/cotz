ITEM.name = "Chunk of Rotten Meat"
ITEM.description = "A small clump of organic mass."
ITEM.longdesc = "You can't tell the origin of this meat, but there's mold on parts of it. This can't be good for you, but it might do in a pinch."
ITEM.model = "models/lostsignalproject/items/consumable/raw_bloodsucker.mdl"

ITEM.price = 5
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.251
ITEM.flatweight = 0

ITEM.hunger = 15
ITEM.quantity = 2

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
--ITEM.img = ix.util.GetMaterial("vgui/hud/items/food/oldmeat.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	--item.player:TakeDamage(7)
	item.player:AddBuff("debuff_psy", 10, {amount = 7/20})
	item.player:AddBuff("debuff_radiation", 10, { amount = 0.25 })
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()