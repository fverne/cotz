ITEM.name = "Cheeseburger"
ITEM.description = "A very cheesy burger"
ITEM.longdesc = "So guys, my parents came home yesterday with a hamburger. I said 'Hey, you didnt invite me to McDonalds?' they said, 'oh honey, we are sorry. And also this is a CHEESEBURGER.' Like what the Frick is a cheeseburger? I know a hamburger, fries, and coke, and kids choccy milk, but what about a cheeseburger? burger in cheese? melted cheese on burger?"
ITEM.model = "models/food/burger.mdl"

ITEM.price = 0
ITEM.width = 1
ITEM.height = 1
ITEM.weight = 0.250
ITEM.flatweight = 0

ITEM.hunger = 15
ITEM.quantity = 1

ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:AddBuff("debuff_psy", 5, {amount = 40/(5*2)})
	ix.chat.Send(item.player, "iteminternal", "eats a bit of their "..item.name..".", false)
end)
function ITEM:PopulateTooltipIndividual(tooltip)
	if !self.entity then
		ix.util.PropertyDesc(tooltip, "Extremely Toxic Food", Color(255, 0, 0))
	end
end
ITEM:DecideFunction()