ITEM.name = "SIG P220"
ITEM.description = "SIG P220, chambered for .45 ACP."
ITEM.longdesc = "The P220's single-stack grip stays slender below its full-sized slide."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_sig220_w.mdl"

ITEM.price = 6900
ITEM.width = 2
ITEM.height = 1
ITEM.unloadedweight = 0.83
ITEM.bulletweight = 0.020

ITEM.class = "cw_anomaly_sig220_vmrecoil"
ITEM.weaponCategory = "secondary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(1.7, -205, 3.1),
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
							["Angles"] = Angle(0, -90, -30),
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_sig220_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(-8.321, 9.525, 0.823),
							["EditorExpand"] = true,
							["UniqueID"] = "1823905936",
							["Bone"] = "pelvis",
							["Name"] = "sig220",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2156781806",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_sig220_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "3605245580",
			["EditorExpand"] = true,
		},
	},
}
