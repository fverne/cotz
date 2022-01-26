ITEM.name = "MP5k"
ITEM.description= "A small, black submachinegun. Fires 9x19mm."
ITEM.longdesc = "A shorter version of the German MP5 submachinegun, mostly identical to the original. It lacks the stock and thus suffers from higher recoil.\nHowever, the gun is very compact and can be easily hidden under most jackets, making it a formidable backup solution.\nThe shorter design means that the bolt is lighter, leading to a higher rate of fire.\n\nAmmo: 9x19mm\nMagazine Capacity: 30"
ITEM.model = ("models/weapons/w_tfa_dmm5k.mdl")
ITEM.class = "cw_mp5k"
ITEM.weaponCategory = "primary"
ITEM.width = 2
ITEM.price = 9500
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_reflex","md_tundra9mm"}

ITEM.bulletweight = 0.008
ITEM.unloadedweight = 1.95

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(1.2999999523163, -205, 5),
	ang = Angle(0, 90, 0),
	fov = 3.8,
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
						["Angles"] = Angle(74.21875, -177.46875, -96.1875),
						["Position"] = Vector(-11.724, -4.649, 0.866),
						["Model"] = "models/weapons/w_tfa_dmm5k.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "79468794673",
						["Bone"] = "chest",
						["Name"] = "mp5k",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "8937478922",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_mp5k@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2778996348",
		["EditorExpand"] = true,
	},
},
}