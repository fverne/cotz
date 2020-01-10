ITEM.name = "PTRS-41"
ITEM.description= "A humongous anti-tank rifle. Fires 14.5x114mm."
ITEM.longdesc = "The PTRS-41 is an anti-tank rifle developed during World War II. While it no longer puts up a threat against anything larger than an early BTR, it will take out any of the beasts or armored figures in the Zone with a single shot to center mass.\nIt's big, bulky and weighs 20 kilograms unloaded, requiring an exoskeleton or very strong arms to be carried and fired without problems.\nAmmunition is very hard to find as it is only shared by the military's armored troop carriers.\n\nAmmo: 14.5x114mm \nMagazine Capacity: 5"
ITEM.model = ("models/weapons/w_grub_ptrs.mdl")
ITEM.class = "cw_ptrs"
ITEM.weaponCategory = "primary"
ITEM.width = 6
ITEM.price = 100000 -- price me daddy uwu
ITEM.height = 2
ITEM.flag = "A"
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 200
ITEM.RoF = "S/-/-"
ITEM.Dmg = "2d10+3"
ITEM.Pen = 98
ITEM.Mag = 5
ITEM.Rld = "2 Ready"
ITEM.Special = "Long, Braced"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5
ITEM.weight = 20.3

ITEM.iconCam = {
	pos = Vector(24, -68, -3),
	ang = Angle(0, 90, 0),
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
						["Model"] = "models/weapons/w_grub_ptrs.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-6.059, -6.115, 10.023),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3824139124",
						["Bone"] = "chest",
						["Name"] = "ptrs",
						["Angles"] = Angle(75.709, 144.362, -172.73),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "2412315201",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_ptrs@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "0224518261",
		["EditorExpand"] = true,
	},
},
}