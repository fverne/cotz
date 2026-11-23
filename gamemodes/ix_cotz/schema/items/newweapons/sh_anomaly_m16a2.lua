ITEM.name = "M16A2"
ITEM.description = "M16A2, chambered for 5.56x45mm."
ITEM.longdesc = "The rear sight is built into the fixed carry handle, high above the receiver."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_m16a2_w.mdl"

ITEM.price = 22000
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 3.5
ITEM.bulletweight = 0.012

ITEM.class = "cw_anomaly_m16a2_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(7.5, -205, 5.1),
	ang = Angle(0, 90, 0),
	fov = 11.6,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_m16a2_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(16.543, -4.312, -1.374),
							["EditorExpand"] = true,
							["UniqueID"] = "3193035042",
							["Bone"] = "spine 2",
							["Name"] = "m16a2",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "1382719836",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_m16a2_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "67432254",
			["EditorExpand"] = true,
		},
	},
}
