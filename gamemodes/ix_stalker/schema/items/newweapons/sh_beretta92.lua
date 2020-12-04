ITEM.name = "Beretta 92"
ITEM.description= "A semi-automatic pistol chambered for 9x19mm."
ITEM.longdesc = "The Beretta 92, also known as the M9, is the Italian-made replacement for the M1911 pistol in the American army.\nIt is a semi-automatic pistol firing the 9x19mm cartridge.\nIt's popular with many stalkers as a sidearm since its ammo is easy to come across and it's very reliable.\n\nAmmo: 9x19mm\nMagazine Capacity: 15"
ITEM.model = ("models/weapons/w_M92f_p228.mdl")
ITEM.class = "cw_beretta92"
ITEM.weaponCategory = "secondary"
ITEM.price = 3000
ITEM.width = 2
ITEM.height = 1
ITEM.validAttachments = {"md_microt1","md_eotech","md_rmr","md_tundra9mm"}

ITEM.bulletweight = 0.008
ITEM.unloadedweight = 0.950

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(6.5, -205, 1.5),
	ang = Angle(0, 90, 0),
	fov = 4,
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
						["Model"] = "models/weapons/w_M92f_p228.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-9.48, 8.311, 0.71),
						["EditorExpand"] = true,
						["UniqueID"] = "3544656491",
						["Bone"] = "pelvis",
						["Name"] = "bm9",
						["Angles"] = Angle(0, -90, -30),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1011232402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_beretta92@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1118323213",
		["EditorExpand"] = true,
	},
},
}