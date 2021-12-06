ITEM.name = "M14 EBR"
ITEM.description= "A modernized M14 battle rifle. Fires 7.62x51mm."
ITEM.longdesc = "The Mk 14 Enhanced Battle Rifle (EBR) is an American selective fire military designated marksman rifle chambered for the 7.62×51mm NATO cartridge.\nIt is a variant of the M14 battle rifle and was originally built for use with units of the United States Special Operations Command, such as the United States Navy SEALs, Delta Force, and task specific ODA units.\nThe EBRs are made with the intention of carrying out both designated marksman and CQB roles in combat.\n\nAmmo: 7.62x51mm \nMagazine Capacity: 20"
ITEM.model = "models/weapons/w_cstm_m14.mdl"
ITEM.class = "cw_m14"
ITEM.weaponCategory = "primary"
ITEM.price = 37500
ITEM.width = 5
ITEM.height = 1
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_nightforce_nxs","md_reflex","md_saker","md_foregrip"}

ITEM.bulletweight = 0.026
ITEM.unloadedweight = 5.1

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 4

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(10.89999961853, -205, 1),
	ang = Angle(0, 90, 0),
	fov = 12,
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
						["Position"] = Vector(13.989, -4.313, -1.375),
						["Model"] = "models/weapons/w_cstm_m14.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7946894673",
						["Bone"] = "spine 2",
						["Name"] = "m14",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1237473522",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_m14@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2787896348",
		["EditorExpand"] = true,
	},
},
}