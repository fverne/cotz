ITEM.name = "Walther WA 2000"
ITEM.description = "Walther WA 2000, chambered for 7.62x51mm."
ITEM.longdesc = "The action sits behind the grip and the long barrel runs between two forward rails."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_wa2000_w.mdl"

ITEM.price = 52000
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 6.95
ITEM.bulletweight = 0.026

ITEM.class = "cw_anomaly_wa2000_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(6.8, -205, 7.4),
	ang = Angle(0, 90, 0),
	fov = 12.4,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_wa2000_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(16.349, -4.266, -1.726),
							["EditorExpand"] = true,
							["UniqueID"] = "1388112709",
							["Bone"] = "spine 2",
							["Name"] = "wa2000",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "3196556091",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_wa2000_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "3907640665",
			["EditorExpand"] = true,
		},
	},
}
