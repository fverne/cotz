ITEM.name = "Hatchet"
ITEM.description = "A hatchet made for collecting wood."
ITEM.model = "models/weapons/tfa_nmrih/w_me_hatchet.mdl"
ITEM.class = "tfa_nmrih_hatchet"
ITEM.weaponCategory = "secondary"
ITEM.price = 500
ITEM.busflag = {"melee"}
ITEM.height = 1
ITEM.width = 2
ITEM.category = "Melee"
ITEM.repairCost = ITEM.price/100*1
ITEM.canAttach = false
ITEM.weight = 0.75
ITEM.iconCam = {
	pos = Vector(-2.5, -23, -0),
	ang = Angle(0, 90, 90),
	fov = 70
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
						["Angles"] = Angle(-77.061, -138.578, 48.449),
						["Position"] = Vector(-9.333, -2.007, -2.832),
						["Model"] = "models/weapons/tfa_nmrih/w_me_hatchet.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7887994673",
						["Bone"] = "pelvis",
						["Name"] = "hatchet",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1288770522",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "tfa_nmrih_hatchet@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2999376348",
		["EditorExpand"] = true,
	},
},
}