ITEM.name = "HK G36C"
ITEM.description= "An assault rifle that fires 5.56x45mm rounds."
ITEM.longdesc = "This subcarbine model is a further development of the G36K.\nIt has a shorter barrel than the G36K, and a four-prong open-type flash hider.\nThe extremely short barrel forced designers to move the gas block closer to the muzzle end and reduce the length of the gas piston operating rod.\nThe handguard and stock were also shortened and the fixed carry handle (with optics) was replaced with a carrying handle with an integrated Picatinny rail.\n\nAmmo: 5.56x45mm \nMagazine Capacity: 30"
ITEM.model = "models/weapons/cw20_g36c.mdl"
ITEM.class = "cw_g36c"
ITEM.weaponCategory = "primary"
ITEM.width = 3
ITEM.price = 40000
ITEM.height = 2
--ITEM.busflag = "ARMS1_3_1"
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_saker","md_foregrip"}
ITEM.Range = 50
ITEM.RoF = "S/3/6"
ITEM.Dmg = "1d10+2"
ITEM.Pen = 12
ITEM.Mag = 30
ITEM.Rld = "Ready"
ITEM.Special = "Short"

ITEM.iconCam = {
	pos = Vector(-6.3000001907349, 22, 1.5),
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
						["Angles"] = Angle(71.319, -177.46875, -96.1875),
						["Position"] = Vector(-7.446, -3.087, 12.014),
						["Model"] = "models/weapons/cw20_g36c.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7809869091",
						["Bone"] = "chest",
						["Name"] = "g36c",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1237780642",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_g36c@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2784642348",
		["EditorExpand"] = true,
	},
},
}