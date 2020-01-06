ITEM.name = "M16A4"
ITEM.description= "An American combat rifle chambered for 5.56x45mm."
ITEM.longdesc = "As a weapon solely issued to the US Marines, the M16A4's origins and quantities in the Zone are unclear.\nThe first model was designed in the 60's and has been constantly modified and upgraded since.\nThis rifle is a very versatile choice, it remains accurate at distances up to 550 meters against small targets and weighs just over 4 kilograms loaded.\n\nAmmo: 5.56x45mm\nMagazine Capacity: 30"
ITEM.model = "models/weapons/ethereal/w_m16.mdl"
ITEM.class = "cw_kk_ins2_m16a4"
ITEM.weaponCategory = "primary"
ITEM.width = 4
ITEM.price = 50000
ITEM.height = 2
--ITEM.busflag = {"ARMS1_3", "SPECIAL5_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 150
ITEM.RoF = "S/3/6"
ITEM.Dmg = "1d10+4"
ITEM.Pen = 12
ITEM.Mag = 30
ITEM.Rld = "Ready"
ITEM.Special = "Long"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5

ITEM.iconCam = {
ang= Angle(-0.70499622821808, 268.25439453125, 0),
fov= 14.085652091515,
pos= Vector(-9, 200, 0)
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
						["Angles"] = Angle(72.219, -177.46875, -98.487),
						["Position"] = Vector(-6.713, -3.194, 12.803),
						["Model"] = "models/weapons/m16a4/w_rif_m16a4.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8553655421",
						["Bone"] = "chest",
						["Name"] = "m16",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1057453672",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_ws_m16a4@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8736551483",
		["EditorExpand"] = true,
	},
},
}