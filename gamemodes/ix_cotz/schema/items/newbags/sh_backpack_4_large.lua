ITEM.name = "Large Zone Survival Backpack"
ITEM.description = "A large backpack. Featuring large compartments for storage of items, as well as being very comfortable."
ITEM.longdesc = "The expanded body suits someone who plans to be away from the camp table for a while. Mud has"
	.. " settled into the stitching near the base, where it is hardest to brush away."
ITEM.model = "models/kek1ch/sumka4.mdl"

ITEM.price = 32500
ITEM.width = 2
ITEM.height = 2
ITEM.weight = 1.550

ITEM.carryinc = 30
ITEM.outfitCategory = "Backpack"

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(1, 0, 200),
	ang = Angle(90, 0, 180),
	fov = 7.6
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
					["UniqueID"] = "backpack_misery4xd",
					["Size"] = 1,
					["Bone"] = "chest",
					["Model"] = "models/kek1ch/sumka4.mdl",
					["ClassName"] = "model",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "backpack_misery4large",
			["EditorExpand"] = true,
		},
	},
}