ITEM.name = "MP-443 “Grach”"
ITEM.description = "MP-443 “Grach”, chambered for 9x19mm."
ITEM.longdesc = "The Grach foregoes a round hammer spur in favor of a flat, square profile at the back of the slide."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_grach_w.mdl"

ITEM.price = 3400
ITEM.width = 2
ITEM.height = 1
ITEM.unloadedweight = 0.95
ITEM.bulletweight = 0.008

ITEM.class = "cw_anomaly_grach_vmrecoil"
ITEM.weaponCategory = "secondary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(1.4, -205, 2.9),
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_grach_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(-9.48, 8.311, 0.71),
							["EditorExpand"] = true,
							["UniqueID"] = "2597115662",
							["Bone"] = "pelvis",
							["Name"] = "grach",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "1995943792",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_grach_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "546955538",
			["EditorExpand"] = true,
		},
	},
}
