ITEM.name = "TOZ-66"
ITEM.description= "A break-action hunting shotgun firing 12 gauge shells."
ITEM.longdesc = "A double barrel hunting shotgun, a classic Russian design popular with hunters and loners alike.\nThe cheap price and long barrel makes it useful for engaging animals and unarmed targets at ranges up to fifty meters.\nThe side-by-side barrels makes the weapon simpler built compared to the TOZ, but the sights are not aligned to both barrels.\n\nAmmo: 12 Gauge \nMagazine Capacity: 2"
ITEM.model = "models/weapons/w_doublebarrel.mdl"
ITEM.class = "cw_toz66"
ITEM.weaponCategory = "primary"
ITEM.width = 5
ITEM.price = 9300
ITEM.height = 1
ITEM.busflag = {"guns2_1"}
ITEM.repairCost = ITEM.price/100*1

ITEM.canAttach = false

ITEM.iconCam = {
	pos = Vector(2.4000000953674, -205, -3),
	ang = Angle(0, 90, -2),
	fov = 12,
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
						["Angles"] = Angle(0, 180, 180),
						["Position"] = Vector(6.687, -5.597, -5.128),
						["EditorExpand"] = true,
						["UniqueID"] = "3552126135",
						["Bone"] = "spine 2",
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