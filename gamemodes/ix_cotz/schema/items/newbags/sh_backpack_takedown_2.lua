ITEM.name = "Large Sling Backpack (Black)"
ITEM.description = "An over-the-shoulder sling backpack. Features compartments for easy storage of your valuables."
ITEM.model = "models/backpack_takedown_sling/backpack_takedown_sling_b.mdl"

ITEM.price = 900
ITEM.width = 1
ITEM.height = 3
ITEM.weight = 1.350

ITEM.carryinc = 20
ITEM.outfitCategory = "Backpack"

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-200, 0, 0),
	ang = Angle(-4.28, 0.04, 0),
	fov = 3.27
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
							["ModelIndex"] = 1,
							-- ["UniqueID"] = "1679365203",
							["ClassName"] = "bodygroup",
							["OwnerName"] = "self",
							["BodyGroupName"] = "root",
						},
					},
				},
				["self"] = {
					["Position"] = Vector(-0.5, 0, -17),
					["UniqueID"] = "backpack_sling",
					-- ["Size"] = 0.85,
					["Bone"] = "chest",
					["Model"] = "models/backpack_takedown_sling/backpack_takedown_sling_b.mdl",
					["ClassName"] = "model",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "backpack_sling",
			["EditorExpand"] = true,
		},
	},
}