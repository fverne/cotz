ITEM.name = "Bottled Tea, 500ml"
ITEM.description = "A brown bottle with zone-made tea inside."
ITEM.longdesc = "Hot tea made from a mixture of sugar, edible dried mushrooms and boiled water that is said to be radiation-free. Stalkers who can afford to buy the drink often take it for long trips in the Zone. It's a good and healthy way to stay on your toes when you're getting tired or when you're out exploring on cold nights."
ITEM.model = "models/lostsignalproject/items/consumable/tea.mdl"

ITEM.price = 175
ITEM.width = 1
ITEM.height = 2
ITEM.weight = 0.250
ITEM.flatweight = 0.050

ITEM.thirst = 19
ITEM.quantity = 2

ITEM.sound = "stalkersound/inv_drink_tea.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/bottletea.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_radiationremoval", 10, { amount = 0.2 })	
	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()