ITEM.name = "M249 SAW"
ITEM.description = "M249 SAW, chambered for 5.56x45mm."
ITEM.longdesc = "The feed cover opens above the belt path, with a folding bipod stowed under the barrel."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_m249_w.mdl"

ITEM.price = 55000
ITEM.width = 6
ITEM.height = 2
ITEM.unloadedweight = 7.5
ITEM.bulletweight = 0.012

ITEM.class = "cw_anomaly_m249_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(5.3, -205, 6.3),
	ang = Angle(0, 90, 0),
	fov = 10.7,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_m249_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(11.188, -4.175, -0.658),
							["EditorExpand"] = true,
							["UniqueID"] = "3049728618",
							["Bone"] = "spine 2",
							["Name"] = "m249",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "1509708308",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_m249_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "261233782",
			["EditorExpand"] = true,
		},
	},
}
