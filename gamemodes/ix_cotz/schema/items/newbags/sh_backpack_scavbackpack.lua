ITEM.name = "MBSS Backpack (Upgraded)"
ITEM.description = "An extra durable backpack. This backpack has been outfitted with extra survival gear. Features compartments for easy storage of your valuables."
ITEM.model = "models/backpack_baselardwild/backpack_baselardwild.mdl"

ITEM.price = 900
ITEM.width = 2
ITEM.height = 3
ITEM.weight = 1.070

ITEM.carryinc = 25
ITEM.outfitCategory = "backpack"

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-200, 0, 0),
	ang = Angle(-3.63, 0.3, 0),
	fov = 5.54
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
							["ModelIndex"] = 2,
							-- ["UniqueID"] = "1679365203",
							["ClassName"] = "bodygroup",
							["OwnerName"] = "self",
							["BodyGroupName"] = "root",
						},
					},
				},
				["self"] = {
					["Position"] = Vector(-0.5, 0, -19),
					["UniqueID"] = "backpack_mbsswild",
					-- ["Size"] = 0.85,
					["Bone"] = "chest",
					["Model"] = "models/backpack_baselardwild/backpack_baselardwild.mdl",
					["ClassName"] = "model",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "backpack_mbsswild",
			["EditorExpand"] = true,
		},
	},
}