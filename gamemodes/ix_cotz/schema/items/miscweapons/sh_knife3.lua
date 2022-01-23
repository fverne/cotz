ITEM.name = "Survival Knife"
ITEM.description = "A survival knife with a plastic handle."
ITEM.model = "models/bf4_sweps/w_knife_dive.mdl"
ITEM.longdesc = "This knife offers better poaching capabilities than most other knives, as it's meant for survival but lacks effect when used in combat."
ITEM.category = "Melee"

ITEM.price = 53950
ITEM.height = 1
ITEM.width = 2

ITEM.class = "tfa_nmrih_survivalknife"
ITEM.weaponCategory = "knife"
ITEM.canAttach = false
ITEM.repairCost = ITEM.price/100*1

ITEM.weight = 1.150

ITEM.knifetier = 4
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
						["Model"] = "models/bf4_sweps/w_knife_dive.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "survivalknife_1",
						["Bone"] = "pelvis",
						["Name"] = "bat",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "survivalknife_1",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "tfa_nmrih_survivalknife@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "survivalknife_1",
		["EditorExpand"] = true,
	},
},
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Melee", Color(64, 224, 208))
	ix.util.PropertyDesc(tooltip, "Poaching Tool", Color(64, 224, 208))
end