ITEM.name = "AKS-74"
ITEM.description = "AKS-74, chambered for 5.45x39mm."
ITEM.longdesc = "The triangular steel stock folds to the left, where its outline is easy to spot among polymer-stock AKs."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_aks74_w.mdl"

ITEM.price = 16000
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 3.2
ITEM.bulletweight = 0.011

ITEM.class = "cw_anomaly_aks74_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(6.7, -205, 5.9),
	ang = Angle(0, 90, 0),
	fov = 10,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_aks74_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(11.522, -4.244, -1.16),
							["EditorExpand"] = true,
							["UniqueID"] = "2935823229",
							["Bone"] = "spine 2",
							["Name"] = "aks74",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "1120297731",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_aks74_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "346565985",
			["EditorExpand"] = true,
		},
	},
}
