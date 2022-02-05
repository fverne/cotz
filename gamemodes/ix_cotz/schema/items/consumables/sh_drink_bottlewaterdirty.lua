ITEM.name = "Water (Dirty), 500ml"
ITEM.description = "A dirty water bottle."
ITEM.longdesc = "A plastic bottle filled with slightly dirty water. Has probably been filled in some pond in the zone."
ITEM.model = "models/lostsignalproject/items/consumable/tea.mdl"

ITEM.price = 15
ITEM.width = 1
ITEM.height = 2
ITEM.weight = 0.250
ITEM.flatweight = 0.025

ITEM.thirst = 17
ITEM.quantity = 2

ITEM.sound = "stalkersound/inv_drink_beak.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/bottlewaterdirty.png")

ITEM:Hook("use", function(item)
	item.player:AddBuff("debuff_radiation", 10, { amount = 0.25 })
	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()