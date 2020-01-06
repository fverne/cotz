ITEM.name = "HK MP5"
ITEM.description= "A black submachinegun. Fires 9x19mm."
ITEM.longdesc = "The MP5 is an iconic German submachinegun developed in the 1960s, known for it's reliability and effectiveness.\nThe MP5 differentiates from other submachineguns because it fires from a closed bolt.\nIt uses the same operating mechanism as the G3 rifle which has made it one of the most accurate submachineguns in the world.\n\nAmmo: 9x19mm\nMagazine Capacity: 30"
ITEM.model = "models/weapons/ethereal/w_mp5a4.mdl"
ITEM.class = "cw_kk_ins2_mp5a4"
ITEM.weaponCategory = "primary"
ITEM.width = 3
ITEM.price = 30000
ITEM.height = 2
--ITEM.busflag = {"ARMS1_1_1", "SPECIAL6"}
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 50
ITEM.RoF = "S/3/6"
ITEM.Dmg = "1d10+3"
ITEM.Pen = 6
ITEM.Mag = 30
ITEM.Rld = "Ready"
ITEM.Special = "Short"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5

ITEM.iconCam = {
	pos = Vector(-9.8999996185303, 25, 2),
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
						["Angles"] = Angle(74.21875, -177.46875, -101.487),
						["Position"] = Vector(-7.646, -2.504, 12.214),
						["Model"] = "models/srp/weapons/w_mp5.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "79478794673",
						["Bone"] = "chest",
						["Name"] = "mp5",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "6247478922",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_mp5@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8647796348",
		["EditorExpand"] = true,
	},
},
}