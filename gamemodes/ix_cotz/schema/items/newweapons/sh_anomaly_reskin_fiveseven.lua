ITEM.name = "Five-seveN"
ITEM.description= "A polymer-framed pistol chambered for 5.7x28mm."
ITEM.longdesc = "The Five-seveN and its iconic cartridge, the FN 5.7x28mm, was designed to replace the aging 9x19mm cartridge.\nThe cartridge sports excellent penetration power and impressively tight groupings.\nAcquiring the FiveseveN in the Zone is fairly tough and will cost you dearly, as will supplying the pistol with ammunition."
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_fn57_w.mdl"
ITEM.class = "cw_cotz_anomaly_fiveseven"
ITEM.category = "Anomaly Reskins"
ITEM.noBusiness = true
ITEM.weaponCategory = "secondary"
ITEM.price = 17500
ITEM.width = 2
ITEM.height = 1
ITEM.validAttachments = {"md_microt1","md_eotech","md_rmr","md_tundra9mm"}

ITEM.bulletweight = 0.006
ITEM.unloadedweight = 0.610




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(1.9, -205, 3.1),
	ang = Angle(0, 90, 0),
	fov = 3.2,
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
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_fn57_w.mdl",
						["ClassName"] = "model",
						["Translucent"] = true,
						["Position"] = Vector(-9.246, 4.888, -1.755),
						["EditorExpand"] = true,
						["UniqueID"] = "3544603835",
						["Bone"] = "pelvis",
						["Name"] = "five7",
						["Angles"] = Angle(0, 270, -30),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1087768762",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_cotz_anomaly_fiveseven@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1197387467",
		["EditorExpand"] = true,
	},
},
}
