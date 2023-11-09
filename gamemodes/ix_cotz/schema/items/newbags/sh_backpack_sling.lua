ITEM.name = "Sling Backpack"
ITEM.description = "A compact over-the-shoulder sling backpack. Features compartments for easy storage of your valuables."
ITEM.model = "models/backpack_molle/backpack_molle.mdl"

ITEM.price = 900
ITEM.width = 1
ITEM.height = 2
ITEM.weight = 0.650

ITEM.carryinc = 10
ITEM.outfitCategory = "Backpack"

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-199.63, -12.21, 0),
	ang = Angle(-2.54, 3.86, 0),
	fov = 3.4
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
					["Position"] = Vector(-0.5, 0, -15),
					["UniqueID"] = "backpack_sling",
					-- ["Size"] = 0.85,
					["Bone"] = "chest",
					["Model"] = "models/backpack_molle/backpack_molle.mdl",
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