ITEM.name = "USAS-12"
ITEM.description = "USAS-12, chambered for 12 Gauge."
ITEM.longdesc = "The deep magazine well and thick receiver account for much of the shotgun's bulk."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_usas12_w.mdl"

ITEM.price = 28400
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 5.5
ITEM.bulletweight = 0.031

ITEM.class = "cw_anomaly_usas12_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(5.5, -205, 7.5),
	ang = Angle(0, 90, 0),
	fov = 9,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_usas12_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(12.524, -4.193, -1.228),
							["EditorExpand"] = true,
							["UniqueID"] = "828450104",
							["Bone"] = "spine 2",
							["Name"] = "usas12",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "3713686854",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_usas12_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "2335445796",
			["EditorExpand"] = true,
		},
	},
}
