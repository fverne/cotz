ITEM.name = "CZ-75 Automatic"
ITEM.description = "CZ-75 Automatic, chambered for 9x19mm."
ITEM.longdesc = "The extended front end and magazine distinguish this automatic CZ from the ordinary service pistol."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_cz75_auto_w.mdl"

ITEM.price = 7500
ITEM.width = 2
ITEM.height = 1
ITEM.unloadedweight = 1.15
ITEM.bulletweight = 0.008

ITEM.class = "cw_anomaly_cz75_auto_vmrecoil"
ITEM.weaponCategory = "secondary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(2.8, -205, 2.8),
	ang = Angle(0, 90, 0),
	fov = 3.4,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_cz75_auto_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(-8.48, 8.311, 0.71),
							["EditorExpand"] = true,
							["UniqueID"] = "1437242662",
							["Bone"] = "pelvis",
							["Name"] = "cz75_auto",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "3113348440",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_cz75_auto_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "4026508090",
			["EditorExpand"] = true,
		},
	},
}
