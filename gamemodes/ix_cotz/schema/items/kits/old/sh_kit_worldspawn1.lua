ITEM.name = "Toolbox"
ITEM.description= "A toolbox with something inside."
ITEM.model = "models/lostsignalproject/items/upgrades/upgrw1.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.flag = "A"

ITEM.items[1] = {
	dropAmount = 1,
	dropRareChance = 40,
	dropVeryRareChance = 10,
	itemsCommon = {
		{"leadpipe"},
		{"crowbar"},
	},
	itemsRare = {
		{"bat"},
		{"fireaxe"},
	},
	itemsVeryRare = {
		{"tooloil1"},
	},
}
