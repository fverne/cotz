ITEM.name = "MP5SD6"
ITEM.description = "MP5SD6, chambered for 9x19mm."
ITEM.longdesc = "The shroud blends into the integral suppressor, giving the SD6 its broad, round fore-end."

ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_mp5sd_w.mdl"

ITEM.price = 15000
ITEM.width = 3
ITEM.height = 2
ITEM.unloadedweight = 3.1
ITEM.bulletweight = 0.008

ITEM.class = "cw_anomaly_mp5sd_vmrecoil"
ITEM.weaponCategory = "primary"
ITEM.noBusiness = true
ITEM.canRepair = true
ITEM.anomalyInventoryAttachments = true

ITEM.iconCam = {
	pos = Vector(2.8, -205, 5.8),
	ang = Angle(0, 90, 0),
	fov = 8.8,
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
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_mp5sd_w.mdl",
							["ClassName"] = "model",
							["Translucent"] = true,
							["Position"] = Vector(17.39, -4.308, 0.361),
							["EditorExpand"] = true,
							["UniqueID"] = "2526593034",
							["Bone"] = "spine 2",
							["Name"] = "mp5sd",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "2057549940",
					["Event"] = "weapon_class",
					["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_anomaly_mp5sd_vmrecoil@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "751695382",
			["EditorExpand"] = true,
		},
	},
}
