ITEM.name = "AKMS"
ITEM.description = "AKMS, chambered for 7.62x39mm."
ITEM.longdesc = "The AKMS tucks its steel stock underneath the receiver, leaving the sides clear."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_akms.mdl"

ITEM.price = 20500
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 3.3
ITEM.bulletweight = 0.019

ITEM.class = "cw_anomaly_akms_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(5.3, -205, 0.9),
	ang = Angle(0, 90, 0),
	fov = 9.8,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_akms.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(11.522, -4.494, -1.16),
							["EditorExpand"] = true,
							["UniqueID"] = "3360635418",
							["Bone"] = "spine 2",
							["Name"] = "akms",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "611598948",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_akms_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "1914309638",
			["EditorExpand"] = true,
		},
	},
}
