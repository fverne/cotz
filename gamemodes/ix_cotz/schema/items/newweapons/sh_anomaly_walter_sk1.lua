ITEM.name = "Custom Walther P99"
ITEM.description = "Custom Walther P99, chambered for 9x19mm."
ITEM.longdesc = "The custom P99 keeps the molded grip and low, squared slide of the service pistol."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_walter99_sk1_w.mdl"

ITEM.price = 4900
ITEM.width = 2
ITEM.height = 1
ITEM.unloadedweight = 0.78
ITEM.bulletweight = 0.008

ITEM.class = "cw_anomaly_walter_sk1_vmrecoil"
ITEM.weaponCategory = "secondary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(1.6, -205, 3.3),
	ang = Angle(0, 90, 0),
	fov = 3.4,
}

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
					[1] = {
						["children"] = {},
						["self"] = {
							["Angles"] = Angle(0, 270, -30),
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_walter99_sk1_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(-8.935, 7.563, 0.783),
							["EditorExpand"] = true,
							["UniqueID"] = "2147807148",
							["Bone"] = "pelvis",
							["Name"] = "walter_sk1",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "1816106962",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_walter_sk1_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "978442672",
			["EditorExpand"] = true,
		},
	},
}
