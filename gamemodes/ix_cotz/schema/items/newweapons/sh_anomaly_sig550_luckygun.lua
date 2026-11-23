ITEM.name = "SIG SG550 “Arrow”"
ITEM.description = "SIG SG550 “Arrow”, chambered for 5.56x45mm."
ITEM.longdesc = "The Arrow retains the long SG550 fore-end under its custom upper fittings."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_sig550_luckygun_w.mdl"

ITEM.price = 29500
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 4.2
ITEM.bulletweight = 0.012

ITEM.class = "cw_anomaly_sig550_luckygun_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(7.2, -205, 3.7),
	ang = Angle(0, 90, 0),
	fov = 9.6,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_sig550_luckygun_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(12, -4.195, -1.495),
							["EditorExpand"] = true,
							["UniqueID"] = "289214849",
							["Bone"] = "spine 2",
							["Name"] = "sig550_luckygun",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "4245055999",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_sig550_luckygun_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "2875729821",
			["EditorExpand"] = true,
		},
	},
}
