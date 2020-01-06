ITEM.name = "Mac-11"
ITEM.description= "A metal box of a submachinegun that fires 9x19mm"
ITEM.longdesc = "The MAC-11 is the milder alternative to the formidable MAC-10.\nIt's well known through the gangster world for it's cheap design capable of firing 20 rounds a second in full auto.\nIt uses an open-bolt design and features a charging handle safety known to malfunction at times.\n\nAmmo: 9x19mm\nMagazine Capacity: 32"
ITEM.model = "models/weapons/w_cst_mac11.mdl"
ITEM.class = "cw_mac11"
ITEM.weaponCategory = "primary"
ITEM.width = 2
ITEM.price = 16000
ITEM.height = 2
ITEM.busflag = {"guns3"}
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 30
ITEM.RoF = "S/3/9"
ITEM.Dmg = "1d10+3"
ITEM.Pen = 4
ITEM.Mag = 30
ITEM.Rld = "Ready"
ITEM.Special = "CQC, Subsonic"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5

ITEM.iconCam = {
	pos = Vector(-9.5, 10.5, 1.5),
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
						["Angles"] = Angle(77.219, -177.46875, -96.1875),
						["Position"] = Vector(-7.346, -2.087, 12.214),
						["Model"] = "models/weapons/w_cst_mac11.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "79468794673",
						["Bone"] = "chest",
						["Name"] = "mac11",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1237478922",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_mac11@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2787796348",
		["EditorExpand"] = true,
	},
},
}