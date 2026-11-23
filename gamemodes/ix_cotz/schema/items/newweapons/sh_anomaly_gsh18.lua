ITEM.name = "GSh-18"
ITEM.description = "GSh-18, chambered for 9x19mm."
ITEM.longdesc = "The light polymer frame contrasts with the deep cuts in the metal slide."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_gsh18_w.mdl"

ITEM.price = 5000
ITEM.width = 2
ITEM.height = 1
ITEM.unloadedweight = 0.59
ITEM.bulletweight = 0.008

ITEM.class = "cw_anomaly_gsh18_vmrecoil"
ITEM.weaponCategory = "secondary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(1.4, -205, 3.2),
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
							["Angles"] = Angle(180, 0, 210),
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_gsh18_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(-6.774, 2.172, 3.359),
							["EditorExpand"] = true,
							["UniqueID"] = "3814714257",
							["Bone"] = "pelvis",
							["Name"] = "gsh18",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "258249711",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_gsh18_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "1493884301",
			["EditorExpand"] = true,
		},
	},
}
