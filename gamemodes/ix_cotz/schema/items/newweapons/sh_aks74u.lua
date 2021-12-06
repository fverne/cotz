ITEM.name = "AKs-74u"
ITEM.description= "A short folding-stock assault rifle chambered for 5.45x39mm."
ITEM.longdesc = "The AKS-74U bridges the gap between a submachine gun and an assault rifle.\nIt was intended for use mainly with special forces, airborne infantry, rear-echelon support units and armored vehicle crews.\nIt is still used in these roles, but has been augmented by various submachine guns, and the AK-105.\nIt is a popular rifle with stalkers due to its reduced weight and slim profile allowing you to carry it with ease.\n\nAmmo: 5.45x39mm\nMagazine Capacity: 30"
ITEM.model = "models/weapons/w_smg_aks.mdl"
ITEM.class = "cw_aks74u"
ITEM.weaponCategory = "primary"
ITEM.price = 12750
ITEM.width = 4
ITEM.height = 2
ITEM.validAttachments = {"md_kobra", "md_pso1", "md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_pbs1","md_foregrip"}

ITEM.bulletweight = 0.011
ITEM.unloadedweight = 2.7

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 1

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-2.5, -205, -3),
	ang = Angle(0, 90, 0),
	fov = 10,
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
						["Angles"] = Angle(180, 0, 0),
						["Position"] =	Vector(4.093, -4.807, -4.414),
						["Model"] = "models/weapons/w_smg_aks.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "3543445691",
						["Bone"] = "spine 2",
						["Name"] = "aks74u",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1059632402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_aks74u@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1513482183",
		["EditorExpand"] = true,
	},
},
}