ITEM.name = "Exoskeleton"
ITEM.description = "An exoskeleton frame with servomotors"
ITEM.longdesc = "State of the art full body active exoskeleton system, 3rd generation, of unknown origin. The servos limit the speed and precision of movements, but effectively ease the load from the user and multiply his physical strength by a factor of two."
ITEM.model = "models/shtokerbox/ground_outfit_exoskeleton.mdl"

ITEM.price = 100000 -- TODO: Put something here
ITEM.width = 3
ITEM.height = 3
ITEM.weight = 4.820

ITEM.carryinc = 50
ITEM.outfitCategory = "Exoskeleton"

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, -1, 200),
	ang = Angle(90, 90, 0),
	fov = 11.41
}



ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
				},
				["self"] = {
					["UniqueID"] = "exoskeleton1_1",
					["Skin"] = 8,
					["BoneMerge"] = true,
					["Model"] = "models/shtokerbox/outfits/male_outfit_sunrise_overlay_exo.mdl",
					["ClassName"] = "model",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "exoskeleton1",
			["EditorExpand"] = true,
		},
	},
}