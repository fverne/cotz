ITEM.name = "M3 Super 90"
ITEM.description= "A pump-action shotgun. Fires 12 Gauge rounds."
ITEM.longdesc = "The Benelli M3 (Super 90) is a dual-mode shotgun designed and manufactured by Italian firearms manufacturer Benelli.\nThe M3 holds a maximum of eight rounds and uses the proprietary Benelli semi-automatic system first showcased in the M1.\nThe M3 is notable for allowing the user the choice of semi-automatic or pump-action operation. It is reliable and versatile, and popular with military and police forces as well as civilians.\n\nAmmo: 12 Gauge \nMagazine Capacity: 8"
ITEM.model = "models/weapons/w_cstm_m3super90.mdl"
ITEM.class = "cw_m3super90"
ITEM.weaponCategory = "primary"
ITEM.width = 4
ITEM.price = 40000
ITEM.height = 1
--ITEM.busflag = "ARMS1_2_1"
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 50
ITEM.RoF = "S/2/-"
ITEM.Dmg = "1d10+5"
ITEM.Pen = 5
ITEM.Mag = 8
ITEM.Rld = "2 Ready"
ITEM.Special = "Long, Buckshot"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5

ITEM.iconCam = {
	pos = Vector(-10, 31, 1.5),
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
						["Position"] = Vector(-6.846, -3.087, 12.214),
						["Model"] = "models/weapons/w_cstm_m3super90.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7946894691",
						["Bone"] = "chest",
						["Name"] = "m3super90",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1237465422",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_m3super90@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2786446348",
		["EditorExpand"] = true,
	},
},
}