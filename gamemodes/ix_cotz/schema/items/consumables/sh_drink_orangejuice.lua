ITEM.name = "Orange Juice, 1l"
ITEM.description = "A carton of juice."
ITEM.longdesc = "A liter of orange juice in a carton. Drinking it brings an air of refreshment and relaxation."
ITEM.model = "models/illusion/eftcontainers/juice.mdl"

ITEM.price = 185
ITEM.width = 1
ITEM.height = 2
ITEM.weight = 0.330
ITEM.flatweight = 0.120

ITEM.thirst = 17
ITEM.quantity = 3

ITEM.sound = "stalkersound/inv_drink_flask_2.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/orangejuice.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_staminarestore", 20, { amount = 0.5 })
	--item.player:AddBuff("buff_psyhealthrestore", 10, { amount = 0.3 })

	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()

ITEM.weight = 1.1