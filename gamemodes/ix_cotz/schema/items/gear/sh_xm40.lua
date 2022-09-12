ITEM.name = "XM-40"
ITEM.description = "A newer gasmask."
ITEM.longdesc = "A regular plastic and rubber respirator, used to protect the wearer from inhaling harmful dusts, fumes, vapours or gases. Widely used by rookies and veterans of all factions due to its universal functionality. Does not provide any physical protection."
ITEM.model = "models/kek1ch/helm_respirator.mdl"
ITEM.price = 100000
--ITEM.busflag = {"ARMOR4", "SPECIAL6_1"}
ITEM.busflag = {"gasmask1_1"}
ITEM.br = 0
ITEM.fbr = 0
ITEM.ar = 0.20
ITEM.far = 1
ITEM.radProt = 0.20
ITEM.isGasmask = true
ITEM.isHelmet = nil
ITEM.ballisticlevels = {"0"}
ITEM.overlayPath = "vgui/overlays/hud_merc"
ITEM.img = ix.util.GetMaterial("vgui/hud/xm40.png")
ITEM.repairCost = ITEM.price/100*1

ITEM.weight = 2.300

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
				["Translucent"] = false,
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
				["Translucent"] = false,
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
				["Translucent"] = false,
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