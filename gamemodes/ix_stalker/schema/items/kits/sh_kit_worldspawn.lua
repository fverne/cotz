ITEM.name = "Lost Shipment"
ITEM.description= "A large crate containing something inside. You can't tell what is in it without breaking it open."
ITEM.model = "models/items/item_item_crate.mdl"
ITEM.width = 3
ITEM.height = 3
ITEM.flag = "A"
ITEM.weight = 7.5

ITEM.items[1] = {
	dropAmount = 4,
	dropRareChance = 35,
	dropVeryRareChance = 8,
	itemsCommon = {
		{"9x18zl", {["quantity"] = 8}},
		{"9x19zl", {["quantity"] = 8}},
		{"22lrzl", {["quantity"] = 8}},
		{"762x25zl", {["quantity"] = 8}},
		{"beer2", {["quantity"] = 1}},
		{"moonshine", {["quantity"] = 1}},
		{"documents0"},
		{"bandage"},
		{"cig1", {["quantity"] = 1}},
	},
	itemsRare = {
		{"9x18zl", {["quantity"] = 12}},
		{"9x19zl", {["quantity"] = 12}},
		{"22lrzl", {["quantity"] = 12}},
		{"762x25zl", {["quantity"] = 12}},
		{"beer2", {["quantity"] = 2}},
		{"moonshine", {["quantity"] = 2}},
		{"cig1", {["quantity"] = 2}},
	},
	itemsVeryRare = {
		{"9x18zl", {["quantity"] = 16}},
		{"9x19zl", {["quantity"] = 16}},
		{"12gaugezl", {["quantity"] = 6}},
		{"22lrzl", {["quantity"] = 16}},
		{"762x25zl", {["quantity"] = 16}},
		{"documents1"},
		{"binoculars"},
		{"cig1", {["quantity"] = 3}},
		{"droplet"},
	},
}

ITEM.items[2] = {
	dropAmount = 1,
	dropRareChance = 35,
	dropVeryRareChance = 2,
	itemsCommon = {
		{"bagrubles", {["quantity"] = 100}},
	},
	itemsRare = {
		{"bagrubles", {["quantity"] = 150}},
	},
	itemsVeryRare = {
		{"suit_mailjacket"},
	},
}