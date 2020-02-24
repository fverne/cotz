ITEM.name = "AN-94"
ITEM.description= "A soviet-designed assault rifle chambered for 5.45x39mm"
ITEM.longdesc = "The AN-94 offers a unique two-shot burst function at a stated 1800 rounds per minute rate of fire.\nThe Nikonov mechanism fires the second shot in the burst quickly enough to allow it to escape before the recoil of the first shot is felt, thus potentially allowing the two shots to hit extremely close together, for example to aid in piercing body armor.\nThis makes it the weapon of choice when fighting heavily armored enemies.\n\nAmmo: 5.45x39mm\nMagazine Capacity: 30"
ITEM.model = "models/srp/weapons/w_abakan.mdl"
ITEM.class = "cw_an94k"
ITEM.weaponCategory = "primary"
ITEM.price = 28600
ITEM.width = 5
ITEM.height = 2
--ITEM.busflag = "ARMS2_3_1"
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_kobra", "md_pso1", "md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_pbs1","md_foregrip"}

ITEM.iconCam = {
	pos = Vector(13, -205, 0),
	ang = Angle(0, 90, 0),
	fov = 11.5,
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
						["Position"] = Vector(-7.546, -3.987, 12.214),
						["Model"] = "models/srp/weapons/w_abakan.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "3543412391",
						["Bone"] = "chest",
						["Name"] = "an94k",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1059123402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_an94k@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1123482183",
		["EditorExpand"] = true,
	},
},
}