ITEM.name = "SPAS-12"
ITEM.description = "SPAS-12, chambered for 12 Gauge."
ITEM.longdesc = "The perforated heat shield and oversized fore-end leave little of the barrel exposed."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_spas12_w.mdl"

ITEM.price = 14000
ITEM.width = 5
ITEM.height = 1
ITEM.unloadedweight = 4.4
ITEM.bulletweight = 0.031

ITEM.class = "cw_anomaly_spas12_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(12.4, -205, 3.5),
	ang = Angle(0, 90, 0),
	fov = 10.9,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_spas12_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(14.98, -3.903, -1.175),
							["EditorExpand"] = true,
							["UniqueID"] = "1760914740",
							["Bone"] = "spine 2",
							["Name"] = "spas12",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2228098378",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_spas12_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "3533724456",
			["EditorExpand"] = true,
		},
	},
}
