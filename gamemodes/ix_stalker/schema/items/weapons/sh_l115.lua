ITEM.name = "L115"
ITEM.description= "A military sniper rifle. Fires .338 Lapua."
ITEM.longdesc = "The L115, also known as the Artic Warfare Magnum is one of the most desirable sniper rifles in the Zone.\nIt fires the .338 Lapua bullet, boasting immense damage against even the most armored targets and effective ranges of up to 1500 meters.\n\nAmmo: .338 Lapua Magnum\nMagazine Capacity: 5"
ITEM.model = "models/weapons/w_cstm_l96.mdl"
ITEM.class = "cw_l115"
ITEM.weaponCategory = "primary"
ITEM.width = 6
ITEM.price = 100000 -- price me daddy uwu
ITEM.height = 2
ITEM.flag = "0"
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 200
ITEM.RoF = "S/-/-"
ITEM.Dmg = "1d10+7"
ITEM.Pen = 32
ITEM.Mag = 5
ITEM.Rld = "Ready"
ITEM.Special = "Long, Braced"

ITEM.canAttach = false
ITEM.iconCam = {
	pos = Vector(-14.5, 34, 1),
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
						["Angles"] = Angle(72.419, -177.46875, -96.1875),
						["Position"] = Vector(-7.046, -3.987, 11.914),
						["Model"] = "models/weapons/w_cstm_l96.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7946869091",
						["Bone"] = "chest",
						["Name"] = "l115",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1237786422",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_l115@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2784946348",
		["EditorExpand"] = true,
	},
},
}