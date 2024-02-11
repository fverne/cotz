ITEM.name = "Screen Helmet"
ITEM.description = "A screen helmet with closed respiratory system."
ITEM.longdesc = "TODO"
ITEM.model = "models/shtokerbox/ground_seva_visor.mdl"

ITEM.price = 100000
ITEM.weight = 4
ITEM.overlayPath = "vgui/overlays/hud_sci"

ITEM.isGasmask = true
ITEM.isHelmet = true
ITEM.isBackpack = true
ITEM.outfitCategory = "Backpack"

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
                                                        ["Jiggle"] = false,
                                                        ["DrawOrder"] = 0,
                                                        ["UniqueID"] = "2591021e9d17bf282907186ae0f74f4e3980d3bcdc13dcf8c829df6f742aaea1",
                                                        ["TargetEntityUID"] = "",
                                                        ["FollowAnglesOnly"] = false,
                                                        ["AimPartName"] = "",
                                                        ["FollowPartUID"] = "",
                                                        ["Bone"] = "neck",
                                                        ["MoveChildrenToOrigin"] = false,
                                                        ["ScaleChildren"] = false,
                                                        ["Angles"] = Angle(-1.2874348840342e-06, 10.003598213196, -8.0801319199963e-06),
                                                        ["ClassName"] = "bone2",
                                                        ["Position"] = Vector(3.3544921875, -0.2421875, 0.00390625),
                                                        ["AimPartUID"] = "",
                                                        ["AlternativeBones"] = false,
                                                        ["Hide"] = false,
                                                        ["Name"] = "",
                                                        ["Scale"] = Vector(1, 1, 1),
                                                        ["EditorExpand"] = false,
                                                        ["AngleOffset"] = Angle(0, 0, 0),
                                                        ["Size"] = 1,
                                                        ["PositionOffset"] = Vector(0, 0, 0),
                                                        ["IsDisturbing"] = false,
                                                        ["InvertHideMesh"] = false,
                                                        ["EyeAngles"] = false,
                                                        ["HideMesh"] = false,
                                                },
                                        },
                                        [2] = {
                                                ["children"] = {
                                                },
                                                ["self"] = {
                                                        ["Jiggle"] = false,
                                                        ["DrawOrder"] = 0,
                                                        ["UniqueID"] = "0dc9481a948eb8900b2e8155feb33b97f05ff37bb58053ba1013e5157d32fce2",
                                                        ["TargetEntityUID"] = "",
                                                        ["FollowAnglesOnly"] = false,
                                                        ["AimPartName"] = "",
                                                        ["FollowPartUID"] = "",
                                                        ["Bone"] = "spine 4",
                                                        ["MoveChildrenToOrigin"] = false,
                                                        ["ScaleChildren"] = false,
                                                        ["Angles"] = Angle(0, 0, 0),
                                                        ["ClassName"] = "bone2",
                                                        ["Position"] = Vector(-2.8076171875, -1.6728515625, 0),
                                                        ["AimPartUID"] = "",
                                                        ["AlternativeBones"] = false,
                                                        ["Hide"] = false,
                                                        ["Name"] = "",
                                                        ["Scale"] = Vector(1, 1, 1),
                                                        ["EditorExpand"] = true,
                                                        ["AngleOffset"] = Angle(0, 0, 0),
                                                        ["Size"] = 0.625,
                                                        ["PositionOffset"] = Vector(0, 0, 0),
                                                        ["IsDisturbing"] = false,
                                                        ["InvertHideMesh"] = false,
                                                        ["EyeAngles"] = false,
                                                        ["HideMesh"] = false,
                                                },
                                        },
                                        [3] = {
                                                ["children"] = {
                                                },
                                                ["self"] = {
                                                        ["Jiggle"] = false,
                                                        ["DrawOrder"] = 0,
                                                        ["UniqueID"] = "73a281a3ecd245798af481c24a24f5aef967ea74d410534af70535cdba0b3777",
                                                        ["TargetEntityUID"] = "",
                                                        ["FollowAnglesOnly"] = false,
                                                        ["AimPartName"] = "",
                                                        ["FollowPartUID"] = "",
                                                        ["Bone"] = "head",
                                                        ["MoveChildrenToOrigin"] = false,
                                                        ["ScaleChildren"] = false,
                                                        ["Angles"] = Angle(-4.6957557060523e-06, 6.5564565658569, 1.2272996627871e-06),
                                                        ["ClassName"] = "bone2",
                                                        ["Position"] = Vector(-0.56903076171875, 0.619140625, 0.000701904296875),
                                                        ["AimPartUID"] = "",
                                                        ["AlternativeBones"] = true,
                                                        ["Hide"] = false,
                                                        ["Name"] = "",
                                                        ["Scale"] = Vector(1, 1, 1),
                                                        ["EditorExpand"] = false,
                                                        ["AngleOffset"] = Angle(0, 0, 0),
                                                        ["Size"] = 1.55,
                                                        ["PositionOffset"] = Vector(0, 0, 0),
                                                        ["IsDisturbing"] = false,
                                                        ["InvertHideMesh"] = false,
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
                                        ["Scale"] = Vector(1, 1, 1),
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
                        [2] = {
                                ["children"] = {
                                },
                                ["self"] = {
                                        ["Jiggle"] = false,
                                        ["DrawOrder"] = 0,
                                        ["UniqueID"] = "29cfd3f2bfa368a5951dc29dc3ad62847ded2e1164058424b32fc35eaf1230ec",
                                        ["TargetEntityUID"] = "",
                                        ["FollowAnglesOnly"] = false,
                                        ["AimPartName"] = "",
                                        ["FollowPartUID"] = "",
                                        ["Bone"] = "head",
                                        ["MoveChildrenToOrigin"] = false,
                                        ["ScaleChildren"] = false,
                                        ["Angles"] = Angle(0, 0, 0),
                                        ["ClassName"] = "bone2",
                                        ["Position"] = Vector(0, 0, 0),
                                        ["AimPartUID"] = "",
                                        ["AlternativeBones"] = false,
                                        ["Hide"] = false,
                                        ["Name"] = "",
                                        ["Scale"] = Vector(1, 1, 1),
                                        ["EditorExpand"] = false,
                                        ["AngleOffset"] = Angle(0, 0, 0),
                                        ["Size"] = 0.8,
                                        ["PositionOffset"] = Vector(0, 0, 0),
                                        ["IsDisturbing"] = false,
                                        ["InvertHideMesh"] = false,
                                        ["EyeAngles"] = false,
                                        ["HideMesh"] = false,
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
                        ["Name"] = "new",
                        ["Duplicate"] = false,
                        ["ClassName"] = "group",
                },
        },          
}