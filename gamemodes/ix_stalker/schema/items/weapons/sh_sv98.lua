ITEM.name = "SV-98"
ITEM.description= "A Russian sniper rifle. Fires 7.62x54mm."
ITEM.longdesc = "The SV-98 is a Russian-made sniper rifle that was based on a civillian sport shooting rifle by Izhmash. \nAccording to the manufacturer, the rifle can be used to engage targets up to 1000 meters. But that requires match ammunition, which is hard to find in the Zone. \nIt weighs about 5.8 kilograms without a sight or suppressor.\n\nAmmo: 7.62x54mm \nMagazine Capacity: 10"
ITEM.model = ("models/weapons/w_sv98_scopeless.mdl")
ITEM.class = "cw_sv98"
ITEM.weaponCategory = "primary"
ITEM.price = 48500
ITEM.width = 6
ITEM.height = 1
--ITEM.busflag = "ARMS2_4_1_1"
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_nightforce_nxs","md_reflex","md_saker","md_foregrip"}

ITEM.iconCam = {
	pos = Vector(0, 200, 0),
	ang = Angle(0, 270, 0),
	fov = 15,
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
						["Angles"] = Angle(-74.107, -0.518, 112.847),
						["Position"] = Vector(-10.008, -3.559, -0.159),
						["Model"] = "models/weapons/w_sv98_scopeless.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8544253421",
						["Bone"] = "chest",
						["Name"] = "sv98",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1234444222",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_sv98@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8412651483",
		["EditorExpand"] = true,
	},
},
}