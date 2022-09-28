ITEM.name = "GP5 Gasmask"
ITEM.description = "An old Soviet gasmask."
ITEM.longdesc = "Cheap rubber gas mask of soviet origin, paired with a modern non-asbestos filter. Due to odd shape, it doesn't fit with all types of helmets."
ITEM.model = "models/hardbass/stalker_skat9m_gasmask.mdl"
ITEM.price = 6000
--ITEM.busflag = {"ARMOR4", "SPECIAL6_1"}
ITEM.busflag = {"gasmask"}
ITEM.br = 0
ITEM.fbr = 0
ITEM.ar = 0.08
ITEM.far = 1
ITEM.radProt = 0.05
ITEM.isGasmask = true
ITEM.isHelmet = false
ITEM.overlayPath = "vgui/overlays/hud_gas"
ITEM.ballisticlevels = {"0"}
ITEM.img = ix.util.GetMaterial("vgui/hud/gp5.png")
ITEM.repairCost = ITEM.price/100*1

ITEM.weight = 1.400

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
				["UniqueID"] = "gp5_body",
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
				["Position"] = Vector(-71.550003051758, -18.670000076294, -0.20999999344349),
				["AngleOffset"] = Angle(0, 0, 0),
				["AlternativeScaling"] = false,
				["Hide"] = false,
				["OwnerEntity"] = false,
				["Scale"] = Vector(1, 1.1399999856949, 1.1399999856949),
				["ClassName"] = "model",
				["EditorExpand"] = true,
				["Size"] = 1,
				["ModelFallback"] = "",
				["Angles"] = Angle(-1.2999999523163, -75.599998474121, -90),
				["TextureFilter"] = 3,
				["Model"] = "models/projectpt/mask_gp5.mdl",
				["BlendMode"] = "",
			},
		},
	},
	["self"] = {
		["DrawOrder"] = 0,
		["UniqueID"] = "gp5_outfit",
		["AimPartUID"] = "",
		["Hide"] = false,
		["Duplicate"] = false,
		["ClassName"] = "group",
		["OwnerName"] = "self",
		["IsDisturbing"] = false,
		["Name"] = "gp5",
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
				["UniqueID"] = "gp5_body",
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
				["Position"] = Vector(2.322265625, -4.3239998817444, -0.2119999974966),
				["AngleOffset"] = Angle(0, 0, 0),
				["AlternativeScaling"] = false,
				["Hide"] = false,
				["OwnerEntity"] = false,
				["Scale"] = Vector(1, 1.1000000238419, 1),
				["ClassName"] = "model",
				["EditorExpand"] = true,
				["Size"] = 1.2250000238419,
				["ModelFallback"] = "",
				["Angles"] = Angle(-4.5890328692622e-06, -79.388000488281, -90.000022888184),
				["TextureFilter"] = 3,
				["Model"] = "models/hardbass/stalker_skat9m_gasmask.mdl",
				["BlendMode"] = "",
			},
		},
	},
	["self"] = {
		["DrawOrder"] = 0,
		["UniqueID"] = "gp5_outfit",
		["AimPartUID"] = "",
		["Hide"] = true,
		["Duplicate"] = false,
		["ClassName"] = "group",
		["OwnerName"] = "self",
		["IsDisturbing"] = false,
		["Name"] = "gp5",
		["EditorExpand"] = false,
	},
},
}

ITEM.pacDataBerill1 = {
[5] = {
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
				["UniqueID"] = "gp5_body",
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
				["Position"] = Vector(-62.450000762939, -17.569999694824, -0.059999998658895),
				["AngleOffset"] = Angle(0, 0, 0),
				["AlternativeScaling"] = false,
				["Hide"] = false,
				["OwnerEntity"] = false,
				["Scale"] = Vector(0.94999998807907, 1, 1),
				["ClassName"] = "model",
				["EditorExpand"] = true,
				["Size"] = 1,
				["ModelFallback"] = "",
				["Angles"] = Angle(-1.2999999523163, -75.599998474121, -90),
				["TextureFilter"] = 3,
				["Model"] = "models/projectpt/mask_gp5.mdl",
				["BlendMode"] = "",
			},
		},
	},
	["self"] = {
		["DrawOrder"] = 0,
		["UniqueID"] = "gp5_outfit",
		["AimPartUID"] = "",
		["Hide"] = false,
		["Duplicate"] = false,
		["ClassName"] = "group",
		["OwnerName"] = "self",
		["IsDisturbing"] = false,
		["Name"] = "gp5",
		["EditorExpand"] = false,
	},
},	
}

ITEM.pacDataNBC = {
	
}