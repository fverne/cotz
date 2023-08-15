ITEM.name = "Pilgrim Backpack"
ITEM.description = "A backpack made for people finding themselves in the east. Features compartments for easy storage of your valuables."
ITEM.model = "models/backpack_pilgrim/backpack_pilgrim.mdl"

ITEM.price = 900
ITEM.width = 2
ITEM.height = 3
ITEM.weight = 2.300

ITEM.carryinc = 25
ITEM.outfitCategory = "backpack"

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-200, 0, 0),
	ang = Angle(-4.29, 0.03, 0),
	fov = 6.22
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
					["UniqueID"] = "backpack_pilgrim",
					-- ["Size"] = 0.85,
					["Bone"] = "chest",
					["Model"] = "models/backpack_pilgrim/backpack_pilgrim.mdl",
					["ClassName"] = "model",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "backpack_pilgrim",
			["EditorExpand"] = true,
		},
	},
}