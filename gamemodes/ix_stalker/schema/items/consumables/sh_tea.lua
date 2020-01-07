ITEM.name = "Bottled Tea"
ITEM.model = "models/kek1ch/drink_tea.mdl"
ITEM.thirst = 45
ITEM.description = "A brown bottle with zone-made tea inside."
ITEM.longdesc = "Hot tea made from a mixture of sugar, edible dried mushrooms and boiled water that is said to be radiation-free. Stalkers who can afford to buy the drink often take it for long trips in the Zone. It's a good and healthy way to stay on your toes when you're getting tired or when you're out exploring on cold nights."
ITEM.quantity = 3
ITEM.price = 150
ITEM.width = 1
ITEM.height = 2
ITEM.cookable = false
ITEM.sound = "stalkersound/inv_drink_tea.mp3"
ITEM.busflag = {"consumables1_1"}
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_radiationremoval", 15, { amount = 1 })
	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)
ITEM.weight = 0.1

ITEM:DecideFunction()