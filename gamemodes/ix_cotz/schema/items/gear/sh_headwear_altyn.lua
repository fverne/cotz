ITEM.name = "Altyn Helmet"
ITEM.description = "A steel helmet."
ITEM.longdesc = "The Altyn surrounds the head with a heavy steel shell and a close-fitting face assembly. Its substantial construction favours impact protection over a light load. The helmet is a protective headpiece, without the radiation protection provided by more specialised enclosed systems."
ITEM.model = "models/shtokerbox/ground_headgear_atlyn.mdl"

ITEM.price = 400000
ITEM.weight = 3.5

ITEM.isGasmask = true
ITEM.filterType = false
ITEM.isHelmet = true

ITEM.br = 0.20
ITEM.fbr = 0
ITEM.sr = 0.10
ITEM.fsr = 0
ITEM.ar = 0
ITEM.far = 0
ITEM.pr = 0.40
ITEM.fpr = 0
ITEM.radProt = 0
ITEM.flatRadProt = 0

ITEM.appearanceCustomization = {
	targets = {
		{1, 1},
	},
	defaultSkin = "act_broneshlem_ris",
	worldMaterialSlots = {1},
	skins = {
		{id = "act_broneshlem_ris", name = "Patterned", skin = 0, worldSkin = 0},
		{id = "act_broneshlem_black", name = "Black", skin = 1, worldSkin = 0,
			worldMaterials = {
				[1] = "models/projectpt/headwear/act_broneshlem_black",
			},
		},
	},
	bodygroups = {},
}

ITEM.exRender = true
ITEM.iconCam = {
    pos = Vector(0, -182.33, 3),
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
                                        ["Position"] = Vector(-64.700073242188, -20.369140625, 0.0048828125),
                                        ["ClassName"] = "model2",
                                        ["Brightness"] = 1,
                                        ["Hide"] = false,
                                        ["NoCulling"] = false,
                                        ["Scale"] = Vector(1, 1, 1),
                                        ["LegacyTransform"] = false,
                                        ["EditorExpand"] = false,
                                        ["Size"] = 1.04,
                                        ["ModelModifiers"] = "",
                                        ["Translucent"] = true,
                                        ["BlendMode"] = "",
                                        ["EyeTargetUID"] = "",
                                        ["Model"] = "models/shtokerbox/headgear/male_headwear_atlyn.mdl",
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