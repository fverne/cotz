ITEM.name = "Tark Meat"
ITEM.description = "Uncooked meat from a Tark."
ITEM.longdesc = "A lean flank of flesh. This lean piece of meat is very rough in texture, indicating it's origin from a Tark, a mutated horse. The meat starts cooking wherever you hold it, resulting in most pieces of tark meat not being cookable at stoves, unless one wants an overcooked meal."
ITEM.model = "models/lostsignalproject/items/consumable/raw_dog.mdl"

ITEM.price = 150
ITEM.width = 1
ITEM.height = 1

ITEM.WeightPerHunger = 0.140
ITEM.BaseWeight = 2.028
ITEM.WeightPerLevel = 0.665

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/food_17.png")

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_radiation", 10, { amount = 9/20 })
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)

function ITEM:PopulateTooltipIndividual(tooltip)
	if !self.entity then
		
		ix.util.PropertyDesc(tooltip, "Low Tier Mutant Meat", Color(0, 255, 0))
		ix.util.PropertyDesc(tooltip, "Toxic Food", Color(255, 0, 0))
	end
end