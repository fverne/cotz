ITEM.name = "Galil ACE-21"
ITEM.description = "Galil ACE-21, chambered for 5.56x45mm."
ITEM.longdesc = "The short Galil ACE has a railed upper cover and a collapsible stock."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_ace21.mdl"

ITEM.price = 24500
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 3.05
ITEM.bulletweight = 0.012

ITEM.class = "cw_anomaly_ace21_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(3.5, -205, 2.8),
	ang = Angle(0, 90, 0),
	fov = 7.6,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_ace21.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(11.522, -4.244, -1.16),
							["EditorExpand"] = true,
							["UniqueID"] = "158652415",
							["Bone"] = "spine 2",
							["Name"] = "ace21",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "3847204737",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_ace21_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "3005342179",
			["EditorExpand"] = true,
		},
	},
}
