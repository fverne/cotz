ITEM.name = "Captain Morgan Spiced Rum, 700ml"
ITEM.description = "A bottle with a clear golden yellow substance inside."
ITEM.longdesc = "Captain Morgan's Rum is distilled from sugar cane. The combination of the type of yeasts employed for fermentation, distillation method, ageing conditions, and blending determines the characteristic flavour of rum. Made with molasses, water, mash and yeast, Captain Morgan Original Spiced rum is distilled in a continuous still. Once distilled, the clear spirit is aged in oak barrels for up to a year, adding a golden colour and character to the rum before the flavours and spices are added. The brand's taste is achieved through a proprietary recipe, which is blended into the rum mixture at the final stages of production, making use of spices indigenous to the Caribbean Islands."
ITEM.model = "models/weapons4/w_kona3.mdl"

ITEM.price = 1400
ITEM.width = 1
ITEM.height = 2
ITEM.weight = 0.230
ITEM.flatweight = 0.220

ITEM.thirst = -12
ITEM.quantity = 3

ITEM.isDrink = true

ITEM.alcohol = 20

ITEM.addictionStrongAlcohol = true

ITEM.sound = "stalkersound/inv_flask.mp3"
ITEM.img = ix.util.GetMaterial("vgui/hud/items/drink/spirit_2.png")

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
