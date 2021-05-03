ITEM.name = "Can of Sprats"
ITEM.description = "A can with something edible inside"
ITEM.longdesc = "These Riga Sprats are tiny, fine, firm little Brisling sardines that are naturally smoked over Oak hardwood logs and then packed with Sunflower oil in big, round 5.6oz tins. This big tin contains 24 to 30 fish (head off) packed in 3 neat layers. Canned sprats (usually smoked) are available in many north European countries, including the Baltic States, Scandinavia, Germany, Poland, Ukraine and Russia. They are an important Latvian export."
ITEM.model = "models/illusion/eftcontainers/sprats.mdl"

ITEM.price = 70
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.120
ITEM.flatweight = 0.035

ITEM.hunger = 13
ITEM.quantity = 1

ITEM.sound = "stalkersound/inv_eat_can_open.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/food/can_sprats.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()