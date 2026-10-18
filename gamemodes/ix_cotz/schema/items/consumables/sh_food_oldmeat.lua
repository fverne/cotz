ITEM.name = "Chunk of Rotten Meat"
ITEM.description = "A small clump of organic mass."
ITEM.longdesc = "You can't tell the origin of this meat, but there's mold on parts of it. This can't be good for you, but it might do in a pinch."
ITEM.model = "models/lostsignalproject/items/consumable/raw_bloodsucker.mdl"

ITEM.price = 5
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.251
ITEM.flatweight = 0

ITEM.hunger = 15
ITEM.quantity = 2

ITEM.message = "eats a bit of their "..ITEM.name.."."
ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
--ITEM.img = ix.util.GetMaterial("vgui/hud/items/food/oldmeat.png")

function ITEM:PopulateTooltipIndividual(tooltip)
	ix.util.PropertyDesc(tooltip, "Toxic Food", Color(255, 0, 0))
end

ITEM.blackScreenAction = function(item, player)
	player:AddBuff("debuff_psy", 10, {amount = 7/20})
	player:AddBuff("debuff_radiation", 10, { amount = 0.25 })
end

ITEM:DecideFunction()