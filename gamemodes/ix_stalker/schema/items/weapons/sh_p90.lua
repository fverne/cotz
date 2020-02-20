ITEM.name = "FN P90"
ITEM.description= "A sub machine gun chambered in 5.7x28mm."
ITEM.longdesc = "The FN P90 is the sister gun to the FN FiveSeven pistol, developed alongside it and its special cartridge, the 5.7x28mm.\nIntending to replace the classic 9x19mm pistol round, it hasn't quite worked out yet, making this a niche weapon.\nThe weapon is rare and so is its ammo.\n\nAmmo: 5.7x28mm \nMagazine Capacity: 50"
ITEM.model = ("models/weapons/therambotnic09/w_cst_p90.mdl")
ITEM.class = "cw_p90"
ITEM.weaponCategory = "primary"
ITEM.width = 3
ITEM.price = 19000
ITEM.height = 2
--ITEM.busflag = {"ARMS1_1_1", "SPECIAL5_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_reflex","md_tundra9mm"}

ITEM.iconCam = {
	pos = Vector(-7, 17, 3.5),
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
						["Angles"] = Angle(0, 180, 180),
						["Position"] = Vector(11.188, -4.175, -0.658),
						["Model"] = "models/weapons/therambotnic09/w_cst_p90.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8544325862",
						["Bone"] = "spine 2",
						["Name"] = "p90",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1036853001",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_p90@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8530011483",
		["EditorExpand"] = true,
	},
},
}