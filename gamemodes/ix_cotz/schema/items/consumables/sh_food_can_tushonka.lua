ITEM.name = "Can of Beef Tushonka"
ITEM.description = "A can with something edible inside"
ITEM.longdesc = "Tushonka is a common name of canned, stewed meat produced in the Soviet Union and other Warsaw Pact countries.\nThe irony is that the idea originally came to Russia in a form of World War II aid transports from the United States. \nSince then, various kinds of tushonkas have become a primary means of long-time meat preservation, used both by the civilian population and as a standard-issue Red Army food ration. \nDespite their long expiry date, tushonkas are known for their high nutrition value (mostly owing to high fat content) and a relatively good taste."
ITEM.model = "models/illusion/eftcontainers/beefstew.mdl"

ITEM.price = 60
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.220
ITEM.flatweight = 0.075

ITEM.hunger = 17
ITEM.quantity = 2

ITEM.sound = "stalkersound/inv_eat_can_open.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/food/can_tushonka.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()