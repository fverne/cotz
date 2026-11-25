ITEM.name = "TOZ BM-16 Sawnoff"
ITEM.description= "A sawn-off hunting shotgun. Fires 12 gauge."
ITEM.longdesc = "This sawn-off double barrelled shotgun is a must-have in many rookies eyes.\nIt dispatches mutants and unarmored stalkers with ease, and is cheap to keep supplied with ammo."
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_bm16_w.mdl"
ITEM.class = "cw_cotz_anomaly_toz66short"
ITEM.category = "Anomaly Reskins"
ITEM.noBusiness = true
ITEM.weaponCategory = "primary"
ITEM.price = 4400
ITEM.width = 3
ITEM.height = 1
ITEM.canAttach = false

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 1.54




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(4.7, -205, 3.8),
	ang = Angle(0, 90, 0),
	fov = 5.4,
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
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_bm16_w.mdl",
						["ClassName"] = "model",
						["Translucent"] = true,
						["Position"] = Vector(9.6, -2.93, -4.8),
						["EditorExpand"] = true,
						["UniqueID"] = "3976837955",
						["Bone"] = "spine 2",
						["Name"] = "toz66short",
						["Angles"] = Angle(0, 0, 180),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1643489682",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_cotz_anomaly_toz66short@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1954394367",
		["EditorExpand"] = true,
	},
},
}
