ITEM.name = "Saiga Semi-Automatic Rifle"
ITEM.description= "A civillian semi-automatic rifle. Fires 7.62x39mm."
ITEM.longdesc = "The Saiga semi-automatic rifles are a family of Russian semi-automatic rifles manufactured by Kalashnikov Concern (formerly Izhmash).\nThey also manufacture the original AK-47 and its variants, Saiga-12 shotguns and the Dragunov sniper rifle.\nSaiga rifles are a sport version of the AK-series rifles, and are marketed for hunting and civilian use.\nThey are sometimes referred to as 'Saiga Sporters'.\n\nAmmo: 7.62x39mm \nMagazine Capacity: 20"
ITEM.model = "models/weapons/w_bfh_saiga308.mdl"
ITEM.class = "cw_saigasport"
ITEM.weaponCategory = "primary"
ITEM.price = 22500
ITEM.width = 5
ITEM.height = 1
ITEM.validAttachments = {"md_kobra","md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_nightforce_nxs","md_pso1","md_reflex","md_pbs1","md_foregrip"}

ITEM.bulletweight = 0.019
ITEM.unloadedweight = 3.6

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 1

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(9, -205, 1),
	ang = Angle(0, 90, 0),
	fov = 11,
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
						["Model"] = "models/weapons/w_bfh_saiga308.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(14.784, -4.193, -2.951),
						["EditorExpand"] = true,
						["UniqueID"] = "9611660162",
						["Bone"] = "spine 2",
						["Name"] = "saigasport",
						["Angles"] = Angle(0, 180, 180),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "0670219331",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_saigasport@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8562719528",
		["EditorExpand"] = true,
	},
},
}