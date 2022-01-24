ITEM.name = "Sharpened Rebar"
ITEM.description = "A homemade stabbing tool."
ITEM.model = "models/bf4_sweps/w_knife_shank.mdl"
ITEM.longdesc = "The knife seems to be in poor condition, and doesn't offer much in terms of cutting capabilites, but one of the sides have been sharpened slightly to compensate."
ITEM.category = "Melee"

ITEM.price = 450
ITEM.height = 1
ITEM.width = 2

ITEM.class = "tfa_nmrih_shankknife"
ITEM.weaponCategory = "knife"
ITEM.canAttach = false
ITEM.repairCost = ITEM.price/100*1

ITEM.weight = 0.850

ITEM.knifetier = 0
ITEM.isPoachKnife = true

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 22, 5),
	ang = Angle(0, 270, -115.29412078857),
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
						["Model"] = "models/bf4_sweps/w_knife_shank.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "shankknife_1",
						["Bone"] = "pelvis",
						["Name"] = "bat",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "shankknife_2",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "tfa_nmrih_shankknife@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "shankknife_3",
		["EditorExpand"] = true,
	},
},
}

function ITEM:PopulateTooltipIndividual(tooltip)
	ix.util.PropertyDesc(tooltip, "Melee", Color(64, 224, 208))
	ix.util.PropertyDesc(tooltip, "Poaching Tool", Color(64, 224, 208))
end