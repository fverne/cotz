ITEM.name = "MR96"
ITEM.description= "A double-action revolver chambered for .44 Magnum."
ITEM.longdesc = "The Manurhin MR96 is a French-manufactured, double-action revolver chambered for .44 Magnum.\nThis specific weapon is a 6-inch version.\nEvery MR96 is match grade accurate, shipped with its own factory test target fired at 25 meters.\nAveraging 15 rounds, no group over 20mm diameter with selected ammunition is allowed.\n\nAmmo: .44 Magnum\nMagazine Capacity: 6"
ITEM.model = "models/weapons/ethereal/w_mr96.mdl"
ITEM.class = "cw_kk_ins2_mr96"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price = 15000
ITEM.height = 1
ITEM.busflag = {"guns3_1_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 50
ITEM.RoF = "S/2/-"
ITEM.Dmg = "1d10+4"
ITEM.Pen = 7
ITEM.Mag = 6
ITEM.Rld = "2 Ready"
ITEM.Special = "CQC"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5
ITEM.weight = 0.95

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
						["Model"] = "models/weapons/w_357.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-7.5, 6.578, 0.844),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3589648235",
						["Bone"] = "pelvis",
						["Name"] = "mr96",
						["Angles"] = Angle(0, 270, 0),
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