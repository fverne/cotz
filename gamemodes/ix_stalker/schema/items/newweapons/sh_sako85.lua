ITEM.name = "Sako 85"
ITEM.description= "A bolt-action sniper rifle intended for hunting wildlife. Fires 7.62x51mm."
ITEM.longdesc = "The Sako 85 is a Finnish bolt-action sniper rifle designed for hunting. It can be fitted with various telescopic sights.\n\nAmmo: 7.62x51mm\nMagazine Capacity: 5"
ITEM.model = ("models/weapons/tfa_nmrih/w_fa_sako85_ironsights.mdl")
ITEM.class = "cw_sako85"
ITEM.weaponCategory = "primary"
ITEM.price = 26700
ITEM.width = 6
ITEM.height = 1
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_nightforce_nxs","md_reflex","md_saker"}

ITEM.bulletweight = 0.026
ITEM.unloadedweight = 2.4

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 3

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
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
						["UniqueID"] = "8544325421",
						["Bone"] = "spine 2",
						["Name"] = "sako85",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1036853672",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_sako85@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8537651483",
		["EditorExpand"] = true,
	},
},
}