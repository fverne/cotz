ITEM.name = "Barrett M98b"
ITEM.description = "A bolt-action rifle chambered for .338 Lapua Magnum."
ITEM.longdesc = "The Barrett M98b builds a long bolt-action rifle around a substantial metal chassis. Its stock, barrel and optical mounting space favour a deliberate firing position. The heavy assembly takes up considerable room in a travelling load, well before a sight and ammunition are added."
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_m98b_w.mdl"
ITEM.class = "cw_cotz_anomaly_barrettm98b"
ITEM.category = "Anomaly Reskins"
ITEM.noBusiness = true
ITEM.weaponCategory = "primary"
ITEM.price = 98000
ITEM.width = 6
ITEM.height = 2
ITEM.validAttachments = {"md_saker"}

ITEM.bulletweight = 0.011
ITEM.unloadedweight = 6.5




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(10.8, -205, 4.6),
	ang = Angle(0, 90, 0),
	fov = 12.6,
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
						["Angles"] = Angle(180, 0, 0),
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_m98b_w.mdl",
						["ClassName"] = "model",
						["Translucent"] = true,
						["Position"] =	Vector(14.702, -3.494, -1.16),
						["EditorExpand"] = true,
						["UniqueID"] = "3547696121",
						["Bone"] = "spine 2",
						["Name"] = "aek971",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "2971273618",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_cotz_anomaly_barrettm98b@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "5153429652",
		["EditorExpand"] = true,
	},
},
}
