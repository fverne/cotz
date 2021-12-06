ITEM.name = "AS Val"
ITEM.description= "A silenced special forces assault rifle chambered for 9x39mm."
ITEM.longdesc = "The AS 'Val' is a Soviet-designed assault rifle featuring an integrated suppressor.\nIts effective range is approximately 300 m, as it uses heavy subsonic 9x39mm SP-6 (high-performance armor-piercing) ammunition\nThe 'Val' has two modes of fire, semi-automatic and fully automatic fire at a rate of 900 RPM.\nAccording to its users, the 'Val' is reliable, accurate, and well liked.\nIt is a must have when getting the jump on your enemies is crucial.\n\nAmmo:9x39mm\nMagazine Capacity: 20"
ITEM.model = "models/weapons/w_dmg_vally.mdl"
ITEM.class = "cw_asval"
ITEM.weaponCategory = "primary"
ITEM.price = 42000
ITEM.width = 5
ITEM.height = 2
ITEM.validAttachments = {"md_kobra", "md_pso1", "md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_foregrip"}

ITEM.bulletweight = 0.023
ITEM.unloadedweight = 2.5

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 4

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(200, 0, -3),
	ang = Angle(180, -0, 180),
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
						["Angles"] = Angle(180, 90, 0),
						["Position"] = Vector(4.252, -5.172, -5.865),
						["Model"] = "models/weapons/w_dmg_vally.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "3421542291",
						["Bone"] = "spine 2",
						["Name"] = "asval",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1234641242",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_asval@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1442432348",
		["EditorExpand"] = true,
	},
},
}