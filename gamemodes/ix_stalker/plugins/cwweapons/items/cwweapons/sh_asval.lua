ITEM.name = "AS Val"
ITEM.description= "A silenced special forces assault rifle chambered for 9x39mm."
ITEM.longdesc = "The AS 'Val' is a Soviet-designed assault rifle featuring an integrated suppressor.\nIts effective range is approximately 300 m, as it uses heavy subsonic 9x39mm SP-6 (high-performance armor-piercing) ammunition\nThe 'Val' has two modes of fire, semi-automatic and fully automatic fire at a rate of 900 RPM.\nAccording to its users, the 'Val' is reliable, accurate, and well liked.\nIt is a must have when getting the jump on your enemies is crucial.\n\nAmmo:9x39mm\nMagazine Capacity: 20"
ITEM.model = "models/weapons/ethereal/w_asval.mdl"
ITEM.class = "cw_kk_ins2_asval"
ITEM.weaponCategory = "primary"
ITEM.width = 4
ITEM.price = 100000 -- GIB PRICES
ITEM.height = 2
--ITEM.busflag = "ARMS2_2_1_1"
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 50
ITEM.RoF = "S/3/6"
ITEM.Dmg = "1d10+4"
ITEM.Pen = 8
ITEM.Mag = 20
ITEM.Rld = "Ready"
ITEM.Special = "Subsonic, Accessory (Suppressor)"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5
ITEM.weight = 2.5
ITEM.busflag = {"guns6_1"}

ITEM.iconCam = {
	ang= Angle(0, 0, 0),
	fov= 70,
	pos= Vector(-31, 0, -2)
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
						["Angles"] = Angle(-11.74, -169.377, -91.9),
						["Position"] = Vector(-11.314, -7.027, -0.342),
						["Model"] = "models/weapons/w_dmg_vally.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "3421542291",
						["Bone"] = "chest",
						["Name"] = "asval",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1234641242",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_asval@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1442432348",
		["EditorExpand"] = true,
	},
},
}