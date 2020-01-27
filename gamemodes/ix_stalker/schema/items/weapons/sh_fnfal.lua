ITEM.name = "FN FAL"
ITEM.description= "A battle rifle that fires 7.62x51mm rounds."
ITEM.longdesc = "Nicknamed ”The Right Arm of The Free World”, the FAL was a popular choice for revolutionaries and armies alike.\nIt earned it's reputation in various African wars as a heavy-hitting automatic rifle that could withstand the jungle's conditions.\n\nAmmo: 7.62x51mm\nMagazine Capacity: 20"
ITEM.model = "models/hgn/srp/weapons/w_rif_fnfal.mdl"
ITEM.class = "cw_fnfal"
ITEM.weaponCategory = "primary"
ITEM.width = 5
ITEM.price = 36000
ITEM.height = 2
--ITEM.busflag = "ARMS1_2_1_1"
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_saker","md_foregrip"}

ITEM.iconCam = {
	pos = Vector(-12, 32, 1.5),
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
						["Angles"] = Angle(74.219, -177.469, -108.987),
						["Position"] = Vector(-7.346, -3.587, 12.614),
						["Model"] = "models/hgn/srp/weapons/w_rif_fnfal.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "3327382291",
						["Bone"] = "chest",
						["Name"] = "fnfal",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1234640142",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_fnfal@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1120142348",
		["EditorExpand"] = true,
	},
},
}