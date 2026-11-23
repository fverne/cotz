ITEM.name = "VSS “Vintorez” 1PN93"
ITEM.description = "VSS “Vintorez” 1PN93, chambered for 9x39mm."
ITEM.longdesc = "The large night optic sits to the left of the receiver and makes the rifle top-heavy."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_vintorez_1pn93_w.mdl"

ITEM.price = 52750
ITEM.width = 5
ITEM.height = 1
ITEM.unloadedweight = 4.0
ITEM.bulletweight = 0.023

ITEM.class = "cw_anomaly_vintorez_1pn93_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(4.2, -205, 4.8),
	ang = Angle(0, 90, 0),
	fov = 13.1,
}

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
					[1] = {
						["children"] = {},
						["self"] = {
							["Angles"] = Angle(0, 0, 180),
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_vintorez_1pn93_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(3.6, -4.3, -3.6),
							["EditorExpand"] = true,
							["UniqueID"] = "4207684923",
							["Bone"] = "spine 2",
							["Name"] = "vintorez_1pn93",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "385307973",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_vintorez_1pn93_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "1083775783",
			["EditorExpand"] = true,
		},
	},
}
