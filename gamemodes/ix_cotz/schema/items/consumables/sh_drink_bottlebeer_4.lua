ITEM.name = "Tuborg GREEN, 330ml"
ITEM.description = "A bottle of beer"
ITEM.longdesc = "The story of Tuborg starts in Hellerup, north of Copenhagen, where the Tuborg Brewery brewed Denmark’s first pilsner-type beer in 1880 and packaged it in bottles with a distinctive green label. It instantly became popular with the Danes.\nTuborg Green is a bottom-fermented lager beer. It's brewed on lager malt, a slightly roasted, bright type of malt which results in the well-known mild, fresh taste and aroma of flowers and cereal. The beer is medium rich and lively with a moderate bitterness in the aftertaste. Today, Tuborg has grown to become an international brand enjoyed in more than 70 countries around the world and known for its exceptional quality and refreshing taste, even in Ukraine, where the beer is also brewed."
ITEM.model = "models/lostsignalproject/items/consumable/beer.mdl"

ITEM.price = 45
ITEM.width = 1
ITEM.height = 2
ITEM.weight = 0.330
ITEM.flatweight = 0.150

ITEM.thirst = 8
ITEM.quantity = 1


ITEM.alcohol = 10

ITEM.addictionLightAlcohol = true

ITEM.sound = "stalkersound/inv_flask.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/bottlebeer_4.png")

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Light Alcohol", Color(64, 224, 208))
end

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_radiationremoval", 10, { amount = 0.15 })

	item.player:GetCharacter():SatisfyAddictions("CheapAlcohol")

	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()
