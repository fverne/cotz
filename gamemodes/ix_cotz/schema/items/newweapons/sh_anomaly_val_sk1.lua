ITEM.name = "Modern AS “Val”"
ITEM.description = "Modern AS “Val”, chambered for 9x39mm."
ITEM.longdesc = "The modern furniture fits around the Val's integral suppressor and narrow receiver."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_val_sk1_w.mdl"

ITEM.price = 39500
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 2.75
ITEM.bulletweight = 0.023

ITEM.class = "cw_anomaly_val_sk1_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(4.5, -205, 4.4),
	ang = Angle(0, 90, 0),
	fov = 9.3,
}

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
					[1] = {
						["children"] = {},
						["self"] = {
							["Angles"] = Angle(180, 90, 0),
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_val_sk1_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(4.252, -5.172, -5.865),
							["EditorExpand"] = true,
							["UniqueID"] = "1782651010",
							["Bone"] = "spine 2",
							["Name"] = "val_sk1",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2256167164",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_val_sk1_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "3490983582",
			["EditorExpand"] = true,
		},
	},
}
