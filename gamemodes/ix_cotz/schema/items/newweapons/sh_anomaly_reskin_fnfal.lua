ITEM.name = "FN FAL"
ITEM.description= "A battle rifle that fires 7.62x51mm rounds."
ITEM.longdesc = "Nicknamed ”The Right Arm of The Free World”, the FAL was a popular choice for revolutionaries and armies alike.\nIt earned it's reputation in various African wars as a heavy-hitting automatic rifle that could withstand the jungle's conditions."
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_fal_w.mdl"
ITEM.class = "cw_cotz_anomaly_fnfal"
ITEM.category = "Anomaly Reskins"
ITEM.noBusiness = true
ITEM.weaponCategory = "primary"
ITEM.price = 36000
ITEM.width = 6
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_saker", "md_nightforce_nxs"}

ITEM.bulletweight = 0.026
ITEM.unloadedweight = 4.45




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(5.3, -205, 3.8),
	ang = Angle(0, 90, 0),
	fov = 10,
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
						["Position"] = Vector(13.596, -3.694, -1.874),
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_fal_w.mdl",
						["ClassName"] = "model",
						["Translucent"] = true,
						["EditorExpand"] = true,
						["UniqueID"] = "3327382291",
						["Bone"] = "spine 2",
						["Name"] = "fnfal",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1234640142",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_cotz_anomaly_fnfal@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1120142348",
		["EditorExpand"] = true,
	},
},
}
