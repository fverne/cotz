ITEM.name = "Saiga-12"
ITEM.description= "A semi-automatic shotgun. Fires 12 gauge."
ITEM.longdesc = "The Saiga-12 is a 12-gauge shotgun available in a wide range of configurations, patterned after the Kalashnikov series of assault rifles and named for the Saiga antelope.\nLike the Kalashnikov rifle variants, it is a rotating bolt, gas-operated gun that feeds from a box magazine.\nAll Saiga-12 configurations are recognizable as Kalashnikov-pattern guns by the large lever-safety on the right side of the receiver, the optic mounting rail on the left side of the receiver and the large top-mounted dust cover held in place by the rear of the recoil spring assembly.\n\nAmmo: 12 Gauge \nMagazine Capacity: 5"
ITEM.model = "models/weapons/ethereal/w_saiga_12k.mdl"
ITEM.class = "cw_kk_ins2_saiga12"
ITEM.weaponCategory = "primary"
ITEM.width = 4
ITEM.price = 100000 -- price me daddy uwu
ITEM.height = 2
--ITEM.busflag = "ARMS2_2_1_1"
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 50
ITEM.RoF = "S/3/-"
ITEM.Dmg = "1d10+5"
ITEM.Pen = 5
ITEM.Mag = 10
ITEM.Rld = "Ready"
ITEM.Special = "Buckshot"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5

ITEM.iconCam = {
	pos = Vector(-6.9000000953674, 28.299999237061, 1),
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
						["Model"] = "models/cw2/weapons/w_saiga_chan.mdl",
						["ClassName"] = "model",
						["Size"] = 0.825,
						["Position"] = Vector(-9.32, -5.096, -5.351),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3547633835",
						["Bone"] = "chest",
						["Name"] = "saiga12",
						["Angles"] = Angle(-89.342, -159.117, -105.45),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1640766402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_saiga12@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1980487467",
		["EditorExpand"] = true,
	},
},
}