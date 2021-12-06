ITEM.name = "AK-12"
ITEM.description= "A Russian assault rifle. Fires 5.45x39mm."
ITEM.longdesc = "The AK-12, also known as the AK-200, is the newest member of the AK family.\nWhile the Russian army had no interest in purchasing any of these because of their massive supply of AK-74's, the AK-12 is still a highly modular and effective weapon platform.\nThis rifle is rare to find, but easy to keep in good condition and easy to find ammunition for.\n\nAmmo: 5.45x39mm \nMagazine Capacity: 30"
ITEM.model = "models/weapons/w_rif_ak12.mdl"
ITEM.class = "cw_ak12"
ITEM.weaponCategory = "primary"
ITEM.price = 29600
ITEM.width = 5
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_pbs1","md_foregrip"}

ITEM.bulletweight = 0.011
ITEM.unloadedweight = 3.3

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 3

ITEM.exRender = false
ITEM.img = ix.util.GetMaterial("vgui/hud/weapons/ak12.png")

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(8.8999996185303, -205, 0),
	ang = Angle(0, 90, 2.3529412746429),
	fov = 11.5,
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
						["Model"] = "models/weapons/w_rif_ak12.mdl",
						["ClassName"] = "model",
						["Position"] =	Vector(14.702, -4.244, -1.16),
						["EditorExpand"] = true,
						["UniqueID"] = "3512531291",
						["Bone"] = "spine 2",
						["Name"] = "ak12",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1054244402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_ak12@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1512312353",
		["EditorExpand"] = true,
	},
},
}