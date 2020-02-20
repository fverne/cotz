ITEM.name = "FAMAS"
ITEM.description= "A black bull-pup assault rifle. Fires 5.56x45mm."
ITEM.longdesc = "The FAMAS is the French army's service rifle, one of the more well-known bullpup designs. It has a large carrying handle with scope attachment slots. \nThis one is the older F1 variant, denoted by the straight magazine and a lack of an extended handguard. It's a very fast rifle at 1000 RPM and has thus found it's use in close quarters faction combat.\n\nAmmo: 5.56x45mm \nMagazine Capacity: 25"
ITEM.model = "models/weapons/w_rif_famas.mdl"
ITEM.class = "cw_famas"
ITEM.weaponCategory = "primary"
ITEM.width = 3
ITEM.price = 23700
ITEM.height = 2
--ITEM.busflag = "ARMS1_3_1"
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_saker"}

ITEM.iconCam = {
	pos = Vector(6, 27.5, 7),
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
						["Angles"] = Angle(180, 0, 0),
						["Position"] = Vector(2.141, -4.444, 2.193),
						["Model"] = "models/weapons/w_rif_famas.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7809869952",
						["Bone"] = "spine 2",
						["Name"] = "famas",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1327780001",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_famas@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2748642348",
		["EditorExpand"] = true,
	},
},
}