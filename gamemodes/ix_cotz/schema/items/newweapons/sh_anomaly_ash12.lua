ITEM.name = "ASh-12.7"
ITEM.description = "ASh-12.7, chambered for 12.7x55mm."
ITEM.longdesc = "The broad magazine sits behind the grip, leaving room for a substantial barrel in a compact frame."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_ash12.mdl"

ITEM.price = 48000
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 5.2
ITEM.bulletweight = 0.069

ITEM.class = "cw_anomaly_ash12_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(-1, -205, 0.4),
	ang = Angle(0, 90, 0),
	fov = 8.5,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_ash12.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(12, -4.5, -3),
							["EditorExpand"] = true,
							["UniqueID"] = "2479869032",
							["Bone"] = "spine 2",
							["Name"] = "ash12",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2146743318",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_ash12_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "698022516",
			["EditorExpand"] = true,
		},
	},
}
