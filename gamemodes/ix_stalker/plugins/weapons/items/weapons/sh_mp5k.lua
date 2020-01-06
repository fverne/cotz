ITEM.name = "MP5k"
ITEM.description= "A small, black submachinegun. Fires 9x19mm."
ITEM.longdesc = "A shorter version of the German MP5 submachinegun, mostly identical to the original. It lacks the stock and thus suffers from higher recoil.\nHowever, the gun is very compact and can be easily hidden under most jackets, making it a formidable backup solution.\nThe shorter design means that the bolt is lighter, leading to a higher rate of fire.\n\nAmmo: 9x19mm\nMagazine Capacity: 30"
ITEM.model = "models/weapons/ethereal/w_mp5k.mdl"
ITEM.class = "cw_kk_ins2_mp5k"
ITEM.weaponCategory = "primary"
ITEM.width = 2
ITEM.price = 25000
ITEM.height = 2
ITEM.busflag = {"guns3_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 30
ITEM.RoF = "S/3/6"
ITEM.Dmg = "1d10+2"
ITEM.Pen = 6
ITEM.Mag = 30
ITEM.Rld = "Ready"
ITEM.Special = "Short"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5

ITEM.iconCam = {
	pos = Vector(1.5, 12, -1),
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
						["Position"] = Vector(-11.724, -4.649, 0.866),
						["Model"] = "models/weapons/w_smg_mpk.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "79468794673",
						["Bone"] = "chest",
						["Name"] = "mp5k",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "8937478922",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_mp5k@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2778996348",
		["EditorExpand"] = true,
	},
},
}