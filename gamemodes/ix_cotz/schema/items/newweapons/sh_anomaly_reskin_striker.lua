ITEM.name = "Striker"
ITEM.description= "A revolver-magazine fed shotgun. 12 gauge."
ITEM.longdesc = "The Striker-12 is an unique shotgun, as it is fed by a permanently attached revolver magazine.\nWhile being an effective tool in combat and priceless for mutant hunting, it's unwieldy and has a non-adjustible stock.\nThe drum has to be manually winded up, each shell has to be manually ejected and it features a very janky trigger."
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_protecta_w.mdl"
ITEM.class = "cw_cotz_anomaly_striker"
ITEM.category = "Anomaly Reskins"
ITEM.noBusiness = true
ITEM.weaponCategory = "primary"
ITEM.price = 28900
ITEM.width = 3
ITEM.height = 1
ITEM.canAttach = false

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 4.2




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(2.6, -205, 4.6),
	ang = Angle(0, 90, 0),
	fov = 10.9,
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
						["Angles"] = Angle(0, 180, 180),
						["Position"] = Vector(5.922, -3.804, -4.465),
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_protecta_w.mdl",
						["ClassName"] = "model",
						["Translucent"] = true,
						["EditorExpand"] = true,
						["UniqueID"] = "8883923491",
						["Bone"] = "spine 2",
						["Name"] = "striker",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1065346402",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_cotz_anomaly_striker@@0",
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
