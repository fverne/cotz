ITEM.name = "H&K UMP"
ITEM.description= "A German submachine gun, firing the .45ACP cartridge."
ITEM.longdesc = "The UMP is a blowback operated, magazine-fed submachine gun firing from a closed bolt.\nAs originally designed, the UMP is chambered for larger cartridges than other submachine guns like the MP5, to provide more stopping power against unarmored targets."
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_ump45_w.mdl"
ITEM.class = "cw_cotz_anomaly_ump45"
ITEM.category = "Anomaly Reskins"
ITEM.noBusiness = true
ITEM.weaponCategory = "primary"
ITEM.price = 14700
ITEM.width = 3
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_cobram2", "md_nightforce_nxs"}

ITEM.bulletweight = 0.020
ITEM.unloadedweight = 2.65




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(0.4, -205, 4),
	ang = Angle(0, 90, 0),
	fov = 7.3,
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
						["Position"] = Vector(8.614, -5.015, 3.43),
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_ump45_w.mdl",
						["ClassName"] = "model",
						["Translucent"] = true,
						["EditorExpand"] = true,
						["UniqueID"] = "8545625421",
						["Bone"] = "spine 2",
						["Name"] = "ump45",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1036896542",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_cotz_anomaly_ump45@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8123321483",
		["EditorExpand"] = true,
	},
},
}
