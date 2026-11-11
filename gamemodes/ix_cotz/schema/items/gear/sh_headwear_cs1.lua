ITEM.name = "Flight Helmet (CS-1)"
ITEM.description = "Heavy assault helmet of Russian make."
ITEM.longdesc = "Favoured by assault teams, its substantial shell has the worn finish of equipment carried"
	.. " through narrow doorways. The lining retains the smell of long shifts and closed storerooms."
ITEM.model = "models/shtokerbox/ground_headgear_cs1.mdl"

ITEM.price = 75000
ITEM.weight = 2.5

ITEM.isGasmask = true
ITEM.filterType = "civilian"
ITEM.isHelmet = true

ITEM.br = 0.04
ITEM.fbr = 0
ITEM.sr = 0.02
ITEM.fsr = 0
ITEM.ar = 0.00
ITEM.far = 0
ITEM.pr = 0.20
ITEM.fpr = 0
ITEM.radProt = 0.55
ITEM.flatRadProt = 0.02

ITEM.appearanceCustomization = {
	targets = {
		{1, 1},
	},
	defaultSkin = "cs1_lone",
	worldMaterialSlots = {0},
	skins = {
		{id = "cs1_lone", name = "Loner", skin = 0, worldSkin = 0},
		{id = "cs1_lone2", name = "Loner 2", skin = 1, worldSkin = 0,
			worldMaterials = {
				[0] = "models/projectpt/cs1_lone2",
			},
		},
		{id = "cs1_csky", name = "Clear Sky", skin = 2, worldSkin = 1},
		{id = "cs1_csky2", name = "Clear Sky 2", skin = 3, worldSkin = 0,
			worldMaterials = {
				[0] = "models/projectpt/cs1_csky2",
			},
		},
		{id = "cs1_dawn", name = "Dawn", skin = 4, worldSkin = 3},
		{id = "cs1_duty", name = "Duty", skin = 5, worldSkin = 0,
			worldMaterials = {
				[0] = "models/projectpt/cs1_duty",
			},
		},
		{id = "cs1_duty2", name = "Duty 2", skin = 6, worldSkin = 0,
			worldMaterials = {
				[0] = "models/projectpt/cs1_duty2",
			},
		},
		{id = "cs1_flek", name = "Flecktarn", skin = 7, worldSkin = 2},
		{id = "cs1_free", name = "Freedom", skin = 8, worldSkin = 0,
			worldMaterials = {
				[0] = "models/projectpt/cs1_free",
			},
		},
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
                                ["Angles"] = Angle(1.9955757579737e-06, -81.503677368164, -90.000015258789),
                                ["AngleOffset"] = Angle(0, 0, 0),
                                ["BoneMerge"] = false,
                                ["Color"] = Vector(1, 1, 1),
                                ["Position"] = Vector(-64.5087890625, -8.83056640625, -0.0029296875),
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
                                ["Model"] = "models/shtokerbox/headgear/male_headwear_cs1.mdl",
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