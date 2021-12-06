ITEM.name = "Monster Energy Ultra White, 500ml"
ITEM.description = "An aluminium can with energy drink inside."
ITEM.longdesc = "Monster Energy is an energy drink that was introduced by Hansen Natural Company (now Monster Beverage Corporation) in April of 2002. The caffeine content of most Monster Energy drinks is approximately 33 mg / 100 ml, or 160 mg for a 500ml can. This is a no sugar, no calorie variant, with a crisp citrus flavour."
ITEM.model = "models/lostsignalproject/items/consumable/drink_water.mdl"

ITEM.price = 150
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.250
ITEM.flatweight = 0.050

ITEM.thirst = 12
ITEM.quantity = 2

ITEM.sound = "stalkersound/inv_drink_can.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/energydrink_6.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_staminarestore", 50, { amount = 1 })
	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()