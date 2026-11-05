ITEM.name = "MBSS Backpack"
ITEM.description = "An extra durable backpack. Features compartments for easy storage of your valuables."
ITEM.longdesc = "The MBSS uses a compact, durable field-pack body to keep a useful load close to the back. Its proportions are taller than a small shoulder bag without reaching the bulk of a large survival pack. Several compartments give everyday equipment a more manageable arrangement."
ITEM.model = "models/backpack_baselard/backpack_baselard.mdl"

ITEM.price = 900
ITEM.width = 2
ITEM.height = 3
ITEM.weight = 0.950

ITEM.carryinc = 18
ITEM.outfitCategory = "Backpack"

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-200, 0, 0),
	ang = Angle(-2.6, -0.04, 0),
	fov = 4.23
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
					["UniqueID"] = "backpack_mbss",
					-- ["Size"] = 0.85,
					["Bone"] = "chest",
					["Model"] = "models/backpack_baselard/backpack_baselard.mdl",
					["ClassName"] = "model",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "backpack_mbss",
			["EditorExpand"] = true,
		},
	},
}