ITEM.name = "Tark Stew"
ITEM.description = "A meal made from a tark, cooked in the zone."
ITEM.longdesc = "Stringy and not very tasty, tark meat is not really considered a delicacy in the zone. Despite how much spice it added, it has the same dull taste."
ITEM.model = "models/lostsignalproject/items/consumable/food_chimera.mdl"

ITEM.price = 740
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.050

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_7.png")

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 5/20 })
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)


function ITEM:PopulateTooltipIndividual(tooltip)
	if !IsValid(self.entity) then
		
		ix.util.PropertyDesc(tooltip, "Mutant Meal", Color(0, 255, 0))
	end
end