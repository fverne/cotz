ITEM.name = "H&K UMP"
ITEM.description= "A German submachine gun, firing the .45ACP cartridge."
ITEM.longdesc = "The UMP is a blowback operated, magazine-fed submachine gun firing from a closed bolt.\nAs originally designed, the UMP is chambered for larger cartridges than other submachine guns like the MP5, to provide more stopping power against unarmored targets.\n\nAmmo: .45ACP \nMagazine Capacity: 25"
ITEM.model = ("models/weapons/w_smg_ump45.mdl")
ITEM.class = "cw_ump45"
ITEM.weaponCategory = "primary"
ITEM.price = 14700
ITEM.width = 3
ITEM.height = 2
--ITEM.busflag = "ARMS1_1_1"
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_cobram2"}

ITEM.iconCam = {
	pos = Vector(-2, -205, 4),
	ang = Angle(0, 90, 0),
	fov = 8.4,
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
						["Position"] = Vector(-12.348, 2.674, 0.436),
						["Model"] = "models/weapons/w_smg_ump45.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8545625421",
						["Bone"] = "chest",
						["Name"] = "ump45",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1036896542",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_ump45@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8123321483",
		["EditorExpand"] = true,
	},
},
}