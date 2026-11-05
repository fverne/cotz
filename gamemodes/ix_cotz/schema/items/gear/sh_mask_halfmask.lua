ITEM.name = "Halfmask"
ITEM.description = "An old gasmask"
ITEM.longdesc = "A regular plastic and rubber respirator, used to protect the wearer from inhaling harmful dusts, fumes, vapours or gases. Widely used by rookies and veterans of all factions due to its universal functionality. Does not provide any physical protection."
ITEM.model = "models/shtokerbox/ground_mask_halfmask.mdl"

ITEM.price = 7500
ITEM.weight = 0.4

ITEM.isGasmask = true
ITEM.isHelmet = false
-- 
ITEM.br = 0.00
ITEM.fbr = 0
ITEM.ar = 0
ITEM.far = 0
ITEM.radProt = 0.50
ITEM.flatRadProt = 0.02

ITEM.appearanceCustomization = {
	targets = {
		{1, 1},
	},
	defaultSkin = "radsuit_loner",
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
	pos = Vector(0, 0, 200),
	ang = Angle(90, 90, 0),
	fov = 3.85
}

ITEM.pacData = {
        [1] = {
                ["children"] = {
                        [1] = {
                                ["children"] = {
                                },
                                ["self"] = {
                                        ["Skin"] = 0,
                                        ["UniqueID"] = "9f1780df13bc6e25c66ae1801138fbe2806dc3aef27d5cdbcc4cf23d267a4a5a",
                                        ["NoLighting"] = false,
                                        ["AimPartName"] = "",
                                        ["IgnoreZ"] = false,
                                        ["AimPartUID"] = "",
                                        ["Materials"] = "",
                                        ["Name"] = "",
                                        ["LevelOfDetail"] = 0,
                                        ["NoTextureFiltering"] = false,
                                        ["PositionOffset"] = Vector(0, 0, 0),
                                        ["IsDisturbing"] = false,
                                        ["EyeAngles"] = false,
                                        ["DrawOrder"] = 0,
                                        ["TargetEntityUID"] = "",
                                        ["Alpha"] = 1,
                                        ["Material"] = "",
                                        ["Invert"] = false,
                                        ["ForceObjUrl"] = false,
                                        ["Bone"] = "head",
                                        ["Angles"] = Angle(-2.511173761377e-06, -71, -90.000015258789),
                                        ["AngleOffset"] = Angle(0, 0, 0),
                                        ["BoneMerge"] = false,
                                        ["Color"] = Vector(1, 1, 1),
                                        ["Position"] = Vector(-62.0380859375, -20.7119140625, 0.01416015625),
                                        ["ClassName"] = "model2",
                                        ["Brightness"] = 1,
                                        ["Hide"] = false,
                                        ["NoCulling"] = false,
                                        ["Scale"] = Vector(1, 1, 1),
                                        ["LegacyTransform"] = false,
                                        ["EditorExpand"] = false,
                                        ["Size"] = 1,
                                        ["ModelModifiers"] = "",
                                        ["Translucent"] = true,
                                        ["BlendMode"] = "",
                                        ["EyeTargetUID"] = "",
                                        ["Model"] = "models/shtokerbox/headgear/male_mask_halfmask.mdl",
                                },
                        },
                },
                ["self"] = {
                        ["DrawOrder"] = 0,
                        ["UniqueID"] = "e002c917f1d4866bf1ca90131651ec2caf6d49d4bed526d0818ea9e6ebfc1cf3",
                        ["Hide"] = false,
                        ["TargetEntityUID"] = "",
                        ["EditorExpand"] = true,
                        ["OwnerName"] = "self",
                        ["IsDisturbing"] = false,
                        ["Name"] = "",
                        ["Duplicate"] = false,
                        ["ClassName"] = "group",
                },
        },
        

}
