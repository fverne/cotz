ITEM.name = "Large School Backpack"
ITEM.description = "A backpack meant for civilian purposes. Features compartments for easy storage of your valuables."
ITEM.model = "models/backpack_redfox/backpack_redfox.mdl"

ITEM.price = 900
ITEM.width = 2
ITEM.height = 3
ITEM.weight = 0.820

ITEM.carryinc = 15
ITEM.outfitCategory = "Backpack"

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-733.82, 2.55, -17.14),
	ang = Angle(-2.12, 359.78, 0),
	fov = 1.27
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
					["Position"] = Vector(-0.5, 0, -12),
					["UniqueID"] = "backpack_school_2",
					-- ["Size"] = 0.85,
					["Bone"] = "chest",
					["Model"] = "models/backpack_redfox/backpack_redfox.mdl",
					["ClassName"] = "model",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "backpack_school_2",
			["EditorExpand"] = true,
		},
	},
}