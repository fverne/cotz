ITEM.name = "Karabiner 43"
ITEM.description = "Karabiner 43 with no compatible ammunition in this conversion."
ITEM.longdesc = "A box magazine interrupts the otherwise traditional lines of the wooden stock."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_g43_w.mdl"

ITEM.price = 28000
ITEM.width = 6
ITEM.height = 1
ITEM.unloadedweight = 4.4
ITEM.bulletweight = 0

ITEM.class = "cw_anomaly_g43_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(9.8, -205, 0.8),
	ang = Angle(0, 90, 0),
	fov = 17.3,
}

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
					[1] = {
						["children"] = {},
						["self"] = {
							["Angles"] = Angle(0, 0, 180),
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_g43_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(-1.1, -5.078, -2.039),
							["EditorExpand"] = true,
							["UniqueID"] = "3953620263",
							["Bone"] = "spine 2",
							["Name"] = "g43",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "127667545",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_g43_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "1374831419",
			["EditorExpand"] = true,
		},
	},
}
