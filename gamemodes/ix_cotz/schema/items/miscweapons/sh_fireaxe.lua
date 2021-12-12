ITEM.name = "Fireaxe"
ITEM.description = "A simple fireaxe."
ITEM.model = "models/weapons/tfa_nmrih/w_me_axe_fire.mdl"
ITEM.class = "tfa_nmrih_fireaxe"
ITEM.weaponCategory = "primary"
ITEM.price = 900
ITEM.busflag = {"melee1"}
ITEM.height = 1
ITEM.width = 4
ITEM.category = "Melee"
ITEM.repairCost = ITEM.price/100*1
ITEM.canAttach = false
ITEM.exRender = true

ITEM.weight = 3.200

ITEM.iconCam = {
	pos = Vector(0, 31, 0),
	ang = Angle(0, 270, -90),
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
						["Position"] = Vector(-7.244, -7.084, -0.487),
						["Model"] = "models/weapons/tfa_nmrih/w_me_axe_fire.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7121284673",
						["Bone"] = "chest",
						["Name"] = "fireaxe",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1288710522",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "tfa_nmrih_fireaxe@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2787076348",
		["EditorExpand"] = true,
	},
},
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Melee", Color(64, 224, 208))
end