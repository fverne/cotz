ITEM.name = "Ithaca 37"
ITEM.description= "A 12 gauge pump-action shotgun."
ITEM.longdesc = ".\n\nAmmo: 12 Gauge\nMagazine Capacity: 7"
ITEM.model = "models/khrcw2/doipack/w_ithaca37.mdl"
ITEM.class = "cw_ithaca37"
ITEM.weaponCategory = "primary"
ITEM.price = 100
ITEM.width = 6
ITEM.height = 1
ITEM.busflag = {"guns2_1_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.canAttach = false

ITEM.model = "models/khrcw2/doipack/w_ithaca37.mdl"
ITEM.iconCam = {
	pos = Vector(3, -205, -0.30000001192093),
	ang = Angle(0, 90, 0),
	fov = 14,
}

ITEM.pacData = {
[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Angles"] = Angle(270, 180, 291.8),
						["Position"] = Vector(-10.468, -4.789, -3.387),
						["Model"] = "models/khrcw2/doipack/w_ithaca37.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "787987394673",
						["Bone"] = "chest",
						["Name"] = "ith37",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "12378689322",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_ithaca37@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "27879386348",
		["EditorExpand"] = true,
	},
},
}