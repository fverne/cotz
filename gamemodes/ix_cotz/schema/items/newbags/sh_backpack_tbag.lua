ITEM.name = "School Backpack"
ITEM.description = "A backpack meant for civilian purposes. Features compartments for easy storage of your valuables."
ITEM.longdesc = "The school backpack uses a familiar civilian arrangement of shoulder straps and fabric compartments. Its moderate carrying space is more suited to everyday belongings than a heavy military load. The ordinary design looks surprisingly at home among the personal possessions of a camp."
ITEM.model = "models/backpack_tactical/backpack_tactical.mdl"

ITEM.price = 900
ITEM.width = 2
ITEM.height = 2
ITEM.weight = 0.950

ITEM.carryinc = 12
ITEM.outfitCategory = "Backpack"

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-200, 0, 0),
	ang = Angle(-1.8, 0, 0),
	fov = 4.56
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
					["Position"] = Vector(-0.5, 0, -21),
					["UniqueID"] = "backpack_school",
					-- ["Size"] = 0.85,
					["Bone"] = "chest",
					["Model"] = "models/backpack_tactical/backpack_tactical.mdl",
					["ClassName"] = "model",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "backpack_school",
			["EditorExpand"] = true,
		},
	},
}