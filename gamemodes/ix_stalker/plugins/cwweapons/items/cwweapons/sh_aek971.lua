ITEM.name = "AEK-971"
ITEM.description= "A Russian assault rifle. Fires 5.45x39mm."
ITEM.longdesc = "The AEK-971 is an experimental assault rifle released around the same time as the AN-94 'Abakan'.\nThe AN-94 was chosen over it, but it was still put into limited production.\nIt has a built-in recoil compensator, meaning its recoil is felt much less by the user.\nIt's a rare specimen since it was only given out to a few select groups of the military.\n\nAmmo: 5.45x39mm \nMagazine Capacity: 30"
ITEM.model = "models/weapons/ethereal/w_aek971.mdl"
ITEM.class = "cw_kk_ins2_aek971"
ITEM.weaponCategory = "primary"
ITEM.width = 4
ITEM.price = 55000
ITEM.height = 2
--ITEM.busflag = "ARMS2_3_1"
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 100
ITEM.RoF = "S/3/9"
ITEM.Dmg = "1d10+3"
ITEM.Pen = 12
ITEM.Mag = 30
ITEM.Reload = "Ready"
ITEM.Special = "Assault"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5
ITEM.weight = 3.3

ITEM.iconCam = {
	pos = Vector(-12, 35, 0),
	ang = Angle(0, 270, 3),
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
						["Angles"] = Angle(87.526, -83.765, -6.541),
						["Model"] = "models/weapons/w_rif_aek97.mdl",
						["ClassName"] = "model",
						["Position"] =	Vector(-9.812, -1.536, 7.308),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3547696121",
						["Bone"] = "chest",
						["Name"] = "aek971",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "2971273618",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_aek971@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "5153429652",
		["EditorExpand"] = true,
	},
},
}