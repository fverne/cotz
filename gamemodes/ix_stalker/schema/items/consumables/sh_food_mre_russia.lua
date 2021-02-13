ITEM.name = "MRE (Russian)"
ITEM.description = "A Russian pack of rations"
ITEM.longdesc = "Breakfast, dinner and supper all in one package. Includes various food items whose function is to provide the body with all minerals and microelements essential for your health as well as cooking equipment (small metal frame, fuel tablets, matches, striker) and other items (e.g. napkins) facilitating use in field conditions. Comes with a polymeric box that protects the ingredients from hazardous environmental conditions. The polymeric box has 3 sections, each respectively for breakfast, dinner and supper."
ITEM.model = "models/lostsignalproject/items/consumable/ration_ru.mdl"

ITEM.price = 750
ITEM.width = 2
ITEM.height = 1
ITEM.weight = 0.560
ITEM.flatweight = 0.050

ITEM.hunger = 26
ITEM.quantity = 3

ITEM.sound = "stalkersound/inv_eat_ration2.mp3"
--ITEM.img = ix.util.GetMaterial("vgui/hud/items/food/mre_russia.png")

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()

