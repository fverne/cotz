ITEM.name = "Mossberg 500"
ITEM.description= "A 12 gauge pump-action shotgun. Seems modern."
ITEM.longdesc = "The Mossberg 500 is one of the most popular smooth-bore pump action shotguns in the world.\nA low price and an inherently reliable design makes it a good choice for hunters and police officers alike.\n\nAmmo: 12 Gauge\nMagazine Capacity: 6"
ITEM.model = "models/weapons/w_shot_mossberg5.mdl"
ITEM.class = "cw_mossberg500"
ITEM.weaponCategory = "primary"
ITEM.width = 3
ITEM.price = 30000
ITEM.height = 1
ITEM.busflag = {"guns2_1_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 50
ITEM.RoF = "S/2/-"
ITEM.Dmg = "1d10+5"
ITEM.Pen = 5
ITEM.Mag = 6
ITEM.Rld = "2 Ready"
ITEM.Special = "Long, Buckshot"

ITEM.canAttach = false
ITEM.iconCam = {
	pos = Vector(-2.2000000476837, -23, 1),
	ang = Angle(0, 90, 5),
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
						["Angles"] = Angle(270, 180, 291.8),
						["Position"] = Vector(-10.468, -4.789, -3.387),
						["Model"] = "models/weapons/w_shot_mossberg5.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "78798794673",
						["Bone"] = "chest",
						["Name"] = "moss500",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1237868922",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_mossberg500@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2787986348",
		["EditorExpand"] = true,
	},
},
}