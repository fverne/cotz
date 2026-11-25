ITEM.name = "AEK-973"
ITEM.description = "AEK-973, chambered for 7.62x39mm."
ITEM.longdesc = "The AEK-973 pairs the AEK family's balanced action with a noticeably curved magazine."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_aek973.mdl"

ITEM.price = 26500
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 3.35
ITEM.bulletweight = 0.019

ITEM.class = "cw_anomaly_aek973_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(6.4, -205, 0.7),
	ang = Angle(0, 90, 0),
	fov = 10.3,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_aek973.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(12, -4.25, -3),
							["EditorExpand"] = true,
							["UniqueID"] = "3503852957",
							["Bone"] = "spine 2",
							["Name"] = "aek973",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "1021572579",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_aek973_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "1787673473",
			["EditorExpand"] = true,
		},
	},
}
