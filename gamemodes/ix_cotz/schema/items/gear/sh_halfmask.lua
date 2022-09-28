ITEM.name = "Respirator"
ITEM.description = "An old gasmask."
ITEM.longdesc = "A regular plastic and rubber respirator, used to protect the wearer from inhaling harmful dusts, fumes, vapours or gases. Widely used by rookies and veterans of all factions due to its universal functionality. Does not provide any physical protection."
ITEM.model = "models/kek1ch/helm_respirator.mdl"
ITEM.price = 3000
--ITEM.busflag = {"ARMOR4", "SPECIAL6_1"}
ITEM.busflag = {"gasmask"}
ITEM.br = 0
ITEM.fbr = 0
ITEM.ar = 0.05
ITEM.far = 1
ITEM.radProt = 0.01
ITEM.isGasmask = true
ITEM.isHelmet = nil
ITEM.ballisticlevels = {"0"}
ITEM.img = ix.util.GetMaterial("vgui/hud/halfmask.png")
ITEM.repairCost = ITEM.price/100*1

ITEM.weight = 0.900

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
				["UniqueID"] = "halfmask_body",
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
				["Position"] = Vector(-64, -11.300000190735, -0.11999999731779),
				["AngleOffset"] = Angle(0, 0, 0),
				["AlternativeScaling"] = false,
				["Hide"] = false,
				["OwnerEntity"] = false,
				["Scale"] = Vector(1, 1, 1),
				["ClassName"] = "model",
				["EditorExpand"] = true,
				["Size"] = 1,
				["ModelFallback"] = "",
				["Angles"] = Angle(-1.2999999523163, -81.199996948242, -90),
				["TextureFilter"] = 3,
				["Model"] = "models/projectpt/mask_halfmask.mdl",
				["BlendMode"] = "",
			},
		},
	},
	["self"] = {
		["DrawOrder"] = 0,
		["UniqueID"] = "halfmask_outfit",
		["AimPartUID"] = "",
		["Hide"] = false,
		["Duplicate"] = false,
		["ClassName"] = "group",
		["OwnerName"] = "self",
		["IsDisturbing"] = false,
		["Name"] = "halfmask",
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
				["UniqueID"] = "halfmask_body",
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
				["Position"] = Vector(-63.599998474121, -11, -0.11999999731779),
				["AngleOffset"] = Angle(0, 0, 0),
				["AlternativeScaling"] = false,
				["Hide"] = false,
				["OwnerEntity"] = false,
				["Scale"] = Vector(1, 1, 1),
				["ClassName"] = "model",
				["EditorExpand"] = true,
				["Size"] = 1,
				["ModelFallback"] = "",
				["Angles"] = Angle(-1.2999999523163, -81.199996948242, -90),
				["TextureFilter"] = 3,
				["Model"] = "models/projectpt/mask_halfmask.mdl",
				["BlendMode"] = "",
			},
		},
	},
	["self"] = {
		["DrawOrder"] = 0,
		["UniqueID"] = "halfmask_outfit",
		["AimPartUID"] = "",
		["Hide"] = true,
		["Duplicate"] = false,
		["ClassName"] = "group",
		["OwnerName"] = "self",
		["IsDisturbing"] = false,
		["Name"] = "halfmask",
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
				["UniqueID"] = "halfmask_body",
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
				["Position"] = Vector(-64, -11.800000190735, -0.11999999731779),
				["AngleOffset"] = Angle(0, 0, 0),
				["AlternativeScaling"] = false,
				["Hide"] = false,
				["OwnerEntity"] = false,
				["Scale"] = Vector(1, 1, 1),
				["ClassName"] = "model",
				["EditorExpand"] = true,
				["Size"] = 1,
				["ModelFallback"] = "",
				["Angles"] = Angle(-1.2999999523163, -81.199996948242, -90),
				["TextureFilter"] = 3,
				["Model"] = "models/projectpt/mask_halfmask.mdl",
				["BlendMode"] = "",
			},
		},
	},
	["self"] = {
		["DrawOrder"] = 0,
		["UniqueID"] = "halfmask_outfit",
		["AimPartUID"] = "",
		["Hide"] = false,
		["Duplicate"] = false,
		["ClassName"] = "group",
		["OwnerName"] = "self",
		["IsDisturbing"] = false,
		["Name"] = "halfmask",
		["EditorExpand"] = false,
	},
},	
}

ITEM.pacDataNBC = {
	
}