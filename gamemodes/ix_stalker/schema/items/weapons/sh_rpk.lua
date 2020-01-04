ITEM.name = "RPK"
ITEM.description= "A long-barreled AK with a heavy stock. Fires 5.45x39mm."
ITEM.longdesc = "A modification of the AK rifle, fit with a more supporting stock, a heavier and longer barrel and a bipod. \nIt can mount any of the AK's attachments apart from a grenade launcher. \nIt lacks the high ammo capacity of most machineguns, but it makes up for this in accuracy and reliability.\n\nAmmo: 5.45x39mm\nMagazine Capacity: 45"
ITEM.model = ("models/weapons/w_rif_rpkm.mdl")
ITEM.class = "cw_rpk"
ITEM.weaponCategory = "primary"
ITEM.width = 5
ITEM.price = 50000
ITEM.height = 2
--ITEM.busflag = "ARMS2_2_1_1"
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_kobra","md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_pso1","md_reflex","md_pbs1","md_foregrip"}
ITEM.Range = 150
ITEM.RoF = "S/3/6"
ITEM.Dmg = "1d10+6"
ITEM.Pen = 10
ITEM.Mag = 75
ITEM.Rld = "Ready"
ITEM.Special = "Long"

ITEM.iconCam = {
	pos = Vector(-11, 30, 0),
	ang = Angle(0, 270, 2),
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
						["Position"] = Vector(-7.446, -3.987, 9.214),
						["Model"] = "models/weapons/w_rif_rpkm.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "3583945391",
						["Bone"] = "chest",
						["Name"] = "rpk",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1059846402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_rpk@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1132482183",
		["EditorExpand"] = true,
	},
},
}