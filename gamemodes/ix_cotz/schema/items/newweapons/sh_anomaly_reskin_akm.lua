ITEM.name = "AKM"
ITEM.description= "A soviet-designed assault rifle chambered for 7.62x39mm."
ITEM.longdesc = "Despite being replaced in the late 1970s by the AK-74 the AKM is still in service in some"
	.. " Russian Army reserve and second-line units and several east European countries.\n"
	.. "It is fairly easy to come by in the Zone and is favoured by many experienced stalkers because of"
	.. " the punch it packs.\n"
	.. "\n"
	.. "Ammo: 7.62x39mm\n"
	.. "Magazine Capacity: 30"
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_akm.mdl"
ITEM.class = "cw_cotz_anomaly_akm"
ITEM.category = "Anomaly Reskins"
ITEM.noBusiness = true
ITEM.weaponCategory = "primary"
ITEM.price = 19250
ITEM.width = 5
ITEM.height = 2
ITEM.validAttachments = {"md_kobra","md_pso1","md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_pbs1","md_foregrip", "md_nightforce_nxs"}

ITEM.bulletweight = 0.019
ITEM.unloadedweight = 3.3




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(5.7, -205, 1.1),
	ang = Angle(0, 90, 0),
	fov = 9.6,
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
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_akm.mdl",
						["ClassName"] = "model",
						["Translucent"] = true,
						["Position"] =	Vector(11.522, -4.494, -1.16),
						["EditorExpand"] = true,
						["UniqueID"] = "3543421491",
						["Bone"] = "spine 2",
						["Name"] = "ak47",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1051212402",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_cotz_anomaly_akm@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1118542183",
		["EditorExpand"] = true,
	},
},
}
