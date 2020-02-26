ITEM.name = "MR96"
ITEM.description= "A double-action revolver chambered for .44 Magnum."
ITEM.longdesc = "The Manurhin MR96 is a French-manufactured, double-action revolver chambered for .44 Magnum.\nThis specific weapon is a 6-inch version.\nEvery MR96 is match grade accurate, shipped with its own factory test target fired at 25 meters.\nAveraging 15 rounds, no group over 20mm diameter with selected ammunition is allowed.\n\nAmmo: .44 Magnum\nMagazine Capacity: 6"
ITEM.model = ("models/weapons/cwc_mateba/w_pist_mateba.mdl")
ITEM.class = "cw_mr96"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price = 8400
ITEM.height = 1
--ITEM.busflag = "ARMS1_1_1"
ITEM.repairCost = ITEM.price/100*1

ITEM.canAttach = false
ITEM.iconCam = {
	pos = Vector(-7, 12, 0),
	ang = Angle(0, 270, -5),
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
						["Model"] = "models/weapons/cwc_mateba/w_pist_mateba.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-9.679, 9.712, 0.126),
						["EditorExpand"] = true,
						["UniqueID"] = "3589648235",
						["Bone"] = "pelvis",
						["Name"] = "mr96",
						["Angles"] = Angle(0, 270, -30),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1486277682",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_mr96@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1977895467",
		["EditorExpand"] = true,
	},
},
}