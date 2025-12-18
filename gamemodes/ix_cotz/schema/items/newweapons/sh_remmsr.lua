ITEM.name = "Remington MSR"
ITEM.description= "PLACEHOLDER."
ITEM.longdesc = "PLACEHOLDER.\n\nAmmo: .338 Lapua Magnum \nMagazine Capacity: 5+1"
ITEM.model = "models/weapons/w_ins2_pd2_msr.mdl"
ITEM.class = "cw_remmsr"
ITEM.weaponCategory = "primary"
ITEM.price = 98000
ITEM.width = 6
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_nightforce_nxs","md_saker"}

ITEM.bulletweight = 0.011
ITEM.unloadedweight = 6.5




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(17.39, -198.75, -13.95),
	ang = Angle(-4.31, 91.83, 0),
	fov = 13.51
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
						["Model"] = "models/weapons/w_ins2_pd2_msr.mdl",
						["ClassName"] = "model",
						["Position"] =	Vector(14.702, -4.244, -1.16),
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
				["Arguments"] = "cw_remmsr@@0",
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