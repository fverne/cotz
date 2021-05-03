ITEM.name = "Ruger 10/22"
ITEM.description= "A semi-automatic rifle chambered for .22LR."
ITEM.longdesc = "The Ruger 10/22 is a semi-automatic rifle produced in America, chambered for the .22 Long Rifle rimfire cartridge. It uses a patented 10-round rotary magazine. The standard Carbine version of the Ruger 10/22 has been in production continuously since 1964, making it one of, if not the, most successful rimfire rifle design in history, with numerous third party manufacturers making parts and accessories for upgrading and customization. In fact, the 10/22's aftermarket is so prolific, that a 10/22 can be built with completely non-Ruger made components.\n\nAmmo: .22LR\nMagazine Capacity: 5"
ITEM.model = ("models/weapons/tfa_nmrih/w_fa_ruger1022.mdl")
ITEM.class = "cw_ruger1022"
ITEM.weaponCategory = "primary"
ITEM.price = 6600
ITEM.width = 5
ITEM.height = 1
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_nightforce_nxs","md_reflex","md_tundra9mm"}

ITEM.bulletweight = 0.0025
ITEM.unloadedweight = 2.3

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 1

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(8, -205, -2),
	ang = Angle(0, 90, 0),
	fov = 13,
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
						["Position"] = Vector(10.662, -4.192, -3.821),
						["Model"] = "models/weapons/tfa_nmrih/w_fa_ruger1022.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8544325421",
						["Bone"] = "spine 2",
						["Name"] = "r1022",
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
				["Arguments"] = "cw_ruger1022@@0",
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