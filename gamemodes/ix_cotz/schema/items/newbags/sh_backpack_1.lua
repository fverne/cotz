ITEM.name = "Modern Military Backpack (Ukrainian)"
ITEM.description = "A backpack. Features compartments for easy storage of your valuables."
ITEM.longdesc = "The Ukrainian military pack separates a main load from smaller compartments for frequently needed belongings. Broad straps carry the bag against the back instead of leaving its weight on a hand. Its practical military layout is as useful to an ordinary traveller as to a soldier."
ITEM.model = "models/kek1ch/sumka1.mdl"

ITEM.price = 900
ITEM.width = 2
ITEM.height = 2
ITEM.weight = 1.150

ITEM.carryinc = 22
ITEM.outfitCategory = "Backpack"

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, -90),
	fov = 4.9
}

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
				},
				["self"] = {
				["Angles"] = Angle(0, -90.013, 90.004),
				["Position"] = Vector(-7.939, 0.021, 1.611),
					["UniqueID"] = "backpack_misery1xd",
					["Size"] = 0.85,
					["Bone"] = "chest",
					["Model"] = "models/kek1ch/sumka1.mdl",
					["ClassName"] = "model",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "backpack_misery1",
			["EditorExpand"] = true,
		},
	},
}