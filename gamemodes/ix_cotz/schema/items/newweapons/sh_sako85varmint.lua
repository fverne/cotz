ITEM.name = "Sako 85 Varmint"
ITEM.description= "A bolt-action sniper rifle intended for hunting small game. Fires .22LR."
ITEM.longdesc = "The Sako 85 is a Finnish bolt-action sniper rifle designed for hunting. It can be fitted with various telescopic sights.\n\nAmmo: .22LR\nMagazine Capacity: 5"
ITEM.model = ("models/weapons/tfa_nmrih/w_fa_sako85_ironsights.mdl")
ITEM.class = "cw_sako85varmint"
ITEM.weaponCategory = "primary"
ITEM.price = 4500
ITEM.width = 6
ITEM.height = 1
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_nightforce_nxs","md_reflex","md_saker"}

ITEM.bulletweight = 0.006
ITEM.unloadedweight = 2.4




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(10, -205, -0.60000002384186),
	ang = Angle(0, 90, 0),
	fov = 14,
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
						["Position"] = Vector(14.155, -4.192, -4.03),
						["Model"] = "models/weapons/tfa_nmrih/w_fa_sako85_ironsights.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "4561465641",
						["Bone"] = "spine 2",
						["Name"] = "sako85",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "416564154165",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_sako85varmint@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "415664156415",
		["EditorExpand"] = true,
	},
},
}