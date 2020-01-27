ITEM.name = "PP-2000"
ITEM.description= "A folding-stock submachine gun chambered for 9x19mm."
ITEM.longdesc = "The PP-2000 is a conventional blowback-operated weapon.\nThe PP-2000 is designed as a close-quarter combat weapon, intended for riot police and special operations forces.\nIn 2008, it was adopted as a standard SMG in the Russian police.\nIts high rate of fire makes it perfect for defending yourself against smaller mutants and bandits.\n\nAmmo: 9x19mm \nMagazine Capacity: 20"
ITEM.model = "models/weapons/w_bf4_pp2000.mdl"
ITEM.class = "cw_pp2000"
ITEM.weaponCategory = "primary"
ITEM.width = 2
ITEM.price = 14000
ITEM.height = 2
--ITEM.busflag = {"ARMS2_1_1", "SPECIAL4"}
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_reflex","md_tundra9mm"}
ITEM.iconCam = {
	pos = Vector(-2.0999999046326, 19, -1),
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
						["Model"] = "models/weapons/w_bf4_pp2000.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-12.909, 1.219, -5.928),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3540269892",
						["Bone"] = "chest",
						["Name"] = "pp2000",
						["Angles"] = Angle(-82.139, -77.12, 167.002),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1640844916",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_pp2000@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1980487075",
		["EditorExpand"] = true,
	},
},
}