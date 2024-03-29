ITEM.name = "Hellhound Chops"
ITEM.description = "A meal made from a dog, cooked in the zone."
ITEM.longdesc = "Chunks of Hellhound braised in a thick rich sauce, makes for an excellent meal. STALKERs rarely meet hellhounds, even more rare is taking one down, and so it is considered a delicacy."
ITEM.model = "models/lostsignalproject/items/consumable/meat_dog.mdl"

ITEM.price = 3280
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.025

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_2.png")

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 8/20 })
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)


function ITEM:PopulateTooltipIndividual(tooltip)
	if !IsValid(self.entity) then
		
		ix.util.PropertyDesc(tooltip, "Mutant Meal", Color(0, 255, 0))
	end
end