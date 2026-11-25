ITEM.name = "Barrett M82"
ITEM.description = "Barrett M82, chambered for 12.7x55mm."
ITEM.longdesc = "The long receiver, large box magazine and heavy front end make it awkward to carry slung."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_m82_w.mdl"

ITEM.price = 95000
ITEM.width = 7
ITEM.height = 2
ITEM.unloadedweight = 13.5
ITEM.bulletweight = 0.069

ITEM.class = "cw_anomaly_m82_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(13.7, -205, 2.6),
	ang = Angle(0, 90, 0),
	fov = 14.1,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_m82_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(14.702, -4.494, -1.16),
							["EditorExpand"] = true,
							["UniqueID"] = "3260172648",
							["Bone"] = "spine 2",
							["Name"] = "m82",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "778645782",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_m82_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "2013757300",
			["EditorExpand"] = true,
		},
	},
}
