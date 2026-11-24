ITEM.name = "SVU-A"
ITEM.description = "A bullpup rifle chambered for 7.62x54mmR."
ITEM.longdesc = "The SVU-A places its action and magazine behind the pistol grip. That bullpup arrangement retains a substantial rifle mechanism within a shorter overall body. The unusual layout is visible in its balance and in the amount of the weapon carried behind the shooting hand."
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_svu_w.mdl"
ITEM.class = "cw_svu"
ITEM.weaponCategory = "primary"
ITEM.price = 76000
ITEM.width = 5
ITEM.height = 2
ITEM.validAttachments = {"md_kobra","md_pso1", "md_schmidt_shortdot", "md_acog", "md_nightforce_nxs", "md_microt1", "md_eotech", "md_aimpoint", "md_cmore", "md_reflex"}

ITEM.bulletweight = 0.022
ITEM.unloadedweight = 3.6




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(2.7, -205, 3.4),
	ang = Angle(0, 90, 0),
	fov = 9.8,
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
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_svu_w.mdl",
						["ClassName"] = "model",
												["Translucent"] = true,
						["Position"] = Vector(9.2, -4, -2.7),
						["EditorExpand"] = true,
						["UniqueID"] = "3859539124",
						["Bone"] = "spine 2",
						["Name"] = "svd",
						["Angles"] = Angle(0, 180, 180),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "2428315201",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_svu@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "0004518261",
		["EditorExpand"] = true,
	},
},
}
