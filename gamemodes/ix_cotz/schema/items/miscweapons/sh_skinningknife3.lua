ITEM.name = "Survival Knife"
ITEM.description = "A survival knife with a plastic handle."
ITEM.model = "models/bf4_sweps/w_knife_dive.mdl"
ITEM.longdesc = "This knife offers better poaching capabilities than most other knives, as it's meant for survival but lacks effect when used in combat."
ITEM.category = "Melee"

ITEM.price = 2950
ITEM.height = 1
ITEM.width = 2

ITEM.class = "tfa_nmrih_survivalknife"
ITEM.weaponCategory = "secondary"
ITEM.canAttach = false
ITEM.repairCost = ITEM.price/100*1

ITEM.weight = 0.950

ITEM.meattickets = 0
ITEM.parttickets = 0
ITEM.knifetier = 3
ITEM.isPoachKnife = true

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