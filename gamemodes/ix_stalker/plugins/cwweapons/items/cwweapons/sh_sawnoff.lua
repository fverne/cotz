ITEM.name = "TOZ BM-16 Sawnoff"
ITEM.description= "A sawn-off hunting shotgun. Fires 12 gauge."
ITEM.longdesc = "This sawn-off double barrelled shotgun is a must-have in many rookies eyes.\nIt dispatches mutants and unarmored stalkers with ease, and is cheap to keep supplied with ammo.\n\nAmmo: 12 Gauge \nMagazine Capacity: 2"
ITEM.model = ("models/weapons/w_sawnoff.mdl")
ITEM.class = "cw_shawedoff"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price = 6000
ITEM.height = 1
ITEM.busflag = {"guns2"}
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 30
ITEM.RoF = "S/2/-"
ITEM.Dmg = "1d10+4"
ITEM.Pen = 2
ITEM.Mag = 2
ITEM.Rld = "Ready"
ITEM.Special = "Storm, Short, Buckshot"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5
ITEM.weight = 1.9

ITEM.iconCam = {
	pos = Vector(0.5, 14, -1.5),
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
						["Model"] = "models/weapons/w_sawnoff.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-9.75, -2.373, 1.564),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3976837955",
						["Bone"] = "pelvis",
						["Name"] = "sawnoff",
						["Angles"] = Angle(0, 270, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1643489682",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_shawedoff@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1954394367",
		["EditorExpand"] = true,
	},
},
}