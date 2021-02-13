ITEM.name = "PP-19-01 'Vityaz'"
ITEM.description= "A folding-stock sub machine gun chambered for 9x19mm."
ITEM.longdesc = "The Vityaz-SN is a 9×19mm Parabellum submachine gun developed in 2004 by Izhmash (now Kalashnikov). It is based on the AK-74 and offers a high degree of parts commonality with the AK-74. The gun is directly developed from the PP-19 Bizon.\n\nAmmo: 9x19mm\nMagazine Capacity: 30"
ITEM.model = ("models/weapons/w_smg_pp19vityaz.mdl")
ITEM.class = "cw_pp1901_vityaz"
ITEM.weaponCategory = "primary"
ITEM.width = 3
ITEM.price = 17500
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_reflex", "md_schmidt_shortdot", "md_tundra9mm"}

ITEM.bulletweight = 0.008
ITEM.unloadedweight = 2.9

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(9.5, -45, 0.80000001192093),
	ang = Angle(0, 90, 0),
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
						["Angles"] = Angle(0, 180, 180),
						["Position"] = Vector(16.922, -4.424, -0.666),
						["Model"] = "models/weapons/w_smg_pp19vityaz.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7793894673",
						["Bone"] = "spine 2",
						["Name"] = "biz",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1237579522",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_pp1901_vityaz@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2784686348",
		["EditorExpand"] = true,
	},
},
}