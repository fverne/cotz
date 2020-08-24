ITEM.name = "Handheld Flashlight"
ITEM.description = "A sturdy flashlight used to light your way in the dark."
ITEM.model = "models/weapons/w_flashlight_zm.mdl"
ITEM.class = "weapon_flashlight"
ITEM.weaponCategory = "flashlight"

ITEM.price = 225
ITEM.height = 1
ITEM.width = 2

ITEM.category = nil
ITEM.canAttach = false
ITEM.repairCost = ITEM.price/100*1

ITEM.pacData = {
[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Angles"] = Angle(-21.944, 90.808, -173.845),
						["Position"] = Vector(-1.907, -11.458, -11.853),
						["Model"] = "models/weapons/w_flashlight_zm.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7979294673",
						["Bone"] = "pelvis",
						["Name"] = "binoculars",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1234486522",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "weapon_flashlight@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2212796348",
		["EditorExpand"] = true,
	},
},
}