ITEM.name = "AK-74M"
ITEM.description = "AK-74M, chambered for 5.45x39mm."
ITEM.longdesc = "A black polymer stock folds against the receiver, and the left side carries an optic mount."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_ak74m.mdl"

ITEM.price = 18500
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 3.4
ITEM.bulletweight = 0.011

ITEM.class = "cw_anomaly_ak74m_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(6.5, -205, 0.8),
	ang = Angle(0, 90, 0),
	fov = 10.2,
}

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
					[1] = {
						["children"] = {},
						["self"] = {
							["Angles"] = Angle(180, 0, 0),
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_ak74m.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(11.522, -4.244, -1.16),
							["EditorExpand"] = true,
							["UniqueID"] = "1499472165",
							["Bone"] = "spine 2",
							["Name"] = "ak74m",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "3042662747",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_ak74m_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "3811907385",
			["EditorExpand"] = true,
		},
	},
}
