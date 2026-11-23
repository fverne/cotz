ITEM.name = "VSS Vintorez “Tide”"
ITEM.description = "VSS Vintorez “Tide”, chambered for 9x39mm."
ITEM.longdesc = "The Tide keeps the distinctive round suppressor that runs forward of the VSS handguard."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_vintorez_nimble_w.mdl"

ITEM.price = 46500
ITEM.width = 5
ITEM.height = 1
ITEM.unloadedweight = 3.15
ITEM.bulletweight = 0.023

ITEM.class = "cw_anomaly_vintorez_nimble_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(4.8, -205, 4.8),
	ang = Angle(0, 90, 0),
	fov = 13,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_vintorez_nimble_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(3.6, -4.3, -3.6),
							["EditorExpand"] = true,
							["UniqueID"] = "805789034",
							["Bone"] = "spine 2",
							["Name"] = "vintorez_nimble",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "3694929172",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_vintorez_nimble_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "2320657270",
			["EditorExpand"] = true,
		},
	},
}
