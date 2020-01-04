ITEM.name = "SAKO TRG-42"
ITEM.description= "A Finnish bolt action rifle chambered for .338 Lapua Magnum."
ITEM.longdesc = "The TRG-42 is the newest development in the TRG sniper rifle family.\nIn addition to a more reliable build, it also fires the massive .338 Lapua Magnum, capable of taking out most humanoid targets in just a single shot.\n\nAmmo: .338 Lapua Magnum \nMagazine Capacity: 5"
ITEM.model = ("models/weapons/tgr/w_spin_scout.mdl")
ITEM.class = "cw_trg42"
ITEM.weaponCategory = "primary"
ITEM.width = 6
ITEM.price = 80000
ITEM.height = 2
--ITEM.busflag = "ARMS1_4_1_1"
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_nightforce_nxs","md_reflex","md_saker","md_foregrip"}
ITEM.Range = 200
ITEM.RoF = "S/-/-"
ITEM.Dmg = "1d10+6"
ITEM.Pen = 20
ITEM.Mag = 5
ITEM.Rld = "Ready"
ITEM.Special = "Long"

ITEM.iconCam = {
	pos = Vector(-13, 33.5, 2),
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
						["Model"] = "models/weapons/tgr/w_spin_scout.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-4.723, -3.92, 8.883),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3578648314",
						["Bone"] = "chest",
						["Name"] = "trg-42",
						["Angles"] = Angle(81.792, -90.548, 11.281),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1418327982",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_trg42@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "7391465467",
		["EditorExpand"] = true,
	},
},
}