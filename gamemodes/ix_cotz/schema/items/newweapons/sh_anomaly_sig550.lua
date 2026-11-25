ITEM.name = "SIG SG550"
ITEM.description = "SIG SG550, chambered for 5.56x45mm."
ITEM.longdesc = "The long handguard carries a folding bipod that tucks away close to the rifle."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_sig550_w.mdl"

ITEM.price = 27000
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 4.1
ITEM.bulletweight = 0.012

ITEM.class = "cw_anomaly_sig550_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(6.9, -205, 3.8),
	ang = Angle(0, 90, 0),
	fov = 9.7,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_sig550_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(12, -3.945, -1.495),
							["EditorExpand"] = true,
							["UniqueID"] = "2903174847",
							["Bone"] = "spine 2",
							["Name"] = "sig550",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "1093768897",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_sig550_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "392157347",
			["EditorExpand"] = true,
		},
	},
}
