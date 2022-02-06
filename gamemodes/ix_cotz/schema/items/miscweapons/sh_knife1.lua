ITEM.name = "Sharpened Rebar"
ITEM.description = "A homemade stabbing tool."
ITEM.model = "models/bf4_sweps/w_knife_shank.mdl"
ITEM.longdesc = "The knife seems to be in poor condition, and doesn't offer much in terms of cutting capabilites, but one of the sides have been sharpened slightly to compensate."
ITEM.category = "Knife"

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
						["Angles"] = Angle(0.68343126773834, 77.647407531738, 93.750434875488),
						["Position"] = Vector(4.8173828125, 0.873046875, -4.857421875),
						["Model"] = "models/bf4_sweps/w_knife_shank.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "shankknife_1",
						["Bone"] = "right thigh",
						["Name"] = "shank knife",
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