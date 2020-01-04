ITEM.name = "TOZ-34 Hunting Shotgun"
ITEM.description= "A break-action hunting shotgun firing 12 gauge shells."
ITEM.longdesc = "A double barrel hunting shotgun, a classic Russian design popular with hunters and loners alike.\nThe cheap price and long barrel makes it useful for engaging animals and unarmed targets at ranges up to fifty meters.\nThe over-and-under barrel placement helps to place shots in the center, but makes the gun more mechanically complex.\n\nAmmo: 12 Gauge \nMagazine Capacity: 2"
ITEM.model = ("models/weapons/w_sv10.mdl")
ITEM.class = "cw_toz34"
ITEM.weaponCategory = "primary"
ITEM.width = 4
ITEM.price = 8000
ITEM.height = 1
ITEM.busflag = {"guns2_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 50
ITEM.RoF = "S/2/-"
ITEM.Dmg = "1d10+5"
ITEM.Pen = 5
ITEM.Mag = 2
ITEM.Rld = "Ready"
ITEM.Special = "Storm, Long, Buckshot"

ITEM.canAttach = false
ITEM.iconCam = {
	pos = Vector(-3, -37, 0),
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
						["Angles"] = Angle(62.727, 107.588, 8.727),
						["Position"] = Vector(-10.144, -3.047, -4.744),
						["Model"] = "models/weapons/w_sv10.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8592523121",
						["Bone"] = "chest",
						["Name"] = "toz34",
						["AngleOffset"] = Angle(200, 0, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1424656542",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_toz34@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "81242563283",
		["EditorExpand"] = true,
	},
},
}