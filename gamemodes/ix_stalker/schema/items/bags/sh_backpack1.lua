ITEM.name = "Modern Military Backpack (Ukranian)"
ITEM.description = "A backpack. Features compartments for easy storage of your valuables."
ITEM.width = 2
ITEM.height = 2
ITEM.invWidth = 5
ITEM.invHeight = 2
ITEM.busflag = {"backpacks"}
ITEM.price = 1500
ITEM.model = "models/kek1ch/sumka1.mdl"
ITEM.weaponCategory = "back"
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