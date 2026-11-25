ITEM.name = "RPG-7"
ITEM.description = "RPG-7 with no compatible ammunition in this conversion."
ITEM.longdesc = "A broad heat shield wraps the middle of the launcher tube."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_rpg7_w.mdl"

ITEM.price = 54000
ITEM.width = 6
ITEM.height = 2
ITEM.unloadedweight = 7
ITEM.bulletweight = 0

ITEM.class = "cw_anomaly_rpg7_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(3.5, -205, 5.1),
	ang = Angle(0, 90, 0),
	fov = 15.2,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_rpg7_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(17.784, -3.054, -1.356),
							["EditorExpand"] = true,
							["UniqueID"] = "1665977835",
							["Bone"] = "spine 2",
							["Name"] = "rpg7",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2406987157",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_rpg7_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "3642358775",
			["EditorExpand"] = true,
		},
	},
}
