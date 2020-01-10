ITEM.name = "Mateba Autorevolver"
ITEM.description= "A double-action revolver chambered for .44 Magnum."
ITEM.longdesc = "The Mateba Model 6 Unica (often known simply as the Mateba or the Mateba Autorevolver) is a recoil operated semi-automatic revolver, one of only a few of this type ever produced. It was developed by Mateba, based in Pavia, Italy.\nThe Mateba Model 6 uses the recoil from firing to rotate the cylinder and cock the hammer, unlike conventional revolvers, which depend on the user physically pulling the trigger and/or cocking the hammer to actuate the weapon's mechanism of operation.\n\nAmmo: .44 Magnum\nMagazine Capacity: 6"
ITEM.model = ("models/weapons/cwc_mateba/w_pist_mateba.mdl")
ITEM.class = "cw_mateba"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price = 100000 -- price me daddy uwu
ITEM.height = 1
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
ITEM.weight = 1.35

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
				["Arguments"] = "cw_mateba@@0",
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