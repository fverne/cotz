ITEM.name = "PPSh-41"
ITEM.description= "A heavy submachinegun with a wooden stock. Fires 7.62x25mm."
ITEM.longdesc = "The PPSh is a Soviet submachinegun that gained a fearful reputation in World War II as a fast and effective weapon. \nIt's weight of 4.3 kilograms coupled with a gas compensator grants it low recoil in bursts and automatic fire. It fires from the open bolt. \nThese have been a popular choice with rookies compared to western, newer submachineguns because of the price and ammunition accessibility.\n\nAmmo: 7.62x25mm \nMagazine Capacity: 35"
ITEM.model = "models/weapons/w_grub_ppsh_stick.mdl"
ITEM.class = "cw_ppsh"
ITEM.weaponCategory = "primary"
ITEM.width = 3
ITEM.price = 10000
ITEM.height = 2
ITEM.busflag = {"guns1_1_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 50
ITEM.RoF = "S/3/6"
ITEM.Dmg = "1d10+2"
ITEM.Pen = 7
ITEM.Mag = 71
ITEM.Rld = "Ready"

ITEM.canAttach = false
ITEM.iconCam = {
	pos = Vector(-10, -12, -35),
	ang = Angle(-90, 0, 3),
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
						["Position"] = Vector(-12.414306640625, 0.842529296875, 7.36279296875),
						["Name"] = "ppsh",
						["ClassName"] = "model",
						["Size"] = 0.85,
						["UniqueID"] = "3544245692",
						["Angles"] = Angle(-1.7127491235733, -46.162250518799, -88.74031829834),
						["Bone"] = "chest",
						["Model"] = "models/weapons/w_grub_ppsh_stick.mdl",
						["EditorExpand"] = true,
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1044232402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_ppsh@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1513321183",
		["EditorExpand"] = true,
	},
},
}