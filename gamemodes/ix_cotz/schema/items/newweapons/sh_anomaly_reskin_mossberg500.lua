ITEM.name = "Mossberg 500"
ITEM.description= "A 12 gauge pump-action shotgun. Seems modern."
ITEM.longdesc = "The Mossberg 500 is one of the most popular smooth-bore pump action shotguns in the world.\nA low price and an inherently reliable design makes it a good choice for hunters and police officers alike."
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_mossberg590_w.mdl"
ITEM.class = "cw_cotz_anomaly_mossberg500"
ITEM.category = "Anomaly Reskins"
ITEM.noBusiness = true
ITEM.weaponCategory = "primary"
ITEM.width = 4
ITEM.price = 10200
ITEM.height = 1
ITEM.validAttachments = {}

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 3.1




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(12.6, -205, 4.2),
	ang = Angle(0, 90, 0),
	fov = 8.6,
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
						["Angles"] = Angle(0, 0, 180),
						["Position"] = Vector(-2.502, -3.06, -2.254),
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_mossberg590_w.mdl",
						["ClassName"] = "model",
						["Translucent"] = true,
						["EditorExpand"] = true,
						["UniqueID"] = "78798794673",
						["Bone"] = "spine 2",
						["Name"] = "moss500",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1237868922",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_cotz_anomaly_mossberg500@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2787986348",
		["EditorExpand"] = true,
	},
},
}
