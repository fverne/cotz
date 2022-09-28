ITEM.name = "EO-20"
ITEM.description = "A newer gasmask."
ITEM.longdesc = "A regular plastic and rubber respirator, used to protect the wearer from inhaling harmful dusts, fumes, vapours or gases. Widely used by rookies and veterans of all factions due to its universal functionality. Does not provide any physical protection."
ITEM.model = "models/kek1ch/helm_respirator.mdl"
ITEM.price = 4000
--ITEM.busflag = {"ARMOR4", "SPECIAL6_1"}
ITEM.busflag = {"gasmask1"}
ITEM.br = 0
ITEM.fbr = 0
ITEM.ar = 0.15
ITEM.far = 1
ITEM.radProt = 0.12
ITEM.isGasmask = true
ITEM.isHelmet = nil
ITEM.overlayPath = "vgui/overlays/hud_gas"
ITEM.ballisticlevels = {"0"}
ITEM.img = ix.util.GetMaterial("vgui/hud/eo20.png")
ITEM.repairCost = ITEM.price/100*1

ITEM.weight = 1.800

ITEM.pacData = {
[1] = {
	["children"] = {
		[1] = {
			["children"] = {
			},
			["self"] = {
				["ClassName"] = "model",
				["UniqueID"] = "eo20_body",
				["Size"] = 1,
				["Model"] = "models/projectpt/mask_sunrise2.mdl",
				["Position"] = Vector(-64, -10.7, -0.12),
				["Angles"] = Angle(-1.2999999523163, -81.199996948242, -90),
				["Translucent"] = false,
				["EditorExpand"] = true,
				["Skin"] = 0,
			},
		},
	},
	["self"] = {
		["EditorExpand"] = true,
		["UniqueID"] = "eo20_outfit",
		["ClassName"] = "group",
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
				["UniqueID"] = "1870384856",
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
				["Position"] = Vector(-64.870002746582, -10.60000038147, -0.11999999731779),
				["AngleOffset"] = Angle(0, 0, 0),
				["AlternativeScaling"] = false,
				["Hide"] = false,
				["OwnerEntity"] = false,
				["Scale"] = Vector(1, 1, 1),
				["ClassName"] = "model",
				["EditorExpand"] = true,
				["Size"] = 1.0149999856949,
				["ModelFallback"] = "",
				["Angles"] = Angle(-1.2999999523163, -81.199996948242, -90),
				["TextureFilter"] = 3,
				["Model"] = "models/projectpt/mask_sunrise2.mdl",
				["BlendMode"] = "",
			},
		},
	},
	["self"] = {
		["DrawOrder"] = 0,
		["UniqueID"] = "1150715892",
		["AimPartUID"] = "",
		["Hide"] = true,
		["Duplicate"] = false,
		["ClassName"] = "group",
		["OwnerName"] = "self",
		["IsDisturbing"] = false,
		["Name"] = "eo20new",
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
				["UniqueID"] = "1870384856",
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
				["Position"] = Vector(-64.970001220703, -11.270000457764, -0.11999999731779),
				["AngleOffset"] = Angle(0, 0, 0),
				["AlternativeScaling"] = false,
				["Hide"] = false,
				["OwnerEntity"] = false,
				["Scale"] = Vector(1, 1, 1),
				["ClassName"] = "model",
				["EditorExpand"] = true,
				["Size"] = 1.0149999856949,
				["ModelFallback"] = "",
				["Angles"] = Angle(-1.2999999523163, -81.199996948242, -90),
				["TextureFilter"] = 3,
				["Model"] = "models/projectpt/mask_sunrise2.mdl",
				["BlendMode"] = "",
			},
		},
	},
	["self"] = {
		["DrawOrder"] = 0,
		["UniqueID"] = "1150715892",
		["AimPartUID"] = "",
		["Hide"] = false,
		["Duplicate"] = false,
		["ClassName"] = "group",
		["OwnerName"] = "self",
		["IsDisturbing"] = false,
		["Name"] = "eo20new",
		["EditorExpand"] = false,
	},
},	
}

ITEM.pacDataNBC = {
	
}