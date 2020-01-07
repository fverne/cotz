ITEM.name = "G3A3"
ITEM.description= "A battle rifle that fires 7.62x51mm rounds."
ITEM.longdesc = "The G3 was Germany's response to the more expensive FAL rifle, based on the CETME design.\nWhile made out of mostly plastic furniture, the rifle remains a heavy but reliable choice.\n\nAmmo: 7.62x51mm\nMagazine Capacity: 20"
ITEM.model = "models/weapons/ethereal/w_g3a3.mdl"
ITEM.class = "cw_kk_ins2_g3a3"
ITEM.weaponCategory = "primary"
ITEM.width = 5
ITEM.price = 100000 -- price me daddy uwu
ITEM.height = 2
--ITEM.busflag = "ARMS1_2_1_1"
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 150
ITEM.RoF = "S/2/4"
ITEM.Dmg = "1d10+5"
ITEM.Pen = 18
ITEM.Mag = 20
ITEM.Rld = "Ready"
ITEM.Special = "Long"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5
ITEM.weight = 4.1

ITEM.iconCam = {
	pos = Vector(-10, 29, 2),
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
						["Angles"] = Angle(74.21875, -177.46875, -110.587),
						["Position"] = Vector(-8.846, -2.987, 12.214),
						["Model"] = "models/weapons/w_hk_g3.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "3329802291",
						["Bone"] = "chest",
						["Name"] = "g3a3",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1234694642",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_g3a3@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2400142348",
		["EditorExpand"] = true,
	},
},
}