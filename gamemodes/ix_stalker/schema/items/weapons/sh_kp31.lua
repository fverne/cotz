ITEM.name = "KP-31"
ITEM.description= "A submachinegun chambered for 9x19mm."
ITEM.longdesc = "The Suomi KP-31 is regarded by many as one of the most successful submachine guns of World War II. It also had a profound effect on that conflict beyond Finland as the Soviet authorities, who had been dismissive of sub-machine guns, were persuaded of their deadly efficiency by the Finns after they attacked them in 1939.\n\nAmmo: 9x19mm \nMagazine Capacity: 30"
ITEM.model = ("models/khrcw2/doipack/w_suomi.mdl")
ITEM.class = "cw_kp31"
ITEM.weaponCategory = "primary"
ITEM.width = 3
ITEM.price = 9600
ITEM.height = 2
ITEM.busflag = {"guns3_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_tundra9mm"}

ITEM.iconCam = {
	pos = Vector(-22, 8, -2),
	ang = Angle(0, -0, 0),
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
						["Angles"] = Angle(-8.912, 96.435, -164.117),
						["Position"] = Vector(-12.767, -4.922, -5.399),
						["Model"] = "models/khrcw2/doipack/w_suomi.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8883938491",
						["Bone"] = "chest",
						["Name"] = "sterling",
						["AngleOffset"] = Angle(0, 0, 90),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1044336402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_sterling@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8134421183",
		["EditorExpand"] = true,
	},
},
}