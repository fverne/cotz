ITEM.name = "Milk, 1l"
ITEM.description = "A carton of milk"
ITEM.longdesc = "A carton of UHT milk. Should probably be drunk quickly after opening, before it goes off. It still seems fresh."
ITEM.model = "models/props_junk/garbage_milkcarton002a.mdl"

ITEM.price = 90
ITEM.width = 1
ITEM.height = 2
ITEM.weight = 0.330
ITEM.flatweight = 0.080

ITEM.thirst = 17
ITEM.quantity = 3

ITEM.sound = "stalkersound/inv_drink_flask_effect.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/milk.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_staminarestore", 10, { amount = 1 })
	--item.player:AddBuff("buff_psyhealthrestore", 10, { amount = 0.15 })

	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()