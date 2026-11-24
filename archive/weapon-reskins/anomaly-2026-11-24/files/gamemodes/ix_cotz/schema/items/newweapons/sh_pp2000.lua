ITEM.name = "PP-2000"
ITEM.description= "A folding-stock submachine gun chambered for 9x19mm."
ITEM.longdesc = "The PP-2000 is a conventional blowback-operated weapon.\nThe PP-2000 is designed as a close-quarter combat weapon, intended for riot police and special operations forces.\nIn 2008, it was adopted as a standard SMG in the Russian police.\nIts high rate of fire makes it perfect for defending yourself against smaller mutants and bandits."
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_pp2000_w.mdl"
ITEM.class = "cw_pp2000"
ITEM.weaponCategory = "primary"
ITEM.price = 14000
ITEM.width = 3
ITEM.height = 1
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_reflex","md_tundra9mm", "md_schmidt_shortdot", "md_acog", "md_nightforce_nxs"}

ITEM.bulletweight = 0.008
ITEM.unloadedweight = 1.4




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-3.4, -205, 1.4),
	ang = Angle(0, 90, 0),
	fov = 8.3,
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
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_pp2000_w.mdl",
						["ClassName"] = "model",
						["Translucent"] = true,
						["Position"] = Vector(9.2, -4.2, -3.4),
						["EditorExpand"] = true,
						["UniqueID"] = "3540269892",
						["Bone"] = "spine 2",
						["Name"] = "pp2000",
						["Angles"] = Angle(0, 180, 180),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1640844916",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_pp2000@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1980487075",
		["EditorExpand"] = true,
	},
},
}
