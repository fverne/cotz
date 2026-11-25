ITEM.name = "FN FNC"
ITEM.description = "FN FNC, chambered for 5.56x45mm."
ITEM.longdesc = "The FNC has a long handguard and a folding stock that leaves its controls accessible."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_fnc_w.mdl"

ITEM.price = 22500
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 3.8
ITEM.bulletweight = 0.012

ITEM.class = "cw_anomaly_fnc_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(5.2, -205, 4.1),
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_fnc_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(12, -3.695, -1.495),
							["EditorExpand"] = true,
							["UniqueID"] = "3029805170",
							["Bone"] = "spine 2",
							["Name"] = "fnc",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "1487687692",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_fnc_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "247602798",
			["EditorExpand"] = true,
		},
	},
}
