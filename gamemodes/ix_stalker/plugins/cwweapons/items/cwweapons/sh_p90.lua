ITEM.name = "FN P90"
ITEM.description= "A sub machine gun chambered in 5.7x28mm."
ITEM.longdesc = "The FN P90 is the sister gun to the FN FiveSeven pistol, developed alongside it and its special cartridge, the 5.7x28mm.\nIntending to replace the classic 9x19mm pistol round, it hasn't quite worked out yet, making this a niche weapon.\nThe weapon is rare and so is its ammo.\n\nAmmo: 5.7x28mm \nMagazine Capacity: 50"
ITEM.model = "models/weapons/ethereal/w_p90.mdl"
ITEM.class = "cw_kk_ins2_p90"
ITEM.weaponCategory = "primary"
ITEM.width = 3
ITEM.price = 100000 -- price me daddy uwu
ITEM.height = 2
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 50
ITEM.RoF = "S/3/9"
ITEM.Dmg = "1d10+2"
ITEM.Pen = 12
ITEM.Mag = 50
ITEM.Rld = "Ready"
ITEM.Special = "Short"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5
ITEM.weight = 2.6

ITEM.iconCam = {
	pos = Vector(-7, 17, 3.5),
	ang = Angle(0, 270, 0),
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
						["Angles"] = Angle(74.21875, -177.46875, -96.1875),
						["Position"] = Vector(-14.65, -0.247, -9.327),
						["Model"] = "models/weapons/therambotnic09/w_cst_p90.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8544325862",
						["Bone"] = "chest",
						["Name"] = "p90",
						["AngleOffset"] = Angle(200, 0, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1036853001",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_p90@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8530011483",
		["EditorExpand"] = true,
	},
},
}