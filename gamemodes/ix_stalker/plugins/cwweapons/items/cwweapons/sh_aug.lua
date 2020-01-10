ITEM.name = "Steyr AUG"
ITEM.description= "A bull-pup assault rifle. Fires 5.56x45mm."
ITEM.longdesc = "The AUG is an Austrian assault rifle designed around the 60-70's and remains a viable solution to this day. \nIt's a bullpup configuration rifle, the magazine behind the handguard results in a shorter length. \nIt's not fully ambidextrious, but it can be changed for left-hand shooters if one changes the bolt with one that has the extractor and ejector on the other side.\n\nAmmo: 5.56x45mm \nMagazine Capacity: 30"
ITEM.model = "models/weapons/ethereal/w_aug.mdl"
ITEM.class = "cw_kk_ins2_aug"
ITEM.weaponCategory = "primary"
ITEM.width = 3
ITEM.price = 50000
ITEM.height = 2
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 100
ITEM.RoF = "S/3/6"
ITEM.Dmg = "1d10+3"
ITEM.Pen = 12
ITEM.Mag = 30
ITEM.Rld = "Ready"
ITEM.Special = "Short"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5
ITEM.weight = 3.3
ITEM.busflag = {"guns5_1_1"}
ITEM.iconCam = {
	pos = Vector(5.5, 27, 6),
	ang = Angle(0, 270, 0),
	fov = 70
}
ITEM.Range = 100
ITEM.RoF = "S/3/6"
ITEM.Dmg = "1d10+3"
ITEM.Pen = 12
ITEM.Mag = 30
ITEM.Rld = "Ready"
ITEM.Special = "Short"

ITEM.pacData = {
[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Angles"] = Angle(74.21875, -177.46875, -106.201),
						["Position"] = Vector(-13.43, -0.853, -4.551),
						["Model"] = "models/weapons/w_rif_aug.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7842129091",
						["Bone"] = "chest",
						["Name"] = "aug",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1237784212",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_aug@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2784612448",
		["EditorExpand"] = true,
	},
},
}