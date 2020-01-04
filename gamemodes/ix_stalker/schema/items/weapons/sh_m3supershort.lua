ITEM.name = "Serbu Super Shorty"
ITEM.description= "An extremely short shotgun. Fires 12 Gauge rounds."
ITEM.longdesc = "The Super-Shorty is a compact, stockless, pump-action AOW chambered in 12-gauge. The basic architecture of most of the production models is based on the Mossberg Maverick 88 shotgun.\nAs the weapon is originally manufactured without a shoulder stock, it is considered a smooth-bore handgun, and thus an AOW, rather than a short-barrelled shotgun.\n\nAmmo: 12 Gauge \nMagazine Capacity: 4"
ITEM.model = "models/weapons/w_shot_shortygun.mdl"
ITEM.class = "cw_m3supershort"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price = 20000
ITEM.height = 1
ITEM.busflag = {"guns2_1_1"}
ITEM.repairCost = ITEM.price/100*1

ITEM.canAttach = false
ITEM.iconCam = {
	pos = Vector(1.3999999761581, 11, -2.5),
	ang = Angle(0, 270, 0),
	fov = 70
}
ITEM.Range = 30
ITEM.RoF = "S/2/-"
ITEM.Dmg = "1d10+4"
ITEM.Pen = 2
ITEM.Mag = 4
ITEM.Rld = "Ready"
ITEM.Special = "Short, Buckshot"

ITEM.pacData = {
[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Model"] = "models/weapons/w_shot_shortygun.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-9.106, -2.47, 0.876),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3547763835",
						["Bone"] = "pelvis",
						["Name"] = "m3short",
						["Angles"] = Angle(0, 270, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1616466402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_m3supershort@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1980476967",
		["EditorExpand"] = true,
	},
},
}