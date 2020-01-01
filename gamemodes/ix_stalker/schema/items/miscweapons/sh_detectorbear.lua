ITEM.name = "Artifact Detector (Bear)"
ITEM.description = "A mid-tier artifact detector."
ITEM.longdesc = "This last generation anomalous activity detector can be used to locate anomalous formations and has a color diode panel, which not only indicates the direction of artifacts, but also measures the distance to them. To switch to artifact search mode, open the device's front cover. Unfortunately, the device is programmed with a somewhat outdated list of detectable artifacts."
ITEM.model = "models/kek1ch/dev_detector_2.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.price = 12000
ITEM.busflag = {"dev"}
ITEM.class = "detector_bear"
ITEM.weaponCategory = "beltbackleft"
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
						["Angles"] = Angle(-8.2, 94, 150),
						["Position"] = Vector(3.9, 1.38, -8.027734375),
						["UniqueID"] = "3522654444",
						["EditorExpand"] = true,
						["Bone"] = "pelvis",
						["Model"] = "models/kali/miscstuff/stalker/detector_bear.mdl",
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