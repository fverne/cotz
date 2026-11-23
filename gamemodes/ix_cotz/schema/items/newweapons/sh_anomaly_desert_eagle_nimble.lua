ITEM.name = "Desert Eagle “Steppe Eagle”"
ITEM.description = "Desert Eagle “Steppe Eagle”, chambered for .357 Magnum."
ITEM.longdesc = "The Steppe Eagle shares the broad slide and heavy frame of the Desert Eagle family."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_desert_eagle_nimble_w.mdl"

ITEM.price = 15000
ITEM.width = 2
ITEM.height = 1
ITEM.unloadedweight = 1.9
ITEM.bulletweight = 0.017

ITEM.class = "cw_anomaly_desert_eagle_nimble_vmrecoil"
ITEM.weaponCategory = "secondary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(3.5, -205, 3.8),
	ang = Angle(0, 90, 0),
	fov = 4.1,
}

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
					[1] = {
						["children"] = {},
						["self"] = {
							["Angles"] = Angle(0, 270, -30),
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_desert_eagle_nimble_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(-9.88, 5.552, -2.062),
							["EditorExpand"] = true,
							["UniqueID"] = "3850036738",
							["Bone"] = "pelvis",
							["Name"] = "desert_eagle_nimble",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "155295356",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_desert_eagle_nimble_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "1596968990",
			["EditorExpand"] = true,
		},
	},
}
