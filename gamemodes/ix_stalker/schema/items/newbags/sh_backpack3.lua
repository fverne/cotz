ITEM.name = "Modern Military Backpack (Russian)"
ITEM.description = "A backpack. Features compartments for easy storage of your valuables."
ITEM.width = 2
ITEM.height = 2
ITEM.invWidth = 5
ITEM.invHeight = 2
ITEM.busflag = {"backpacks"}
ITEM.price = 1500
ITEM.model = "models/kek1ch/sumka3.mdl"
ITEM.weaponCategory = "back"
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