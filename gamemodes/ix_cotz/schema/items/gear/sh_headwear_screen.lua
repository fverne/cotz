ITEM.name = "Screen Helmet"
ITEM.description = "A screen helmet with closed respiratory system."
ITEM.longdesc = "The Screen encloses the head behind a broad visor and connects to a closed respiratory assembly. The complete equipment occupies space beyond the helmet itself. Its emphasis is on environmental protection and a self-contained arrangement, rather than a thick ballistic shell."
ITEM.model = "models/shtokerbox/ground_seva_visor.mdl"

ITEM.price = 100000
ITEM.weight = 4
ITEM.overlayPath = "vgui/overlays/hud_sci"

ITEM.isGasmask = true
ITEM.filterType = "scientific"
ITEM.isHelmet = true
ITEM.isBackpack = true
ITEM.outfitCategory = "Backpack"
ITEM.carryinc = 18
ITEM.baseSuit = "headwear_screen"
ITEM.suitVariant = "baseline"

ITEM.br = 0.01
ITEM.fbr = 0
ITEM.sr = 0.01
ITEM.fsr = 0
ITEM.ar = 0
ITEM.far = 0
ITEM.pr = 0.45
ITEM.fpr = 0
ITEM.radProt = 0.98
ITEM.flatRadProt = 0.02

ITEM.appearanceCustomization = {
	targets = {
		{1, 1},
	},
	defaultSkin = "seva_lone",
	worldMaterialSlots = {},
	worldNotice = "Some worn finishes have no matching ground-model surface.",
	skins = {
		{id = "seva_lone", name = "Loner", skin = 0, worldSkin = 0},
		{id = "seva_duty", name = "Duty", skin = 1, worldSkin = 0},
		{id = "seva_midn", name = "Midnight", skin = 2, worldSkin = 0},
		{id = "seva_csky", name = "Clear Sky", skin = 3, worldSkin = 0},
		{id = "seva_free", name = "Freedom", skin = 4, worldSkin = 0},
	},
	bodygroups = {},
}

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, -90, 0),
	fov = 3.85
}

function ITEM:PopulateTooltipIndividual(tooltip)
	ix.util.PropertyDesc2(tooltip, self.outfitCategory, Color(64, 224, 208), ix.util.GetMaterial("vgui/ui/stalker/weaponupgrades/handling.png"))
end

ITEM.pacData =  {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
					[1] = {
						["children"] = {},
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
                                                        ["Angles"] = Angle(0, 0, 0.038444),
                                                        ["ClassName"] = "bone2",
                                                        ["Position"] = Vector(-0.014039, 0.294386, 0.000001),
                                                        ["AimPartUID"] = "",
                                                        ["AlternativeBones"] = true,
                                                        ["Hide"] = false,
                                                        ["Name"] = "",
                                                        ["Scale"] = Vector(0.959645, 1.005322, 0.929422),
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
                                        ["NoCulling"] = false,
                                        ["Scale"] = Vector(1, 1, 1),
                                        ["LegacyTransform"] = false,
                                        ["EditorExpand"] = true,
                                        ["Size"] = 1,
                                        ["ModelModifiers"] = "",
                                        ["Translucent"] = true,
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
                        ["Name"] = "new",
                        ["Duplicate"] = false,
                        ["ClassName"] = "group",
                },
	},
}
