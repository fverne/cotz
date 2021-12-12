ITEM.name = "Guitar"
ITEM.description = "An acoustic guitar."
ITEM.model = "models/lostsignalproject/items/misc/guitar.mdl"
ITEM.class = "guitar"
ITEM.weaponCategory = "primary"
ITEM.price = 500
--ITEM.busflag = {"MERCH3", "SPECIAL7_1"}
ITEM.busflag = {"hardware1_1"}
ITEM.height = 2
ITEM.width = 4
ITEM.category = nil
ITEM.repairCost = ITEM.price/100*1
ITEM.canAttach = false

ITEM.weight = 4.500

ITEM.exRender = true
ITEM.iconCam = {
	ang= Angle(90, 90, 0),
	fov= 12,
	pos= Vector(-10, 0, 200)
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
						["Angles"] = Angle(0, 180, -90),
						["Position"] = Vector(0, -2.932, -3.453),
						["Model"] = "models/lostsignalproject/items/misc/guitar.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7978994673",
						["Bone"] = "spine 2",
						["Name"] = "guitar",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1237790522",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "guitar@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2789796348",
		["EditorExpand"] = true,
	},
},
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Musical Instrument", Color(64, 224, 208))
end