ITEM.name = "Kitchen Knife"
ITEM.description = "An unsharpened cooking tool."
ITEM.model = "models/splatolivia/knife/knife.mdl"
ITEM.longdesc = "This old knife is in quite bad shape. The handle is rotten, and it rattles when you shake it."
ITEM.category = "Knife"

ITEM.price = 4250
ITEM.height = 1
ITEM.width = 2

ITEM.class = "tfa_nmrih_oldknife"
ITEM.weaponCategory = "knife"
ITEM.canAttach = false
ITEM.repairCost = ITEM.price/100*1

ITEM.weight = 0.450

ITEM.knifetier = 1
ITEM.isPoachKnife = true

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(20, 3, 0),
	ang = Angle(-180, 0, -180),
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
						["Model"] = "models/splatolivia/knife/knife.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "oldknife_1",
						["Bone"] = "pelvis",
						["Name"] = "bat",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "oldknife_2",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "tfa_nmrih_oldknife@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "oldknife_3",
		["EditorExpand"] = true,
	},
},
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Melee", Color(64, 224, 208))
	ix.util.PropertyDesc(tooltip, "Poaching Tool", Color(64, 224, 208))
end