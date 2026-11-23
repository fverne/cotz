ITEM.name = "Type 63"
ITEM.description = "Type 63, chambered for 7.62x39mm."
ITEM.longdesc = "The Type 63 resembles an SKS at a glance, but its detachable magazine breaks the stock's underside."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_type63_w.mdl"

ITEM.price = 17800
ITEM.width = 5
ITEM.height = 2
ITEM.unloadedweight = 3.8
ITEM.bulletweight = 0.019

ITEM.class = "cw_anomaly_type63_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(7.2, -205, 4.4),
	ang = Angle(0, 90, 0),
	fov = 11,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_type63_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(15.415, -4.194, -4.119),
							["EditorExpand"] = true,
							["UniqueID"] = "2469113997",
							["Bone"] = "spine 2",
							["Name"] = "type63",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2131806451",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_type63_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "696157841",
			["EditorExpand"] = true,
		},
	},
}
