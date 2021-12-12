ITEM.name = "Crowbar"
ITEM.description = "A crowbar for prying open objects."
ITEM.model = "models/weapons/tfa_nmrih/w_me_crowbar.mdl"
ITEM.class = "tfa_nmrih_crowbar"
ITEM.weaponCategory = "secondary"
ITEM.price = 350
ITEM.busflag = {"melee"}
ITEM.height = 1
ITEM.width = 3
ITEM.category = "Melee"
ITEM.canAttach = false
ITEM.repairCost = ITEM.price/100*1

ITEM.weight = 3.620

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 23, -2),
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
						["Position"] = Vector(-7.366, 6.884, 6.301),
						["Model"] = "models/weapons/tfa_nmrih/w_me_crowbar.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7878994673",
						["Bone"] = "chest",
						["Name"] = "crowbar",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1122770522",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "tfa_nmrih_crowbar@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2659376348",
		["EditorExpand"] = true,
	},
},
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Melee", Color(64, 224, 208))
end