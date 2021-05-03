ITEM.name = "PP19 'Bizon'"
ITEM.description= "A folding-stock sub machine gun chambered for 9x18mm."
ITEM.longdesc = "The Bizon is a submachinegun that features an uncommon large helical magazine, doubling as a grip.\nIt's very similiar to the AK74 rifles and 60 percent of the parts for the weapons are interchangable.\nAn effective submachinegun for police and security purposes.\n\nAmmo: 9x18mm\nMagazine Capacity: 64"
ITEM.model = ("models/weapons/w_smg_biz.mdl")
ITEM.class = "cw_pp19"
ITEM.weaponCategory = "primary"
ITEM.price = 16000
ITEM.width = 3
ITEM.height = 1
ITEM.validAttachments = {"md_kobra","md_microt1","md_eotech","md_aimpoint","md_cmore","md_reflex","md_tundra9mm"}

ITEM.bulletweight = 0.011
ITEM.unloadedweight = 2.1

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-4, -205, -1),
	ang = Angle(0, 90, 0),
	fov = 8.8,
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
						["Position"] = Vector(4.174, -5.064, -3.862),
						["Model"] = "models/weapons/w_smg_biz.mdl",
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
				["Arguments"] = "cw_pp19@@0",
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