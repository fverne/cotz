ITEM.name = "RPK"
ITEM.description= "A long-barreled AK with a heavy stock. Fires 5.45x39mm."
ITEM.longdesc = "A modification of the AK rifle, fit with a more supporting stock, a heavier and longer barrel and a bipod. \nIt can mount any of the AK's attachments apart from a grenade launcher. \nIt lacks the high ammo capacity of most machineguns, but it makes up for this in accuracy and reliability.\n\nAmmo: 5.45x39mm\nMagazine Capacity: 45"
ITEM.model = ("models/weapons/w_rif_rpkm.mdl")
ITEM.class = "cw_rpk"
ITEM.weaponCategory = "primary"
ITEM.price = 35000
ITEM.width = 6
ITEM.height = 2
ITEM.validAttachments = {"md_kobra","md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_pso1","md_reflex","md_pbs1","md_foregrip"}

ITEM.bulletweight = 0.011
ITEM.unloadedweight = 4.8

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(11, -205, -1),
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
						["Position"] = Vector(14.48, -3.675, -1.348),
						["Model"] = "models/weapons/w_rif_rpkm.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "3583945391",
						["Bone"] = "spine 2",
						["Name"] = "rpk",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1059846402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_rpk@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1132482183",
		["EditorExpand"] = true,
	},
},
}