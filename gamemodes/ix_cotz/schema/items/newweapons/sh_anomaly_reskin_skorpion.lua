ITEM.name = "Skorpion"
ITEM.description= "A compact machine pistol. Fires 9x18mm."
ITEM.longdesc = "The Škorpion vz. 61 is a Czechoslovak machine pistol developed in 1959.\nAlthough it was developed for use with security forces and special forces, the weapon was also accepted into service with the Czechoslovak Army, as a personal sidearm for lower-ranking army staff, vehicle drivers, armoured vehicle personnel and special forces.\nCurrently the weapon is in use with the armed forces of several countries as a sidearm."
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_vz61_w.mdl"
ITEM.class = "cw_cotz_anomaly_skorpion"
ITEM.category = "Anomaly Reskins"
ITEM.noBusiness = true
ITEM.weaponCategory = "primary"
ITEM.price = 6200
ITEM.width = 3
ITEM.height = 1
ITEM.validAttachments = {"md_microt1","md_aimpoint","md_reflex","md_tundra9mm", "md_eotech", "md_cmore", "md_schmidt_shortdot", "md_acog", "md_nightforce_nxs"}

ITEM.bulletweight = 0.011
ITEM.unloadedweight = 1.30




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(4.5, -205, 5.6),
	ang = Angle(0, 90, 0),
	fov = 7,
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
						["Position"] = Vector(-3.5, -3.05, -7),
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_vz61_w.mdl",
						["ClassName"] = "model",
						["Translucent"] = true,
						["EditorExpand"] = true,
						["UniqueID"] = "7764798673",
						["Bone"] = "spine 2",
						["Name"] = "skorp",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1239764522",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_cotz_anomaly_skorpion@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2784647898",
		["EditorExpand"] = true,
	},
},
}
