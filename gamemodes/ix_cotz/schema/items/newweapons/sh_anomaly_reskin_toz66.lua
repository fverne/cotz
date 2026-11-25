ITEM.name = "TOZ-66"
ITEM.description= "A break-action hunting shotgun firing 12 gauge shells."
ITEM.longdesc = "A double barrel hunting shotgun, a classic Russian design popular with hunters and loners alike.\nThe cheap price and long barrel makes it useful for engaging animals and unarmed targets at ranges up to fifty meters.\nThe side-by-side barrels makes the weapon simpler built compared to the TOZ, but the sights are not aligned to both barrels."
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_bm16_full_w.mdl"

ITEM.width = 5
ITEM.height = 1
ITEM.price = 7900

ITEM.class = "cw_cotz_anomaly_toz66"
ITEM.category = "Anomaly Reskins"
ITEM.noBusiness = true
ITEM.weaponCategory = "primary"

ITEM.canAttach = false

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 3.2




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(8.5, -205, 2.5),
	ang = Angle(0, 90, 0),
	fov = 11.7,
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
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_bm16_full_w.mdl",
						["ClassName"] = "model",
						["Translucent"] = true,
						["Angles"] = Angle(0, 0, 180),
						["Position"] = Vector(12.7, -4.75, -2.4),
						["EditorExpand"] = true,
						["UniqueID"] = "3552126135",
						["Bone"] = "spine 2",
						["Name"] = "toz66",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1616512402",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_cotz_anomaly_toz66@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1980937684",
		["EditorExpand"] = true,
	},
},
}
