ITEM.name = "Chernihivske White, 500ml"
ITEM.description = "A can of beer"
ITEM.longdesc = "The easily recognizable label of Chernihivske beer is very common for a drinks assortment of any Ukrainian store. This lager-type beer has a specific refreshing taste, ensured by traditional brewing recipes of old Chernihiv city. This brand, appreciated by many Ukrainians who value national product, is represented on the market by many different kinds of beer. This one is the special 'White' type, which was the first unfiltered beer on the Ukrainian market."
ITEM.model = "models/lostsignalproject/items/consumable/drink_water.mdl"

ITEM.price = 30
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.500
ITEM.flatweight = 0.075

ITEM.thirst = 11
ITEM.quantity = 1


ITEM.alcohol = 10

ITEM.addictionLightAlcohol = true

ITEM.sound = "stalkersound/inv_drink_can.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/canbeer_2.png")

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Light Alcohol", Color(64, 224, 208))
end

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_radiationremoval", 10, { amount = 0.25 })

	item.player:GetCharacter():SatisfyAddictions("CheapAlcohol")

	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()
