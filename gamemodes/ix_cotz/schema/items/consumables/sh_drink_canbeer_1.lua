ITEM.name = "OBOLON Strong, 500ml"
ITEM.description = "A can of beer"
ITEM.longdesc = "Obolon Strong is a lager beer with a harmony of bitter and light taste. The singularity of the recipe of this light beer lies in the fact that besides traditional ingredients such as barley malt, hops and water Obolon Strong contains maltose syrup. This gives the beer a pleasant light taste, sufficient alcohol content and lower carbohydrate content at the same time. It has a nice light flavor, and sufficient strength. The alchol content is between 6 and 14 percent."
ITEM.model = "models/lostsignalproject/items/consumable/drink_water.mdl"

ITEM.price = 40
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.500
ITEM.flatweight = 0.075

ITEM.thirst = 12
ITEM.quantity = 1


ITEM.alcohol = 10

ITEM.addictionLightAlcohol = true

ITEM.sound = "stalkersound/inv_drink_can.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/canbeer_1.png")

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Light Alcohol", Color(64, 224, 208))
end

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_radiationremoval", 10, { amount = 0.4 })

	item.player:GetCharacter():SatisfyAddictions("CheapAlcohol")

	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()
