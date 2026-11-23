ITEM.name = "USP Match"
ITEM.description = "USP Match, chambered for 9x19mm."
ITEM.longdesc = "A barrel weight extends past the slide and gives the Match its squared nose."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_usp_match_w.mdl"

ITEM.price = 5500
ITEM.width = 2
ITEM.height = 1
ITEM.unloadedweight = 1.1
ITEM.bulletweight = 0.008

ITEM.class = "cw_anomaly_usp_match_vmrecoil"
ITEM.weaponCategory = "secondary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(2.8, -205, 3.2),
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
							["Angles"] = Angle(0, 270, -30),
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_usp_match_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(-8.935, 7.563, 0.783),
							["EditorExpand"] = true,
							["UniqueID"] = "421677596",
							["Bone"] = "pelvis",
							["Name"] = "usp_match",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "4112069218",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_usp_match_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "2742516736",
			["EditorExpand"] = true,
		},
	},
}
