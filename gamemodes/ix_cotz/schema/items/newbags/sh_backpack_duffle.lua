ITEM.name = "Worn Sportsbag"
ITEM.description = "An old sportsbag. Features compartments for easy storage of your valuables."
ITEM.model = "models/backpack_sportbag/backpack_sportbag.mdl"

ITEM.price = 900
ITEM.width = 3
ITEM.height = 2
ITEM.weight = 0.650

ITEM.carryinc = 10
ITEM.outfitCategory = "Backpack"

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-200, 0, 0),
	ang = Angle(-1.68, -0.14, 0),
	fov = 6.71
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
					["Position"] = Vector(-0.5, 0, -14),
					["UniqueID"] = "backpack_duffle_1",
					-- ["Size"] = 0.85,
					["Bone"] = "chest",
					["Model"] = "models/backpack_sportbag/backpack_sportbag.mdl",
					["ClassName"] = "model",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "backpack_duffle_1",
			["EditorExpand"] = true,
		},
	},
}