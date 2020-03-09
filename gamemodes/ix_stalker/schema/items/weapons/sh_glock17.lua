ITEM.name = "Glock 17"
ITEM.description= "An Austrian handgun that fires 9x19mm."
ITEM.longdesc = "The Glock is an Austrian polymer handgun, famous for it's price, reliability and trigger safety mechanism.\nIt's favored by police agencies around the world and comes in many flavors.\n\nAmmo: 9x19mm\nMagazine Capacity: 17"
ITEM.model = "models/weapons/w_pist_glock30.mdl"
ITEM.class = "cw_glock17"
ITEM.weaponCategory = "secondary"
ITEM.price = 4800
ITEM.width = 2
ITEM.height = 1
ITEM.busflag = {"guns3"}
ITEM.repairCost = ITEM.price/100*1

ITEM.canAttach = false

ITEM.iconCam = {
	pos = Vector(-0.80000001192093, 200, -1.7000000476837),
	ang = Angle(0, 270, 0),
	fov = 3.6,
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
						["Model"] = "models/weapons/w_pist_glock30.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-6.774, 3.172, 3.359),
						["EditorExpand"] = true,
						["UniqueID"] = "3547633835",
						["Bone"] = "pelvis",
						["Name"] = "glock17",
						["Angles"] = Angle(0, 90, 30),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1640766402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_glock17@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1980487467",
		["EditorExpand"] = true,
	},
},
}