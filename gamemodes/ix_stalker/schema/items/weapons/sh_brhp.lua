ITEM.name = "Browning Hi-Power"
ITEM.description= "A semi-automatic pistol chambered for 9x19mm."
ITEM.longdesc = "The Browning Hi-Power pistol is product of the French military requesting a new service pistol.\nThe Hi-Power name alludes to the 13-round magazine capacity, almost twice that of contemporary designs such as the Luger or Colt M1911.\nIt has been widely used throughout history, mainly in the second world war by both the Axis and the Allied forces.\nWhen the war ended, over 50 armies adopted it as their service pistol.\n\nAmmo: 9x19mm\nMagazine Capacity: 13"
ITEM.model = "models/weapons/w_pist_brhp.mdl"
ITEM.class = "cw_brhp"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price = 1200
ITEM.height = 1
ITEM.busflag = {"guns3_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_microt1","md_eotech","md_rmr","md_tundra9mm"}

ITEM.iconCam = {
	ang= Angle(0, 0, 0),
	fov= 23.889,
	pos= Vector(-35, 0, -2)
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
						["Model"] = "models/weapons/w_pist_brhp.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-7.5, 0.10999999940395, 2.4000000953674),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3543276491",
						["Bone"] = "pelvis",
						["Name"] = "brhp",
						["Angles"] = Angle(0, 180, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1016812402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_brhp@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1118321183",
		["EditorExpand"] = true,
	},
},
}