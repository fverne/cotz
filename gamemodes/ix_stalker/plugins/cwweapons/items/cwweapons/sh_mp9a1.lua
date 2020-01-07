ITEM.name = "MP9a1"
ITEM.description= "A compact machine pistol. Fires 9x19mm."
ITEM.longdesc = "The Machine Pistol 9 is a Swiss-made submachinegun from the early 2000s, it weighs 1.4 kilograms unloaded and is generally compact.\nIt features a drop, trigger and ambidextrious safety switch and has a fire-rate of 900 rounds a minute.\n\nAmmo: 9x19mm\nMagazine Capacity: 3"
ITEM.model = ("models/weapons/w_smg_mp9a1.mdl")
ITEM.class = "cw_mp9a1"
ITEM.weaponCategory = "primary"
ITEM.width = 2
ITEM.price = 35000
ITEM.height = 2
ITEM.busflag = {"guns3_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 30
ITEM.RoF = "S/3/6"
ITEM.Dmg = "1d10+2"
ITEM.Pen = 5
ITEM.Mag = 30
ITEM.Rld = "Ready"
ITEM.Special = "CQC"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5
ITEM.weight = 1.4

ITEM.iconCam = {
	pos = Vector(4.5, 13, -4),
	ang = Angle(0, 270, 2),
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
						["Position"] = Vector(-13.292, -5.403, -2.197),
						["Model"] = "models/weapons/w_smg_mp9a1.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "79898994673",
						["Bone"] = "chest",
						["Name"] = "mp9a1",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1238978922",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_mp9a1@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2786496348",
		["EditorExpand"] = true,
	},
},
}