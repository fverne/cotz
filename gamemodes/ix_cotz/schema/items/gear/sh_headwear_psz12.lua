ITEM.name = "PSZ-12"
ITEM.description = "A high-end helmet with gasmask."
ITEM.longdesc = "The PSZ-12 groups a substantial helmet shell and gasmask into one headpiece. Its hard panels and fitted face assembly give it a more enclosed outline than an open combat helmet. The arrangement favours integrated protection, at the cost of carrying both systems together."
ITEM.model = "models/shtokerbox/ground_headgear_psz12.mdl"

ITEM.price = 315000
ITEM.weight = 2.65

ITEM.isGasmask = true
ITEM.filterType = "military"
ITEM.isHelmet = true

ITEM.br = 0.14
ITEM.fbr = 0
ITEM.sr = 0.07
ITEM.fsr = 0
ITEM.ar = 0
ITEM.far = 0
ITEM.pr = 0.35
ITEM.fpr = 0
ITEM.radProt = 0.85
ITEM.flatRadProt = 0.02

ITEM.appearanceCustomization = {
	targets = {
		{1, 1},
	},
	defaultSkin = "act_diger_slemnew",
	worldMaterialSlots = {0},
	skins = {
		{id = "act_diger_slemnew", name = "Standard", skin = 0, worldSkin = 0},
		{id = "act_diger_slemnew2", name = "Alternate 1", skin = 1, worldSkin = 0,
			worldMaterials = {
				[0] = "models/projectpt/headwear/act_diger_slemnew2",
			},
		},
		{id = "act_diger_slemnew3", name = "Alternate 2", skin = 2, worldSkin = 0,
			worldMaterials = {
				[0] = "models/projectpt/headwear/act_diger_slemnew3",
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
                                        ["Angles"] = Angle(3.2302014005836e-06, -77.28247833252, -90.000015258789),
                                        ["AngleOffset"] = Angle(0, 0, 0),
                                        ["BoneMerge"] = false,
                                        ["Color"] = Vector(1, 1, 1),
                                        ["Position"] = Vector(-67.16064453125, -14.3212890625, -0.0009765625),
                                        ["ClassName"] = "model2",
                                        ["Brightness"] = 1,
                                        ["Hide"] = false,
                                        ["NoCulling"] = false,
                                        ["Scale"] = Vector(1, 1, 1),
                                        ["LegacyTransform"] = false,
                                        ["EditorExpand"] = false,
                                        ["Size"] = 1.05,
                                        ["ModelModifiers"] = "",
                                        ["Translucent"] = true,
                                        ["BlendMode"] = "",
                                        ["EyeTargetUID"] = "",
                                        ["Model"] = "models/shtokerbox/headgear/male_headwear_psz12.mdl",
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