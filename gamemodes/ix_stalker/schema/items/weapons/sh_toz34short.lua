ITEM.name = "TOZ-34 Sawnoff"
ITEM.description= "A sawnoff break-action hunting shotgun firing 12 gauge shells."
ITEM.longdesc = "A double barrel hunting shotgun, a classic Russian design popular with hunters and loners alike.\nThis one has had its barrel cut, sacrificing accuracy for portability.\nThe over-and-under barrel placement helps to place shots in the center, but makes the gun more mechanically complex.\n\nAmmo: 12 Gauge \nMagazine Capacity: 2"
ITEM.model = ("models/weapons/w_sv10s.mdl")
ITEM.class = "cw_toz34short"
ITEM.weaponCategory = "secondary"
ITEM.width = 4
ITEM.price = 6000
ITEM.height = 1
ITEM.busflag = {"guns2"}
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 30
ITEM.RoF = "S/2/-"
ITEM.Dmg = "1d10+4"
ITEM.Pen = 2
ITEM.Mag = 2
ITEM.Rld = "Ready"
ITEM.Special = "Storm, Short, Buckshot"

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
						["Angles"] = Angle(0, 78.300003051758, -90),
						["Position"] = Vector(7.2630615234375, 1.69482421875, -3.53466796875),
						["Model"] = "models/weapons/w_sv10s.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8592523121",
						["Bone"] = "pelvis",
						["Name"] = "toz34s",
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
				["Arguments"] = "cw_toz34short@@0",
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