ITEM.name = "Exoskeleton"
ITEM.description = "An exoskeleton frame with servomotors"
ITEM.longdesc = "State of the art full body active exoskeleton system, 3rd generation, of unknown origin. The servos limit the speed and precision of movements, but effectively ease the load from the user and multiply his physical strength by a factor of two."
ITEM.model = "models/shtokerbox/ground_outfit_exoskeleton.mdl"
ITEM.skin = 11

ITEM.price = 3000000 -- TODO: Put something here
ITEM.width = 3
ITEM.height = 3
ITEM.weight = 4.820

ITEM.carryinc = 50
ITEM.outfitCategory = "Exoskeleton"
ITEM.isExoskeleton = true
ITEM.isBackpack = false

ITEM.appearanceCustomization = {
	targets = {
		{1, 1},
	},
	defaultSkin = "radsuit_duty",
	worldMaterialSlots = {},
	skins = {
		{id = "radsuit_loner", name = "Loner", skin = 0, worldSkin = 0},
		{id = "radsuit_loner2", name = "Loner 2", skin = 1, worldSkin = 1},
		{id = "radsuit_loner3", name = "Loner 3", skin = 2, worldSkin = 2},
		{id = "radsuit_loner4", name = "Loner 4", skin = 3, worldSkin = 3},
		{id = "radsuit_loner5", name = "Loner 5", skin = 4, worldSkin = 4},
		{id = "radsuit_loner6", name = "Loner 6", skin = 5, worldSkin = 5},
		{id = "radsuit_loner7", name = "Loner 7", skin = 6, worldSkin = 6},
		{id = "radsuit_bandit", name = "Bandit", skin = 7, worldSkin = 7},
		{id = "radsuit_bandit2", name = "Bandit 2", skin = 8, worldSkin = 8},
		{id = "radsuit_cs", name = "Clear Sky", skin = 9, worldSkin = 9},
		{id = "radsuit_cs2", name = "Clear Sky 2", skin = 10, worldSkin = 10},
		{id = "radsuit_duty", name = "Duty", skin = 11, worldSkin = 11},
		{id = "radsuit_duty2", name = "Duty 2", skin = 12, worldSkin = 12},
		{id = "radsuit_duty3", name = "Duty 3", skin = 13, worldSkin = 13},
		{id = "radsuit_freedom", name = "Freedom", skin = 14, worldSkin = 14},
		{id = "radsuit_freedom2", name = "Freedom 2", skin = 15, worldSkin = 15},
		{id = "radsuit_merc", name = "Mercenary", skin = 16, worldSkin = 16},
		{id = "radsuit_merc2", name = "Mercenary 2", skin = 17, worldSkin = 17},
		{id = "radsuit_merc3", name = "Mercenary 3", skin = 18, worldSkin = 18},
		{id = "radsuit_merc4", name = "Mercenary 4", skin = 19, worldSkin = 19},
		{id = "radsuit_monolith", name = "Monolith", skin = 20, worldSkin = 20},
		{id = "radsuit_monolith2", name = "Monolith 2", skin = 21, worldSkin = 21},
		{id = "radsuit_renegade", name = "Renegade", skin = 22, worldSkin = 22},
	},
	bodygroups = {},
}

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, -1, 200),
	ang = Angle(90, 90, 0),
	fov = 11.41
}



ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
				},
				["self"] = {
					["UniqueID"] = "exoskeleton1_1",
					["Skin"] = 11,
					["BoneMerge"] = true,
					["Model"] = "models/shtokerbox/outfits/male_outfit_sunrise_overlay_exo.mdl",
					["ClassName"] = "model",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "exoskeleton1",
			["EditorExpand"] = true,
		},
	},
}