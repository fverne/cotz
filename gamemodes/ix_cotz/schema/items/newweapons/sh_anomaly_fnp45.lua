ITEM.name = "FNP-45"
ITEM.description = "FNP-45, chambered for .45 ACP."
ITEM.longdesc = "The frame is polymer, but the broad slide and double-stack grip give the pistol considerable bulk."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_fnp45_w.mdl"

ITEM.price = 7600
ITEM.width = 2
ITEM.height = 1
ITEM.unloadedweight = 0.94
ITEM.bulletweight = 0.020

ITEM.class = "cw_anomaly_fnp45_vmrecoil"
ITEM.weaponCategory = "secondary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(2.1, -205, 3),
	ang = Angle(0, 90, 0),
	fov = 3.5,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_fnp45_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(-9.071, 9.525, 0.823),
							["EditorExpand"] = true,
							["UniqueID"] = "1715939107",
							["Bone"] = "pelvis",
							["Name"] = "fnp45",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2323406685",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_fnp45_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "3692171583",
			["EditorExpand"] = true,
		},
	},
}
