ITEM.name = "FN F2000 “EOTech”"
ITEM.description = "FN F2000 “EOTech”, chambered for 5.56x45mm."
ITEM.longdesc = "The EOTech sits above the rounded bullpup receiver, which houses a forward ejection chute."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_fn2000_nimble_w.mdl"

ITEM.price = 33000
ITEM.width = 4
ITEM.height = 2
ITEM.unloadedweight = 3.6
ITEM.bulletweight = 0.012

ITEM.class = "cw_anomaly_fn2000_nimble_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(-0.1, -205, 5.6),
	ang = Angle(0, 90, 0),
	fov = 7.8,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_fn2000_nimble_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(16.652, -3.444, -1.132),
							["EditorExpand"] = true,
							["UniqueID"] = "1695037582",
							["Bone"] = "spine 2",
							["Name"] = "fn2000_nimble",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2301837552",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_fn2000_nimble_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "3747417746",
			["EditorExpand"] = true,
		},
	},
}
