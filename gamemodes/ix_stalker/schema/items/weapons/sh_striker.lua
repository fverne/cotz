ITEM.name = "Striker"
ITEM.description= "A revolver-magazine fed shotgun. 12 gauge."
ITEM.longdesc = "The Striker-12 is an unique shotgun, as it is fed by a permanently attached revolver magazine.\nWhile being an effective tool in combat and priceless for mutant hunting, it's unwieldy and has a non-adjustible stock.\nThe drum has to be manually winded up, each shell has to be manually ejected and it features a very janky trigger.\n\nAmmo: 12 Gauge\nMagazine Capacity: 12"
ITEM.model = ("models/weapons/w_shot_strike.mdl")
ITEM.class = "cw_striker"
ITEM.weaponCategory = "primary"
ITEM.width = 3
ITEM.price = 33900
ITEM.height = 2
--ITEM.busflag = "ARMS1_2_1_1"
ITEM.repairCost = ITEM.price/100*1

ITEM.canAttach = false
ITEM.iconCam = {
	pos = Vector(-1, 15, -1),
	ang = Angle(0, 270, 0),
	fov = 70
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
						["Angles"] = Angle(74.21875, -177.46875, -96.1875),
						["Position"] = Vector(-11.065, -5.617, 0.194),
						["Model"] = "models/weapons/w_shot_strike.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8883923491",
						["Bone"] = "chest",
						["Name"] = "striker",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1065346402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_striker@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8137397183",
		["EditorExpand"] = true,
	},
},
}