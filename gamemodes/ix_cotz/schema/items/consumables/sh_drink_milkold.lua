ITEM.name = "Milk (Old), 1l"
ITEM.description = "A carton of milk"
ITEM.longdesc = "An old carton of milk. It doesn't seem like it's in too good a shape. Could still be used to quench some thirst, even if it might cause some slight nausea."
ITEM.model = "models/props_junk/garbage_milkcarton002a.mdl"

ITEM.price = 10
ITEM.width = 1
ITEM.height = 2
ITEM.weight = 0.330
ITEM.flatweight = 0.080

ITEM.thirst = 17
ITEM.quantity = 3

ITEM.sound = "stalkersound/inv_drink_beak.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/milkold.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 0.5 })

	--item.player:DamagePsyHealth(5)
	--item.player:TakeDamage(5)

	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()

ITEM.weight = 1.08