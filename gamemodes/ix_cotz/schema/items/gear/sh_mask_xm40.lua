ITEM.name = "XM-40"
ITEM.description = "A newer gasmask."
ITEM.longdesc = "A regular plastic and rubber respirator, used to protect the wearer from inhaling harmful dusts, fumes, vapours or gases. Widely used by rookies and veterans of all factions due to its universal functionality. Does not provide any physical protection."
ITEM.model = "models/shtokerbox/ground_mask_xm40.mdl"

ITEM.price = 135000
ITEM.weight = 0.55

ITEM.isGasmask = true
ITEM.isHelmet = false
-- 
ITEM.br = 0.00
ITEM.fbr = 0
ITEM.ar = 0
ITEM.far = 0
ITEM.radProt = 0.90
ITEM.flatRadProt = 0.02

ITEM.appearanceCustomization = {
	targets = {
		{1, 1},
	},
	defaultSkin = "io7a_loner",
	worldMaterialSlots = {},
	skins = {
		{id = "io7a_loner", name = "Loner", skin = 0, worldSkin = 0},
		{id = "io7a_bandit", name = "Bandit", skin = 1, worldSkin = 1},
		{id = "io7a_bandit2", name = "Bandit 2", skin = 2, worldSkin = 2},
		{id = "io7a_cobra", name = "Cobra", skin = 3, worldSkin = 3},
		{id = "io7a_dull", name = "Dull", skin = 4, worldSkin = 4},
		{id = "io7a_duty", name = "Duty", skin = 5, worldSkin = 5},
		{id = "io7a_flektarn", name = "Flektarn", skin = 6, worldSkin = 6},
		{id = "io7a_freedom", name = "Freedom", skin = 7, worldSkin = 7},
		{id = "io7a_freedom2", name = "Freedom 2", skin = 8, worldSkin = 8},
		{id = "io7a_merc1", name = "Mercenary 1", skin = 11, worldSkin = 11},
		{id = "io7a_merc2", name = "Mercenary 2", skin = 12, worldSkin = 12},
		{id = "io7a_merc3", name = "Mercenary 3", skin = 13, worldSkin = 13},
		{id = "io7a_merc4", name = "Mercenary 4", skin = 14, worldSkin = 14},
		{id = "io7a_merc5", name = "Mercenary 5", skin = 15, worldSkin = 15},
		{id = "io7a_merc6", name = "Mercenary 6", skin = 16, worldSkin = 16},
		{id = "io7a_merc7", name = "Mercenary 7", skin = 17, worldSkin = 17},
		{id = "io7a_merc8", name = "Mercenary 8", skin = 18, worldSkin = 18},
		{id = "io7a_merc9", name = "Mercenary 9", skin = 19, worldSkin = 19},
		{id = "io7a_merc10", name = "Mercenary 10", skin = 20, worldSkin = 20},
		{id = "io7a_merc11", name = "Mercenary 11", skin = 21, worldSkin = 21},
		{id = "io7a_merc12", name = "Mercenary 12", skin = 22, worldSkin = 22},
		{id = "io7a_merc13", name = "Mercenary 13", skin = 23, worldSkin = 23},
		{id = "io7a_merc14", name = "Mercenary 14", skin = 24, worldSkin = 24},
		{id = "io7a_merc15", name = "Mercenary 15", skin = 25, worldSkin = 25},
		{id = "io7a_merc16", name = "Mercenary 16", skin = 26, worldSkin = 26},
		{id = "io7a_merc17", name = "Mercenary 17", skin = 27, worldSkin = 27},
		{id = "io7a_military", name = "Military", skin = 28, worldSkin = 28},
		{id = "io7a_monolith", name = "Monolith", skin = 29, worldSkin = 29},
		{id = "io7a_sand", name = "Sand", skin = 30, worldSkin = 30},
		{id = "io7a_scientific", name = "Scientific", skin = 31, worldSkin = 31},
		{id = "io7a_urban", name = "Urban", skin = 32, worldSkin = 32},
		{id = "io7a_woodland", name = "Woodland", skin = 33, worldSkin = 33},
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
				["Invert"] = false,
				["LightBlend"] = 1,
				["CellShade"] = 0,
				["OwnerName"] = "self",
				["AimPartName"] = "",
				["IgnoreZ"] = false,
				["AimPartUID"] = "",
				["Passes"] = 1,
				["Name"] = "",
				["NoTextureFiltering"] = false,
				["DoubleFace"] = false,
				["PositionOffset"] = Vector(0, 0, 0),
				["IsDisturbing"] = false,
				["Fullbright"] = false,
				["EyeAngles"] = false,
				["DrawOrder"] = 0,
				["TintColor"] = Vector(0, 0, 0),
				["UniqueID"] = "xm40_body",
				["Translucent"] = true,
				["LodOverride"] = -1,
				["BlurSpacing"] = 0,
				["Alpha"] = 1,
				["Material"] = "",
				["UseWeaponColor"] = false,
				["UsePlayerColor"] = false,
				["UseLegacyScale"] = false,
				["Bone"] = "head",
				["Color"] = Vector(255, 255, 255),
				["Brightness"] = 1,
				["BoneMerge"] = false,
				["BlurLength"] = 0,
				["Position"] = Vector(-77.764999389648, -18.541999816895, -0.17399999499321),
				["AngleOffset"] = Angle(0, 0, 0),
				["AlternativeScaling"] = false,
				["Hide"] = false,
				["OwnerEntity"] = false,
				["Scale"] = Vector(1, 1, 1),
				["ClassName"] = "model",
				["EditorExpand"] = true,
				["Size"] = 1.2200000286102,
				["ModelFallback"] = "",
				["Angles"] = Angle(-1.2999999523163, -76.300003051758, -90),
				["TextureFilter"] = 3,
				["Model"] = "models/projectpt/mask_io7a.mdl",
				["BlendMode"] = "",
			},
		},
	},
	["self"] = {
		["DrawOrder"] = 0,
		["UniqueID"] = "xm40_outfit",
		["AimPartUID"] = "",
		["Hide"] = false,
		["Duplicate"] = false,
		["ClassName"] = "group",
		["OwnerName"] = "self",
		["IsDisturbing"] = false,
		["Name"] = "xm40",
		["EditorExpand"] = false,
	},
},
}

