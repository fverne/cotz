ITEM.name = "SAKO RK 95"
ITEM.description= "A grey assault rifle. Fires 7.62x39mm."
ITEM.longdesc = "The RK 95 TP is the Finnish answer to the Kalashnikov rifles.\nIt's as reliable as the AK rifles as well as having a number of improvements of its own.\nIt fires the large 7.62x39mm intermediate cartridge, meaning it packs quite a punch.\n\nAmmo: 7.62x39mm \nMagazine Capacity: 30"
ITEM.model = "models/weapons/world/rifles/rk95.mdl"
ITEM.class = "cw_rk95"
ITEM.weaponCategory = "primary"
ITEM.width = 4
ITEM.price = 25150
ITEM.height = 2
--ITEM.busflag = "ARMS2_3_1"
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_pbs1"}

ITEM.iconCam = {
	pos = Vector(-3.5, 27, -1),
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
						["Angles"] = Angle(0, 180, 180),
						["Model"] = "models/weapons/world/rifles/rk95.mdl",
						["ClassName"] = "model",
						["Position"] =	Vector(10.203, -4.154, -4.08),
						["EditorExpand"] = true,
						["UniqueID"] = "3547382491",
						["Bone"] = "spine 2",
						["Name"] = "rk95",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "10421523402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_rk95@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1118412183",
		["EditorExpand"] = true,
	},
},
}