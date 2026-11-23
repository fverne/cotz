ITEM.name = "CZ-75"
ITEM.description = "CZ-75, chambered for 9x19mm."
ITEM.longdesc = "The slide runs inside the frame rails, giving the CZ its narrow upper profile."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_cz75_w.mdl"

ITEM.price = 3600
ITEM.width = 2
ITEM.height = 1
ITEM.unloadedweight = 0.98
ITEM.bulletweight = 0.008

ITEM.class = "cw_anomaly_cz75_vmrecoil"
ITEM.weaponCategory = "secondary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(2, -205, 3),
	ang = Angle(0, 90, 0),
	fov = 3.3,
}

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
					[1] = {
						["children"] = {},
						["self"] = {
							["Angles"] = Angle(0, -90, -30),
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_cz75_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(-9.48, 8.311, 0.71),
							["EditorExpand"] = true,
							["UniqueID"] = "2027842268",
							["Bone"] = "pelvis",
							["Name"] = "cz75",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2498040482",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_cz75_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "3263913152",
			["EditorExpand"] = true,
		},
	},
}
