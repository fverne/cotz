ITEM.name = "Battered cardboard box"
ITEM.description= "A cardboard box in tatters, there seems to be something inside."
ITEM.model = "models/props_junk/cardboard_box004a.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.flag = "A"

ITEM.items[1] = {
	dropAmount = 2,
	dropRareChance = 15,
	dropVeryRareChance = 5,
	itemsCommon = {
		{"cig1", {["quantity"] = 3}},
		{"cannedcorn", {["quantity"] = 3}},
		{"cannedbeans", {["quantity"] = 3}},
		{"cannedchilibeans", {["quantity"] = 3}},
		{"moonshine", {["quantity"] = 3}},
		{"vodka2", {["quantity"] = 3}},
},
	itemsRare = {
				{"headlamp"},
		{"radio"},
		{"geigercounter"},
		{"burershand"},
},
	itemsVeryRare = {
		{"gpstrackingdevice"},
		{"documents1"},
},
}