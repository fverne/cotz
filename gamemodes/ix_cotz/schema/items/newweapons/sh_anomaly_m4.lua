ITEM.name = "M4A1 RAS"
ITEM.description = "M4A1 RAS, chambered for 5.56x45mm."
ITEM.longdesc = "The RAS handguard puts accessory rails around the short carbine's barrel."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_m4_w.mdl"

ITEM.price = 31500
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 3.1
ITEM.bulletweight = 0.012

ITEM.class = "cw_anomaly_m4_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(4.9, -205, 5.2),
	ang = Angle(0, 90, 0),
	fov = 9.5,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_m4_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(16.543, -4.312, -1.374),
							["EditorExpand"] = true,
							["UniqueID"] = "1214914274",
							["Bone"] = "spine 2",
							["Name"] = "m4",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2756798108",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_m4_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "4064225534",
			["EditorExpand"] = true,
		},
	},
}
