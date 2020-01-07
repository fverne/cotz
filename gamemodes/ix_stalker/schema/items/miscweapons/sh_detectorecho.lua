ITEM.name = "Artifact Detector (Echo)"
ITEM.description = "A low-tier artifact detector."
ITEM.longdesc = "This dated anomalous activity detector produces an alarm signal when anomalous particles enter a special chamber as you approach an anomaly. It can also register the presence of artifacts and measure the distance to the nearest one. The distance is indicated by the frequency of the sound the detector emits. To switch to artifact search mode, open the device's front cover. Due to its simple design, Echo can only be used to locate the most common artifacts."
ITEM.model = "models/kek1ch/dev_detector_1.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.price = 4000
ITEM.busflag = {"dev"}
ITEM.class = "detector_echo"
ITEM.weaponCategory = "beltbackleft"
ITEM.canAttach = false
ITEM.keepWhenEquipped = true
ITEM.repairCost = ITEM.price/100*1
ITEM.weight = 0.25
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
						["UniqueID"] = "3522654987",
						["EditorExpand"] = true,
						["Bone"] = "pelvis",
						["Model"] = "models/kali/miscstuff/stalker/detector_echo.mdl",
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