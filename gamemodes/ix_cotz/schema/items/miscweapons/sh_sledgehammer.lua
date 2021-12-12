ITEM.name = "Sledgehammer"
ITEM.description = "A Sledgehammer for use in demolition."
ITEM.model = "models/weapons/tfa_nmrih/w_me_sledge.mdl"
ITEM.class = "tfa_nmrih_sledge"
ITEM.weaponCategory = "primary"
ITEM.price = 700
ITEM.busflag = {"melee1"}
ITEM.height = 1
ITEM.width = 4
ITEM.category = "Melee"
ITEM.repairCost = ITEM.price/100*1
ITEM.canAttach = false

ITEM.weight = 8.000

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-0.30000001192093, 45, 3),
	ang = Angle(0, 270, -90),
	fov = 45,
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
						["Position"] = Vector(-6.557, -7.391, 6.482),
						["Model"] = "models/weapons/tfa_nmrih/w_me_sledge.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "0087994673",
						["Bone"] = "chest",
						["Name"] = "sledgehammer",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "0088770522",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "tfa_nmrih_sledge@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2990076348",
		["EditorExpand"] = true,
	},
},
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Melee", Color(64, 224, 208))
end