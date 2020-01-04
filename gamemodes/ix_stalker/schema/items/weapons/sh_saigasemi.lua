ITEM.name = "Saiga Semi-Automatic Rifle"
ITEM.description= "A civillian semi-automatic rifle. Fires 7.62x39mm."
ITEM.longdesc = "The Saiga semi-automatic rifles are a family of Russian semi-automatic rifles manufactured by Kalashnikov Concern (formerly Izhmash).\nThey also manufacture the original AK-47 and its variants, Saiga-12 shotguns and the Dragunov sniper rifle.\nSaiga rifles are a sport version of the AK-series rifles, and are marketed for hunting and civilian use.\nThey are sometimes referred to as 'Saiga Sporters'.\n\nAmmo: 7.62x39mm \nMagazine Capacity: 20"
ITEM.model = "models/weapons/w_bfh_saiga308.mdl"
ITEM.class = "cw_saigasport"
ITEM.weaponCategory = "primary"
ITEM.width = 4
ITEM.price = 20000
ITEM.height = 2
ITEM.busflag = {"guns4"}
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_kobra","md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_nightforce_nxs","md_pso1","md_reflex","md_pbs1","md_foregrip"}
ITEM.Range = 100
ITEM.RoF = "S/3/-"
ITEM.Dmg = "1d10+5"
ITEM.Pen = 10
ITEM.Mag = 20
ITEM.Rld = "Ready"

ITEM.iconCam = {
	pos = Vector(-9, 28, 1),
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
						["Model"] = "models/weapons/w_bfh_saiga308.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-5.131, -8.79, 5.314),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "9611660162",
						["Bone"] = "chest",
						["Name"] = "saigasport",
						["Angles"] = Angle(59.479, -179.102, 91),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "0670219331",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_saigasport@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8562719528",
		["EditorExpand"] = true,
	},
},
}