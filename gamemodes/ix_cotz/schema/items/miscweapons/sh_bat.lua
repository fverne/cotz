ITEM.name = "Bat"
ITEM.description = "A baseball bat."
ITEM.model = "models/weapons/tfa_nmrih/w_me_bat_metal.mdl"
ITEM.longdesc = "A worn aluminium bat, with several dents in it. The leather wrapping around the handle is torn in several places."
ITEM.category = "Melee"

ITEM.price = 450
ITEM.height = 1
ITEM.width = 3

ITEM.class = "tfa_nmrih_bat"
ITEM.weaponCategory = "secondary"
ITEM.canAttach = false
ITEM.repairCost = ITEM.price/100*1

ITEM.weight = 0.950

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-23, 0, 5),
	ang = Angle(0, -0, -90),
	fov = 70
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
						["Angles"] = Angle(0.719, 93.188, -174.281),
						["Position"] = Vector(-7.366, 6.884, 6.301),
						["Model"] = "models/weapons/tfa_nmrih/w_me_bat_metal.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7777994673",
						["Bone"] = "chest",
						["Name"] = "bat",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1237770522",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "tfa_nmrih_bat@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2789376348",
		["EditorExpand"] = true,
	},
},
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Melee", Color(64, 224, 208))
end