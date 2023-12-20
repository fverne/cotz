ITEM.name = "Screen Helmet"
ITEM.description = "A screen helmet with closed respiratory system."
ITEM.longdesc = "TODO"
ITEM.model = "models/shtokerbox/ground_seva_visor.mdl"

ITEM.price = 100000
ITEM.weight = 4

ITEM.isGasmask = true
ITEM.isHelmet = true
ITEM.isBackpack = true
ITEM.outfitCategory = "Backpack"
ITEM.ballisticlevels = {"ll-a"}

ITEM.br = 0.01
ITEM.fbr = 0
ITEM.sr = 0.01
ITEM.fsr = 0
ITEM.ar = 0
ITEM.far = 0
ITEM.pr = 0.45
ITEM.fpr = 0
ITEM.radProt = 0.60

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, -90, 0),
	fov = 3.85
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc2(tooltip, self.outfitCategory, Color(64, 224, 208), Material("vgui/ui/stalker/weaponupgrades/handling.png"))
end

ITEM.pacData = {
        [1] = {
                ["children"] = {
                        [1] = {
                                ["children"] = {
                                        [1] = {
                                                ["children"] = {
                                                },
                                                ["self"] = {
                                                        ["Skin"] = 0,
                                                        ["UniqueID"] = "70710793e4d1833c9c5496ec203f7ef716e8a9f7126ccb3ab68b57ab3ee7580b",
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
                                                        ["Material"] = "models/props_wasteland/rockcliff02c",
                                                        ["Invert"] = false,
                                                        ["ForceObjUrl"] = false,
                                                        ["Bone"] = "head",
                                                        ["Angles"] = Angle(4.0258932113647, 3.1959166526794, 35.1067237854),
                                                        ["AngleOffset"] = Angle(0, 0, 0),
                                                        ["BoneMerge"] = false,
                                                        ["Color"] = Vector(1, 1, 1),
                                                        ["Position"] = Vector(1.272705078125, 2.9892578125, -3.923828125),
                                                        ["ClassName"] = "model2",
                                                        ["Brightness"] = 1,
                                                        ["Hide"] = false,
                                                        ["NoCulling"] = false,
                                                        ["Scale"] = Vector(1, 1, 1),
                                                        ["LegacyTransform"] = false,
                                                        ["EditorExpand"] = true,
                                                        ["Size"] = 0.35,
                                                        ["ModelModifiers"] = "",
                                                        ["Translucent"] = false,
                                                        ["BlendMode"] = "",
                                                        ["EyeTargetUID"] = "",
                                                        ["Model"] = "models/props_junk/garbage_metalcan002a.mdl",
                                                },
                                        },
                                        [2] = {
                                                ["children"] = {
                                                },
                                                ["self"] = {
                                                        ["Skin"] = 0,
                                                        ["UniqueID"] = "3f070fb9c261b2c2234f3c0a5aebd44ff5eeb96bb930bee71858215cc4fc353a",
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
                                                        ["Material"] = "models/props_wasteland/rockcliff02c",
                                                        ["Invert"] = false,
                                                        ["ForceObjUrl"] = false,
                                                        ["Bone"] = "head",
                                                        ["Angles"] = Angle(-3.8548414707184, 3.7009537220001, 135.61256408691),
                                                        ["AngleOffset"] = Angle(0, 0, 0),
                                                        ["BoneMerge"] = false,
                                                        ["Color"] = Vector(1, 1, 1),
                                                        ["Position"] = Vector(1.0938720703125, 2.982421875, 3.9892578125),
                                                        ["ClassName"] = "model2",
                                                        ["Brightness"] = 1,
                                                        ["Hide"] = false,
                                                        ["NoCulling"] = false,
                                                        ["Scale"] = Vector(1, 1, 1),
                                                        ["LegacyTransform"] = false,
                                                        ["EditorExpand"] = false,
                                                        ["Size"] = 0.35,
                                                        ["ModelModifiers"] = "",
                                                        ["Translucent"] = false,
                                                        ["BlendMode"] = "",
                                                        ["EyeTargetUID"] = "",
                                                        ["Model"] = "models/props_junk/garbage_metalcan002a.mdl",
                                                },
                                        },
                                        [3] = {
                                                ["children"] = {
                                                },
                                                ["self"] = {
                                                        ["FollowAnglesOnly"] = false,
                                                        ["DrawOrder"] = 0,
                                                        ["InvertHideMesh"] = false,
                                                        ["TargetEntityUID"] = "",
                                                        ["AimPartName"] = "",
                                                        ["FollowPartUID"] = "",
                                                        ["Bone"] = "spine 2",
                                                        ["ScaleChildren"] = false,
                                                        ["UniqueID"] = "3936700a07fb50903e14d7c2540a2710b7ee1554f2a5fd148810d04e74b59740",
                                                        ["MoveChildrenToOrigin"] = false,
                                                        ["Position"] = Vector(0, 0, 0),
                                                        ["AimPartUID"] = "",
                                                        ["Angles"] = Angle(0, 0, 0),
                                                        ["Hide"] = false,
                                                        ["Name"] = "",
                                                        ["Scale"] = Vector(1, 1, 1),
                                                        ["EditorExpand"] = false,
                                                        ["ClassName"] = "bone3",
                                                        ["Size"] = 1,
                                                        ["PositionOffset"] = Vector(0, 0, 0),
                                                        ["IsDisturbing"] = false,
                                                        ["AngleOffset"] = Angle(0, 0, 0),
                                                        ["EyeAngles"] = false,
                                                        ["HideMesh"] = true,
                                                },
                                        },
                                        [4] = {
                                                ["children"] = {
                                                },
                                                ["self"] = {
                                                        ["FollowAnglesOnly"] = false,
                                                        ["DrawOrder"] = 0,
                                                        ["InvertHideMesh"] = false,
                                                        ["TargetEntityUID"] = "",
                                                        ["AimPartName"] = "",
                                                        ["FollowPartUID"] = "",
                                                        ["Bone"] = "neck",
                                                        ["ScaleChildren"] = false,
                                                        ["UniqueID"] = "2591021e9d17bf282907186ae0f74f4e3980d3bcdc13dcf8c829df6f742aaea1",
                                                        ["MoveChildrenToOrigin"] = false,
                                                        ["Position"] = Vector(3.3544921875, -0.2421875, 0.00390625),
                                                        ["AimPartUID"] = "",
                                                        ["Angles"] = Angle(-1.2874348840342e-06, 10.003598213196, -8.0801319199963e-06),
                                                        ["Hide"] = false,
                                                        ["Name"] = "",
                                                        ["Scale"] = Vector(1, 1, 1),
                                                        ["EditorExpand"] = false,
                                                        ["ClassName"] = "bone3",
                                                        ["Size"] = 1,
                                                        ["PositionOffset"] = Vector(0, 0, 0),
                                                        ["IsDisturbing"] = false,
                                                        ["AngleOffset"] = Angle(0, 0, 0),
                                                        ["EyeAngles"] = false,
                                                        ["HideMesh"] = false,
                                                },
                                        },
                                        [5] = {
                                                ["children"] = {
                                                },
                                                ["self"] = {
                                                        ["FollowAnglesOnly"] = false,
                                                        ["DrawOrder"] = 0,
                                                        ["InvertHideMesh"] = false,
                                                        ["TargetEntityUID"] = "",
                                                        ["AimPartName"] = "",
                                                        ["FollowPartUID"] = "",
                                                        ["Bone"] = "spine 4",
                                                        ["ScaleChildren"] = false,
                                                        ["UniqueID"] = "0dc9481a948eb8900b2e8155feb33b97f05ff37bb58053ba1013e5157d32fce2",
                                                        ["MoveChildrenToOrigin"] = false,
                                                        ["Position"] = Vector(-2.8076171875, -1.6728515625, 0),
                                                        ["AimPartUID"] = "",
                                                        ["Angles"] = Angle(0, 0, 0),
                                                        ["Hide"] = false,
                                                        ["Name"] = "",
                                                        ["Scale"] = Vector(1, 1, 1),
                                                        ["EditorExpand"] = false,
                                                        ["ClassName"] = "bone3",
                                                        ["Size"] = 1,
                                                        ["PositionOffset"] = Vector(0, 0, 0),
                                                        ["IsDisturbing"] = false,
                                                        ["AngleOffset"] = Angle(0, 0, 0),
                                                        ["EyeAngles"] = false,
                                                        ["HideMesh"] = false,
                                                },
                                        },
                                },
                                ["self"] = {
                                        ["Skin"] = 0,
                                        ["UniqueID"] = "7f3343dbd2881a4aa18f3d870d2a75267b5f98cd5ffe9b2f0b80f62ebb88937b",
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
                                        ["Angles"] = Angle(1.42149920066e-05, -5.5568771362305, 2.1882369765081e-05),
                                        ["AngleOffset"] = Angle(0, 0, 0),
                                        ["BoneMerge"] = true,
                                        ["Color"] = Vector(1, 1, 1),
                                        ["Position"] = Vector(0, 0, 0),
                                        ["ClassName"] = "model2",
                                        ["Brightness"] = 1,
                                        ["Hide"] = false,
                                        ["NoCulling"] = true,
                                        ["Scale"] = Vector(1, 1.1000000238419, 1.1000000238419),
                                        ["LegacyTransform"] = false,
                                        ["EditorExpand"] = true,
                                        ["Size"] = 1,
                                        ["ModelModifiers"] = "",
                                        ["Translucent"] = false,
                                        ["BlendMode"] = "",
                                        ["EyeTargetUID"] = "",
                                        ["Model"] = "models/shtokerbox/outfits/male_outfit_sunrise_vest_seva.mdl",
                                },
                        },
                },
                ["self"] = {
                        ["DrawOrder"] = 0,
                        ["UniqueID"] = "fb9f0fb1ee92ca3e7681ef966ffa58b68e1cf72b7b8f1114fb71f767bd7dc85e",
                        ["Hide"] = false,
                        ["TargetEntityUID"] = "",
                        ["EditorExpand"] = true,
                        ["OwnerName"] = "self",
                        ["IsDisturbing"] = false,
                        ["Name"] = "my outfit",
                        ["Duplicate"] = false,
                        ["ClassName"] = "group",
                },
        },        
}