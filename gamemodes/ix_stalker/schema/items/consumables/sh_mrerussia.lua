ITEM.name = "MRE (Russian)"
ITEM.model = "models/kek1ch/ration_ru.mdl"
ITEM.hunger = 32
ITEM.description = "A Russian pack of rations"
ITEM.longdesc = "Breakfast, dinner and supper all in one package. Includes various food items whose function is to provide the body with all minerals and microelements essential for your health as well as cooking equipment (small metal frame, fuel tablets, matches, striker) and other items (e.g. napkins) facilitating use in field conditions. Comes with a polymeric box that protects the ingredients from hazardous environmental conditions. The polymeric box has 3 sections, each respectively for breakfast, dinner and supper."
ITEM.quantity = 3
ITEM.price = 800
ITEM.width = 2
ITEM.height = 1
ITEM.busflag = {"consumables3_1_1"}
ITEM.sound = "stalkersound/inv_eat_ration2.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()