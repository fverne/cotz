ITEM.name = "SIG SG550-1 Sniper"
ITEM.description = "SIG SG550-1 Sniper, chambered for 5.56x45mm."
ITEM.longdesc = "The extended barrel and substantial stock distinguish this from the standard rifle."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_sig550_sniper_w.mdl"

ITEM.price = 34000
ITEM.width = 6
ITEM.height = 2
ITEM.unloadedweight = 7.0
ITEM.bulletweight = 0.012

ITEM.class = "cw_anomaly_sig550_sniper_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(8.3, -205, 4.7),
	ang = Angle(0, 90, 0),
	fov = 10.4,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_sig550_sniper_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(12, -4.195, -1.495),
							["EditorExpand"] = true,
							["UniqueID"] = "83020109",
							["Bone"] = "spine 2",
							["Name"] = "sig550_sniper",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "3905532211",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_sig550_sniper_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "3198680913",
			["EditorExpand"] = true,
		},
	},
}
