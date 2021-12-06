ITEM.name = "Large Modern Military Backpack (USA)"
ITEM.description = "A large backpack. Features compartments for easy storage of your valuables."
ITEM.model = "models/kek1ch/sumka2.mdl"

ITEM.price = 13500
ITEM.width = 2
ITEM.height = 2
ITEM.weight = 1.250

ITEM.carryinc = 20
ITEM.outfitCategory = "backpack"

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, -1, 200),
	ang = Angle(90, 0, 90),
	fov = 5.7
}

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
				},
				["self"] = {
				["Angles"] = Angle(180, -90.013, 90.004),
				["Position"] = Vector(-6.607, 0.035, -0.598),
					["UniqueID"] = "backpack_misery2xd",
					["Size"] = 1,
					["Bone"] = "chest",
					["Model"] = "models/kek1ch/sumka2.mdl",
					["ClassName"] = "model",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "backpack_misery2large",
			["EditorExpand"] = true,
		},
	},
}