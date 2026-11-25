ITEM.name = "M16A4"
ITEM.description= "An American combat rifle chambered for 5.56x45mm."
ITEM.longdesc = "As a weapon solely issued to the US Marines, the M16A4's origins and quantities in the Zone are unclear.\nThe first model was designed in the 60's and has been constantly modified and upgraded since.\nThe rifle's size and weight favour deliberate use over hurried movement through confined spaces."
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_m16_w.mdl"
ITEM.class = "cw_cotz_anomaly_ws_m16a4"
ITEM.category = "Anomaly Reskins"
ITEM.noBusiness = true
ITEM.weaponCategory = "primary"
ITEM.price = 22500
ITEM.width = 5
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_saker", "md_nightforce_nxs"}

ITEM.bulletweight = 0.012
ITEM.unloadedweight = 2.89




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(7.6, -205, 5.5),
	ang = Angle(0, 90, 0),
	fov = 11.8,
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
						["Position"] = Vector(16.543, -3.312, -1.374),
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_m16_w.mdl",
						["ClassName"] = "model",
						["Translucent"] = true,
						["EditorExpand"] = true,
						["UniqueID"] = "8553655421",
						["Bone"] = "spine 2",
						["Name"] = "m16",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1057453672",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_cotz_anomaly_ws_m16a4@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8736551483",
		["EditorExpand"] = true,
	},
},
}
