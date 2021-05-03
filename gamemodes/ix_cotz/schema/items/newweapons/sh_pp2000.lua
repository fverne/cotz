ITEM.name = "PP-2000"
ITEM.description= "A folding-stock submachine gun chambered for 9x19mm."
ITEM.longdesc = "The PP-2000 is a conventional blowback-operated weapon.\nThe PP-2000 is designed as a close-quarter combat weapon, intended for riot police and special operations forces.\nIn 2008, it was adopted as a standard SMG in the Russian police.\nIts high rate of fire makes it perfect for defending yourself against smaller mutants and bandits.\n\nAmmo: 9x19mm \nMagazine Capacity: 20"
ITEM.model = "models/weapons/w_bf4_pp2000.mdl"
ITEM.class = "cw_pp2000"
ITEM.weaponCategory = "primary"
ITEM.price = 14000
ITEM.width = 3
ITEM.height = 1
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_reflex","md_tundra9mm"}

ITEM.bulletweight = 0.008
ITEM.unloadedweight = 1.4

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(2, -205, -1.2999999523163),
	ang = Angle(0, 90, 0),
	fov = 9.5,
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
						["Model"] = "models/weapons/w_bf4_pp2000.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-1.452, -2.714, 2.521),
						["EditorExpand"] = true,
						["UniqueID"] = "3540269892",
						["Bone"] = "spine 2",
						["Name"] = "pp2000",
						["Angles"] = Angle(0, 180, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1640844916",
				["Event"] = "weapon_class",
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