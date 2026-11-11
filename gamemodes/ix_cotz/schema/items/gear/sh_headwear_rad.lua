ITEM.name = "Exohelm with Respirator"
ITEM.description = "A high-end helmet with gasmask."
ITEM.longdesc = "This helmet resembles that of an ordinary exoskeleton, but differs sightly from its standard counterpart and has differing protective characteristics. Good protection from gunfire and high calibre rounds in combination with anomaly protection make this helmet one of the best in its category."
ITEM.model = "models/shtokerbox/ground_headgear_radsuit.mdl"

ITEM.price = 400000
ITEM.weight = 3

ITEM.isGasmask = true
ITEM.filterType = "scientific"
ITEM.isHelmet = true

ITEM.br = 0.18
ITEM.fbr = 0
ITEM.sr = 0.09
ITEM.fsr = 0
ITEM.ar = 0
ITEM.far = 0
ITEM.pr = 0.40
ITEM.fpr = 0
ITEM.radProt = 0.90
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
    pos = Vector(0, -182.33, 5),
    ang = Angle(0, 90, 0),
    fov = 4
}

ITEM.pacData = {
        [1] = {
                ["children"] = {
                        [1] = {
                                ["children"] = {
                                },
                                ["self"] = {
                                        ["Skin"] = 0,
                                        ["UniqueID"] = "1e1bd684c74c6e40a6380274ca842cb5751f7f905224259fb7871f23850f0c18",
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
                                        ["Angles"] = Angle(2.9661125608982e-06, -72, -90.000015258789),
                                        ["AngleOffset"] = Angle(0, 0, 0),
                                        ["BoneMerge"] = false,
                                        ["Color"] = Vector(1, 1, 1),
                                        ["Position"] = Vector(-63.8046875, -20.3056640625, -0.009765625),
                                        ["ClassName"] = "model2",
                                        ["Brightness"] = 1,
                                        ["Hide"] = false,
                                        ["NoCulling"] = false,
                                        ["Scale"] = Vector(1, 1, 1),
                                        ["LegacyTransform"] = false,
                                        ["EditorExpand"] = false,
                                        ["Size"] = 1.03,
                                        ["ModelModifiers"] = "",
                                        ["Translucent"] = true,
                                        ["BlendMode"] = "",
                                        ["EyeTargetUID"] = "",
                                        ["Model"] = "models/shtokerbox/headgear/male_headwear_radsuit_full.mdl",
                                },
                        },
                },
                ["self"] = {
                        ["DrawOrder"] = 0,
                        ["UniqueID"] = "0bc0e64c3291f630cef3fe7dfde885b929d9c0de45f01227ada9eb95199631c7",
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