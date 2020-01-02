ITEM.name = "DP-28"
ITEM.description= "A big, old Soviet machinegun. Fires 7.62x54mm."
ITEM.longdesc = "The Degtyaryov machine gun or DP is a light machine gun firing the 7.62x54mmR cartridge that was used primarily by the Soviet Union starting in 1928.\nThe DP machine gun was supplemented in the 1950s by the more modern RPD machine gun and entirely replaced in Soviet service by the general purpose PK machine gun in the 1960s.\nDespite its numerous problems, the DP had a reputation as a relatively effective light support weapon.\nIt was nicknamed the 'Record player' by Red Army troops because the disc-shaped pan magazine resembled a gramophone record and its top cover revolved while the weapon was fired.\n\nAmmo: 7.62x54mm \nMagazine Capacity: 47"
ITEM.model = ("models/weapons/w_ro2_dp28.mdl")
ITEM.class = "cw_dp28"
ITEM.weaponCategory = "primary"
ITEM.width = 6
ITEM.price = 65000
ITEM.height = 2
ITEM.flag = "0"
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 150
ITEM.RoF = "S/3/6"
ITEM.Dmg = "1d10+5"
ITEM.Pen = 18
ITEM.Mag = 47
ITEM.Rld = "2 Ready"
ITEM.Special = "Long, Braced"

ITEM.canAttach = false
ITEM.iconCam = {
	pos = Vector(-15, 45, -2),
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
						["Angles"] = Angle(74.219, -177.469, -76.57),
						["Position"] = Vector(-4.607, -3.621, 7.157),
						["Model"] = "models/weapons/w_ro2_dp28.mdl",
						["ClassName"] = "model",
						["Size"] = 0.9,
						["EditorExpand"] = true,
						["UniqueID"] = "7923896121",
						["Bone"] = "chest",
						["Name"] = "dp28",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1237570000",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_dp28@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2787231255",
		["EditorExpand"] = true,
	},
},
}