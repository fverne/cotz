ITEM.name = "M50 Gasmask"
ITEM.description = "A modern gasmask"
ITEM.longdesc = "TODO"
ITEM.model = "models/shtokerbox/ground_mask_m50.mdl"

ITEM.price = 90000
ITEM.weight = 0.75

ITEM.isGasmask = true
ITEM.isHelmet = false
-- ITEM.ballisticlevels = {"ll-a"}

ITEM.br = 0.00
ITEM.fbr = 0
ITEM.ar = 0
ITEM.far = 0
ITEM.radProt = 0.60

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, -4, 200),
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
				["Invert"] = false,
				["EyeTargetName"] = "",
				["NoLighting"] = false,
				["OwnerName"] = "self",
				["AimPartName"] = "",
				["IgnoreZ"] = false,
				["AimPartUID"] = "",
				["Materials"] = "",
				["Name"] = "",
				["LevelOfDetail"] = 0,
				["NoTextureFiltering"] = false,
				["PositionOffset"] = Vector(0, 0, 0),
				["NoCulling"] = false,
				["Translucent"] = false,
				["DrawOrder"] = 0,
				["Alpha"] = 1,
				["Material"] = "",
				["Bone"] = "head",
				["UniqueID"] = "536074279",
				["BoneMerge"] = false,
				["EyeTargetUID"] = "",
				["Position"] = Vector(1.0369999408722, -3.1429998874664, -0.30000001192093),
				["BlendMode"] = "",
				["Angles"] = Angle(90, 14.710472106934, 0),
				["Hide"] = false,
				["EyeAngles"] = false,
				["Scale"] = Vector(1.1900000572205, 1.1799999475479, 1.0099999904633),
				["AngleOffset"] = Angle(0, 0, 0),
				["EditorExpand"] = false,
				["Size"] = 0.875,
				["Color"] = Vector(1, 1, 1),
				["ClassName"] = "model2",
				["IsDisturbing"] = false,
				["ModelModifiers"] = "",
				["Model"] = "models/hardbass/m50.mdl",
			},
		},
	},
	["self"] = {
		["DrawOrder"] = 0,
		["UniqueID"] = "1426430527",
		["AimPartUID"] = "",
		["Hide"] = false,
		["Duplicate"] = false,
		["ClassName"] = "group",
		["OwnerName"] = "self",
		["IsDisturbing"] = false,
		["Name"] = "M50",
		["EditorExpand"] = false,
	},
},

}
