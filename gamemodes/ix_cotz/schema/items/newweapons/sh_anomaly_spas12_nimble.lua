ITEM.name = "Modern SPAS-12"
ITEM.description = "Modern SPAS-12, chambered for 12 Gauge."
ITEM.longdesc = "The modern fittings sit around the broad heat shield and heavy action of a SPAS-12."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_spas12_nimble_w.mdl"

ITEM.price = 15500
ITEM.width = 5
ITEM.height = 1
ITEM.unloadedweight = 4.5
ITEM.bulletweight = 0.031

ITEM.class = "cw_anomaly_spas12_nimble_vmrecoil"
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_spas12_nimble_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(14.98, -4.153, -1.175),
							["EditorExpand"] = true,
							["UniqueID"] = "657885928",
							["Bone"] = "spine 2",
							["Name"] = "spas12_nimble",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "3406688918",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_spas12_nimble_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "2640559348",
			["EditorExpand"] = true,
		},
	},
}
