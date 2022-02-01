ITEM.name = "Lvivske Svitle, 1.5l"
ITEM.description = "A large bottle of beer"
ITEM.longdesc = "Lvivske Svitle is a bright premium-class camp, with impeccable quality, based on centuries-old traditions and professional secrets of Lviv brewers. The secrets of the recipe of this beer were passed down from generation to generation. The formulation of the camp includes water, light barley malt and hops. The lager has a pure malt aroma and a unique, light hop flavor."
ITEM.model = "models/props_junk/garbage_glassbottle001a.mdl"

ITEM.price = 95
ITEM.width = 1
ITEM.height = 3
ITEM.weight = 0.500
ITEM.flatweight = 0.300

ITEM.thirst = 9
ITEM.quantity = 3


ITEM.alcohol = 10

ITEM.addictionLightAlcohol = true

ITEM.sound = "stalkersound/inv_flask.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/bottlebeer_2.png")

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Light Alcohol", Color(64, 224, 208))
end

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_radiationremoval", 10, { amount = 0.2 })

	item.player:GetCharacter():SatisfyAddictions("CheapAlcohol")

	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()
