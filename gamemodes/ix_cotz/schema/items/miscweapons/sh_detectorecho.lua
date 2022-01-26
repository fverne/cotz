ITEM.name = "Artifact Detector (Echo)"
ITEM.description = "A low-tier artifact detector."
ITEM.longdesc = "This dated anomalous activity detector produces an alarm signal when anomalous particles enter a special chamber as you approach an anomaly. It can also register the presence of artifacts and measure the distance to the nearest one. The distance is indicated by the frequency of the sound the detector emits. To switch to artifact search mode, open the device's front cover. Due to its simple design, Echo can only be used to locate the most common artifacts."
ITEM.model = "models/lostsignalproject/items/devices/detector_echo.mdl"
ITEM.width = 1
ITEM.height = 2
ITEM.price = 6000
ITEM.busflag = {"dev"}
ITEM.class = "detector_echo"
ITEM.weaponCategory = "artifactdetector"
ITEM.canAttach = false
ITEM.keepWhenEquipped = true
ITEM.repairCost = ITEM.price/100*1

ITEM.weight = 0.300

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-1, 0, 20),
	ang = Angle(90, 0, 0),
	fov = 15,
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
						["Angles"] = Angle(2.544, 93.658, 25.026),
						["Position"] = Vector(5.145, 3.09, 3.893),
						["UniqueID"] = "3522654987",
						["EditorExpand"] = true,
						["Bone"] = "pelvis",
						["Model"] = "models/lostsignalproject/items/devices/detector_echo.mdl",
						["ClassName"] = "model",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1016198042",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "detector_echo@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1118122877",
		["EditorExpand"] = true,
	},
},
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Low-Tier Artifact Detector", Color(64, 224, 208))
end