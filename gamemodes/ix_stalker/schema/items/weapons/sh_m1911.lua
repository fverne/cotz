ITEM.name = "M1911"
ITEM.description= "An American military surplus semi-automatic pistol chambered for .45 ACP."
ITEM.longdesc = "The M1911 first came into service in the American army in 1911 and has yet to be phased out of production, this pistol is a military surplus from the Vietnam war.\nIt's very reliable even in an area as extreme as the Zone, plus the heavy round has exceptional stopping power against unarmored targets.\n\nAmmo: .45ACP\nMagazine Capacity: 7"
ITEM.model = "models/weapons/cw_pist_m1911.mdl"
ITEM.class = "cw_m1911"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price = 6600
ITEM.height = 1
--ITEM.busflag = "ARMS1_1"
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_microt1","md_eotech","md_rmr","md_cobram2"}

ITEM.iconCam = {
	pos = Vector(-7, 10, 1),
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
						["Model"] = "models/weapons/cw_pist_m1911.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-7.01, 5.953, -0.761),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3589733835",
						["Bone"] = "pelvis",
						["Name"] = "m1911",
						["Angles"] = Angle(0, 270, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1640773902",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_m1911@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1973887467",
		["EditorExpand"] = true,
	},
},
}