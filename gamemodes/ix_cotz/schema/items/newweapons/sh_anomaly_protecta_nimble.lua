ITEM.name = "Custom Armsel Protecta"
ITEM.description = "Custom Armsel Protecta, chambered for 12 Gauge."
ITEM.longdesc = "The custom fittings change the outline of the stock and fore-end, while the revolving cylinder remains prominent."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_protecta_nimble_w.mdl"

ITEM.price = 25000
ITEM.width = 3
ITEM.height = 1
ITEM.unloadedweight = 4.5
ITEM.bulletweight = 0.031

ITEM.class = "cw_anomaly_protecta_nimble_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(2.6, -205, 4.6),
	ang = Angle(0, 90, 0),
	fov = 10.9,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_protecta_nimble_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(5.922, -3.804, -4.465),
							["EditorExpand"] = true,
							["UniqueID"] = "24378994",
							["Bone"] = "spine 2",
							["Name"] = "protecta_nimble",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "3980953100",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_protecta_nimble_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "3139881070",
			["EditorExpand"] = true,
		},
	},
}
