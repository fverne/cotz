ITEM.name = "Modern Military Backpack (Russian)"
ITEM.description = "A backpack. Features compartments for easy storage of your valuables."
ITEM.model = "models/kek1ch/sumka3.mdl"

ITEM.price = 1100
ITEM.width = 2
ITEM.height = 2
ITEM.weight = 1.070

ITEM.carryinc = 15
ITEM.outfitCategory = "backpack"

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-1, 0, 200),
	ang = Angle(90, 0, 180),
	fov = 7
}

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
				},
				["self"] = {
				["Angles"] = Angle(90, -90.016, 89.957),
				["Position"] = Vector(-6.333, 0.016, -1.611),
					["UniqueID"] = "backpack_misery3xd",
					["Size"] = 0.75,
					["Bone"] = "chest",
					["Model"] = "models/kek1ch/sumka3.mdl",
					["ClassName"] = "model",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "backpack_misery3",
			["EditorExpand"] = true,
		},
	},
}