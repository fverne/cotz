ITEM.name = "MRE (USA)"
ITEM.model = "models/kek1ch/ration_mre.mdl"
ITEM.hunger = 31
ITEM.description = "An American pack of rations"
ITEM.longdesc = "The Meal, Ready-to-Eat (commonly known as the MRE) is a self-contained, individual field ration in lightweight packaging, developed by the United States military for its service members for use in combat or other field conditions where organised food facilities are not available. One MRE can be used as one meal. The packaging of an MRE is designed to withstand rough conditions and exposure to the elements. Contains one course along with a variety of other food and drink items. While it can be eaten cold, it usually tastes much better when heated up with the included flameless ration heater (FRH, a water-activated exothermic reaction device that emits heat)."
ITEM.quantity = 3
ITEM.price = 1050
ITEM.width = 2
ITEM.height = 1
ITEM.busflag = {"consumables3_1_1"}
ITEM.sound = "stalkersound/inv_eat_ration3.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

ITEM:DecideFunction()