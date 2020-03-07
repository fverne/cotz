ITEM.name = "Taurus Judge"
ITEM.description= "A home security revolver chambered for .410 buckshot."
ITEM.longdesc = "PLACEHOLDER.\n\nAmmo: .410 Buck\nMagazine Capacity: 5"
ITEM.model = "models/weapons/cwc_judge/w_khri_410jury.mdl"
ITEM.class = "cw_taurusjudge"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price = 1500
ITEM.height = 1
ITEM.busflag = {"guns1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.canAttach = false

ITEM.iconCam = {
	pos = Vector(3, -205, 0),
	ang = Angle(0, 90, 0),
	fov = 4.7,
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
						["Model"] = "models/weapons/cwc_judge/w_khri_410jury.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-7.5, 2.084, 0.609),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3544111191",
						["Bone"] = "pelvis",
						["Name"] = "tjudge",
						["Angles"] = Angle(0, 90, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1083332402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_taurusjudge@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "11227613",
		["EditorExpand"] = true,
	},
},
}