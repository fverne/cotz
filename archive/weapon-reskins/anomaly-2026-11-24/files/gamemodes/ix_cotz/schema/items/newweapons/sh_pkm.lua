ITEM.name = "PKM"
ITEM.description= "A large machinegun. Fires 7.62x54mm."
ITEM.longdesc = "The PK is a 7.62x54mm general-purpose machine gun designed in the Soviet Union and currently in production in Russia.\nThe original PK machine gun was introduced in 1961 and then the improved PKM in 1969 to replace the SGM and RP-46 machine guns in Soviet service.\nIt remains in use as a front-line infantry and vehicle-mounted weapon with Russia's armed forces.\nThe PK has been exported extensively and produced in several other countries under license."
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_pkm_w.mdl"
ITEM.class = "cw_pkm"
ITEM.weaponCategory = "primary"
ITEM.price = 50000
ITEM.width = 6
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_reflex","md_pbs1", "md_acog", "md_schmidt_shortdot", "md_nightforce_nxs"}

ITEM.bulletweight = 0.022
ITEM.unloadedweight = 7.9




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(7.9, -205, 4.9),
	ang = Angle(0, 90, 0),
	fov = 12.9,
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
						["Position"] = Vector(11.188, -4.175, -0.658),
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_pkm_w.mdl",
						["ClassName"] = "model",
						["Translucent"] = true,
						["EditorExpand"] = true,
						["UniqueID"] = "7923894673",
						["Bone"] = "spine 2",
						["Name"] = "pkm",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1237573522",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_pkm@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2787236348",
		["EditorExpand"] = true,
	},
},
}