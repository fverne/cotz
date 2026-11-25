ITEM.name = "HK XM8"
ITEM.description = "HK XM8, chambered for 5.56x45mm."
ITEM.longdesc = "The curved polymer shell encloses the receiver and gives the XM8 its distinctive smooth profile."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_xm8_w.mdl"

ITEM.price = 27500
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 3.4
ITEM.bulletweight = 0.012

ITEM.class = "cw_anomaly_xm8_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(7.3, -205, 5.5),
	ang = Angle(0, 90, 0),
	fov = 11.5,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_xm8_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(14.673, -3.059, -1.334),
							["EditorExpand"] = true,
							["UniqueID"] = "1107418814",
							["Bone"] = "spine 2",
							["Name"] = "xm8",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2923079360",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_xm8_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "4166314146",
			["EditorExpand"] = true,
		},
	},
}
