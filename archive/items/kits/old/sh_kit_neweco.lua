ITEM.name = "Ecologist startup kit (OOC)"
ITEM.description= "This item is supposed to be given to new ecologists. Contains some items and cash for starting out."
ITEM.model = "models/lostsignalproject/items/misc/backpack.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.flag = "A"
ITEM.itemsForcedDrop = {
	{"detectorecho"},
	{"9x18"},
	{"9x19"},
	{"9x19"},
	{"radio"},
	{"water"},
	{"geigercounter"},
	{"medkitscientific"},
	{"antirad"},
	}

ITEM.items[1] = {
	dropAmount = 1,
	itemsCommon = {
		{"makarov", {["durability"] = 100},},
		{"fort12", {["durability"] = 100},},
}
}

ITEM.items[2] = {
	dropAmount = 1,
	itemsCommon = {
		{"mp5", {["durability"] = 100},},
		{"pp2000", {["durability"] = 100},},
		{"mp9a1", {["durability"] = 100},},
		{"uzi", {["durability"] = 100},},
		{"sterling", {["durability"] = 100},},
}
}

ITEM.items[3] = {
	dropAmount = 1,
	itemsCommon = {
		{"droplet"},
		{"jellyfish"},
		{"thorn"},
		{"stoneflower"},
}
}
