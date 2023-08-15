ITEM.name = "Army Backpack"
ITEM.description = "An old army backpack. Features compartments for easy storage of your valuables."
ITEM.model = "models/backpack_vkbo/backpack_vkbo.mdl"

ITEM.price = 900
ITEM.width = 2
ITEM.height = 3
ITEM.weight = 1.150

ITEM.carryinc = 20
ITEM.outfitCategory = "backpack"

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-200, 0, 0),
	ang = Angle(-2.83, -0.11, 0),
	fov = 5.36
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
					["Position"] = Vector(-0.5, 0, -17),
					["UniqueID"] = "backpack_vkbo",
					-- ["Size"] = 0.85,
					["Bone"] = "chest",
					["Model"] = "models/backpack_vkbo/backpack_vkbo.mdl",
					["ClassName"] = "model",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "backpack_vkbo",
			["EditorExpand"] = true,
		},
	},
}