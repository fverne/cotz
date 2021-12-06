ITEM.name = "EuroShopper Energy Drink, 250ml"
ITEM.description = "An aluminium can with energy drink inside."
ITEM.longdesc = "Euro Shopper is a discount brand of everyday commodities developed and marketed by AMS Sourcing B.V.. It was introduced to the market in 1996 and branded products have been sold by some of the AMS members in different countries in Europe ever since. This can most likely originates from either Finland or Lithuania."
ITEM.model = "models/weapons4/w_energy2.mdl"

ITEM.price = 70
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.250
ITEM.flatweight = 0.025

ITEM.thirst = 4
ITEM.quantity = 1

ITEM.sound = "stalkersound/inv_drink_can.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/energydrink_4.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_staminarestore", 50, { amount = 1 })
	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()