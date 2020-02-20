ITEM.name = "M1917 Revolver"
ITEM.description= "A single-action variant of a revolver chambered for .45 ACP."
ITEM.longdesc = "The M1917 Revolvers are six-shot, .45 ACP, large frame revolvers adopted by the United States Military in 1917, to supplement the standard .45 ACP M1911 pistol during World War I.\n\nAmmo: .45 ACP\nMagazine Capacity: 6"
ITEM.model = ("models/khrcw2/doipack/w_sw1917.mdl")
ITEM.class = "cw_m1917"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price = 14000
ITEM.height = 1
--ITEM.busflag = {"ARMS2_1_1", "SPECIAL5"}
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_rmr","md_cobram2"}
ITEM.iconCam = {
	pos = Vector(-7, 12, 0),
	ang = Angle(0, 270, -5),
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
						["Model"] = "models/khrcw2/doipack/w_sw1917.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-7.5, 6.578, 0.844),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "33589648235",
						["Bone"] = "pelvis",
						["Name"] = "mr96",
						["Angles"] = Angle(0, 270, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "14862772682",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_m1917@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "19772895467",
		["EditorExpand"] = true,
	},
},
}