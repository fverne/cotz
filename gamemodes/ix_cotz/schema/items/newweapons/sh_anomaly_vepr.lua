ITEM.name = "Vepr-12 “Hammer”"
ITEM.description = "Vepr-12 “Hammer”, chambered for 12 Gauge."
ITEM.longdesc = "The reinforced receiver and wide box magazine give the Vepr a heavier profile than a rifle-pattern AK."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_vepr_w.mdl"

ITEM.price = 23500
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 4.4
ITEM.bulletweight = 0.031

ITEM.class = "cw_anomaly_vepr_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(6.6, -205, 5.3),
	ang = Angle(0, 90, 0),
	fov = 10.5,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_vepr_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(12.524, -4.193, -1.228),
							["EditorExpand"] = true,
							["UniqueID"] = "597242668",
							["Bone"] = "spine 2",
							["Name"] = "vepr",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "3483519826",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_vepr_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "2580284720",
			["EditorExpand"] = true,
		},
	},
}
