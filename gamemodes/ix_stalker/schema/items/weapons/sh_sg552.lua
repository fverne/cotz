ITEM.name = "SIG SG 552"
ITEM.description= "A Swiss assault rifle. Fires 5.45x45mm."
ITEM.longdesc = "The Sig 552 is the carbine version of the 550 rifle, often agreed to be one of the best modern assault rifles. It's accurate, reliable and easy to use. \nIt's high price and rather rare match ammunition has put many STALKERs off from using this weapon, instead choosing a more common alternative. It has a 700 round per minute rate of fire.\n\nAmmo: 5.56x45mm \nMagazine Capacity: 30"
ITEM.model = ("models/weapons/w_rif_tg552.mdl")
ITEM.class = "cw_sg552"
ITEM.weaponCategory = "primary"
ITEM.width = 3
ITEM.price = 24000
ITEM.height = 2
--ITEM.busflag = "ARMS1_3_1"
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_saker"}

ITEM.iconCam = {
	pos = Vector(-7.5, 156.86274719238, 0),
	ang = Angle(0, 270, 0),
	fov = 13.52
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
						["Model"] = "models/weapons/w_rif_tg552.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-9.244, -5.617, -6.187),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3522668235",
						["Bone"] = "chest",
						["Name"] = "sg552",
						["Angles"] = Angle(-86.712, -85.22, -163.068),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1418662282",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_sg552@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "7391421667",
		["EditorExpand"] = true,
	},
},
}