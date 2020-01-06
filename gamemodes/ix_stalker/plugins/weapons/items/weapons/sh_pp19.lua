ITEM.name = "PP19 'Bizon'"
ITEM.description= "A folding-stock sub machine gun chambered for 9x18mm."
ITEM.longdesc = "The Bizon is a submachinegun that features an uncommon large helical magazine, doubling as a grip.\nIt's very similiar to the AK74 rifles and 60 percent of the parts for the weapons are interchangable.\nAn effective submachinegun for police and security purposes.\n\nAmmo: 9x18mm\nMagazine Capacity: 64"
ITEM.model = ("models/weapons/w_smg_biz.mdl")
ITEM.class = "cw_pp19"
ITEM.weaponCategory = "primary"
ITEM.width = 3
ITEM.price = 25000
ITEM.height = 2
ITEM.busflag = {"guns1_1_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 50
ITEM.RoF = "S/3/6"
ITEM.Dmg = "1d10+2"
ITEM.Pen = 5
ITEM.Mag = 64
ITEM.Rld = "Ready"
ITEM.Special = "Subsonic"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5

ITEM.iconCam = {
ang= Angle(-0.70499622821808, 268.25439453125, 0),
fov= 9.085652091515,
pos= Vector(10, 200, -2)
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
						["Position"] = Vector(-13.141, -4.329, -1.789),
						["Model"] = "models/weapons/w_smg_biz.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7793894673",
						["Bone"] = "chest",
						["Name"] = "biz",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1237579522",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_pp19@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2784686348",
		["EditorExpand"] = true,
	},
},
}