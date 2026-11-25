ITEM.name = "SAKO TRG-42"
ITEM.description= "A Finnish bolt action rifle chambered for .338 Lapua Magnum."
ITEM.longdesc = "The TRG-42 is the newest development in the TRG sniper rifle family.\nIn addition to a more reliable build, it also fires the massive .338 Lapua Magnum, capable of taking out most humanoid targets in just a single shot."
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_trg_w.mdl"
ITEM.class = "cw_cotz_anomaly_trg42"
ITEM.category = "Anomaly Reskins"
ITEM.noBusiness = true
ITEM.weaponCategory = "primary"
ITEM.price = 32000
ITEM.width = 6
ITEM.height = 1
ITEM.validAttachments = {"md_saker"}

ITEM.bulletweight = 0.017
ITEM.unloadedweight = 5.1




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(10.8, -205, 4.6),
	ang = Angle(0, 90, 0),
	fov = 14.8,
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
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_trg_w.mdl",
						["ClassName"] = "model",
						["Translucent"] = true,
						["Position"] = Vector(16.349, -3.516, -1.726),
						["EditorExpand"] = true,
						["UniqueID"] = "3578648314",
						["Bone"] = "spine 2",
						["Name"] = "trg-42",
						["Angles"] = Angle(0, 180, 180),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1418327982",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_cotz_anomaly_trg42@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "7391465467",
		["EditorExpand"] = true,
	},
},
}
