ITEM.name = "HK417"
ITEM.description = "HK417, chambered for 7.62x51mm."
ITEM.longdesc = "The wider magazine well and heavier receiver distinguish the HK417 from the smaller HK416."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_hk417_w.mdl"

ITEM.price = 40000
ITEM.width = 6
ITEM.height = 2
ITEM.unloadedweight = 4.4
ITEM.bulletweight = 0.026

ITEM.class = "cw_anomaly_hk417_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(9.5, -205, 5.2),
	ang = Angle(0, 90, 0),
	fov = 12.5,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_hk417_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(13.989, -3.063, -1.375),
							["EditorExpand"] = true,
							["UniqueID"] = "2199818103",
							["Bone"] = "spine 2",
							["Name"] = "hk417",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "1864759049",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_hk417_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "961263979",
			["EditorExpand"] = true,
		},
	},
}
