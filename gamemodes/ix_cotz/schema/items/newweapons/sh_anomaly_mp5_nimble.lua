ITEM.name = "MP5A3 “Frasier”"
ITEM.description = "MP5A3 “Frasier”, chambered for .45 ACP."
ITEM.longdesc = "The Frasier keeps the compact MP5 profile around a larger-calibre magazine."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_mp5_nimble_w.mdl"

ITEM.price = 16200
ITEM.width = 3
ITEM.height = 2
ITEM.unloadedweight = 2.9
ITEM.bulletweight = 0.020

ITEM.class = "cw_anomaly_mp5_nimble_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(1.2, -205, 5.6),
	ang = Angle(0, 90, 0),
	fov = 7.7,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_mp5_nimble_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(17.39, -2.808, 0.361),
							["EditorExpand"] = true,
							["UniqueID"] = "1036495433",
							["Bone"] = "spine 2",
							["Name"] = "mp5_nimble",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "3523007031",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_mp5_nimble_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "2274532437",
			["EditorExpand"] = true,
		},
	},
}
