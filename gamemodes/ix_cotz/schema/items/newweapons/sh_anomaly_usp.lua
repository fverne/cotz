ITEM.name = "USP45"
ITEM.description = "USP45, chambered for .45 ACP."
ITEM.longdesc = "An enclosed recoil assembly sits under the barrel inside the broad USP slide."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_usp45_w.mdl"

ITEM.price = 7400
ITEM.width = 2
ITEM.height = 1
ITEM.unloadedweight = 0.89
ITEM.bulletweight = 0.020

ITEM.class = "cw_anomaly_usp_vmrecoil"
ITEM.weaponCategory = "secondary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(2, -205, 3.2),
	ang = Angle(0, 90, 0),
	fov = 3.2,
}

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
					[1] = {
						["children"] = {},
						["self"] = {
							["Angles"] = Angle(0, 270, -30),
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_usp45_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(-8.935, 7.563, 0.783),
							["EditorExpand"] = true,
							["UniqueID"] = "3132233995",
							["Bone"] = "pelvis",
							["Name"] = "usp",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "1451843957",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_usp_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "15150871",
			["EditorExpand"] = true,
		},
	},
}
