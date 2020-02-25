ITEM.name = "Sterling"
ITEM.description= "A submachinegun chambered for 9x19mm."
ITEM.longdesc = "The Sterling was taken into service as a replacement for the Sten gun roughly ten years after World War II ended. \nIt's built entirely out of metal and plastic and has a folding stock underneath the reciever. While being a slow weapon with 550 RPM, this helps to fire full-auto with ease and high accuracy. \nA suppressor can be mounted which greatly decreases the sound level.\n\nAmmo: 9x19mm \nMagazine Capacity: 32"
ITEM.model = ("models/weapons/b_sterling.mdl")
ITEM.class = "cw_sterling"
ITEM.weaponCategory = "primary"
ITEM.price = 9600
ITEM.width = 3
ITEM.height = 1
ITEM.busflag = {"guns3_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_tundra9mm"}

ITEM.iconCam = {
	pos = Vector(200, -8, -3),
	ang = Angle(180, -0, 180),
	fov = 9,
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
						["Angles"] = Angle(-8.912, 96.435, -164.117),
						["Position"] = Vector(-12.767, -4.922, -5.399),
						["Model"] = "models/weapons/b_sterling.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8883938491",
						["Bone"] = "chest",
						["Name"] = "sterling",
						["AngleOffset"] = Angle(0, 0, 90),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1044336402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_sterling@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8134421183",
		["EditorExpand"] = true,
	},
},
}