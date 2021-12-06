ITEM.name = "HK416"
ITEM.description= "A German combat rifle chambered for 5.56x45mm."
ITEM.longdesc = "The Heckler & Koch HK416 is a rifle based on the AR-15 class of firearm, specifically the Colt M4 carbine family issued to the U.S. military, however it uses a proprietary short-stroke gas piston system derived from the ArmaLite AR-18 (the same system was also used in Heckler & Koch's earlier G36 family of rifles). It is used by militaries around the world, including the Norwegian and the French. A modified variant is also in use by the United States Marine Corps, under the moniker 'M27 Infantry Automatic Rifle'.\n\nAmmo: 5.56x45mm\nMagazine Capacity: 30"
ITEM.model = ("models/weapons/w_cwkk_hk416.mdl")
ITEM.class = "cw_hk416"
ITEM.weaponCategory = "primary"
ITEM.price = 29000
ITEM.width = 5
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_reflex","md_saker","md_foregrip"}

ITEM.bulletweight = 0.012
ITEM.unloadedweight = 3.5

ITEM.repair_PartsComplexity = 4
ITEM.repair_PartsRarity = 4

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(8, -205, 1),
	ang = Angle(0, 90, 0),
	fov = 9.8,
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
						["Angles"] = Angle(72.219, -177.46875, -98.487),
						["Position"] = Vector(-6.713, -3.194, 12.803),
						["Model"] = "models/weapons/w_cwkk_hk416.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8551155421",
						["Bone"] = "chest",
						["Name"] = "hk416",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1057333672",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_hk416@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8736555483",
		["EditorExpand"] = true,
	},
},
}
