ITEM.name = "Sako 85"
ITEM.description= "A bolt-action sniper rifle intended for hunting wildlife. Fires 7.62x51mm."
ITEM.longdesc = "The Sako 85 is a Finnish bolt-action sniper rifle designed for hunting. It can be fitted with various telescopic sights.\n\nAmmo: 7.62x51mm\nMagazine Capacity: 5"
ITEM.model = ("models/weapons/tfa_nmrih/w_fa_sako85_ironsights.mdl")
ITEM.class = "cw_sako85"
ITEM.weaponCategory = "primary"
ITEM.width = 4
ITEM.price = 30000
ITEM.height = 2
--ITEM.busflag = {"ARMS1_4_1", "SPECIAL6_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_nightforce_nxs","md_reflex","md_saker"}
ITEM.Range = 150
ITEM.RoF = "S/-/-"
ITEM.Dmg = "1d10+4"
ITEM.Pen = 12
ITEM.Mag = 5
ITEM.Rld = "Ready"
ITEM.Special = "Long"

ITEM.iconCam = {
	pos = Vector(-10, -16, 0),
	ang = Angle(0, 90, 0),
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
						["Angles"] = Angle(74.21875, -177.46875, -96.1875),
						["Position"] = Vector(-14.65, -0.247, -9.327),
						["Model"] = "models/weapons/tfa_nmrih/w_fa_sako85_ironsights.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8544325421",
						["Bone"] = "chest",
						["Name"] = "sako85",
						["AngleOffset"] = Angle(200, 0, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1036853672",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_sako85@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8537651483",
		["EditorExpand"] = true,
	},
},
}