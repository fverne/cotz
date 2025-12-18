ITEM.name = "Ruger Mini-14"
ITEM.description= "A new semi-automatic self-loading rifle. Fires 5.56x45mm."
ITEM.longdesc = "The Mini-14 is a lightweight semi-automatic rifle manufactured by Sturm, Ruger & Co.\nIntroduced in 1973, it is based on the M14 rifle and is essentially a scaled-down version chambered in 5.56×45mm NATO.\n\nAmmo: 5.56x45mm \nMagazine Capacity: 15+1"
ITEM.model = "models/weapons/w_tfa_mn14_classic_hd.mdl"
ITEM.class = "cw_rugermini14"
ITEM.weaponCategory = "primary"
ITEM.price = 12900
ITEM.width = 5
ITEM.height = 1
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_nightforce_nxs","md_reflex"}

ITEM.bulletweight = 0.019
ITEM.unloadedweight = 3.85




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end


ITEM.iconCam = {
	pos = Vector(5, 53, 0),
	ang = Angle(0, -90, 10),
	fov = 45,
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
						["Angles"] = Angle(0, 0, 180),
						["Model"] = "models/weapons/w_tfa_mn14_classic_hd.mdl",
						["ClassName"] = "model",
						["Position"] =	Vector(0.415, -4.194, -4.119),
						["EditorExpand"] = true,
						["UniqueID"] = "26643642",
						["Bone"] = "spine 2",
						["Name"] = "mini14",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "356135613156",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_rugermini14@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "3153625236523",
		["EditorExpand"] = true,
	},
},
}