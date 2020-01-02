ITEM.name = "Makarov"
ITEM.description= "A Russian steel-framed police pistol that fires 9x18 Makarov."
ITEM.longdesc = "The Makarov is the replacement for the Tokarev pistol.\nIt's a cheap, compact and reliable choice, but it's not very comfortable and has a smaller magazine than other handguns of same weight category.\n\nAmmo: 9x18mm\nMagazine Capacity: 8"
ITEM.model = "models/weapons/w_makarov_pm_fixed.mdl"
ITEM.class = "cw_makarov"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price = 1000
ITEM.height = 1
ITEM.busflag = {"guns1_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.canAttach = false
ITEM.Range = 30
ITEM.RoF = "S/3/-"
ITEM.Dmg = "1d10+1"
ITEM.Pen = 4
ITEM.Mag = 8
ITEM.Rld = "Ready"
ITEM.Special = "CQC, Subsonic"

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-8, 215.68627929688, 4),
	ang = Angle(0, 270, 4.7058825492859),
	fov = 5,
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
						["Model"] = "models/cw2/pistols/w_makarov.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-7.5, 2.993, -1.955),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3589789835",
						["Bone"] = "pelvis",
						["Name"] = "makarov",
						["Angles"] = Angle(0, 180, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1640777682",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_makarov@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1977897467",
		["EditorExpand"] = true,
	},
},
}