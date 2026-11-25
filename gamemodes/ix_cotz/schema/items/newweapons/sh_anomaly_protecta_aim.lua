ITEM.name = "Modern Armsel Protecta"
ITEM.description = "Modern Armsel Protecta, chambered for 12 Gauge."
ITEM.longdesc = "The modern furniture surrounds the same broad revolving cylinder as the original Protecta."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_protecta_aim_w.mdl"

ITEM.price = 23500
ITEM.width = 3
ITEM.height = 1
ITEM.unloadedweight = 4.5
ITEM.bulletweight = 0.031

ITEM.class = "cw_anomaly_protecta_aim_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(9.2, -205, 5.3),
	ang = Angle(0, 90, 0),
	fov = 9.5,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_protecta_aim_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(5.922, -3.804, -4.465),
							["EditorExpand"] = true,
							["UniqueID"] = "4050932300",
							["Bone"] = "spine 2",
							["Name"] = "protecta_aim",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "491727410",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_protecta_aim_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "1260479568",
			["EditorExpand"] = true,
		},
	},
}
