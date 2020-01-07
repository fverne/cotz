ITEM.name = "Toolbox"
ITEM.description= "A toolbox with something inside."
ITEM.model = "models/kek1ch/dev_instrument_1.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.flag = "A"
ITEM.weight = 4

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
	},
	itemsVeryRare = {
		{"fireaxe"},
	},
}
