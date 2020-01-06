ITEM.name = "Skorpion"
ITEM.description= "A compact machine pistol. Fires 9x18mm."
ITEM.longdesc = "The Škorpion vz. 61 is a Czechoslovak machine pistol developed in 1959.\nAlthough it was developed for use with security forces and special forces, the weapon was also accepted into service with the Czechoslovak Army, as a personal sidearm for lower-ranking army staff, vehicle drivers, armoured vehicle personnel and special forces.\nCurrently the weapon is in use with the armed forces of several countries as a sidearm.\n\nAmmo: 9x18mm \nMagazine Capacity: 20"
ITEM.model = ("models/weapons/w_smg_skorp.mdl")
ITEM.class = "cw_skorpion"
ITEM.weaponCategory = "primary"
ITEM.width = 2
ITEM.price = 5500
ITEM.height = 2
ITEM.busflag = {"guns1_1_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 30
ITEM.RoF = "S/3/6"
ITEM.Dmg = "1d10+1"
ITEM.Pen = 4
ITEM.Mag = 20
ITEM.Rld = "Ready"
ITEM.Special = "CQC, Subsonic"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5

ITEM.iconCam = {
	pos = Vector(9, 20, -2),
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
						["Position"] = Vector(-13.863, -5.159, -5.964),
						["Model"] = "models/weapons/w_smg_skorp.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7764798673",
						["Bone"] = "chest",
						["Name"] = "skorp",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1239764522",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_skorpion@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2784647898",
		["EditorExpand"] = true,
	},
},
}