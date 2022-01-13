ITEM.name = "Artifact Detector (Bear)"
ITEM.description = "A mid-tier artifact detector."
ITEM.longdesc = "This last generation anomalous activity detector can be used to locate anomalous formations and has a color diode panel, which not only indicates the direction of artifacts, but also measures the distance to them. To switch to artifact search mode, open the device's front cover. Unfortunately, the device is programmed with a somewhat outdated list of detectable artifacts."
ITEM.model = "models/lostsignalproject/items/devices/detector_bear.mdl"
ITEM.width = 1
ITEM.height = 2
ITEM.price = 16000
ITEM.busflag = {"dev"}
ITEM.class = "detector_bear"
ITEM.weaponCategory = "artifactdetector"
ITEM.canAttach = false
ITEM.keepWhenEquipped = true
ITEM.repairCost = ITEM.price/100*1

ITEM.weight = 0.620

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
						["UniqueID"] = "3522654444",
						["EditorExpand"] = true,
						["Bone"] = "pelvis",
						["Model"] = "models/lostsignalproject/items/devices/detector_bear.mdl",
						["ClassName"] = "model",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1014448042",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "detector_bear@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1144122877",
		["EditorExpand"] = true,
	},
},
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Mid-Tier Artifact Detector", Color(64, 224, 208))
end