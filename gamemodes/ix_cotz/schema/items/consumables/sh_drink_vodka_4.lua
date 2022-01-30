ITEM.name = "Khortytsa Vodka, 700ml"
ITEM.description = "A bottle with a clear substance inside."
ITEM.longdesc = "Made from durum wheat and corn, this is one of the few vodkas that uses the latest technology of platinum filtration and a unique system of special birch and alder-tree charcoal filters. Platinum filtration is a state of the art process that gives this vodka a clean, balanced, and soft finish. Thanks to an optimal balance of all ingredients this vodka is perfect for making cocktails One of the three best selling vodkas globally. Spring Water clear. Big, assertive, snack-cracker-grain aroma. Toasty on the palate, dry, creamy texture. A winner on all levels."
ITEM.model = "models/weapons4/w_vodka2.mdl"

ITEM.price = 610
ITEM.width = 1
ITEM.height = 2
ITEM.weight = 0.230
ITEM.flatweight = 0.220

ITEM.thirst = -34
ITEM.quantity = 3

ITEM.isDrink = true

ITEM.alcohol = 20

ITEM.addictionStrongAlcohol = true

ITEM.sound = "stalkersound/inv_flask.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/vodka_4.png")

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Strong Alcohol", Color(64, 224, 208))
end

ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("buff_radiationremoval", 10, { amount = 0.75 })

	item.player:GetCharacter():SatisfyAddictions("ExpensiveAlcohol")

	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)

ITEM:DecideFunction()
