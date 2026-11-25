ITEM.name = "MP-133"
ITEM.description = "MP-133, chambered for 12 Gauge."
ITEM.longdesc = "The ribbed fore-end moves the action by hand, unlike the outwardly similar MP-153."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_mp133_w.mdl"

ITEM.price = 9500
ITEM.width = 5
ITEM.height = 1
ITEM.unloadedweight = 3.3
ITEM.bulletweight = 0.031

ITEM.class = "cw_anomaly_mp133_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(8.2, -205, 3.4),
	ang = Angle(0, 90, 0),
	fov = 11,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_mp133_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(14.98, -3.403, -1.175),
							["EditorExpand"] = true,
							["UniqueID"] = "4124459753",
							["Bone"] = "spine 2",
							["Name"] = "mp133",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "434977431",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_mp133_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "1334015221",
			["EditorExpand"] = true,
		},
	},
}
