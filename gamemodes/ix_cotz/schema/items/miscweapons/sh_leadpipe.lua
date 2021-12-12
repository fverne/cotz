ITEM.name = "Lead Pipe"
ITEM.description = "A pipe for use in plumbering."
ITEM.model = "models/weapons/tfa_nmrih/w_me_pipe_lead.mdl"
ITEM.class = "tfa_nmrih_lpipe"
ITEM.weaponCategory = "secondary"
ITEM.price = 400
ITEM.busflag = {"melee"}
ITEM.height = 1
ITEM.width = 3
ITEM.category = "Melee"
ITEM.repairCost = ITEM.price/100*1
ITEM.canAttach = false

ITEM.weight = 1.500

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0.40000000596046, 33, 0),
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
						["Model"] = "models/weapons/tfa_nmrih/w_me_pipe_lead.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7121286473",
						["Bone"] = "chest",
						["Name"] = "leadpipe",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1288750122",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "tfa_nmrih_lpipe@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2787036748",
		["EditorExpand"] = true,
	},
},
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Melee", Color(64, 224, 208))
end