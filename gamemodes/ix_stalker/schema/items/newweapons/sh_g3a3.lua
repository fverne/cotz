ITEM.name = "G3A3"
ITEM.description= "A battle rifle that fires 7.62x51mm rounds."
ITEM.longdesc = "The G3 was Germany's response to the more expensive FAL rifle, based on the CETME design.\nWhile made out of mostly plastic furniture, the rifle remains a heavy but reliable choice.\n\nAmmo: 7.62x51mm\nMagazine Capacity: 20"
ITEM.model = "models/weapons/w_hk_g3.mdl"
ITEM.class = "cw_g3a3"
ITEM.weaponCategory = "primary"
ITEM.width = 6
ITEM.price = 34250
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_nightforce_nxs","md_reflex","md_saker","md_foregrip"}

ITEM.bulletweight = 0.026
ITEM.unloadedweight = 4.38

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 4

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(10, -205, 3),
	ang = Angle(0, 90, -5.5),
	fov = 11.5,
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
						["Angles"] = Angle(-7.344, 180, 180),
						["Position"] = Vector(14.673, -5.375, -2.02),
						["Model"] = "models/weapons/w_hk_g3.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "3329802291",
						["Bone"] = "spine 2",
						["Name"] = "g3a3",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1234694642",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_g3a3@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2400142348",
		["EditorExpand"] = true,
	},
},
}