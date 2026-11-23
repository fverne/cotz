ITEM.name = "FNX-45 Tactical"
ITEM.description = "FNX-45 Tactical, chambered for .45 ACP."
ITEM.longdesc = "The Tactical model's tall iron sights stand above its squared slide."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_fnx45_w.mdl"

ITEM.price = 8000
ITEM.width = 2
ITEM.height = 1
ITEM.unloadedweight = 0.95
ITEM.bulletweight = 0.020

ITEM.class = "cw_anomaly_fnx45_vmrecoil"
ITEM.weaponCategory = "secondary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(6.2, -205, 3.2),
	ang = Angle(0, 90, 0),
	fov = 4.7,
}

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
					[1] = {
						["children"] = {},
						["self"] = {
							["Angles"] = Angle(0, -90, -30),
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_fnx45_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(-9.071, 9.525, 0.823),
							["EditorExpand"] = true,
							["UniqueID"] = "1897302319",
							["Bone"] = "pelvis",
							["Name"] = "fnx45",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2637033809",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_fnx45_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "3410214707",
			["EditorExpand"] = true,
		},
	},
}
