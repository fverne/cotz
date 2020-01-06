ITEM.name = "Remington 870 AE"
ITEM.description= "A pump-action shotgun. Fires 12 gauge."
ITEM.longdesc = "The Remington Model 870 is a pump-action shotgun manufactured by Remington Arms Company, LLC.\nIt is widely used by the public for sport shooting, hunting, and self-defense. It is also commonly used by law enforcement and military organizations worldwide.\nOn April 13, 2009, the ten millionth Model 870 was produced; the 870 holds the record for best-selling shotgun in history.\n\nAmmo: 12 Gauge \nMagazine Capacity: 8"
ITEM.model = ("models/weapons/w_shot_remington.mdl")
ITEM.class = "cw_rem870ae"
ITEM.weaponCategory = "primary"
ITEM.width = 4
ITEM.price = 40000
ITEM.height = 1
ITEM.busflag = {"guns2_1_1"}
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

ITEM.canAttach = false
ITEM.iconCam = {
	pos = Vector(-12, 37, 1),
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
						["Angles"] = Angle(78.519, -177.46875, -100.487),
						["Position"] = Vector(-7.361, -1.493, 11.48),
						["Model"] = "models/weapons/w_shot_remington.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7793798673",
						["Bone"] = "chest",
						["Name"] = "rem870",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1239789522",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_rem870ae@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2784687898",
		["EditorExpand"] = true,
	},
},
}