ITEM.name = "OTs-14-1A “Groza-1”"
ITEM.description = "OTs-14-1A “Groza-1”, chambered for 7.62x39mm."
ITEM.longdesc = "The magazine sits behind the grip, keeping the Groza-1 short without shortening its whole action."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_groza_nimble_w.mdl"

ITEM.price = 24000
ITEM.width = 4
ITEM.height = 2
ITEM.unloadedweight = 3.2
ITEM.bulletweight = 0.019

ITEM.class = "cw_anomaly_groza_nimble_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(-2.2, -205, 5.8),
	ang = Angle(0, 90, 0),
	fov = 8.3,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_groza_nimble_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(2.141, -4.444, 2.193),
							["EditorExpand"] = true,
							["UniqueID"] = "3765646459",
							["Bone"] = "spine 2",
							["Name"] = "groza_nimble",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "206064645",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_groza_nimble_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "1512440423",
			["EditorExpand"] = true,
		},
	},
}
