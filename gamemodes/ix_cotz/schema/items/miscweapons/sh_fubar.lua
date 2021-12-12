ITEM.name = "FUBar"
ITEM.description = "A Functional Utility Bar for heavy demolition work."
ITEM.model = "models/weapons/tfa_nmrih/w_me_fubar.mdl"
ITEM.class = "tfa_nmrih_fubar"
ITEM.weaponCategory = "primary"
ITEM.price = 2500
ITEM.busflag = {"melee1"}
ITEM.height = 1
ITEM.width = 4
ITEM.category = "Melee"
ITEM.repairCost = ITEM.price/100*1
ITEM.canAttach = false

ITEM.weight = 4.080

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(3.7999999523163, 52.287582397461, 4.3000001907349),
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
						["Position"] = Vector(-6.38, -10.539, 6.522),
						["Model"] = "models/weapons/tfa_nmrih/w_me_fubar.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7778884673",
						["Bone"] = "chest",
						["Name"] = "fubar",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1288870522",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "tfa_nmrih_fubar@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2777776348",
		["EditorExpand"] = true,
	},
},
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Melee", Color(64, 224, 208))
end