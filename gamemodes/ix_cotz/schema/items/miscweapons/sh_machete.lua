ITEM.name = "Machete"
ITEM.description = "A machete made for cutting."
ITEM.model = "models/weapons/tfa_nmrih/w_me_machete.mdl"
ITEM.class = "tfa_nmrih_machete"
ITEM.weaponCategory = "secondary"
ITEM.price = 600
ITEM.busflag = {"melee"}
ITEM.height = 1
ITEM.width = 3
ITEM.category = "Melee"
ITEM.repairCost = ITEM.price/100*1
ITEM.canAttach = false

ITEM.weight = 0.800

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 34, 0),
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
						["Position"] = Vector(-7.366, 6.884, 6.301),
						["Model"] = "models/weapons/tfa_nmrih/w_me_machete.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "0087994673",
						["Bone"] = "chest",
						["Name"] = "machete",
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
				["Arguments"] = "tfa_nmrih_machete@@0",
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