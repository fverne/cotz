ITEM.name = "SAKO TRG-42"
ITEM.description= "A Finnish bolt action rifle chambered for .338 Lapua Magnum."
ITEM.longdesc = "The TRG-42 is the newest development in the TRG sniper rifle family.\nIn addition to a more reliable build, it also fires the massive .338 Lapua Magnum, capable of taking out most humanoid targets in just a single shot.\n\nAmmo: .338 Lapua Magnum \nMagazine Capacity: 5"
ITEM.model = ("models/weapons/tgr/w_spin_scout.mdl")
ITEM.class = "cw_trg42"
ITEM.weaponCategory = "primary"
ITEM.price = 32000
ITEM.width = 6
ITEM.height = 1
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_nightforce_nxs","md_reflex","md_saker","md_foregrip"}

ITEM.bulletweight = 0.017
ITEM.unloadedweight = 5.1

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(13.5, -205, 1.7000000476837),
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
						["Model"] = "models/weapons/tgr/w_spin_scout.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(16.349, -4.266, -1.726),
						["EditorExpand"] = true,
						["UniqueID"] = "3578648314",
						["Bone"] = "spine 2",
						["Name"] = "trg-42",
						["Angles"] = Angle(0, 180, 180),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1418327982",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_trg42@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "7391465467",
		["EditorExpand"] = true,
	},
},
}