ITEM.name = "Colt Anaconda"
ITEM.description= "A snub-nosed double-action revolver chambered for .44 Magnum."
ITEM.longdesc = "The Colt Anaconda is a double action handgun chambered for the .44 Magnum cartridge, built on Colt's large I-frame.\nAnacondas have a reputation for accuracy, smooth trigger pull, and a tight cylinder lock-up.\nIt is quite heavy considering it is a handgun.\n\nAmmo: .44 Magnum\nMagazine Capacity: 6"
ITEM.model = ("models/weapons/w_python.mdl")
ITEM.class = "cw_python"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price = 100000 --NEEDS PRICE NERDS
ITEM.height = 1
ITEM.busflag = {"guns3_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 50
ITEM.RoF = "S/2/-"
ITEM.Dmg = "1d10+4"
ITEM.Pen = 7
ITEM.Mag = 6
ITEM.Rld = "2 Ready"
ITEM.Special = "CQC"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5
ITEM.weight = 1.3

ITEM.canAttach = false
ITEM.iconCam = {
	pos = Vector(-10, -11, 1.5),
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
						["Model"] = "models/weapons/w_python.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-9.858, -9.148, -1.514),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3989742835",
						["Bone"] = "pelvis",
						["Name"] = "python",
						["Angles"] = Angle(0, 90, 0),
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
				["Arguments"] = "cw_python@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1989894367",
		["EditorExpand"] = true,
	},
},
}