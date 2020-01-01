ITEM.name = "Guitar"
ITEM.description = "An acoustic guitar."
ITEM.model = "models/custom/guitar/m_d_45.mdl"
ITEM.class = "guitar"
ITEM.weaponCategory = "primary"
ITEM.price = 500
--ITEM.busflag = {"MERCH3", "SPECIAL7_1"}
ITEM.busflag = {"hardware1_1"}
ITEM.height = 2
ITEM.width = 4
ITEM.category = nil
ITEM.repairCost = ITEM.price/100*1
ITEM.canAttach = false
ITEM.iconCam = {
	ang= Angle(-0.70499622821808, 268.25439453125, 90),
	fov= 16.085652091515,
	pos= Vector(8, 200, 22)
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
						["Angles"] = Angle(-28.537, 90, -173.5),
						["Position"] = Vector(-10.705, -7.085, 15.227),
						["Model"] = "models/custom/guitar/m_d_45.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7978994673",
						["Bone"] = "chest",
						["Name"] = "guitar",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1237790522",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "guitar@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2789796348",
		["EditorExpand"] = true,
	},
},
}