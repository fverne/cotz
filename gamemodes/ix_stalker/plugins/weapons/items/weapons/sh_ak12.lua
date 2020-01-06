ITEM.name = "AK-12"
ITEM.description= "A Russian assault rifle. Fires 5.45x39mm."
ITEM.longdesc = "The AK-12, also known as the AK-200, is the newest member of the AK family.\nWhile the Russian army had no interest in purchasing any of these because of their massive supply of AK-74's, the AK-12 is still a highly modular and effective weapon platform.\nThis rifle is rare to find, but easy to keep in good condition and easy to find ammunition for.\n\nAmmo: 5.45x39mm \nMagazine Capacity: 30"
ITEM.model = "models/weapons/ethereal/w_ak12.mdl"
ITEM.class = "cw_kk_ins2_ak12"
ITEM.weaponCategory = "primary"
ITEM.width = 4
ITEM.height = 2
--ITEM.busflag = "ARMS2_3_1"
ITEM.price = 100000 -- someone decide a price other than "special" plz thx
ITEM.repairCost = ITEM.price/100*1
ITEM.iconCam = {
	pos = Vector(-10, 33, 0.5),
	ang = Angle(0, 270, 3),
	fov = 70
}
ITEM.Range = 100
ITEM.RoF = "S/3/6"
ITEM.Dmg = "1d10+3"
ITEM.Pen = 12
ITEM.Mag = 30
ITEM.Rld = "Ready"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5

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
						["Model"] = "models/weapons/w_rif_ak12.mdl",
						["ClassName"] = "model",
						["Position"] =	Vector(-7.659, -1.39, 7.009),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3512531291",
						["Bone"] = "chest",
						["Name"] = "ak12",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1054244402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_ak12@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1512312353",
		["EditorExpand"] = true,
	},
},
}