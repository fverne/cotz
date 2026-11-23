ITEM.name = "Zulu's PKM"
ITEM.description = "Zulu's PKM, chambered for 7.62x54mmR."
ITEM.longdesc = "The stock and front furniture distinguish this PKM from a standard service example."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_pkm_zulus_w.mdl"

ITEM.price = 53500
ITEM.width = 6
ITEM.height = 2
ITEM.unloadedweight = 8.1
ITEM.bulletweight = 0.022

ITEM.class = "cw_anomaly_pkm_zulus_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(7.9, -205, 5.5),
	ang = Angle(0, 90, 0),
	fov = 12.9,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_pkm_zulus_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(11.188, -4.175, -0.658),
							["EditorExpand"] = true,
							["UniqueID"] = "1697914259",
							["Bone"] = "spine 2",
							["Name"] = "pkm_zulus",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2299487725",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_pkm_zulus_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "3747687311",
			["EditorExpand"] = true,
		},
	},
}