ITEM.pacDataExpedition = {
[1] = {
	["children"] = {
		[1] = {
			["children"] = {
			},
			["self"] = {
				["Skin"] = 0,
				["Invert"] = false,
				["LightBlend"] = 1,
				["CellShade"] = 0,
				["OwnerName"] = "self",
				["AimPartName"] = "",
				["IgnoreZ"] = false,
				["AimPartUID"] = "",
				["Passes"] = 1,
				["Name"] = "",
				["NoTextureFiltering"] = false,
				["DoubleFace"] = false,
				["PositionOffset"] = Vector(0, 0, 0),
				["IsDisturbing"] = false,
				["Fullbright"] = false,
				["EyeAngles"] = false,
				["DrawOrder"] = 0,
				["TintColor"] = Vector(0, 0, 0),
				["UniqueID"] = "xm40_body",
				["Translucent"] = true,
				["LodOverride"] = -1,
				["BlurSpacing"] = 0,
				["Alpha"] = 1,
				["Material"] = "",
				["UseWeaponColor"] = false,
				["UsePlayerColor"] = false,
				["UseLegacyScale"] = false,
				["Bone"] = "head",
				["Color"] = Vector(255, 255, 255),
				["Brightness"] = 1,
				["BoneMerge"] = false,
				["BlurLength"] = 0,
				["Position"] = Vector(-64.724998474121, -22.238000869751, -0.17379760742188),
				["AngleOffset"] = Angle(0, 0, 0),
				["AlternativeScaling"] = false,
				["Hide"] = false,
				["OwnerEntity"] = false,
				["Scale"] = Vector(1, 1, 1),
				["ClassName"] = "model",
				["EditorExpand"] = true,
				["Size"] = 1.0499999523163,
				["ModelFallback"] = "",
				["Angles"] = Angle(-1.2999999523163, -72.300003051758, -90),
				["TextureFilter"] = 3,
				["Model"] = "models/projectpt/mask_io7a.mdl",
				["BlendMode"] = "",
			},
		},
	},
	["self"] = {
		["DrawOrder"] = 0,
		["UniqueID"] = "xm40_outfit",
		["AimPartUID"] = "",
		["Hide"] = true,
		["Duplicate"] = false,
		["ClassName"] = "group",
		["OwnerName"] = "self",
		["IsDisturbing"] = false,
		["Name"] = "xm40",
		["EditorExpand"] = false,
	},
},
}

ITEM.pacDataBerill1 = {
[1] = {
	["children"] = {
		[1] = {
			["children"] = {
			},
			["self"] = {
				["Skin"] = 0,
				["Invert"] = false,
				["LightBlend"] = 1,
				["CellShade"] = 0,
				["OwnerName"] = "self",
				["AimPartName"] = "",
				["IgnoreZ"] = false,
				["AimPartUID"] = "",
				["Passes"] = 1,
				["Name"] = "",
				["NoTextureFiltering"] = false,
				["DoubleFace"] = false,
				["PositionOffset"] = Vector(0, 0, 0),
				["IsDisturbing"] = false,
				["Fullbright"] = false,
				["EyeAngles"] = false,
				["DrawOrder"] = 0,
				["TintColor"] = Vector(0, 0, 0),
				["UniqueID"] = "xm40_body",
				["Translucent"] = true,
				["LodOverride"] = -1,
				["BlurSpacing"] = 0,
				["Alpha"] = 1,
				["Material"] = "",
				["UseWeaponColor"] = false,
				["UsePlayerColor"] = false,
				["UseLegacyScale"] = false,
				["Bone"] = "head",
				["Color"] = Vector(255, 255, 255),
				["Brightness"] = 1,
				["BoneMerge"] = false,
				["BlurLength"] = 0,
				["Position"] = Vector(-69.964996337891, -17.312000274658, -0.17399999499321),
				["AngleOffset"] = Angle(0, 0, 0),
				["AlternativeScaling"] = false,
				["Hide"] = false,
				["OwnerEntity"] = false,
				["Scale"] = Vector(1, 1, 1),
				["ClassName"] = "model",
				["EditorExpand"] = true,
				["Size"] = 1.1,
				["ModelFallback"] = "",
				["Angles"] = Angle(-1.2999999523163, -76.300003051758, -90),
				["TextureFilter"] = 3,
				["Model"] = "models/projectpt/mask_io7a.mdl",
				["BlendMode"] = "",
			},
		},
	},
	["self"] = {
		["DrawOrder"] = 0,
		["UniqueID"] = "xm40_outfit",
		["AimPartUID"] = "",
		["Hide"] = false,
		["Duplicate"] = false,
		["ClassName"] = "group",
		["OwnerName"] = "self",
		["IsDisturbing"] = false,
		["Name"] = "xm40",
		["EditorExpand"] = false,
	},
},	
}

ITEM.pacDataNBC = {
	
}