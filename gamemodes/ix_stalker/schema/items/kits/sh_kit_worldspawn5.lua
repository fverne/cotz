ITEM.name = "Pistol Holster"
ITEM.description= "A pistol holster, with a pistol seated inside."
ITEM.model = "models/weapons/w_eq_eholster_elite.mdl"
ITEM.width = 2
ITEM.height = 1
ITEM.flag = "A"

ITEM.items[1] = {
	dropAmount = 1,
	dropRareChance = 40,
	itemsCommon = {
		{"makarov", {["ammo"] = math.random(0,3)}, {["durability"] = math.random(8)}},
		{"rugermk3", {["ammo"] = math.random(0,3)}, {["durability"] = math.random(8)}},
		{"fort12", {["ammo"] = math.random(0,3)}, {["durability"] = math.random(8)}},
		{"tokarev", {["ammo"] = math.random(0,3)}, {["durability"] = math.random(8)}},
		{"cz52", {["ammo"] = math.random(0,3)}, {["durability"] = math.random(8)}},
	},
	itemsRare = {
		{"beretta92", {["ammo"] = math.random(0,3)}, {["durability"] = math.random(8)}},
		{"brhp", {["ammo"] = math.random(0,3)}, {["durability"] = math.random(8)}},
		{"glock17", {["ammo"] = math.random(0,3)}, {["durability"] = math.random(8)}},
		{"p99", {["ammo"] = math.random(0,3)}, {["durability"] = math.random(8)}},
	},
}
