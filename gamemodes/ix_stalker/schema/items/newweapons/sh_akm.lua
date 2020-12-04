ITEM.name = "AKM"
ITEM.description= "A soviet-designed assault rifle chambered for 7.62x39mm."
ITEM.longdesc = "The AKM is an assault rifle firing the 7.62×39mm Soviet intermediate cartridge.\nDespite being replaced in the late 1970s by the AK-74 the AKM is still in service in some Russian Army reserve and second-line units and several east European countries.\nIt is fairly easy to come by in the Zone and is favoured by many experienced stalkers because of the punch it packs.\n\nAmmo: 7.62x39mm\nMagazine Capacity: 30"
ITEM.model = "models/weapons/w_ops_ak47.mdl"
ITEM.class = "cw_akm"
ITEM.weaponCategory = "primary"
ITEM.price = 19250
ITEM.width = 5
ITEM.height = 2
ITEM.validAttachments = {"md_kobra","md_pso1","md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_pbs1","md_foregrip"}

ITEM.bulletweight = 0.019
ITEM.unloadedweight = 3.3

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(8, -205, 0),
	ang = Angle(0, 90, 5),
	fov = 10.6,
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
						["Model"] = "models/weapons/w_ops_ak47.mdl",
						["ClassName"] = "model",
						["Position"] =	Vector(11.522, -4.244, -1.16),
						["EditorExpand"] = true,
						["UniqueID"] = "3543421491",
						["Bone"] = "spine 2",
						["Name"] = "ak47",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1051212402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_akm@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1118542183",
		["EditorExpand"] = true,
	},
},
}