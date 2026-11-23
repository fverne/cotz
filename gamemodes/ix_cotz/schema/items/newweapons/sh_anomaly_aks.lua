ITEM.name = "AKS"
ITEM.description = "AKS, chambered for 7.62x39mm."
ITEM.longdesc = "The folding steel stock is the distinguishing feature of this early-pattern AK."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_aks.mdl"

ITEM.price = 18000
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 3.8
ITEM.bulletweight = 0.019

ITEM.class = "cw_anomaly_aks_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(5.1, -205, 0.9),
	ang = Angle(0, 90, 0),
	fov = 9.4,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_aks.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(11.522, -4.244, -1.16),
							["EditorExpand"] = true,
							["UniqueID"] = "1194389508",
							["Bone"] = "spine 2",
							["Name"] = "aks",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2869659770",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_aks_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "4251305496",
			["EditorExpand"] = true,
		},
	},
}
