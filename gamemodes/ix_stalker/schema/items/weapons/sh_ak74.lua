ITEM.name = "AK74"
ITEM.description= "A soviet-designed assault rifle chambered for 5.45x39mm."
ITEM.longdesc = "The AK-74 is the replacement for the AKM and the most notable difference between the two is the drop in caliber from 7.62x39mm to 5.45x39mm.\nThis means the recoil is less intense but the penetration of the bullet also suffers slightly.\nThe 5.45x39mm cartridge is popular with many stalkers since it takes care of mutant and armored humans alike.\n\nAmmo: 5.45x39mm\nMagazine Capacity: 30"
ITEM.model = "models/weapons/w_ops_ak74.mdl"
ITEM.class = "cw_ak74"
ITEM.weaponCategory = "primary"
ITEM.price = 15000
ITEM.width = 5
ITEM.height = 2
--ITEM.busflag = {"ARMS2_3_1", "SPECIAL4_1", "SPECIAL7_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_kobra","md_pso1","md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_pbs1","md_foregrip"}

ITEM.iconCam = {
	pos = Vector(10, -205, 2),
	ang = Angle(0, 90, 4.5),
	fov = 12.5,
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
						["Angles"] = Angle(180, 0, 0),
						["Model"] = "models/weapons/w_ops_ak74.mdl",
						["ClassName"] = "model",
						["Position"] =	Vector(11.522, -4.244, -1.16),
						["EditorExpand"] = true,
						["UniqueID"] = "3543431291",
						["Bone"] = "spine 2",
						["Name"] = "ak74",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1053212402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_ak74@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1512342183",
		["EditorExpand"] = true,
	},
},
}