ITEM.name = "EO-20 Gasmask"
ITEM.description = "A modern gasmask"
ITEM.longdesc = "The EO-20 gives its eye openings and breathing assembly a compact fitted body. Flexible sealing material sits behind the harder visible components. It is dedicated respiratory equipment, worn separately from a helmet rather than built into a complete enclosed headpiece."
ITEM.model = "models/shtokerbox/ground_mask_sunrise2.mdl"

ITEM.price = 30000
ITEM.weight = 0.5

ITEM.isGasmask = true
ITEM.isHelmet = false
-- 
ITEM.br = 0.00
ITEM.fbr = 0
ITEM.ar = 0
ITEM.far = 0
ITEM.radProt = 0.80
ITEM.flatRadProt = 0.02

ITEM.appearanceCustomization = {
	targets = {
		{1, 1},
		{1, 1, 1},
	},
	defaultSkin = "sunrise_loner",
	worldMaterialSlots = {},
	skins = {
		{id = "sunrise_loner", name = "Sunrise Loner", skin = 0, worldSkin = 0},
		{id = "sunrise_camo", name = "Sunrise Camo", skin = 1, worldSkin = 1},
		{id = "sunrise_mercenary", name = "Sunrise Mercenary", skin = 2, worldSkin = 2},
		{id = "sunrise_military", name = "Sunrise Military", skin = 3, worldSkin = 3},
		{id = "sunrise_military2", name = "Sunrise Military2", skin = 4, worldSkin = 4},
		{id = "sunrise_monolith", name = "Sunrise Monolith", skin = 5, worldSkin = 5},
		{id = "sunrise_bandit", name = "Sunrise Bandit", skin = 6, worldSkin = 6},
		{id = "sunrise_black", name = "Sunrise Black", skin = 7, worldSkin = 7},
		{id = "sunrise_flek", name = "Sunrise Flek", skin = 8, worldSkin = 8},
		{id = "sunrise_urban", name = "Sunrise Urban", skin = 9, worldSkin = 9},
		{id = "sunrise_duty", name = "Sunrise Duty", skin = 10, worldSkin = 10},
		{id = "sunrise_scientific", name = "Sunrise Scientific", skin = 11, worldSkin = 11},
		{id = "sunrise_neutral1", name = "Sunrise Neutral1", skin = 12, worldSkin = 12},
		{id = "sunrise_neutral2", name = "Sunrise Neutral2", skin = 13, worldSkin = 13},
		{id = "sunrise_neutral3", name = "Sunrise Neutral3", skin = 14, worldSkin = 14},
		{id = "sunrise_neutral4", name = "Sunrise Neutral4", skin = 15, worldSkin = 15},
		{id = "sunrise_neutral5", name = "Sunrise Neutral5", skin = 16, worldSkin = 16},
		{id = "sunrise_neutral6", name = "Sunrise Neutral6", skin = 17, worldSkin = 17},
		{id = "sunrise_neutral7", name = "Sunrise Neutral7", skin = 18, worldSkin = 18},
		{id = "sunrise_neutral8", name = "Sunrise Neutral8", skin = 19, worldSkin = 19},
		{id = "sunrise_neutral9", name = "Sunrise Neutral9", skin = 20, worldSkin = 20},
		{id = "sunrise_neutral10", name = "Sunrise Neutral10", skin = 21, worldSkin = 21},
		{id = "sunrise_neutral11", name = "Sunrise Neutral11", skin = 22, worldSkin = 22},
		{id = "sunrise_neutral12", name = "Sunrise Neutral12", skin = 23, worldSkin = 23},
		{id = "sunrise_loner2", name = "Sunrise Loner2", skin = 24, worldSkin = 24},
		{id = "sunrise_loner3", name = "Sunrise Loner3", skin = 25, worldSkin = 25},
		{id = "sunrise_loner4", name = "Sunrise Loner4", skin = 26, worldSkin = 26},
		{id = "sunrise_loner5", name = "Sunrise Loner5", skin = 27, worldSkin = 27},
		{id = "sunrise_loner6", name = "Sunrise Loner6", skin = 28, worldSkin = 28},
		{id = "sunset_duty", name = "Sunset Duty", skin = 34, worldSkin = 34},
		{id = "sunset_duty2", name = "Sunset Duty2", skin = 35, worldSkin = 35},
		{id = "sunset_ecologist", name = "Sunset Ecologist", skin = 37, worldSkin = 37},
		{id = "sunset_freedom", name = "Sunset Freedom", skin = 38, worldSkin = 38},
		{id = "sunset_loner", name = "Sunset Loner", skin = 40, worldSkin = 40},
		{id = "sunset_loner2", name = "Sunset Loner2", skin = 41, worldSkin = 41},
		{id = "sunset_mercenary", name = "Sunset Mercenary", skin = 42, worldSkin = 42},
		{id = "sunset_military", name = "Sunset Military", skin = 43, worldSkin = 43},
		{id = "sunset_monolith", name = "Sunset Monolith", skin = 44, worldSkin = 44},
		{id = "sunset_scientific", name = "Sunset Scientific", skin = 46, worldSkin = 46},
		{id = "wild_bandit", name = "Wild Bandit", skin = 51, worldSkin = 51},
		{id = "wild_bandit2", name = "Wild Bandit2", skin = 52, worldSkin = 52},
		{id = "wild_beyond", name = "Wild Beyond", skin = 53, worldSkin = 53},
		{id = "wild_duty", name = "Wild Duty", skin = 54, worldSkin = 54},
		{id = "wild_duty2", name = "Wild Duty2", skin = 55, worldSkin = 55},
		{id = "wild_finalday", name = "Wild Finalday", skin = 56, worldSkin = 56},
		{id = "wild_freedom", name = "Wild Freedom", skin = 57, worldSkin = 57},
		{id = "wild_mercenary", name = "Wild Mercenary", skin = 58, worldSkin = 58},
		{id = "wild_monolith", name = "Wild Monolith", skin = 59, worldSkin = 59},
		{id = "wild_monolith2", name = "Wild Monolith2", skin = 60, worldSkin = 60},
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
                                [1] = {
                                        ["children"] = {
                                                [1] = {
                                                        ["children"] = {
                                                        },
                                                        ["self"] = {
                                                                ["DrawOrder"] = 0,
                                                                ["UniqueID"] = "0112f1e03fc0d30eddd70866360143fd87670c1f6d6f3488964e16715b7c3dca",
                                                                ["TargetEntityUID"] = "",
                                                                ["AimPartName"] = "",
                                                                ["Bone"] = "head",
                                                                ["BlendMode"] = "",
                                                                ["Position"] = Vector(0.023529052734375, -0.3017578125, 0.0029296875),
                                                                ["AimPartUID"] = "",
                                                                ["NoTextureFiltering"] = false,
                                                                ["Hide"] = false,
                                                                ["Name"] = "",
                                                                ["Translucent"] = true,
                                                                ["IgnoreZ"] = false,
                                                                ["Angles"] = Angle(3.5143566131592, 87.746253967285, -0.13824853301048),
                                                                ["AngleOffset"] = Angle(0, 0, 0),
                                                                ["PositionOffset"] = Vector(0, 0, 0),
                                                                ["IsDisturbing"] = false,
                                                                ["ClassName"] = "clip2",
                                                                ["EyeAngles"] = false,
                                                                ["EditorExpand"] = false,
                                                        },
                                                },
                                        },
                                        ["self"] = {
                                                ["Skin"] = 0,
                                                ["UniqueID"] = "ef775194aaab32877636107891bd52b874a97afe43507462e2e61fb61f030099",
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
                                                ["Angles"] = Angle(-4.9187663535122e-05, -84.789024353027, -90.000015258789),
                                                ["AngleOffset"] = Angle(0, 0, 0),
                                                ["BoneMerge"] = false,
                                                ["Color"] = Vector(1, 1, 1),
                                                ["Position"] = Vector(-65.46435546875, -10.3203125, 0.001953125),
                                                ["ClassName"] = "model2",
                                                ["Brightness"] = 1,
                                                ["Hide"] = false,
                                                ["NoCulling"] = false,
                                                ["Scale"] = Vector(0.050000000745058, 1, 1.0299999713898),
                                                ["LegacyTransform"] = false,
                                                ["EditorExpand"] = true,
                                                ["Size"] = 1,
                                                ["ModelModifiers"] = "",
                                                ["Translucent"] = true,
                                                ["BlendMode"] = "",
                                                ["EyeTargetUID"] = "",
                                                ["Model"] = "models/shtokerbox/headgear/male_mask_sunrise.mdl",
                                        },
                                },
                        },
                        ["self"] = {
                                ["Skin"] = 0,
                                ["UniqueID"] = "741bf23a8e7e7b548bf6eba6ec9a216eba0e9c280a7845c735698b648acdae82",
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
                                ["Angles"] = Angle(-1.9917317331419e-05, -77.012977600098, -90.000015258789),
                                ["AngleOffset"] = Angle(0, 0, 0),
                                ["BoneMerge"] = false,
                                ["Color"] = Vector(1, 1, 1),
                                ["Position"] = Vector(-72.154663085938, -15.6025390625, 0.001953125),
                                ["ClassName"] = "model2",
                                ["Brightness"] = 1,
                                ["Hide"] = false,
                                ["NoCulling"] = false,
                                ["Scale"] = Vector(1, 0.89999997615814, 1.0299999713898),
                                ["LegacyTransform"] = false,
                                ["EditorExpand"] = true,
                                ["Size"] = 1.1,
                                ["ModelModifiers"] = "",
                                ["Translucent"] = true,
                                ["BlendMode"] = "",
                                ["EyeTargetUID"] = "",
                                ["Model"] = "models/shtokerbox/headgear/male_mask_sunrise.mdl",
                        },
                },
        },
        ["self"] = {
                ["DrawOrder"] = 0,
                ["UniqueID"] = "65fd422e281358b6fad2d359b6f4ee88bfe8c0672983d044f1635c43cf5e47b4",
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
