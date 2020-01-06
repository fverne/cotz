ITEM.name = "SKS"
ITEM.description= "An old Russian semi-automatic rifle chambered for 7.62x39mm."
ITEM.longdesc = "The SKS is a Soviet semi-automatic carbine chambered for the 7.62x39mm round, designed in 1943 by Sergei Gavrilovich Simonov.\nIn the early 1950s, the Soviets took the SKS carbine out of front-line service and replaced it with the AK-47; however, the SKS remained in second-line service for decades.\nThe SKS is currently popular on the civilian surplus market as a hunting and marksmanship semi-automatic rifle in many countries, including the Zone.\n\nAmmo: 7.62x39mm \nMagazine Capacity: 30"
ITEM.model = "models/weapons/ethereal/w_sks.mdl"
ITEM.class = "cw_kk_ins2_sks"
ITEM.weaponCategory = "primary"
ITEM.width = 4
ITEM.price = 18000
ITEM.height = 1
ITEM.busflag = {"guns4"}
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 100
ITEM.RoF = "S/3/-"
ITEM.Dmg = "1d10+5"
ITEM.Pen = 10
ITEM.Mag = 30
ITEM.Rld = "Ready"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5

ITEM.iconCam = {
	pos = Vector(10, -30, 0),
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
						["Angles"] = Angle(-73.093, -13.529, 128.826),
						["Model"] = "models/weapons/world/rifles/sks.mdl",
						["ClassName"] = "model",
						["Position"] =	Vector(-6.922, -3.151, 8.242),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3888831291",
						["Bone"] = "chest",
						["Name"] = "sks",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1053552402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_sks@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1515522183",
		["EditorExpand"] = true,
	},
},
}