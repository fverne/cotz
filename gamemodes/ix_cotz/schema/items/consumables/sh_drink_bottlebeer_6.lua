ITEM.name = "Lvivske Porter, 1l"
ITEM.description = "A bottle of beer"
ITEM.longdesc = "Lvivske is the oldest Ukrainian beer, which monks began brewing back in 1715. Nowadays, Lvivske has become part of the Ukrainian history. It is a symbol of the epoch and pride of Ukraine.\nLvivske Porter is a special type of dark beer with a touch of malt and wine smack. This hop beverage has a unique bouquet which has been polished for centuries."
ITEM.model = "models/weapons4/w_pivo1.mdl"

ITEM.price = 75
ITEM.width = 1
ITEM.height = 2
ITEM.weight = 0.500
ITEM.flatweight = 0.220

ITEM.thirst = 6
ITEM.quantity = 2


ITEM.alcohol = 10

ITEM.addictionLightAlcohol = true

ITEM.sound = "stalkersound/inv_flask.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/bottlebeer_6.png")

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
