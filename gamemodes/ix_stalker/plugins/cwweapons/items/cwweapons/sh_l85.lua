ITEM.name = "L85"
ITEM.description= "A bullpup assault rifle. Fires 5.56x45mm."
ITEM.longdesc = "The standard rifle for the British armed forces. This rifle was designed to be fitted with various attachments.\n\nAmmo: 5.56x45mm\nMagazine Capacity: 30"
ITEM.model = "models/weapons/ethereal/w_l85a2.mdl"
ITEM.class = "cw_kk_ins2_l85a2"
ITEM.weaponCategory = "primary"
ITEM.width = 3
ITEM.price = 50000
ITEM.height = 2
--ITEM.busflag = "ARMS1_3_1"
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 150
ITEM.RoF = "S/3/6"
ITEM.Dmg = "1d10+4"
ITEM.Pen = 12
ITEM.Mag = 30
ITEM.Rld = "Ready"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5
ITEM.weight = 3.82

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(11.5, 200, 3),
	ang = Angle(0, 270, 0),
	fov = 10,
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
						["Model"] = "models/weapons/w_rif_l852.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8544325421",
						["Bone"] = "chest",
						["Name"] = "l85",
						["AngleOffset"] = Angle(200, 0, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1036853672",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_l85@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8537651483",
		["EditorExpand"] = true,
	},
},
}