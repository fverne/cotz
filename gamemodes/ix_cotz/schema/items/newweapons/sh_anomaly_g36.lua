ITEM.name = "G36"
ITEM.description = "G36, chambered for 5.56x45mm."
ITEM.longdesc = "The full-length G36 carries its optic in the raised handle above the polymer receiver."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_g36_w.mdl"

ITEM.price = 27500
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 3.6
ITEM.bulletweight = 0.012

ITEM.class = "cw_anomaly_g36_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(6.5, -205, 6.4),
	ang = Angle(0, 90, 0),
	fov = 9.9,
}

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
					[1] = {
						["children"] = {},
						["self"] = {
							["Angles"] = Angle(0, 180, 180),
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_g36_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(14.673, -4.309, -1.334),
							["EditorExpand"] = true,
							["UniqueID"] = "2976699514",
							["Bone"] = "spine 2",
							["Name"] = "g36",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "1566026756",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_g36_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "188342886",
			["EditorExpand"] = true,
		},
	},
}
