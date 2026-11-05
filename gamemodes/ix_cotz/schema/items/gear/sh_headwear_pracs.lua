ITEM.name = "PRACS"
ITEM.description = "A high-end helmet with gasmask"
ITEM.longdesc = "Closely fitted components leave little exposed around the face. Cleaning the joins and keeping"
	.. " the headgear comfortable becomes part of the routine before every long patrol."
ITEM.model = "models/shtokerbox/ground_headgear_pracs.mdl"

ITEM.price = 250000
ITEM.weight = 2.5

ITEM.isGasmask = true
ITEM.isHelmet = true

ITEM.br = 0.12
ITEM.fbr = 0
ITEM.sr = 0.06
ITEM.fsr = 0
ITEM.ar = 0
ITEM.far = 0
ITEM.pr = 0.32
ITEM.fpr = 0
ITEM.radProt = 0.80
ITEM.flatRadProt = 0.02

ITEM.appearanceCustomization = {
	targets = {
		{1, 1},
	},
	defaultSkin = "skat_loner",
	worldMaterialSlots = {},
	skins = {
		{id = "skat_loner", name = "Loner", skin = 0, worldSkin = 0},
		{id = "skat_loner2", name = "Loner 2", skin = 1, worldSkin = 1},
		{id = "skat_bandit", name = "Bandit", skin = 2, worldSkin = 2},
		{id = "skat_bandit2", name = "Bandit 2", skin = 3, worldSkin = 3},
		{id = "skat_black", name = "Black", skin = 4, worldSkin = 4},
		{id = "skat_duty", name = "Duty", skin = 5, worldSkin = 5},
		{id = "skat_duty2", name = "Duty 2", skin = 6, worldSkin = 6},
		{id = "skat_duty3", name = "Duty 3", skin = 7, worldSkin = 7},
		{id = "skat_duty4", name = "Duty 4", skin = 8, worldSkin = 8},
		{id = "skat_freedom", name = "Freedom", skin = 9, worldSkin = 9},
		{id = "skat_freedom2", name = "Freedom 2", skin = 10, worldSkin = 10},
		{id = "skat_merc", name = "Mercenary", skin = 11, worldSkin = 11},
		{id = "skat_merc2", name = "Mercenary 2", skin = 12, worldSkin = 12},
		{id = "skat_merc3", name = "Mercenary 3", skin = 13, worldSkin = 13},
		{id = "skat_merc4", name = "Mercenary 4", skin = 14, worldSkin = 14},
		{id = "skat_military", name = "Military", skin = 15, worldSkin = 15},
		{id = "skat_military2", name = "Military 2", skin = 16, worldSkin = 16},
		{id = "skat_monolith", name = "Monolith", skin = 17, worldSkin = 17},
		{id = "skat_scientific", name = "Scientific", skin = 18, worldSkin = 18},
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
                                        ["Position"] = Vector(-63.567016601563, -20.0146484375, -0.0029296875),
                                        ["ClassName"] = "model2",
                                        ["Brightness"] = 1,
                                        ["Hide"] = false,
                                        ["NoCulling"] = false,
                                        ["Scale"] = Vector(1, 1, 1),
                                        ["LegacyTransform"] = false,
                                        ["EditorExpand"] = false,
                                        ["Size"] = 1.02,
                                        ["ModelModifiers"] = "",
                                        ["Translucent"] = true,
                                        ["BlendMode"] = "",
                                        ["EyeTargetUID"] = "",
                                        ["Model"] = "models/shtokerbox/headgear/male_headwear_pracs.mdl",
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