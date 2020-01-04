ITEM.name = "TOZ-66"
ITEM.description= "A break-action hunting shotgun firing 12 gauge shells."
ITEM.longdesc = "A double barrel hunting shotgun, a classic Russian design popular with hunters and loners alike.\nThe cheap price and long barrel makes it useful for engaging animals and unarmed targets at ranges up to fifty meters.\nThe side-by-side barrels makes the weapon simpler built compared to the TOZ, but the sights are not aligned to both barrels.\n\nAmmo: 12 Gauge \nMagazine Capacity: 2"
ITEM.model = "models/weapons/w_doublebarrel.mdl"
ITEM.class = "cw_toz66"
ITEM.weaponCategory = "primary"
ITEM.width = 4
ITEM.price = 15000
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
	pos = Vector(-2, 30, -3),
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
						["Model"] = "models/weapons/w_doublebarrel.mdl",
						["ClassName"] = "model",
						["Angles"] = Angle(78.806, -89.399, 97.233),
						["Position"] = Vector(-7.858, -4.796, 1.549),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3552126135",
						["Bone"] = "chest",
						["Name"] = "toz66",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1616512402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_toz66@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1980937684",
		["EditorExpand"] = true,
	},
},
}