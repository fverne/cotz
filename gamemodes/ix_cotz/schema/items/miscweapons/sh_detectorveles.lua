ITEM.name = "Artifact Detector (Veles)"
ITEM.description = "A high-tier artifact detector"
ITEM.longdesc = "A next generation scientific detection scanner. Thanks to three modernized detection chambers, the position of artifacts is shown on a special display screen. When closed, the device registers only radiation and anomalies. To switch to artifact search mode, open the front LED display. When in search mode, the detector is capable of locating all artifacts known to science."
ITEM.model = "models/lostsignalproject/items/devices/detector_veles.mdl"
ITEM.width = 1
ITEM.height = 2
ITEM.price = 55000
ITEM.busflag = {"dev"}
ITEM.class = "detector_veles"
ITEM.weaponCategory = "artifactdetector"
ITEM.canAttach = false
ITEM.keepWhenEquipped = true
ITEM.repairCost = ITEM.price/100*1

ITEM.weight = 0.900

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
						["UniqueID"] = "3333354987",
						["EditorExpand"] = true,
						["Bone"] = "pelvis",
						["Model"] = "models/lostsignalproject/items/devices/detector_veles.mdl",
						["ClassName"] = "model",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1016144242",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "detector_veles@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1222222877",
		["EditorExpand"] = true,
	},
},
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "High-Tier Artifact Detector", Color(64, 224, 208))
end