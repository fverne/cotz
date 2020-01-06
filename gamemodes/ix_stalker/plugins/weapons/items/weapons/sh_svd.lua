ITEM.name = "Dragunov SVD"
ITEM.description= "A sharpshooter rifle based on the AK. Fires 7.62x54mm."
ITEM.longdesc = "The SVD is a marksman's rifle designed to fill the gap between assault and sniper rifle for infantry squads. It was designed from the AK rifle. \nThe SVD is able to deliver accurate shots in rapid succession, but it is not as precise as a sniper rifle.\n\nAmmo: 7.62x54mm \nMagazine Capacity: 10"
ITEM.model = "models/weapons/ethereal/w_svd.mdl"
ITEM.class = "cw_kk_ins2_svd"
ITEM.weaponCategory = "primary"
ITEM.width = 6
ITEM.price = 100000 -- price me daddy uwu
ITEM.height = 2
--ITEM.busflag = "ARMS2_4_1_1"
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 200
ITEM.RoF = "S/2/-"
ITEM.Dmg = "1d10+6"
ITEM.Pen = 20
ITEM.Mag = 10
ITEM.Rld = "Ready"
ITEM.Special = "Long"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5

ITEM.iconCam = {
	pos = Vector(-16.5, 33, 1),
	ang = Angle(0, 270, -4),
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
						["Model"] = "models/weapons/drag/w_snip_dragn.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-6.059, -6.115, 10.023),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3859539124",
						["Bone"] = "chest",
						["Name"] = "svd",
						["Angles"] = Angle(75.709, 144.362, -172.73),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "2428315201",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_dragunov@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "0004518261",
		["EditorExpand"] = true,
	},
},
}