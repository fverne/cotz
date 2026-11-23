ITEM.name = "PB"
ITEM.description = "PB, chambered for 9x18mm."
ITEM.longdesc = "The PB's round suppressor housing gives it a much longer front end than a Makarov."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_pb_w.mdl"

ITEM.price = 1500
ITEM.width = 2
ITEM.height = 1
ITEM.unloadedweight = 0.97
ITEM.bulletweight = 0.011

ITEM.class = "cw_anomaly_pb_vmrecoil"
ITEM.weaponCategory = "secondary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(3.8, -205, 2.6),
	ang = Angle(0, 90, 0),
	fov = 3.3,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_pb_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(-9.266, 6.039, -0.924),
							["EditorExpand"] = true,
							["UniqueID"] = "3595404557",
							["Bone"] = "pelvis",
							["Name"] = "pb",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "980876659",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_pb_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "1813558033",
			["EditorExpand"] = true,
		},
	},
}
