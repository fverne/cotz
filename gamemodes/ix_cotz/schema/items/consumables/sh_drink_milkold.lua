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

ITEM.message = "takes a swig of their "..ITEM.name.."."
ITEM.sound = "stalkersound/inv_drink_beak.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/milkold.png")

function ITEM:PopulateTooltipIndividual(tooltip)
	ix.util.PropertyDesc(tooltip, "Radioactive", Color(255, 0, 0))
end

ITEM.blackScreenAction = function(item, player)
	player:AddBuff("debuff_radiation", 10, { amount = 0.5 })
end

ITEM:DecideFunction()