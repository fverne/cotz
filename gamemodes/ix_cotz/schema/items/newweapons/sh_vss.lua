ITEM.name = "VSS Vintorez"
ITEM.description= "A special forces sniper rifle chambered for 9x39mm."
ITEM.longdesc = "The VSS 'Vintorez' is issued primarily to Spetsnaz units for undercover or clandestine operations, a role made evident by its ability to be stripped down for transport in a specially fitted briefcase.\nFor this reason, it is hard to get ahold of in the Zone.\nThe weapon has an integral suppressor which wraps around the barrel.\nThe barrel itself has a series of small ports drilled in the rifling grooves, leading into the suppressor which slows and cools the exhaust gases.\nIt uses a subsonic 9x39 mm SP-5 cartridge to avoid a sonic boom.\n\nAmmo: 9x39mm\nMagazine Capacity: 10"
ITEM.model = ("models/cw2/rifles/w_vss.mdl")
ITEM.class = "cw_vss"
ITEM.weaponCategory = "primary"
ITEM.width = 5
ITEM.price = 45000
ITEM.height = 1
ITEM.validAttachments = {"md_kobra","md_pso1","md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_foregrip"}

ITEM.bulletweight = 0.023
ITEM.unloadedweight = 2.6

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 4

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(0, 200, 0),
	ang = Angle(0, 270, 0),
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
						["Angles"] = Angle(59.719, 133.045, 43.587),
						["Position"] = Vector(5.933, -4.267,-3.558),
						["Model"] = "models/cw2/rifles/w_vss.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8545355421",
						["Bone"] = "spine 2",
						["Name"] = "vss",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1053653672",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_vss@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8542551483",
		["EditorExpand"] = true,
	},
},
}