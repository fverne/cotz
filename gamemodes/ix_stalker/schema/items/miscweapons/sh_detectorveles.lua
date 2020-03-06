ITEM.name = "Artifact Detector (Veles)"
ITEM.description = "A high-tier artifact detector"
ITEM.longdesc = "A next generation scientific detection scanner. Thanks to three modernized detection chambers, the position of artifacts is shown on a special display screen. When closed, the device registers only radiation and anomalies. To switch to artifact search mode, open the front LED display. When in search mode, the detector is capable of locating all artifacts known to science."
ITEM.model = "models/kek1ch/dev_detector_3.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.price = 32000
ITEM.busflag = {"dev"}
ITEM.class = "detector_veles"
ITEM.weaponCategory = "detectorslot"
ITEM.canAttach = false
ITEM.keepWhenEquipped = true
ITEM.repairCost = ITEM.price/100*1
ITEM.pacData = {
[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Angles"] = Angle(0, -90, -40),
						["Position"] = Vector(5.874, 3.09, 3.622),
						["UniqueID"] = "3333354987",
						["EditorExpand"] = true,
						["Bone"] = "pelvis",
						["Model"] = "models/kek1ch/dev_detector_3.mdl",
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