ITEM.name = "Mosin Nagant"
ITEM.description= "An old bolt action rifle mostly made out of wood. Fires 7.62x54mm."
ITEM.longdesc = "The Mosin Nagant is an old bolt action design with it's origins in the Russian Empire, 1891.\nIt was used extensively as the official service rifle for multiple states and remains in arsenals of guerillas and other formations that needs to utilize a reliable, powerful and cheap rifle.\nIt's especially popular with the hunters in the Zone as the large bullet takes a wild animal out in a single shot.\nVery devastating towards unarmored personnel and personnel in armor alike, with the right ammunition.\n\nAmmo: 7.62x54mm\nMagazine Capacity: 5"
ITEM.model = "models/weapons/ethereal/w_mosin.mdl"
ITEM.class = "cw_kk_ins2_mosin"
ITEM.weaponCategory = "primary"
ITEM.width = 5
ITEM.price = 40000
ITEM.height = 1
ITEM.busflag = {"guns6"}
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 150
ITEM.RoF = "S/-/-"
ITEM.Dmg = "1d10+6"
ITEM.Pen = 20
ITEM.Mag = 5
ITEM.Rld = "Ready"
ITEM.Special = "Long"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5
ITEM.weight = 4

ITEM.iconCam = {
	pos = Vector(-11.39999961853, 39, 0),
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
						["Angles"] = Angle(74.21875, -177.46875, -96.1875),
						["Position"] = Vector(-7.678, -3.941, 7.315),
						["Model"] = "models/weapons/ws mosin/w_ws_mosin.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8542553421",
						["Bone"] = "chest",
						["Name"] = "mosin",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1234453672",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_ws_mosin@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8235351483",
		["EditorExpand"] = true,
	},
},
}