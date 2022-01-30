ITEM.name = "Shevkoff Black Ultra Premium Vodka, 500ml"
ITEM.description = "A bottle with a clear substance inside."
ITEM.longdesc = "Ukrainian high-shelf vodka. Goes down incredibly smooth, and pulling one of these out of your bag will make you the most popular guy in your camp."
ITEM.model = "models/lostsignalproject/items/consumable/vodka_putinka.mdl"

ITEM.price = 1260
ITEM.width = 1
ITEM.height = 2
ITEM.weight = 0.250
ITEM.flatweight = 0.220

ITEM.thirst = -40
ITEM.quantity = 2

ITEM.isDrink = true

ITEM.alcohol = 20

ITEM.addictionStrongAlcohol = true

ITEM.sound = "stalkersound/inv_flask.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/vodka_5.png")

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Strong Alcohol", Color(64, 224, 208))
end

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_radiationremoval", 10, { amount = 1 })

	item.player:GetCharacter():SatisfyAddictions("ExpensiveAlcohol")

	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()
