ITEM.name = "OTs-33 “Pernach”"
ITEM.description = "OTs-33 “Pernach”, chambered for 9x18mm."
ITEM.longdesc = "The Pernach has an extended grip and a shoulder-stock fitting at the heel."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_oc33_w.mdl"

ITEM.price = 8500
ITEM.width = 2
ITEM.height = 1
ITEM.unloadedweight = 1.15
ITEM.bulletweight = 0.011

ITEM.class = "cw_anomaly_oc33_vmrecoil"
ITEM.weaponCategory = "secondary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(2.2, -205, 2),
	ang = Angle(0, 90, 0),
	fov = 4.3,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_oc33_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(-6.72, -1.028, 3.574),
							["EditorExpand"] = true,
							["UniqueID"] = "1848537189",
							["Bone"] = "pelvis",
							["Name"] = "oc33",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2182416411",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_oc33_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "3564848761",
			["EditorExpand"] = true,
		},
	},
}
