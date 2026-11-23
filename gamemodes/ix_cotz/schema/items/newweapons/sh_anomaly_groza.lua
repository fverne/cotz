ITEM.name = "OTs-14-4A"
ITEM.description = "OTs-14-4A, chambered for 9x39mm."
ITEM.longdesc = "Moving the action and magazine behind the grip gives the Groza its compact outline."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_groza_w.mdl"

ITEM.price = 38000
ITEM.width = 4
ITEM.height = 2
ITEM.unloadedweight = 3.2
ITEM.bulletweight = 0.023

ITEM.class = "cw_anomaly_groza_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(-2.2, -205, 6.3),
	ang = Angle(0, 90, 0),
	fov = 8.3,
}

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
					[1] = {
						["children"] = {},
						["self"] = {
							["Angles"] = Angle(180, 0, 0),
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_groza_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(2.141, -4.444, 2.193),
							["EditorExpand"] = true,
							["UniqueID"] = "679335673",
							["Bone"] = "spine 2",
							["Name"] = "groza",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "3292966535",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_groza_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "2452152549",
			["EditorExpand"] = true,
		},
	},
}
