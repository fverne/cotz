ITEM.name = "RPK"
ITEM.description= "A long-barreled AK with a heavy stock. Fires 5.45x39mm."
ITEM.longdesc = "A modification of the AK rifle, fit with a more supporting stock, a heavier and longer barrel and a bipod. \nIt can mount any of the AK's attachments apart from a grenade launcher. \nIt lacks the high ammo capacity of most machineguns, but it makes up for this in accuracy and reliability."
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_rpk_w.mdl"
ITEM.class = "cw_cotz_anomaly_rpk"
ITEM.category = "Anomaly Reskins"
ITEM.noBusiness = true
ITEM.weaponCategory = "primary"
ITEM.price = 35000
ITEM.width = 6
ITEM.height = 2
ITEM.validAttachments = {"md_kobra","md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_pso1","md_reflex","md_pbs1", "md_nightforce_nxs"}

ITEM.bulletweight = 0.011
ITEM.unloadedweight = 4.8




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(9.6, -205, 5.2),
	ang = Angle(0, 90, 0),
	fov = 11.9,
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
						["Position"] = Vector(14.48, -3.925, -1.348),
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_rpk_w.mdl",
						["ClassName"] = "model",
						["Translucent"] = true,
						["EditorExpand"] = true,
						["UniqueID"] = "3583945391",
						["Bone"] = "spine 2",
						["Name"] = "rpk",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1059846402",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_cotz_anomaly_rpk@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1132482183",
		["EditorExpand"] = true,
	},
},
}
