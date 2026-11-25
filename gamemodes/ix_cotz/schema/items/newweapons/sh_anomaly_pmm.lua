ITEM.name = "PMM"
ITEM.description = "PMM, chambered for 9x18mm."
ITEM.longdesc = "The wider grip accommodates a larger magazine than the original PM."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_pmm_w.mdl"

ITEM.price = 1100
ITEM.width = 2
ITEM.height = 1
ITEM.unloadedweight = 0.76
ITEM.bulletweight = 0.011

ITEM.class = "cw_anomaly_pmm_vmrecoil"
ITEM.weaponCategory = "secondary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(1.1, -205, 2.9),
	ang = Angle(0, 90, 0),
	fov = 3.1,
}

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
					[1] = {
						["children"] = {},
						["self"] = {
							["Angles"] = Angle(-30, 180, 0),
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_pmm_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(-10.266, 6.039, -0.924),
							["EditorExpand"] = true,
							["UniqueID"] = "3880805824",
							["Bone"] = "pelvis",
							["Name"] = "pmm",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "191569342",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_pmm_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "1560630236",
			["EditorExpand"] = true,
		},
	},
}
