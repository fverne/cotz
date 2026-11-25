ITEM.name = "SR-25"
ITEM.description = "SR-25, chambered for 7.62x51mm."
ITEM.longdesc = "The long receiver and wide magazine well distinguish the SR-25 from smaller AR-pattern rifles."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_sr25_w.mdl"

ITEM.price = 42000
ITEM.width = 6
ITEM.height = 2
ITEM.unloadedweight = 4.9
ITEM.bulletweight = 0.026

ITEM.class = "cw_anomaly_sr25_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(6.4, -205, 7),
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_sr25_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(13.989, -3.063, -1.375),
							["EditorExpand"] = true,
							["UniqueID"] = "2288194390",
							["Bone"] = "spine 2",
							["Name"] = "sr25",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "1683516200",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_sr25_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "842409290",
			["EditorExpand"] = true,
		},
	},
}
