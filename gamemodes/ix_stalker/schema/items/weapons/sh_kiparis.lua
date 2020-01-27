ITEM.name = "OTs-02 Kiparis"
ITEM.description= "A submachinegun with a folded stock. Fires 9x18mm."
ITEM.longdesc = "A russian submachinegun, the OTS-02 is a blowback-operated weapon of a conventional design chambered in 9×18mm Makarov.\n\nAmmo: 9x18mm\nMagazine Capacity: 30"
ITEM.model = ("models/weapons/w_smg_skorp.mdl")
ITEM.class = "cw_kiparis"
ITEM.weaponCategory = "primary"
ITEM.width = 2
ITEM.price = 6300
ITEM.height = 2
ITEM.busflag = {"guns1_1_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_tundra9mm"}

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
						["Model"] = "models/weapons/w_smg_skorp.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8544325421",
						["Bone"] = "chest",
						["Name"] = "kiparis",
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
				["Arguments"] = "cw_kiparis@@0",
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