ITEM.name = "SIG SG 552"
ITEM.description= "A Swiss assault rifle. Fires 5.56x45mm."
ITEM.longdesc = "The Sig 552 is the carbine version of the 550 rifle, often agreed to be one of the best modern assault rifles. It's accurate, reliable and easy to use. \nIt's high price and rather rare match ammunition has put many STALKERs off from using this weapon, instead choosing a more common alternative. It has a 700 round per minute rate of fire.\n\nAmmo: 5.56x45mm \nMagazine Capacity: 30"
ITEM.model = ("models/weapons/w_rif_tg552.mdl")
ITEM.class = "cw_sg552"
ITEM.weaponCategory = "primary"
ITEM.price = 24000
ITEM.width = 5
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_saker"}

ITEM.bulletweight = 0.012
ITEM.unloadedweight = 3.2

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 3

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(7.5, -205, 1),
	ang = Angle(0, 90, 0),
	fov = 10.5,
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
						["Model"] = "models/weapons/w_rif_tg552.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(15.415, -4.195, -1.495),
						["EditorExpand"] = true,
						["UniqueID"] = "3522668235",
						["Bone"] = "spine 2",
						["Name"] = "sg552",
						["Angles"] = Angle(0, 180, 180),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1418662282",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_sg552@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "7391421667",
		["EditorExpand"] = true,
	},
},
}