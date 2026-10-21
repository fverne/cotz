ITEM.name = "MRE (USA)"
ITEM.description = "An American pack of rations"
ITEM.longdesc = "The Meal, Ready-to-Eat (commonly known as the MRE) is a self-contained, individual field ration in lightweight packaging, developed by the United States military for its service members for use in combat or other field conditions where organised food facilities are not available. One MRE can be used as one meal. The packaging of an MRE is designed to withstand rough conditions and exposure to the elements. Contains one course along with a variety of other food and drink items. While it can be eaten cold, it usually tastes much better when heated up with the included flameless ration heater (FRH, a water-activated exothermic reaction device that emits heat)."
ITEM.model = "models/lostsignalproject/items/consumable/ration_mre.mdl"

ITEM.price = 960
ITEM.width = 2
ITEM.height = 1
ITEM.weight = 0.740
ITEM.flatweight = 0.05

ITEM.hunger = 32
ITEM.quantity = 3

ITEM.message = "eats a bit of their "..ITEM.name.."."
ITEM.sound = "stalkersound/inv_eat_ration3.mp3"
--ITEM.img = ix.util.GetMaterial("vgui/hud/items/food/mre_usa.png")

ITEM:DecideFunction()