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

ITEM.message = "eats a bit of their "..ITEM.name.."."
ITEM.sound = "stalkersound/inv_eat_mutant_food.mp3"

function ITEM:PopulateTooltipIndividual(tooltip)
	ix.util.PropertyDesc(tooltip, "Extremely Toxic Food", Color(255, 0, 0))
end

ITEM.blackScreenAction = function(item, player)
	player:AddBuff("debuff_psy", 5, { amount = 40 / (5 * 2) })
end

ITEM:DecideFunction()