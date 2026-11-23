ITEM.name = "M24 SWS “Green Dragon”"
ITEM.description = "M24 SWS “Green Dragon”, chambered for .338 Lapua."
ITEM.longdesc = "The Green Dragon's long barrel and conventional bolt sit in a heavy molded stock."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_m24_w.mdl"

ITEM.price = 36000
ITEM.width = 6
ITEM.height = 1
ITEM.unloadedweight = 5.4
ITEM.bulletweight = 0.017

ITEM.class = "cw_anomaly_m24_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(11.1, -205, 4.7),
	ang = Angle(0, 90, 0),
	fov = 17.4,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_m24_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(16.349, -4.266, -1.726),
							["EditorExpand"] = true,
							["UniqueID"] = "2750414805",
							["Bone"] = "spine 2",
							["Name"] = "m24",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "1339328427",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_m24_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "431671753",
			["EditorExpand"] = true,
		},
	},
}
