ITEM.name = "P99"
ITEM.description= "A German handgun, firing the 9x19mm cartridge."
ITEM.longdesc = "The Walther P99 is a semi-automatic pistol developed by the German company Carl Walther GmbH Sportwaffen of Ulm.\nIt is designed for law enforcement, security forces and the civilian shooting market as a replacement for the Walther P5 and the P88.\n\nAmmo: 9x19mm\nMagazine Capacity: 15"
ITEM.model = "models/weapons/ethereal/w_p99.mdl"
ITEM.class = "cw_kk_ins2_p99"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price = 8000
ITEM.height = 1
ITEM.busflag = {"guns3_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 30
ITEM.RoF = "S/3/-"
ITEM.Dmg = "1d10+2"
ITEM.Pen = 5
ITEM.Mag = 15
ITEM.Rld = "Ready"
ITEM.Special = "CQC"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5
ITEM.weight = 0.63

ITEM.iconCam = {
	pos = Vector(-5, 8, 1.5),
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
						["Model"] = "models/srp/weapons/w_p99.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-7.238, 5.06, -2.297),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3628359835",
						["Bone"] = "pelvis",
						["Name"] = "p99",
						["Angles"] = Angle(0, 270, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1640786782",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_p99@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1977899867",
		["EditorExpand"] = true,
	},
},
}